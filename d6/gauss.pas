unit gauss;

{$Q-}

interface

uses Types,Classes, math,GR32_LowLevel;

{.$IFDEF CLX}
type  PDWORD = ^DWORD;      
{.$ENDIF}

//Radius cannot exceed 255 since overflow at integer operations hazard
//flood=0: no flood; 1: a pixel is added 100% to pixel-next neighbours, to more far away pixels with normal decrease
//normaly, a pixel distributes its color to Radius^2/(pi/2) surrounding pixels
procedure Blur(Bitmap: PDWORD; Width,Height:integer; Radius: double{byte}; flood:double; inv:boolean=false);


var eigen:single;

implementation

type QWORD=single{Int64};
type PQWORD=^QWORD;

{type
  PRGBTriple = ^TRGBTriple;
  TRGBTriple = packed record
    B: Byte;
    G: Byte;
    R: Byte;
  end;
  PRow = ^TRow;
  TRow = Array [0..1000000] of TRGBTriple;
  PPRows = ^TPRows;
  TPRows = Array [0..1000000] of PRow;
 }
const
  MaxKernelSize = 255;
  AsFloat=true;

var gTemp:double=0;

type
  TKernelSize = 1..MaxKernelSize;
  TKernel = record
    Size: TKernelSize;
    dSize:double;
    FullAdd: Array [0..MaxKernelSize] of DWORD;
    FullAddTimes255: Array [0..MaxKernelSize] of DWORD;
    Weights: Array [{-MaxKernelSize}0..MaxKernelSize] of single;
  end;

function GetWeight(var K: TKernel; J:double):double;
begin
 result:=Sqr(K.dSize-J);
// result:=(K.Size-J)*(K.Size-J);
// result:=K.Size*K.Size-J*J
end;

var K: TKernel;



procedure MakeGaussianKernel({var K: TKernel; }Radius: Double; MaxData, DataGranularity,Flood: Double);
var
  J: Integer;
  Temp, Delta: Double;
begin                     {
  K.Size:=round(Radius)+1;
  for J := 0 to K.Size-1 do
  begin
    Temp := J / Radius;
    K.Weights[J] := Exp(-Temp * Temp / 2);
  end;
  Temp := 0;
  for J := 1 to K.Size-1 do
    Temp := Temp + K.Weights[J];
  Temp:=Temp*2+K.Weights[0];
  for J := 0 to K.Size-1 do
    K.Weights[J] := K.Weights[J] / Temp;   }

  
  for J := 0 to High(K.Weights) do
  begin
    K.Weights[J] :=0;
  end;

  K.Size:=Ceil(Radius)+1;
  K.dSize:=Radius+1;
  for J := 0 to K.Size-1 do
  begin             
    K.Weights[J] := GetWeight(K,J);//}Exp(-4*(K.Size-1-J) / Radius * (K.Size-1-J) / Radius / 2);;
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

(*

procedure MakeGaussianKernel(var K: TKernel; Radius: Double; MaxData, DataGranularity: Double);
var
  J: Integer;
  Temp, Delta: Double;
  KernelSize: TKernelSize;
begin
  for J := Low(K.Weights) to High(K.Weights) do
  begin
    Temp := J / Radius;
    K.Weights[J] := Exp(-Temp * Temp / 2);
  end;
  Temp := 0;
  for J := Low(K.Weights) to High(K.Weights) do
    Temp := Temp + K.Weights[J];
  for J := Low(K.Weights) to High(K.Weights) do
    K.Weights[J] := K.Weights[J] / Temp;
  KernelSize := MaxKernelSize;
  Delta := DataGranularity / (2 * MaxData);
  Temp := 0;
  while (Temp < Delta) and (KernelSize > 1) do
  begin
    Temp := Temp + 2 * K.Weights[KernelSize];
    Dec(KernelSize);
  end;
  KernelSize:=round(Radius)+1;
  K.Size := KernelSize;
  Temp := 0;
  for J := -K.Size to K.Size do
    Temp := Temp + K.Weights[J];
  //Temp:=K.Weights[0]*6;//!!
  for J := -K.Size to K.Size do
    K.Weights[J] := K.Weights[J] / Temp;
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

*)
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
  Src:PDWord;
  Src3,Src2:PQWORD;
  incr:QWORD;
  WP:PDWORD;
  fW:Single;
  fWP:PSingle;
  fincr:double;
  P2,theRow2,Pstart: PQWORD;
  ffinal:Single;
  P_Preview:PDWORD;
  LastVal:DWORD;
  LastRepeat:integer;
  NewVal:DWORD;
  PredKSize,BadArea:integer;
  P3:PQWORD;

const PreviewVals=true;

begin
  //FillLongword(P^,Size,0);
  //KSize:=K.Size-1;
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
   P_Preview:=PDWORD(P);
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
     {if (LastRepeat>=0) then
      assert(abs(round(theRow^)-round(ffinal))<0.0001); }
     theRow^:=ffinal;
     {inc(bad)};
    end else;
     {inc(good)};

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
    //P2^:=P3^ div (256*256*256*256*256){shr (4*8)}*100;
    //P2^:=PDWORD(PByte(P3)+4)^ shr 16{ shr 8 *1000};
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
     {
    255:
    begin
     inc(P^,K.FullAddTimes255[0]);
     Src2:=P;
     Src3:=P;
     for N:=1 to K.Size-1 do
     begin
      incr:=K.FullAddTimes255[N];
      dec(Src2);
      inc(Src3);
      inc(Src2^,incr);
      inc(Src3^,incr);
     end;
    end;  }
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

