unit EQ_DEMO;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls, Bass, ExtCtrls;
type
  TForm3 = class(TForm)
    TrackBar1: TTrackBar;
    TrackBar2: TTrackBar;
    TrackBar3: TTrackBar;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label7: TLabel;
    TrackBar5: TTrackBar;
    Label8: TLabel;
    TrackBar6: TTrackBar;
    Label9: TLabel;
    TrackBar7: TTrackBar;
    Label10: TLabel;
    TrackBar8: TTrackBar;
    Label11: TLabel;
    TrackBar9: TTrackBar;
    Label12: TLabel;
    TrackBar10: TTrackBar;
    Label13: TLabel;
    TrackBar11: TTrackBar;
    Label14: TLabel;
    TrackBar12: TTrackBar;
    procedure TrackBar1Change(Sender: TObject);
    procedure TrackBar2Change(Sender: TObject);
    procedure TrackBar3Change(Sender: TObject);
    procedure TrackBar5Change(Sender: TObject);
    procedure TrackBar6Change(Sender: TObject);
    procedure TrackBar7Change(Sender: TObject);
    procedure TrackBar8Change(Sender: TObject);
    procedure TrackBar9Change(Sender: TObject);
    procedure TrackBar10Change(Sender: TObject);
    procedure TrackBar11Change(Sender: TObject);
    procedure TrackBar12Change(Sender: TObject);
  private
    { Private declarations }
  public
   // procedure EQ;
    { Public declarations }
  end;

var
  Form3      : TForm3;
  EQ_FX      :  BASS_DX8_PARAMEQ;
  EQ_MAS     : Array [1..11] of HSTREAM;

procedure EQ;
implementation

uses Unit1;

{$R *.dfm}

procedure EQ;
var
  i       : Byte;
begin
    for i:=1 to 12 do
     EQ_MAS[i]:= BASS_ChannelSetFX(stream, BASS_FX_DX8_PARAMEQ, 1);
     EQ_FX.fCenter:=80;
     BASS_FXSetParameters(EQ_MAS[1], @EQ_FX);
     EQ_FX.fCenter:=170;
     BASS_FXSetParameters(EQ_MAS[2], @EQ_FX);
     EQ_FX.fCenter:=310;
     BASS_FXSetParameters(EQ_MAS[3], @EQ_FX);
     EQ_FX.fCenter:=600;
     BASS_FXSetParameters(EQ_MAS[4], @EQ_FX);
     EQ_FX.fCenter:=1000;
     BASS_FXSetParameters(EQ_MAS[5], @EQ_FX);
     EQ_FX.fCenter:=3000;
     BASS_FXSetParameters(EQ_MAS[6], @EQ_FX);
     EQ_FX.fCenter:=6000;
     BASS_FXSetParameters(EQ_MAS[7], @EQ_FX);
     EQ_FX.fCenter:=12000;
     BASS_FXSetParameters(EQ_MAS[8], @EQ_FX);
     EQ_FX.fCenter:=14000;
     BASS_FXSetParameters(EQ_MAS[9], @EQ_FX);
     EQ_FX.fCenter:=16000;
     BASS_FXSetParameters(EQ_MAS[10], @EQ_FX);
     BASS_FXSetParameters(EQ_MAS[11], @EQ_FX);
     EQ_FX.fGain:=0;
     EQ_FX.fBandwidth:=2.5;
     BASS_FXSetParameters(EQ_MAS[11], @EQ_FX);
end;
procedure TForm3.TrackBar1Change(Sender: TObject);
begin
 BASS_FXGetParameters(EQ_MAS[1], @EQ_FX);
 EQ_FX.fGain:=15-TrackBar1.Position;
 BASS_FXSetParameters(EQ_MAS[1], @EQ_FX);
end;

procedure TForm3.TrackBar2Change(Sender: TObject);
begin
 BASS_FXGetParameters(EQ_MAS[2], @EQ_FX);
 EQ_FX.fGain:=15-TrackBar2.Position;
 BASS_FXSetParameters(EQ_MAS[2], @EQ_FX);
end;

procedure TForm3.TrackBar3Change(Sender: TObject);
begin
 BASS_FXGetParameters(EQ_MAS[3], @EQ_FX);
 EQ_FX.fGain:=15-TrackBar3.Position;
 BASS_FXSetParameters(EQ_MAS[3], @EQ_FX);
end;

procedure TForm3.TrackBar5Change(Sender: TObject);
begin
 BASS_FXGetParameters(EQ_MAS[4], @EQ_FX);
 EQ_FX.fGain:=15-TrackBar5.Position;
 BASS_FXSetParameters(EQ_MAS[4], @EQ_FX);
end;

procedure TForm3.TrackBar6Change(Sender: TObject);
begin
 BASS_FXGetParameters(EQ_MAS[5], @EQ_FX);
 EQ_FX.fGain:=15-TrackBar6.Position;
 BASS_FXSetParameters(EQ_MAS[5], @EQ_FX);
end;

procedure TForm3.TrackBar7Change(Sender: TObject);
begin
 BASS_FXGetParameters(EQ_MAS[6], @EQ_FX);
 EQ_FX.fGain:=15-TrackBar7.Position;
 BASS_FXSetParameters(EQ_MAS[6], @EQ_FX);
end;

procedure TForm3.TrackBar8Change(Sender: TObject);
begin
 BASS_FXGetParameters(EQ_MAS[7], @EQ_FX);
 EQ_FX.fGain:=15-TrackBar8.Position;
 BASS_FXSetParameters(EQ_MAS[7], @EQ_FX);
end;

procedure TForm3.TrackBar9Change(Sender: TObject);
begin
 BASS_FXGetParameters(EQ_MAS[8], @EQ_FX);
 EQ_FX.fGain:=15-TrackBar9.Position;
 BASS_FXSetParameters(EQ_MAS[8], @EQ_FX);
end;

procedure TForm3.TrackBar10Change(Sender: TObject);
begin
 BASS_FXGetParameters(EQ_MAS[9], @EQ_FX);
 EQ_FX.fGain:=15-TrackBar10.Position;
 BASS_FXSetParameters(EQ_MAS[9], @EQ_FX);
end;

procedure TForm3.TrackBar11Change(Sender: TObject);
begin
 BASS_FXGetParameters(EQ_MAS[10], @EQ_FX);
 EQ_FX.fGain:=15-TrackBar11.Position;
 BASS_FXSetParameters(EQ_MAS[10], @EQ_FX);
end;

procedure TForm3.TrackBar12Change(Sender: TObject);
begin
 BASS_FXGetParameters(EQ_MAS[11], @EQ_FX);
 EQ_FX.fGain:=15-TrackBar12.Position;
 BASS_FXSetParameters(EQ_MAS[11], @EQ_FX);
end;

end.
