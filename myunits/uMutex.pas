unit uMutex;

interface

uses Messages;

const ClassName={$ifdef QS}'TuQuickMain'{$elseif WC}'TuWWWCMain'{$elseif AH}'TuHideMain'{$elseif sdl}'TuSDLMain'{$else}'TdhMainForm'{$endif};

const wmMainInstanceOpenFile = WM_USER+ 101;

implementation

uses
  Windows, sysutils;

var
     MutexHandle: THandle;
     s:String;
     i:integer;
     hPrevWindow:integer;
Initialization
//showmessage('4');

{  s:=Application.ExeName;
  for i:=1 to length(s) do
   if s[i]='\' then s[i]:='_';
}
  MutexHandle := CreateMutex(nil, TRUE, {pchar(s)}ClassName);
          if GetLastError = ERROR_ALREADY_EXISTS then
          begin

               hPrevWindow := FindWindow(pchar(ClassName), nil);

{               MessageBox(0, pchar(inttostr(hPrevWindow)+'->Instance of this application is already running:'+Application.ExeName),
                             'Application already running', mb_IconHand);
}
               if hPrevWindow <> 0 then
               begin
                 SetForeGroundWindow(hPrevWindow);
                 SendMessage(hPrevWindow, wmMainInstanceOpenFile, 0, 0 );
               end;
  	       CloseHandle(MutexHandle);
               MutexHandle:=0;
               Halt;
          end;{ else
               MessageBox(0, 'Instance new started',
                             'Application running', mb_IconHand)};
Finalization
 if MutexHandle<>0 then
  CloseHandle(MutexHandle);
end.
