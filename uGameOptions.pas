unit uGameOptions;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, pngimage, ExtCtrls, StdCtrls, Mask,
  IniFiles, ImgList, Menus, jpeg, Vcl.ComCtrls;

type
  TfrmOptions = class(TForm)
    groupAudio: TGroupBox;
    groupWindowMode: TGroupBox;
    groupLanguage: TGroupBox;
    groupGraphics: TGroupBox;
    radio3DMax: TRadioButton;
    radio3DMin: TRadioButton;
    radioNo3D: TRadioButton;
    trEffectVolume: TTrackBar;
    trMusicVolume: TTrackBar;
    trNotifVolume: TTrackBar;
    trEmojiVolume: TTrackBar;
    lblEffectVolume: TLabel;
    lblMusicVolume: TLabel;
    lblNotifVolume: TLabel;
    lblEmojiVolume: TLabel;
    btnSaveSettings: TButton;
    Label5: TLabel;
    Image1: TImage;
    chkWindowMode: TRadioButton;
    chkFullscreenMode: TRadioButton;
    chkLanguagePT: TRadioButton;
    chkLanguageEN: TRadioButton;
    chkLanguageES: TRadioButton;
    chkLanguageVT: TRadioButton;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    groupPowerBar: TGroupBox;
    chkDivisoriasMetrico: TRadioButton;
    chkDivisoriasOff: TRadioButton;
    chkDivisoriasMilimetrico: TRadioButton;
    procedure btnSaveSettingsClick(Sender: TObject);
    procedure radio3DMaxClick(Sender: TObject);
    procedure radio3DMinClick(Sender: TObject);
    procedure radioNo3DClick(Sender: TObject);
    procedure trEffectVolumeChange(Sender: TObject);
    procedure trMusicVolumeChange(Sender: TObject);
    procedure trNotifVolumeChange(Sender: TObject);
    procedure trEmojiVolumeChange(Sender: TObject);
    procedure chkWindowModeClick(Sender: TObject);
    procedure chkFullscreenModeClick(Sender: TObject);
    procedure chkLanguagePTClick(Sender: TObject);
    procedure chkLanguageENClick(Sender: TObject);
    procedure chkLanguageESClick(Sender: TObject);
    procedure chkLanguageVTClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure chkDivisoriasMetricoClick(Sender: TObject);
    procedure chkDivisoriasOffClick(Sender: TObject);
    procedure chkDivisoriasMilimetricoClick(Sender: TObject);
  private
    { Private declarations }
    procedure LoadAppLanguage(Arq: TIniFile);
  public
    { Public declarations }
  end;

var
  frmOptions: TfrmOptions;

  E3D: integer;
  E3DUse: integer;
  EffectVolume: integer;
  MusicVolume: integer;
  NotifVolume: integer;
  EmojiVolume: integer;
  WindowMode: integer;
  Language: string;
  Barra: integer;

implementation

uses ExtFunctions, GlobalVars;

{$R *.dfm}

procedure TfrmOptions.FormCreate(Sender: TObject);
var
Arq: TIniFile;
begin

  DoubleBuffered := True;
  Arq := TIniFile.Create(GetCurrentDir() + '\\GunBoundOption.ini');

  //LoadAppLanguage(Arq);

  E3D          := ReadRegistryBinaryValue('SOFTWARE\GBWorld\GunboundWC', 'Effect3D', 1);
  E3DUse       := ReadRegistryBinaryValue('SOFTWARE\GBWorld\GunboundWC', 'EffectUse', 1);
  EffectVolume := ReadRegistryIntegerValue('SOFTWARE\GBWorld\GunboundWC', 'EffectVolume');
  MusicVolume  := ReadRegistryIntegerValue('SOFTWARE\GBWorld\GunboundWC', 'MusicVolume');

  NotifVolume  := Arq.ReadInteger('GunBoundOption', 'NotifVolume', 0);
  EmojiVolume  := Arq.ReadInteger('GunBoundOption', 'EmojiVolume', 0);
  WindowMode   := ReadRegistryIntegerValue('SOFTWARE\GBWorld\GHP\Config', 'WindowMode');
  Language     := Arq.ReadString('GunBoundOption', 'Language', '0');
  Barra        := Arq.ReadInteger('GunBoundOption', 'Barra', 0);

  if (E3D = 2) then
  radio3DMax.Checked := True;
  if (E3D = 1) then
  radio3DMin.Checked := True;
  if (E3D = 0) then
  radioNo3D.Checked := True;

  trEffectVolume.Position := EffectVolume;
  trMusicVolume.Position := MusicVolume;
  trNotifVolume.Position := NotifVolume;
  trEmojiVolume.Position := EmojiVolume;

  if not (WindowMode = 0) then
  chkWindowMode.Checked := True
  else
  chkFullscreenMode.Checked := True;

  if (Barra = 0) then
  chkDivisoriasMetrico.Checked := True;
  if (Barra = 1) then
  chkDivisoriasMilimetrico.Checked := True;
  if (Barra = 2) then
  chkDivisoriasOff.Checked := True;

  if (Language = 'PT') then
  chkLanguagePT.Checked := True;
  if (Language = 'EN') then
  chkLanguageEN.Checked := True;
  if (Language = 'ES') then
  chkLanguageES.Checked := True;
  if (Language = 'VT') then
  chkLanguageVT.Checked := True;

  Arq.Free;

