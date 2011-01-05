program Vp;

uses
  Forms,
  Vp_ in 'Vp_.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Video Player';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
