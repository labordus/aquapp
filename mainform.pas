unit mainform;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, DBGrids,
  DBCtrls, ComCtrls, StdCtrls, Spin, EditBtn, Buttons, ExtCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    btnNextDay: TButton;
    Button1: TButton;
    btnPrevDay: TButton;
    DBGrid1: TDBGrid;
    DBGrid3: TDBGrid;
    cbxAqua: TDBLookupComboBox;
    DBGrid5: TDBGrid;
    DBText2: TDBText;
    Label10: TLabel;
    PageControl1: TPageControl;
    btnEditAqua: TSpeedButton;
    tabOverzicht: TTabSheet;
    tabDaginvoer: TTabSheet;
    procedure btnEditAquaClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure cbxAquaChange(Sender: TObject);
    procedure DBGrid3CellClick(Column: TColumn);
    procedure DBGrid5CellClick(Column: TColumn);
    procedure DBGrid5UserCheckboxState(Sender: TObject; Column: TColumn;
      var AState: TCheckboxState);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    RecList: TBookmarklist;
  public
    { public declarations }
  end;

procedure Openeditaquaform;

var
  Form1: TForm1;

implementation

uses uDM, editaquaform, globals, rasterform;

{$R *.lfm}

{ TForm1 }


procedure TForm1.btnEditAquaClick(Sender: TObject);
begin
  Openeditaquaform;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  frmRaster := TfrmRaster.Create(Application);
  try
    if frmRaster.ShowModal = mrOk then;
  finally
    FreeAndNil(frmRaster);
  end;
end;

procedure Openeditaquaform;
begin
  frmEditAqua := TfrmEditAqua.Create(Application);
  try
    if frmEditAqua.ShowModal = mrOk then;
  finally
    FreeAndNil(frmEditAqua);
  end;
end;


procedure TForm1.cbxAquaChange(Sender: TObject);
begin
  DM.tblAqua.Locate('aquaNM', cbxAqua.Caption, []);
  SwitchAqua(DM.tblAqua.FieldByName('aquaID').AsInteger);
end;

procedure TForm1.DBGrid3CellClick(Column: TColumn);
begin
  SwitchDay;
end;

procedure TForm1.DBGrid5CellClick(Column: TColumn);
begin
  if Column.Index=1 then
    RecList.CurrentRowSelected := not RecList.CurrentRowSelected;
end;

procedure TForm1.DBGrid5UserCheckboxState(Sender: TObject; Column: TColumn;
  var AState: TCheckboxState);
begin
  if RecList.CurrentRowSelected then
    AState := cbChecked
  else
    AState := cbUnchecked;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  RecList := TBookmarkList.Create(DbGrid1);
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  RecList.Free;
end;


end.

