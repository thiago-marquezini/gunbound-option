program GunBoundOption;

uses
  Forms,
  uGameOptions in 'uGameOptions.pas' {frmOptions},
  ExtFunctions in 'ExtFunctions.pas',
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'GunBound World';
  Application.CreateForm(TfrmOptions, frmOptions);
  Application.Run;
end.