end;

///////////////////////
// Load App Language //
///////////////////////
procedure TfrmOptions.LoadAppLanguage(Arq: TIniFile);
begin

 try

    groupGraphics.Caption := Arq.ReadString('Language', 'GraphicGroup', '0');
    radio3DMax.Caption := Arq.ReadString('Language', '3DMax', '0');
    radio3DMin.Caption := Arq.ReadString('Language', '3DMin', '0');
    radioNo3D.Caption := Arq.ReadString('Language', 'No3D', '0');

    groupAudio.Caption := Arq.ReadString('Language', 'AudioGroup', '0');
    lblEffectVolume.Caption := Arq.ReadString('Language', 'EffectVolume', '0');
    lblMusicVolume.Caption := Arq.ReadString('Language', 'MusicVolume', '0');
    lblNotifVolume.Caption := Arq.ReadString('Language', 'NotifVolume', '0');
    lblEmojiVolume.Caption := Arq.ReadString('Language', 'EmojiVolume', '0');

    groupWindowMode.Caption := Arq.ReadString('Language', 'WModeGroup', '0');
    chkWindowMode.Caption := Arq.ReadString('Language', 'WModeEnabled', '0');
    chkFullscreenMode.Caption := Arq.ReadString('Language', 'WModeDisabled', '0');

    groupLanguage.Caption := Arq.ReadString('Language', 'LanguageGroup', '0');
    chkLanguagePT.Caption := Arq.ReadString('Language', 'LanguagePT', '0');
    chkLanguageEN.Caption := Arq.ReadString('Language', 'LanguageEN', '0');
    chkLanguageES.Caption := Arq.ReadString('Language', 'LanguageES', '0');
    chkLanguageVT.Caption := Arq.ReadString('Language', 'LanguageVT', '0');

    groupPowerBar.Caption := Arq.ReadString('Language', 'PowerBarGroup', '0');
    chkDivisoriasMetrico.Caption := Arq.ReadString('Language', 'PowerBarMetric', '0');
    chkDivisoriasMilimetrico.Caption := Arq.ReadString('Language', 'PowerBarMilimetric', '0');
    chkDivisoriasOff.Caption := Arq.ReadString('Language', 'PowerBarDisabled', '0');

    btnSaveSettings.Caption := Arq.ReadString('Language', 'ButtonSave', '0');

 except;
 end;

end;

procedure TfrmOptions.btnSaveSettingsClick(Sender: TObject);
begin
  Application.MessageBox('As configuracoes foram salvas com sucesso.',
			   'GunBound World',
			   MB_OK Or MB_ICONASTERISK);

 ExitProcess(0);
end;


//////////////////////
// Graphics Options //
//////////////////////
procedure TfrmOptions.radio3DMaxClick(Sender: TObject);
var Data: array of Byte;
begin

 SetLength(Data, 1);
 Data[0] := $02;
 WriteRegistryBinaryValue('SOFTWARE\GBWorld\GunboundWC', 'Effect3D', Data[0], 1);

 Data[0] := $01;
 WriteRegistryBinaryValue('SOFTWARE\GBWorld\GunboundWC', 'EffectUse', Data[0], 1);

end;

procedure TfrmOptions.radio3DMinClick(Sender: TObject);
var Data: array of Byte;
begin

 SetLength(Data, 1);
 Data[0] := $01;
 WriteRegistryBinaryValue('SOFTWARE\GBWorld\GunboundWC', 'Effect3D', Data[0], 1);

end;

