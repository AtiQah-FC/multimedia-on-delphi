unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, MPlayer, ExtCtrls, Gauges, ComCtrls, ID3, FileCtrl, Buttons;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Button1: TButton;
    Button2: TButton;
    OpenDialog1: TOpenDialog;
    MediaPlayer1: TMediaPlayer;
    Timer1: TTimer;
    Label2: TLabel;
    Label3: TLabel;
    Button3: TButton;
    Label4: TLabel;
    Label5: TLabel;
    ProgressBar1: TProgressBar;
    Button4: TButton;
    Button5: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure ProgressBar1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
  private
    { Private declarations }
  public
     procedure BeginPlay;
    { Public declarations }
  end;

var
  Form1: TForm1;
  ratio: double;

implementation

uses Unit2,Unit4;

{$R *.DFM}

//подключаем ХР манифест, файл должен быть в директории
//с проектом, для работы программе он не нужен, только при компиляции

{$R WindowsXP.res}

function MusicToStr(n: longint): string;
var
s: string;
sec: longint;
min: longint;
begin
sec:=trunc(n/1000);
min:=trunc(sec/60);
sec:=sec-min*60;
s:=inttostr(min);
if sec<10 then s:=s+' : 0'+inttostr(sec)
else s:=s+' : '+ inttostr(sec);
MusicToStr:=s;
end;

procedure TForm1.BeginPlay;
begin
  label1.Caption:=extractfilename(mediaplayer1.FileName);
  with readID3Tag(mediaplayer1.FileName) do
    begin
    label4.Caption := Artist;
    label5.Caption := Title;
    end;
  ratio:=mediaplayer1.Length/progressbar1.Max;
  label2.Caption:=MusicToStr(mediaplayer1.Length);
  mediaplayer1.Play;
end;


procedure TForm1.Button1Click(Sender: TObject);
begin
if OpenDialog1.Execute then
  begin
  mediaplayer1.FileName:=opendialog1.FileName;
  mediaplayer1.Open;
  BeginPlay;
  end;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
if mpcanplay in mediaplayer1.Capabilities then
  begin
  progressbar1.Position:=trunc(mediaplayer1.Position / ratio);
  label3.Caption:=MusicToStr(mediaplayer1.Position);
  if mediaplayer1.Position = mediaplayer1.Length then Form2.NextTrack;
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
if mpcanplay in mediaplayer1.Capabilities then
 if mediaplayer1.Mode=mpplaying then
 mediaplayer1.Pause
 else
 mediaplayer1.Play;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
if form2.Visible then form2.Close
else form2.Show;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
 close
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
 Form4.Show;
end;

procedure TForm1.ProgressBar1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
if mpcanplay in mediaplayer1.Capabilities then
  begin
  mediaplayer1.Position:=trunc(x * ratio);
  mediaplayer1.Play;
  end;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
form2.Close;
end;

end.
