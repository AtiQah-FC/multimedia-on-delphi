{ ����� (AVI) ������
  � ���������� �.�., 2010}
unit Vp_;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, MPlayer, Buttons, StdCtrls;

type
  TForm1 = class(TForm)
    OpenDialog: TOpenDialog;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    MediaPlayer: TMediaPlayer;
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure MediaPlayerNotify(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
   MediaPlayer.Display := Form1;

   // ��� ����� ������� �� ����� ��������
   // �����. �� �� ������ ������ ...
   SpeedButton1.GroupIndex := 1;
   SpeedButton1.AllowAllUp := True;
end;

// ���������� ������ ����������� AVI �����
procedure DimAvi(f: string; var w,h: integer);
var
    fst: TFileStream;
    // ��������� ��������� AVI ����� �����
    // �����, ��������, �  ..\CBuilder\Include\aviriff.h
    header: record
        RIFF: array[1..4] of char;    // 'RIFF'
        nu1:  array[1..5] of LongInt; // �� ������������ (� ������ ������)
        AVIH: array[1..4] of char;    // 'avih'
        nu2:  array[1..9] of LongInt; // �� ������������ (� ������ ������)
        Width:  LongInt;
        Height: LongInt;
    end;

begin
    fst := TFileStream.Create(f,fmOpenRead);
    fst.Read(header,sizeof(header));
    w := header.Width;
    h := header.Height;
    fst.Destroy;
end;


// ������ �� ������ Eject - ����� �����
procedure TForm1.SpeedButton2Click(Sender: TObject);
var
    top,left: integer; // ����� ������� ���� "������"
    width,height: integer; // ������ ������
    mw,mh: integer; // ����������� ��������� ������ ������
    kh,kw: real;    // ����-�� ��������������� �� h � w
    k: real;        // ����. ���������������

begin
    OpenDialog.Title := '����� �����';
    if not OpenDialog.Execute
      then exit;

    // ������������ ������ ����
    // ��������� ������ � ���������
    // "������" (������� �� ����������� �����),
    // �� ������� ����� ������� ����
    DimAvi(OpenDialog.FileName,width,height);

    mh:=SpeedButton1.Top - 10;
    mw:=Form1.ClientWidth;

    if mh > height
        then kh :=1
        else kh := mh/height;

    if mw > width
        then kw :=1
        else kw := mw/width;

    if kw < kh
        then k := kw
        else k := kh;

    // ����� ������� ���������

    width  := Round(width * k);
    height := Round(height * k);

    left := (Form1.ClientWidth - width ) div 2;
    top := 10;

    MediaPlayer.FileName := OpenDialog.FileName;
    MediaPlayer.Open;
    MediaPlayer.DisplayRect := Rect(left,top,width,height);
    SpeedButton1.Enabled := True;
end;

// ������ �� ������ Play/Stop
procedure TForm1.SpeedButton1Click(Sender: TObject);
begin
    if SpeedButton1.Down  then
    begin
      // ������ ���������������
      MediaPlayer.Play;
      SpeedButton1.Hint := 'Stop';
    end
    else begin
      // ���������� ���������������
      MediaPlayer.Stop;
      SpeedButton1.Hint := 'Play';
    end;
end;

// ������ �� �������
procedure TForm1.MediaPlayerNotify(Sender: TObject);
begin
  if (MediaPlayer.Mode = mpStopped )
     and SpeedButton1.Down
  then
     SpeedButton1.Down := False; // "������" ������ Play
end;

end.