procedure TfrmOptions.radioNo3DClick(Sender: TObject);
var Data: array of Byte;
begin

 SetLength(Data, 1);
 Data[0] := $00;
 WriteRegistryBinaryValue('SOFTWARE\GBWorld\GunboundWC', 'Effect3D', Data[0], 1);

 Data[0] := $00;
 WriteRegistryBinaryValue('SOFTWARE\GBWorld\GunboundWC', 'EffectUse', Data[0], 1);

end;


//////////////////////
// Audio Options //
//////////////////////
procedure TfrmOptions.trEffectVolumeChange(Sender: TObject);
begin
 if not (EffectVolume = trEffectVolume.Position) then
 begin
 WriteRegistryIntegerValue('SOFTWARE\GBWorld\GunboundWC', 'EffectVolume', trEffectVolume.Position);
 end;
end;

procedure TfrmOptions.trMusicVolumeChange(Sender: TObject);
begin
 if not (MusicVolume = trMusicVolume.Position) then
 begin
 WriteRegistryIntegerValue('SOFTWARE\GBWorld\GunboundWC', 'MusicVolume', trMusicVolume.Position);
 end;
end;

procedure TfrmOptions.trNotifVolumeChange(Sender: TObject);
var Arq : TIniFile;
begin

 Arq := TIniFile.Create(GetCurrentDir() + '\\GunBoundOption.ini');
 Arq.WriteInteger('GunBoundOption', 'NotifVolume', trNotifVolume.Position);
 Arq.Free();

end;

procedure TfrmOptions.trEmojiVolumeChange(Sender: TObject);
var Arq : TIniFile;
begin

 Arq := TIniFile.Create(GetCurrentDir() + '\\GunBoundOption.ini');
 Arq.WriteInteger('GunBoundOption', 'EmojiVolume', trEmojiVolume.Position);
 Arq.Free();

end;


//////////////////////
/// Window Options ///
//////////////////////
procedure TfrmOptions.chkWindowModeClick(Sender: TObject);
begin

 WriteRegistryIntegerValue('SOFTWARE\GBWorld\GHP\Config', 'WindowMode', 1);

end;

procedure TfrmOptions.chkFullscreenModeClick(Sender: TObject);
begin

 WriteRegistryIntegerValue('SOFTWARE\GBWorld\GHP\Config', 'WindowMode', 0);

end;


//////////////////////
// Language Options //
//////////////////////
procedure TfrmOptions.chkLanguagePTClick(Sender: TObject);
var Arq : TIniFile;
begin

 Arq := TIniFile.Create(GetCurrentDir() + '\\GunBoundOption.ini');
 Arq.WriteString('GunBoundOption', 'Language', 'PT');
 Arq.Free();

end;

procedure TfrmOptions.chkLanguageENClick(Sender: TObject);
var Arq : TIniFile;
begin

 Arq := TIniFile.Create(GetCurrentDir() + '\\GunBoundOption.ini');
 Arq.WriteString('GunBoundOption', 'Language', 'EN');
 Arq.Free();

end;

procedure TfrmOptions.chkLanguageESClick(Sender: TObject);
var Arq : TIniFile;
begin

 Arq := TIniFile.Create(GetCurrentDir() + '\\GunBoundOption.ini');
 Arq.WriteString('GunBoundOption', 'Language', 'ES');
 Arq.Free();

end;

procedure TfrmOptions.chkLanguageVTClick(Sender: TObject);
var Arq : TIniFile;
begin

 Arq := TIniFile.Create(GetCurrentDir() + '\\GunBoundOption.ini');
 Arq.WriteString('GunBoundOption', 'Language', 'VT');
 Arq.Free();

end;

///////////////////////
// Power Bar Options //
///////////////////////
procedure TfrmOptions.chkDivisoriasMetricoClick(Sender: TObject);
var Arq : TIniFile;
begin

 Arq := TIniFile.Create(GetCurrentDir() + '\\GunBoundOption.ini');
 Arq.WriteInteger('GunBoundOption', 'Barra', 0);
 Arq.Free();

end;

procedure TfrmOptions.chkDivisoriasMilimetricoClick(Sender: TObject);
var Arq : TIniFile;
begin

 Arq := TIniFile.Create(GetCurrentDir() + '\\GunBoundOption.ini');
 Arq.WriteInteger('GunBoundOption', 'Barra', 1);
 Arq.Free();

end;

procedure TfrmOptions.chkDivisoriasOffClick(Sender: TObject);
var Arq : TIniFile;
begin

 Arq := TIniFile.Create(GetCurrentDir() + '\\GunBoundOption.ini');
 Arq.WriteInteger('GunBoundOption', 'Barra', 2);
 Arq.Free();

end;

end.
