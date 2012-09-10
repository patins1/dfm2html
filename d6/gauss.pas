{-------------------------------------------------------------------------------
The contents of this file are subject to the Mozilla Public License
Version 1.1 (the "License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at
http://www.mozilla.org/MPL/

Software distributed under the License is distributed on an "AS IS" basis,
WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License for
the specific language governing rights and limitations under the License.

The Original Code is DFM2HTML

The Initial Developer of the Original Code is Joerg Kiegeland

You may retrieve the latest version of this file at the DFM2HTML home page,
located at http://www.dfm2html.com

-------------------------------------------------------------------------------}

unit gauss;

{$Q-}

interface

uses Types,Classes, math,GR32_LowLevel;

//Radius cannot exceed 255 since overflow at integer operations hazard
//flood=0: no flood; 1: a pixel is added 100% to pixel-next neighbours, to more far away pixels with normal decrease
//normaly, a pixel distributes its color to Radius^2/(pi/2) surrounding pixels
procedure Blur(Bitmap: PCardinal; Width,Height:integer; Radius: double{byte}; flood:double; inv:boolean=false);


var eigen:single;

implementation

type QWORD=single{Int64};
type PQWORD=^QWORD;

const
  MaxKernelSize = 255;
  AsFloat=true;

var gTemp:double=0;

type
  TKernelSize = 1..MaxKernelSize;
  TKernel = record
    Size: TKernelSize;
    dSize:double;
    FullAdd: Array [0..MaxKernelSize] of Cardinal;
    FullAddTimes255: Array [0..MaxKernelSize] of Cardinal;
    Weights: Array [{-MaxKernelSize}0..MaxKernelSize] of single;
  end;

function GetWeight(var K: TKernel; J:double):double;
begin
 result:=Sqr(K.dSize-J);
end;

var K: TKernel;

procedure MakeGaussianKernel({var K: TKernel; }Radius: Double; MaxData, DataGranularity,Flood: Double);
var
  J: Integer;
  Temp, Delta: Double;
begin
  for J := 0 to High(K.Weights) do
  begin
    K.Weights[J] :=0;
  end;
  K.Size:=Ceil(Radius)+1;
  K.dSize:=Radius+1;
  for J := 0 to K.Size-1 do
  begin             
    K.Weights[J] := GetWeight(K,J);
  end;
  Temp := 0;
  for J := 1 to K.Size-1 do
    Temp := Temp + K.Weights[J];
  gTemp:=Temp*2+K.Weights[0];
  for J := 0 to K.Size-1 do
    K.Weights[J] := K.Weights[J] / gTemp;
end;

function TrimInt(Lower, Upper, theInteger: Integer): Integer;
begin
  if (theInteger <= Upper) and (theInteger >= Lower) then
    Result := theInteger
  else
    if theInteger > Upper then
      Result := Upper
    else
      Result := Lower;
end;

function TrimReal(Lower, Upper: Integer; X: Double): Integer;
begin
  if (X < Upper) and (X >= Lower) then
    Result := Trunc(X)
  else
    if X > Upper then
      Result := Upper
    else
      Result := Lower;
end;

var bad,good:integer;

procedure BlurRow2(theRow: PQWORD;{ K: TKernel;} P: PQWORD; Size,Stride:integer);
var
  J, N: Integer;
  W:QWORD;
  TR, TG, TB: Double;
  Src:PCardinal;
  Src3,Src2:PQWORD;
  incr:QWORD;
  WP:PCardinal;
  fW:Single;
  fWP:PSingle;
  fincr:double;
  P2,theRow2,Pstart: PQWORD;
  ffinal:Single;
  P_Preview:PCardinal;
  LastVal:Cardinal;
  LastRepeat:integer;
  NewVal:Cardinal;
  PredKSize,BadArea:integer;
  P3:PQWORD;

const PreviewVals=true;

begin
  PredKSize:=K.Size-1;
  if AsFloat then
  begin
  if PreviewVals then
  begin

   theRow2:=theRow;
   P2:=P;
   for J := 0 to Size-1 do
   begin
    P2^:=theRow2^;
    inc(theRow2,Stride);
    inc(P2);
   end;

   BadArea:=-(PredKSize*2+1)+1;
   LastVal:=0;
   LastRepeat:=(BadArea-1)+PredKSize;
   P_Preview:=PCardinal(P);
   for J := 1 to PredKSize do
   begin
    NewVal:=P_Preview^;
    if (LastVal=NewVal) then
    begin
     inc(LastRepeat);
    end else
    begin
     LastVal:=NewVal;
     LastRepeat:=BadArea;
    end;
    inc(P_Preview);
   end;

   for J := 0 to Size-1 do
   begin
    NewVal:=P_Preview^;
    if (LastVal=NewVal) then
    begin
     inc(LastRepeat);
    end else
    begin
     LastVal:=NewVal;
     LastRepeat:=BadArea;
    end;
    inc(P_Preview);

    if (LastRepeat<0)  then
    begin
     fWP:=@K.Weights[0];
     ffinal:=fWP^*P^;
     Src2:=P;
     Src3:=P;
     for N:=1 to PredKSize do
     begin
      dec(Src2);
      inc(Src3);
      inc(fWP);
      ffinal:=ffinal+(Src2^+Src3^)*fWP^;
     end;
     theRow^:=ffinal;
    end;

    inc(theRow,Stride);
    inc(P);
   end;
  end else
  begin
   P2:=theRow;
   P3:=P;

   Pstart:=P;
   dec(Pstart,K.Size-1);
   FillChar(Pstart^,((K.Size-1)*2+Size)*SizeOf(QWORD),0);
   for J := 0 to Size-1 do
   begin
    fW:=theRow^;
    if fW<>0 then
    begin
     fWP:=@K.Weights[0];
     P^:=P^+fWP^*fW;
     inc(fWP);
     Src2:=P;
     Src3:=P;
     for N:=1 to PredKSize do
     begin
      fincr:=fWP^*fW;
      dec(Src2);
      inc(Src3);
      inc(fWP);
      Src2^:=Src2^+fincr;
      Src3^:=Src3^+fincr;
     end;
    end;
    inc(theRow,Stride);
    inc(P);
   end;

   for J:=0 to Size - 1 do //second data stride operation. time comsuming since no data locality
   begin
    P2^:=P3^;
    inc(P3);
    inc(P2,Stride);
   end;

  end;

  end else
  begin
   FillChar(Pstart^,((K.Size-1)*2+Size)*SizeOf(QWORD),0);
   for J := 0 to Size-1 do
   begin
    W:=theRow^;
    if W<>0 then  //this saves much time for images with many transparent pixels!
    begin
     WP:=@K.FullAdd[0];
     P^:=P^+WP^*W;
     inc(WP);
     Src2:=P;
     Src3:=P;
     for N:=1 to K.Size-1 do
     begin
      incr:=WP^*W;
      dec(Src2);
      inc(Src3);
      inc(WP);
      Src2^:=Src2^+incr;
      Src3^:=Src3^+incr;
     end;
    end;
    inc(theRow,Stride);
    inc(P);
   end;
  end;
end;

procedure Blur(Bitmap: PCardinal; Width,Height:integer; Radius: double; flood:double; inv:boolean=false);
var
  Row: Integer;
  Col,N,J: Integer;
  P2: PCardinal;
  LineStart,P,Pstart,P3:PQWORD;
  adj:Single;
var PP:PCardinal;

procedure Normalize;
var PP:PCardinal;
    J:integer;
begin
    PP:=Bitmap;
    for J:=0 to Width*Height-1 do
    begin
     PP^:=(PP^ shr 8);
     if PP^>$FF then
      PP^:=$FF;
     inc(PP);
    end;
end;
           
procedure Invert;
var PP:PCardinal;
    J:integer;
begin   
    PP:=Bitmap;
    if inv then
    for J:=0 to Width*Height-1 do
    begin      
     if PP^>$FF then
      PP^:=$FF;
     PP^:=255 - PP^;
     inc(PP);
    end;
end;

type PSingle=^Single;

procedure ToSingle;
var PP:PCardinal ;
    J:integer;
begin
    PP:=Bitmap;
    if AsFloat then
    for J:=0 to Width*Height-1 do
    begin
     PSingle(PP)^:=PP^;
     inc(PP);
    end;
end;


var Size:integer;
begin

    eigen:=1;
    if Radius=0 then exit;

    Invert;

    ToSingle;

    MakeGaussianKernel({K, }Radius, 255, 1,flood);
    adj:=1/((GetWeight(K,(K.dSize-1)*flood)/gTemp)/K.Weights[0]);
    eigen:=K.Weights[0]/adj;

    for N:=0 to K.Size-1 do
    begin
     K.FullAdd[N]:=round(K.Weights[N]*$FFFF);
    end;
    Size:=((K.Size-1)*2+max(Height,Width)) * SizeOf(QWORD);
    GetMem(Pstart, Size);
    P:=Pstart;
    inc(P,K.Size-1);


    FillChar(Pstart^,Size,0);
    LineStart:=PQWORD(Bitmap);
    for Row := 0 to Height - 1 do
    begin
      BlurRow2(LineStart, {K, }P, Width,1);
      inc(LineStart,Width);
    end;

    PP:=Bitmap;
    if not AsFloat then
    for J:=0 to Width*Height-1 do
    begin
     PP^:=PP^ shr 8;
     inc(PP);
    end;

    FillChar(Pstart^,Size,0);
    LineStart:=PQWORD(Bitmap);
    for Col := 0 to Width - 1 do
    begin
      BlurRow2(LineStart, P, Height, Width);//one data stride
      inc(LineStart);
    end;

    PP:=Bitmap;
    if not AsFloat then
    for J:=0 to Width*Height-1 do
    begin
     PP^:=PP^ shr 24;
     inc(PP);
    end;

    if not AsFloat then
     Invert;

    PP:=Bitmap;
    if AsFloat then  
    for J:=0 to Width*Height-1 do
    begin
     if inv then
      PP^:=max(min(round((255-PSingle(PP)^)*adj{+0.5}),255),0) else
      PP^:=min(round((PSingle(PP)^)*adj),255);
     inc(PP);
    end else
    for J:=0 to Width*Height-1 do
    begin
     PP^:=min(round((PP^)*adj*1),255);
     inc(PP);
    end;

    FreeMem(Pstart);
end;


end.


