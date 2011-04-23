unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls,BASS_DSHOW, ComCtrls, Bass, ExtDlgs,
  XPMan, Menus;

type
  TForm2 = class(TForm)
    pnl1: TPanel;
    btn1: TButton;
    btn2: TButton;
    btn3: TButton;
    dlgOpen1: TOpenDialog;
    sc: TScrollBar;
    xpmnfst1: TXPManifest;
    procedure FormCreate(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure btn2Click(Sender: TObject);
    procedure btn3Click(Sender: TObject);
    procedure pnl1DblClick(Sender: TObject);
    procedure scScroll(Sender: TObject; ScrollCode: TScrollCode;
      var ScrollPos: Integer);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
const
  CLSID_hax264: TGUID = '{43fc6785-8e56-8e56-9ccc-9f3556ac9d24}';
  CLSID_MADDECODER: TGUID = '{d1a36f81-56ae-11d6-8c1f-00104b49aa66}';
  CLSID_DIVX      : TGUID = '{2BCA55D6-E4CF-4F1E-B1E8-FBF770AE46F1}';
  CLSID_FFDSHOW :TGUID='{04FE9017-F873-410e-871E-AB91661A4EF7}';
  CLSID_FFDSHOW2 :TGUID='{008BAC12-FBAF-497b-9670-BC6F6FBAE2C4}';
  CLSID_FFDSHOW3 :TGUID='{3D446B6F-71DE-4437-BE15-8CE47174340F}';
var
  Form2: TForm2;
  chan       : HSTREAM;
  paused: boolean;





implementation

uses Unit1;

{$R *.dfm}

procedure TForm2.FormCreate(Sender: TObject);
var dir: string;
begin
 paused:=false;
 dir:='Bass_dshow.dll';
 doublebuffered:=true;
 BASS_Init(-1, 44100,0, handle, nil);
 BASS_DSHOW_Init(handle);
 BASS_PLUGINLOAD(pchar(dir),0);
 BASS_SetConfig(BASS_CONFIG_NET_TIMEOUT, 5000);
 BASS_DSHOW_LoadPlugin('BASS_DSHOW_FFMPEG.dll',CLSID_DSHOWPLUGIN ,nil);
end;


procedure TForm2.btn1Click(Sender: TObject);
begin
  dlgOpen1.Title  := 'Open Files';
  dlgOpen1.Filter := 'Avi|*.avi';
  if chan<>0 then
  begin
    BASS_Stop();
    BASS_MusicFree(chan);
    BASS_StreamFree(chan);
  end;
  if dlgOpen1.Execute then 
    Chan :=BASS_StreamCreateFile(FALSE, PChar(dlgOpen1.FileName), 0, 0, 0);
  if chan<>0 then
    begin
     BASS_DSHOW_ChannelSetWindow(chan,pnl1.Handle);
     sc.max:=round(BASS_ChannelBytes2Seconds(chan, BASS_ChannelGetLength(chan, BASS_POS_BYTE)));
     btn2Click(Sender);
    end;
end;

procedure TForm2.btn2Click(Sender: TObject);
begin
  if(paused=true)then paused:=true;
    BASS_ChannelPlay(chan, False);
end;

procedure TForm2.btn3Click(Sender: TObject);
begin
  if(paused=false) then
    begin
      bass_channelpause(chan);
      paused:=true;
    end
  else
   begin
     BASS_ChannelPlay(Chan, False);
     paused:=false;
   end;
end;

procedure TForm2.pnl1DblClick(Sender: TObject);
begin
  BASS_DSHOW_ChannelSetFullscreen(chan,true);
end;

procedure TForm2.scScroll(Sender: TObject; ScrollCode: TScrollCode;
  var ScrollPos: Integer);
begin
  if ScrollCode = scEndScroll then
    BASS_ChannelSetPosition(chan, BASS_ChannelSeconds2Bytes(chan,sc.position), BASS_POS_BYTE);
end;

procedure TForm2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  BASS_ChannelStop(chan);
end;

end.
