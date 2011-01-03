unit Unit3;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TForm3 = class(TForm)
    Edit1: TEdit;
    Button1: TButton;
    Button2: TButton;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

uses Unit2;

{$R *.DFM}

procedure TForm3.Button2Click(Sender: TObject);
begin
Close;
end;

procedure TForm3.Button1Click(Sender: TObject);
var
  s: string;
begin
with Form2 do
  begin
  ListBox1.Clear;
  setlength(pathlist,0);
  s:=SavePlayList(Edit1.Text,false);
  ComboBox1.Items.Add(s);
  ComboBox1.ItemIndex:=ComboBox1.Items.Count-1;
  CurrentPL:=s;
  Caption:=CurrentPL + ' (0)';
  end;
Close;
end;

end.
