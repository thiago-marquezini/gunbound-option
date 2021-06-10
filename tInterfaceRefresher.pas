unit tInterfaceRefresher;

interface

uses
  Classes;

type
  InterfaceRefresher = class(TThread)
  private
    { Private declarations }
  protected
    procedure Execute; override;
  public
    ActionId: Integer;

    procedure EnableLoginForm();

  end;

implementation

uses uGameOptions;



procedure InterfaceRefresher.EnableLoginForm;
begin

//    frmOptions.lblLoginId.Enabled := True;
//    frmOptions.lblPassword.Enabled := True;
//    frmOptions.txtPlayerLoginID.Enabled := True;
//    frmOptions.txtPlayerPassword.Enabled := True;
//    frmOptions.btnOptLogin.Enabled := True;

end;


procedure InterfaceRefresher.Execute;
begin

  if Self.ActionId = 1 then begin

    EnableLoginForm();
    
  end;

end;

end.
