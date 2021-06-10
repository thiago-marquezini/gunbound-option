unit ExtFunctions;

interface

uses Windows, SysUtils, Dialogs, Registry;


  function StartThread(pFunction : TFNThreadStartRoutine) : THandle;
  function CloseThread( ThreadHandle : THandle) : Boolean;

  function ReadRegistryIntegerValue(KeyName: string; Field: string): integer;
  function ReadRegistryBinaryValue(KeyName: string; Field: string; Size: integer): integer;
  procedure WriteRegistryIntegerValue(KeyName: string; Field: string; Value: integer);
  procedure WriteRegistryBinaryValue(KeyName: string; Field: string; Data: array of Byte; Size: integer);
  
implementation

procedure WriteRegistryBinaryValue(KeyName: string; Field: string; Data: array of Byte; Size: integer);
var
  Reg: TRegistry;
begin
  Reg := TRegistry.Create(KEY_SET_VALUE);
  try
    Reg.RootKey := HKEY_LOCAL_MACHINE;
    if Reg.OpenKey(KeyName, True) then
    begin
      Reg.WriteBinaryData(Field, Data[0], Size);
      Reg.CloseKey;
    end;
  finally
    Reg.Free;
  end;
end;

procedure WriteRegistryIntegerValue(KeyName: string; Field: string; Value: integer);
var
   Registry: TRegistry;
 begin
   Registry := TRegistry.Create(KEY_SET_VALUE);
   try
     Registry.RootKey := HKEY_LOCAL_MACHINE;

     if Registry.OpenKey(KeyName, False) then
     begin
       Registry.WriteInteger(Field, Value);
     end;
   finally
     Registry.Free;
   end;
end;

function ReadRegistryBinaryValue(KeyName: string; Field: string; Size: integer): integer;
var
   Registry: TRegistry;
   Data: array of Byte;
 begin
   Registry := TRegistry.Create(KEY_READ);
   try
     Registry.RootKey := HKEY_LOCAL_MACHINE;
     Registry.OpenKey(KeyName, False);

     SetLength(Data, Size);
     Registry.ReadBinaryData(Field, Data[0], Size);
     Result := Data[0];
   finally
     Registry.Free;
   end;
end;


function ReadRegistryIntegerValue(KeyName: string; Field: string): integer;
var
   Registry: TRegistry;
 begin
   Registry := TRegistry.Create(KEY_READ);
   try
     Registry.RootKey := HKEY_LOCAL_MACHINE;
     Registry.OpenKey(KeyName, False);
     Result := Registry.ReadInteger(Field);
   finally
     Registry.Free;
   end;
end;



function StartThread(pFunction : TFNThreadStartRoutine) : THandle;
var
ThreadID : DWORD;
begin
Result := CreateThread(nil, 0, pFunction, nil, 0, ThreadID);
if Result <> 0 then
SetThreadPriority(Result, THREAD_PRIORITY_HIGHEST);
end;

function CloseThread( ThreadHandle : THandle) : Boolean;
begin
Result := TerminateThread(ThreadHandle, 0);
CloseHandle(ThreadHandle);
end;

end.
 