procedure Blur(Bitmap: PDWORD; Width,Height:integer; Radius: double; flood:double; inv:boolean=false);
var
  Row: Integer;
  Col,N,J: Integer;
  //K: TKernel;
  P2: PDWORD;
  LineStart,P,Pstart,P3:PQWORD;
  adj:Single;
var PP:PDWORD;

procedure Normalize;
var PP:PDWORD;
    J:integer;
begin
    PP:=Bitmap;
   { if flood=0 then
    for J:=0 to Width*Height-1 do
    begin
     PP^:=(PP^ shr 16);
     //assert(PP^<=255); //>$FF cannot appear
     inc(PP);
    end else }
    for J:=0 to Width*Height-1 do
    begin
     PP^:=(PP^ shr 8);
     if PP^>$FF then
      PP^:=$FF;
     inc(PP);
    end;
end;
           
procedure Invert;
var PP:PDWORD;
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
var PP:PDWORD;
    J:integer;
begin
    PP:=Bitmap;
    if AsFloat then
    for J:=0 to Width*Height-1 do
    begin
     PSingle(PP)^:=PP^{/255};
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


    //adj:=1-(1-1/K.Weights[0])*flood;
    //adj:=1/((GetWeight(K,(K.Size-1)*flood)/gTemp)/K.Weights[0]);
    adj:=1/((GetWeight(K,(K.dSize{.9999})*flood)/gTemp)/K.Weights[0]);

    eigen:=K.Weights[0]/adj;
//    eigen:=sqrt(eigen);

    for N:=0 to K.Size-1 do
    begin
     K.FullAdd[N]:=round(K.Weights[N]*$FFFF);
     //K.FullAddTimes255[N]:=Floor(K.Weights[N]*256*256*adj*255);
    end;
    //K.FullAdd[K.Size-1]:=0;
    Size:=((K.Size-1)*2+max(Height,Width)) * SizeOf(QWORD);
    GetMem(Pstart, Size);
    //FillLongword(Pstart^,Size,0);
    P:=Pstart;
    inc(P,K.Size-1);


    FillChar(Pstart^,Size,0);
    LineStart:=PQWORD(Bitmap);
    for Row := 0 to Height - 1 do
    begin
      BlurRow2(LineStart, {K, }P, Width,1);
      (*
      //MoveStride(P,LineStart,Width);
      P2:=LineStart;
      P3:=P;
      for Col := 0 to Width - 1 do //second data stride operation. time comsuming since no data locality
      begin
       if AsFloat then
        PSingle(P2)^:=P3^ else
        {P2^:=P3^};
       inc(P3);
       inc(P2);
      end;
      //MoveLongword(P^,LineStart^,Width);
      *)
      inc(LineStart,Width);
    end;

    //Normalize;


    PP:=Bitmap;
    if not AsFloat then
    for J:=0 to Width*Height-1 do
    begin
     PP^:=PP^ shr 8;
     inc(PP);
    end;


    {PP:=Bitmap;
    if AsFloat then
    for J:=0 to Width*Height-1 do
    begin
     if PSingle(PP)^<=1/gTemp*255 then
      PSingle(PP)^:=0;
     inc(PP);
    end; }


    FillChar(Pstart^,Size,0);
    LineStart:=PQWORD(Bitmap);
    for Col := 0 to Width - 1 do
    begin
      BlurRow2(LineStart, {K, }P, Height, Width);//one data stride
      (*
      P2:=LineStart;
      P3:=P;
      for Row:=0 to Height - 1 do //second data stride operation. time comsuming since no data locality
      begin
       //P2^:=P3^ div (256*256*256*256*256){shr (4*8)}*100;
       //P2^:=PDWORD(PByte(P3)+4)^ shr 16{ shr 8 *1000};
       if AsFloat then
        PSingle(P2)^:=P3^ else
        {P2^:=P3^};
       inc(P3);
       inc(P2,Width);
      end;
      *)
      inc(LineStart);
    end;

  {  Normalize;

            }


    PP:=Bitmap;
    if not AsFloat then
    for J:=0 to Width*Height-1 do
    begin
     PP^:=PP^ shr 24;
     //PP^:=min(round((PP^ shr 24)*adj*1),255);
     //PP^:=sqr(PP^);
     inc(PP);
    end;

    if not AsFloat then
     Invert;

           {
    PP:=Bitmap;
    if AsFloat then
    for J:=0 to Width*Height-1 do
    begin
     if not( (PSingle(PP)^>=0.01) and (PSingle(PP)^<=0.011)) then
      PP^:=0 else
      PP^:=100;
     //PP^:=min(round((PP^ shr 24)*adj*1),255);
     //PP^:=sqr(PP^);
     inc(PP);
    end;
    exit;   }

    PP:=Bitmap;
    if AsFloat then  
    for J:=0 to Width*Height-1 do
    begin
     {if PSingle(PP)^<=1/gTemp*255 then
      PSingle(PP)^:=0;}
     if inv then
      PP^:=max(min(round((255-PSingle(PP)^)*adj{+0.5}),255),0) else
      PP^:=min(round((PSingle(PP)^)*adj),255);
     //PP^:=min(round((PP^ shr 24)*adj*1),255);
     //PP^:=sqr(PP^);
     inc(PP);
    end else
    for J:=0 to Width*Height-1 do
    begin
     PP^:=min(round((PP^)*adj*1),255);;
     //PP^:=min(round((PP^ shr 24)*adj*1),255);
     //PP^:=sqr(PP^);
     inc(PP);
    end;


    FreeMem(Pstart);

end;


end.


