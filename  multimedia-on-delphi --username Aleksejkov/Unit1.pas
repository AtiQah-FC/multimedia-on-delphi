unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, bass, ShellApi, XPMan, Menus, BASS_DSHOW;

type
  TForm1 = class(TForm)
    TrackBar1: TTrackBar;
    lst1: TListBox;
    lbl1: TLabel;
    btn1: TButton;
    btn2: TButton;
    btn3: TButton;
    btn4: TButton;
    btn6: TButton;
    dlgOpen1: TOpenDialog;
    Timer1: TTimer;
    Timer2: TTimer;
    Label1: TLabel;
    Label2: TLabel;
    Timer3: TTimer;
    pb1: TProgressBar;
    xpmnfst1: TXPManifest;
    pb2: TPaintBox;
    Timer4: TTimer;
    btn5: TButton;
    btn7: TButton;
    btn8: TButton;
    procedure FormCreate(Sender: TObject);
    procedure PlayStrem;
    procedure btn4Click(Sender: TObject);
    procedure btn6Click(Sender: TObject);
    procedure btn2Click(Sender: TObject);
    procedure lst1DblClick(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure btn3Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Error(msg: string);
    procedure LoadMediaFile(mDir: TLabel; OpenFile: TOpenDialog; List: TListBox);  
    procedure FormDestroy(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure Timer3Timer(Sender: TObject);
    procedure NextTrack;
    procedure pb1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Timer4Timer(Sender: TObject);
    procedure btn5Click(Sender: TObject);
    procedure btn7Click(Sender: TObject);
    procedure btn8Click(Sender: TObject);
  private
    { Private declarations }
    modc: Integer;
    samc: Integer;
    strc: Integer;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  stream: HStream;
  f: PCHar;
  track: boolean;
  mDir:TLabel;
  ratio:Double;


implementation

uses Unit2, EQ_DEMO, Trecord;

{$R *.dfm}
{$R bass.res}



procedure TForm1.Error(msg: string);
var
	s: string;
begin
	s := msg + #13#10 + '(Error code: ' + IntToStr(BASS_ErrorGetCode) + ')';
	MessageBox(Handle, PChar(s), nil, 0);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
	modc := 0;		// music module count
	samc := 0;		// sample count
	strc := 0;		// stream count

	// check the correct BASS was loaded
	if (HIWORD(BASS_GetVersion) <> BASSVERSION) then
	begin
		MessageBox(0,'An incorrect version of BASS.DLL was loaded',nil,MB_ICONERROR);
		Halt;
	end;

	// Initialize audio - default device, 44100hz, stereo, 16 bits
	if not BASS_Init(-1, 44100, 0, Handle, nil) then
		Error('Error initializing audio!');
  AnimateWindow(Form1.Handle, 1000, AW_CENTER);
  BASS_SetConfig(BASS_CONFIG_BUFFER,1000);
end;


procedure TForm1.PlayStrem;
begin
if (lst1.ItemIndex<>-1) and (BASS_ChannelIsActive(stream)<>BASS_ACTIVE_PLAYING) then
  begin
    if BASS_ChannelIsActive(stream)=BASS_ACTIVE_PAUSED then
      Bass_ChannelPlay(stream, false)
    else
      begin
        stream:=Bass_StreamCreateFile(false, PChar(lst1.Items[lst1.ItemIndex]),0,0,0);
        Bass_ChannelPlay(stream, false);
      end;

  end;
  ratio:=BASS_ChannelGetLength(stream,BASS_POS_BYTE)/pb1.Max
end;

procedure TForm1.btn4Click(Sender: TObject);
begin
  LoadMediaFile(mDir,dlgOpen1,lst1);
end;

procedure TForm1.btn6Click(Sender: TObject);
begin
  lst1.Items.Delete(lst1.ItemIndex);
end;

procedure TForm1.btn2Click(Sender: TObject);
begin
  Bass_channelstop (stream)
end;

procedure TForm1.lst1DblClick(Sender: TObject);
begin
  if(stream<>0) then Bass_StreamFree(stream);
  PlayStrem;
  pb1.Min:=0;
  pb1.Position:=pb1.Min;
end;

procedure TForm1.btn1Click(Sender: TObject);
begin
  PlayStrem;
end;

procedure TForm1.TrackBar1Change(Sender: TObject);
var
   volume:Real;
begin
   volume:= ((TrackBar1.Max - TrackBar1.Position) / 100);
   BASS_ChannelSetAttribute(stream, BASS_ATTRIB_VOL, volume);
end;

procedure TForm1.btn3Click(Sender: TObject);
begin
  IF btn3.Caption= 'Pause' then
     begin
        BASS_ChannelPause(stream);
        btn3.Caption:= 'Resume';
     end
  else
   begin
       PlayStrem;
       btn3.Caption:= 'Pause';
   end;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  if track= false then
     pb1.Position:=trunc(BASS_ChannelGetPosition(stream, 0)/ratio);
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  bass_free();
end;

procedure TForm1.Timer2Timer(Sender: TObject);
var  TrackLen: Double;
     TrackPos: Double;
     ValPos: Double;
     ValLen: Double;
     Time1: string;
     Time2: string;
begin
  TrackPos:=BASS_ChannelBytes2Seconds(stream,BASS_ChannelGetPosition(stream, 0));
  TrackLen:=BASS_ChannelBytes2Seconds(stream,BASS_ChannelGetLength(stream, 0));
  ValPos:=TrackPos / (24 * 3600);
  ValLen:=TrackLen / (24 * 3600);
  Time1:=FormatDateTime('hh:mm:ss',ValPos);
  Time2:=FormatDateTime('hh:mm:ss',ValLen);
  Label1.Caption:= Time1;
  label2.Caption:=Time2;
end;

procedure TForm1.LoadMediaFile(mDir: TLabel; OpenFile: TOpenDialog;
  List: TListBox);
var
  nam, Dir: string;
  k, k1, i: integer;
begin
  if OpenFile.Execute then
  GetDir(0, dir);
  k:= length(dir);
  for i:=0 to OpenFile.Files.Count-1 do
  begin
    k1:= length(OpenFile.Files.Strings[i]);
    nam:= Copy(OpenFile.Files.Strings[i], k+2, k1-k);
    List.Items.Add(nam);
    mDir.Caption:= Dir + '\';
  end;
end;

procedure TForm1.Timer3Timer(Sender: TObject);
begin
  if BASS_ChannelGetPosition(stream, 0)=BASS_ChannelGetLength(stream, 0) then
     NextTrack;
end;

procedure TForm1.NextTrack;
begin
  if lst1.ItemIndex<lst1.Count-1 then
    begin
      BASS_ChannelStop(stream);
      lst1.ItemIndex:=lst1.ItemIndex+1;
      PlayStrem;
    end;
  if lst1.ItemIndex=lst1.Count-1 then
    begin
      BASS_ChannelStop(stream);
      lst1.ItemIndex:=0;
      PlayStrem;
    end;
end;

procedure TForm1.pb1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
if track=False then
  begin
   bass_ChannelSetPosition(stream, trunc(x * ratio/2), 0);
   PlayStrem;
  end;
end;

procedure TForm1.Timer4Timer(Sender: TObject);
type  fftdata = array[1..8192] of single;
var data : fftdata;
    i, n : integer;
    level: cardinal;
    levelL, levelR: byte;
begin
 if(stream<>0) then
 begin
 level := BASS_ChannelGetLevel(stream);
 levelL := loword(level)*100 div (maxword div 2);
 levelR := hiword(level)*100 div (maxword div 2);

 Bass_ChannelGetData(stream, @data, BASS_DATA_FFT16384);

 With pb2 do
 begin
   Canvas.FillRect(rect(0, 0, pb2.width, pb2.height));
   Canvas.Pen.Color := clRed;
   for i := 1 to 8192 do
   begin
     n := round(data[i] * 100);
     pb2.Canvas.MoveTo(i, 100);
     pb2.Canvas.LineTo(i, 100 - n);
   end;
   Canvas.Rectangle(258,100,266,100-levelL);
   Canvas.Rectangle(268,100,276,100-levelR);
 end;
end;
end;

procedure TForm1.btn5Click(Sender: TObject);
begin
 Form2.btn1Click(Sender);
 Form2.show
end;

procedure TForm1.btn7Click(Sender: TObject);
begin
  if stream<>0 then
  EQ;
  Form3.show;
end;

procedure TForm1.btn8Click(Sender: TObject);
begin
  form4.Show;
end;

end.
