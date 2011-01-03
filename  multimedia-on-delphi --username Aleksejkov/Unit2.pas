unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Menus, ExtCtrls, ShellAPI, FileCtrl, ImgList;

type
  TForm2 = class(TForm)
    ListBox1: TListBox;
    PopupMenu1: TPopupMenu;
    N3: TMenuItem;
    N2: TMenuItem;
    Panel1: TPanel;
    ComboBox1: TComboBox;
    N1: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    OpenDialog1: TOpenDialog;
    N11: TMenuItem;
    N12: TMenuItem;
    N13: TMenuItem;
    N14: TMenuItem;
    N15: TMenuItem;
    procedure N1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure ListBox1DblClick(Sender: TObject);
    procedure ListBox1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ListBox1DragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure ListBox1DragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ListBox1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure N3Click(Sender: TObject);
    procedure ListBox1DrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure FormResize(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure N8Click(Sender: TObject);
    procedure N11Click(Sender: TObject);
    procedure N12Click(Sender: TObject);
  private
  procedure WMDropFiles(var Message: TWMDropFiles); message WM_DROPFILES;
    procedure ManualChoise;
    procedure LoadPlayList;
    procedure DeleteItem;
    procedure AutoChoise;
    { Private declarations }
  protected
  procedure CreateParams(var Params: TCreateParams); override;
  public
    function SavePlayList(PLName: string; Erase: boolean): string;
    procedure NextTrack;
    { Public declarations }
  end;

const
  SaveDir = '\PlayLists\';    //директория для хранения плейлистов
  PLExt = '.txt';             //расширение плейлистов
  DefName = 'Новый PlayList'; //имя нового плейлиста по умолчанию

  FonColor = clwhite;     //цвет фона
  StripeColor = 15789292;  //цвет полос
  SelColor = 12498100; //цвет выделения
  PBColor = 9193010;  //цвет фона проигрываемого элемента
  PFColor = cllime; //цвет шрифта проигрываемого элемента
  LBFontColor = clblack;  //цвет шрифта листбокса по умолчанию

  Ext: array[0..2] of string = ('.mp3','.wma','.wav'); //список расширений для
  //загрузки из проводника, расширения обязательно маленькими буквами
  OpenFilter = 'music files|*.mp3;*.wma;*.wav';
  //фильтр для диалога добавления файлов

var
  Form2: TForm2;

  BufSize      : Integer; // размер буфера для файла
  FilePath      : array of char; // Путь к файлу
  FileName      : string; // Название Файла
  FilesCount    : integer; // Количество перетаскиваемых файлов

  CurrentPL: string; //имя текущего открытого плейлиста
  PlayItem: string; //текущий воспроизводимый элемент
  pathlist: array of string;

implementation

uses Unit1, Unit3;

{$R *.DFM}

procedure ListFileDir(Path, Ext: string; aCombobox: TCombobox; HideExt: boolean);
var
  SR: TSearchRec;
begin
if FindFirst(Path + Ext, faAnyFile, SR) = 0 then
  begin
    repeat
    if (SR.Attr <> faDirectory) then
      if HideExt then
        begin
        //удаляем расширение
        Delete(SR.Name,length(SR.Name)-3,4);
        aCombobox.items.Add(SR.Name);
        end
      else
      aCombobox.items.Add(SR.Name);
    until FindNext(SR) <> 0;
    FindClose(SR);
  end;
end;

procedure AddFromFolder(Path, Exte: string; aListBox: TListBox);
var
  SR: TSearchRec;
  fe: string;
  j: integer;
begin
if FindFirst(Path + Exte, faAnyFile, SR) = 0 then
  begin
    repeat
    if (SR.Attr <> faDirectory) then
      begin
      fe:=ExtractFileExt(SR.Name);
      for j:=0 to length(Ext)-1 do
        if AnsiLowerCase(fe) = Ext[j] then
          begin
          aListBox.Items.Add(SR.Name);
          setlength(pathlist,aListBox.items.Count);
          pathlist[length(pathlist)-1]:=Path+SR.Name;
          Break;
          end;
      end;
    until FindNext(SR) <> 0;
    FindClose(SR);
  end;
end;

//функция сохраняет плейлист и возвращает имя под к-рым сохранила
//PLName - имя под к-рым надо сохранить
//Erase - заменять ли файл, если нет, к имени добавится номер
function TForm2.SavePlayList(PLName: string; Erase: boolean): string;
var
  plf: TextFile;
  i: integer;
  fn: string;
begin
if not DirectoryExists(ExtractFilePath(Application.EXEName)+SaveDir) then
  if not CreateDir(ExtractFilePath(Application.EXEName)+SaveDir) then
  raise Exception.Create('Cannot create '+
        ExtractFilePath(Application.EXEName)+SaveDir);

fn:=ExtractFilePath(Application.EXEName)+SaveDir+PLName+PLExt;

if not Erase then
if FileExists(fn) then
  begin
  fn:=ExtractFilePath(Application.EXEName)+SaveDir+PLName+'(2)'+PLExt;
  i:=2;
  while FileExists(fn) do
    begin
    inc(i);
    fn:=ExtractFilePath(Application.EXEName) +
    SaveDir + PLName + '(' + inttostr(i) + ')' + PLExt;
    end;
  PLName:=PLName+'('+inttostr(i)+')';
  end;

AssignFile(plf,fn);
Rewrite(plf);
for i:=0 to length(PathList)-1 do
  WriteLn(plf,PathList[i]);
CloseFile(plf);
Result:=PLName;
end;

procedure TForm2.DeleteItem;
var
  i,j,n: integer;
begin
if ListBox1.ItemIndex <> -1 then
  begin
  n:=0;
  for i:=ListBox1.Items.Count-1 downto 0 do
    if ListBox1.Selected[i] then
      begin
      //index:=ListBox1.ItemIndex;
      ListBox1.Items.Delete(i);

      for j:=i to Length(pathlist)-2 do
      pathlist[j]:=pathlist[j+1];
      SetLength(pathlist,Length(pathlist)-1);
      
      inc(n);
      end;
  //showmessage('удалено '+inttostr(n));
  Caption:=CurrentPL+' ('+inttostr(ListBox1.Items.Count)+')';
  end;
end;

procedure TForm2.LoadPlayList;
var
  plf: TextFile;
  fn,s: string;
  n: integer;
begin
fn:=ExtractFilePath(Application.EXEName)+SaveDir+
ComboBox1.Text+PLExt;
if fileexists(fn) then
  begin
  n:=0;
  setlength(pathlist,n);
  ListBox1.Clear;
  AssignFile(plf,fn);
  Reset(plf);
  while not Eof(plf) do
    begin
    ReadLn(plf,s);
    Listbox1.Items.Add(ExtractFileName(s));
    setlength(pathlist,n+1);
    PathList[n]:=s;
    inc(n);
    end;
  CloseFile(plf);
  Caption:=ComboBox1.Text + ' (' + inttostr(n) + ')';
  end;
end;

//разрешаем форме принимать файлы
procedure TForm2.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  Params.ExStyle := Params.ExStyle or WS_EX_ACCEPTFILES or WS_EX_APPWINDOW;
  Params.WndParent := GetDesktopWindow;
end;

//принятие файлов
procedure TForm2.WMDropFiles(var Message: TWMDropFiles);
var
i,j: integer;
fe: string;
begin
FilesCount := DragQueryFile(Message.Drop, $FFFFFFFF, nil, 0);

for i := 0 to FilesCount-1 do
  begin
    BufSize    := DragQueryFile(Message.Drop, i, nil, 0);
    SetLength(FilePath, BufSize + 1);
    DragQueryFile(Message.Drop, i, PChar(FilePath), BufSize + 1);
    FileName := ExtractFileName(PChar(FilePath));

    fe:=ExtractFileExt(PChar(FilePath));
    for j:=0 to length(Ext)-1 do
      if AnsiLowerCase(fe) = Ext[j] then
        begin
        listbox1.Items.Add(FileName);
        setlength(pathlist,listbox1.items.Count);
        pathlist[length(pathlist)-1]:=PChar(FilePath);
        Break;
        end;
  end;

Caption:=CurrentPL+' ('+inttostr(ListBox1.Items.Count)+')';

DragFinish(Message.Drop);
end;

procedure TForm2.NextTrack;
begin
if ListBox1.Items.Count > 0 then
  begin
  if N5.Checked then  //повторять одну
    begin
    AutoChoise;
    end;
  if N6.Checked then  //повторять все
    begin
    if ListBox1.Items.IndexOf(PlayItem) = ListBox1.Items.Count-1 then
    PlayItem:=ListBox1.Items[0] else
    PlayItem:=ListBox1.Items[ListBox1.Items.IndexOf(PlayItem)+1];
    AutoChoise;
    end;
  if N7.Checked then  //в случ порядке
    begin
    Randomize;
    PlayItem:=ListBox1.Items[Random(ListBox1.Items.Count)];
    AutoChoise;
    end;
  if N8.Checked then  //откл повтор
    begin
    end;
  end;
end;

procedure TForm2.AutoChoise;
begin
Caption:=CurrentPL+' '+ inttostr(ListBox1.Items.IndexOf(PlayItem)+1)+' ('+
inttostr(listbox1.items.count)+')';
with Form1.MediaPlayer1 do
  begin
  FileName:=pathlist[ListBox1.Items.IndexOf(PlayItem)];
  Open;
  end;
ListBox1.Repaint;
Form1.BeginPlay;
end;

procedure TForm2.ManualChoise;
begin
if listbox1.ItemIndex <> -1 then
  begin
  Caption:=CurrentPL+' '+ inttostr(listbox1.ItemIndex+1)+' ('+
  inttostr(listbox1.items.count)+')';
  with Form1.MediaPlayer1 do
    begin
    FileName:=pathlist[listbox1.itemindex];
    Open;
    end;
  PlayItem:=listbox1.items[listbox1.itemindex];
  ListBox1.Repaint;
  Form1.BeginPlay;
  end;
end;

procedure TForm2.N1Click(Sender: TObject);
begin
form3.Edit1.Text:=DefName;
form3.ShowModal;
end;

procedure TForm2.N2Click(Sender: TObject);
begin
ManualChoise;
end;

procedure TForm2.ListBox1DblClick(Sender: TObject);
begin
ManualChoise;
end;

procedure TForm2.ListBox1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  APoint: TPoint;
  Index,i: integer;
begin
  APoint.X := X;
  APoint.Y := Y;
  //начинаем перетаскивание, свойство DragMode должно быть dmManual
  if (Button = mbLeft)and not(ssCtrl in Shift) then
  if Listbox1.ItemAtPos(APoint, True) <> -1 then
  ListBox1.BeginDrag(false);

  //при нажатии правой кнопки выделяем пункт
  if Button = mbRight then
  begin
  Index := ListBox1.ItemAtPos(APoint, True);
  listbox1.ItemIndex:=index;

  if index <> -1 then
  if not ListBox1.Selected[index] then
    begin
    for i:=0 to ListBox1.Items.Count-1 do ListBox1.Selected[i]:=false;
    ListBox1.Selected[index]:=true;
    end;

  //делаем пункты меню неактивными в случае клика в пустом месте
  if index = -1 then
    begin
    N2.Enabled:=false;
    N3.Enabled:=false;
    end else
    begin
    N2.Enabled:=true;
    N3.Enabled:=true;
    end;
  end;
end;

procedure TForm2.ListBox1DragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin
Accept := Source is TListBox;
end;

//обработка перетаскивания пунктов листбокса 
procedure TForm2.ListBox1DragDrop(Sender, Source: TObject; X, Y: Integer);
var
APoint: TPoint;
Index, Sindex, i: integer; //index - куда бросаем, sindex - откуда тянем
Sstring, pstring: string; //строка источник и строка с путем
begin
if (Sender is TListBox) and (Source is TListBox) then
  begin
  APoint.X := X;
  APoint.Y := Y;
  with Sender as TListBox do
    begin
    Index := ItemAtPos(APoint, True);
    sindex:= ItemIndex;
    end;
  if (Index <> -1)and(sindex <> -1) then
    with Sender as TListBox do
    begin
    sstring:=Items.Strings[sindex];
    Items.Delete(sindex);
    Items.Insert(index,sstring);
    ItemIndex:=index;
    Selected[index]:=true;
    //параллельно с листбоксом изменяем массив с путями
    pstring:=pathlist[sindex];
    if index < sindex then
     for i:=sindex downto index+1 do
       pathlist[i]:=pathlist[i-1];
    if index > sindex then
     for i:=sindex to index-1 do
       pathlist[i]:=pathlist[i+1];
    pathlist[index]:=pstring;
    end;
  end;
end;

///Create//////Create//////Create//////Create//////Create///

procedure TForm2.FormCreate(Sender: TObject);
begin
ListFileDir(ExtractFilePath(Application.EXEName)+SaveDir,
'*'+PLExt,Combobox1,true);
if ComboBox1.Items.Count > 0 then
  begin
  ComboBox1.ItemIndex:=0;
  ComboBox1Change(Self);
  CurrentPL:=ComboBox1.Text;
  end else
  CurrentPL:='Default';
ListBox1.Color:=FonColor;
ListBox1.DoubleBuffered:=true;
OpenDialog1.Filter:=OpenFilter;
end;

procedure TForm2.ComboBox1Change(Sender: TObject);
begin
if CurrentPL <> '' then SavePlayList(CurrentPL,true);
LoadPlayList;
CurrentPL:=ComboBox1.Text;
end;

procedure TForm2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
if CurrentPL <> '' then
SavePlayList(CurrentPL,true);
end;

procedure TForm2.ListBox1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key = 13 then ManualChoise;
if key = 46 then DeleteItem;
end;

procedure TForm2.N3Click(Sender: TObject);
begin
DeleteItem;
end;

procedure TForm2.ListBox1DrawItem(Control: TWinControl; Index: Integer;
  Rect: TRect; State: TOwnerDrawState);
var
  S : String;
//  myrect: trect;
begin
//  setrect(myrect,Rect.Left+16,Rect.Top,Rect.right,Rect.bottom);
S:=TListBox(Control).Items[Index];
with TListBox(Control).Canvas do
  begin
  if odSelected in State then
    begin
    Brush.Color:=SelColor;
    Font.Color:=LBFontColor;
    //if Index = TListBox(Control).Items.IndexOf(PlayItem) then
    //Font.Color:=OrangeColor;
    end
  else
    if Index = TListBox(Control).Items.IndexOf(PlayItem) then
      begin
      Brush.color:=PBColor;
      Font.Color:=PFColor;
      end
    else
      if odd(index) then  Brush.Color:=StripeColor
      else Brush.Color:=FonColor;
  FillRect(Rect);
  DrawText(Handle,@S[1],Length(S),
  rect,DT_SINGLELINE OR DT_END_ELLIPSIS);

//  if Index = PlayingItem then
//  Imagelist1.draw(ListBox1.Canvas,Rect.Left, Rect.Top,1) else
//  Imagelist1.draw(ListBox1.Canvas,Rect.Left, Rect.Top,0);
  end;
end;

procedure TForm2.FormResize(Sender: TObject);
begin
ListBox1.Repaint;
end;

procedure TForm2.N5Click(Sender: TObject);
begin
N5.Checked:=true;
end;

procedure TForm2.N6Click(Sender: TObject);
begin
N6.Checked:=true;
end;

procedure TForm2.N7Click(Sender: TObject);
begin
N7.Checked:=true;
end;

procedure TForm2.N8Click(Sender: TObject);
begin
N8.Checked:=true;
end;

procedure TForm2.N11Click(Sender: TObject);
var
i: integer;
fn: string;
begin
if OpenDialog1.Execute then
  begin
  for i:=0 to OpenDialog1.Files.Count-1 do
    begin
    fn:=ExtractFileName(OpenDialog1.Files[i]);
    listbox1.Items.Add(fn);
    setlength(pathlist,listbox1.items.Count);
    pathlist[length(pathlist)-1]:=OpenDialog1.Files[i];
    end;
  Caption:=CurrentPL+' ('+inttostr(ListBox1.Items.Count)+')';
  end;
end;

procedure TForm2.N12Click(Sender: TObject);
var s: string;
begin
if SelectDirectory('Выбор папки','d:\,c:\',s) then
  begin
  AddFromFolder(s+'\','*.*',ListBox1);
  ShowMessage('procedure completed');
  Caption:=CurrentPL+' ('+inttostr(ListBox1.Items.Count)+')';
  end;


//ListFileDir(ExtractFilePath(Application.EXEName)+SaveDir,
//'*'+PLExt,Combobox1,true);
end;

end.
