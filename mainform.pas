unit mainform;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, DBGrids,
  DBCtrls, ComCtrls, StdCtrls, Spin, EditBtn, Buttons, ExtCtrls, maskedit,
  DateTimePicker;

type

  { TfrmMain }

  TfrmMain = class(TForm)
    btnConfig: TButton;
    btnFoodRemove: TButton;
    btnNextDay: TButton;
    Button1: TButton;
    btnPrevDay: TButton;
    btnFoodAdd: TButton;
    btnAddDay: TButton;
    gridFoodPerDag: TDBGrid;
    DBGrid2: TDBGrid;
    DBGrid3: TDBGrid;
    cbxAqua: TDBLookupComboBox;
    DBGrid5: TDBGrid;
    DBText2: TDBText;
    dtFoodTime: TDateTimePicker;
    PageControl1: TPageControl;
    btnEditAqua: TSpeedButton;
    spinFoodAmount: TSpinEdit;
    tabOverzicht: TTabSheet;
    tabDaginvoer: TTabSheet;
    TrayIcon1: TTrayIcon;
    procedure btnAddDayClick(Sender: TObject);
    procedure btnConfigClick(Sender: TObject);
    procedure btnFoodAddClick(Sender: TObject);
    procedure btnEditAquaClick(Sender: TObject);
    procedure btnFoodRemoveClick(Sender: TObject);
    procedure btnNextDayClick(Sender: TObject);
    procedure btnPrevDayClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure cbxAquaChange(Sender: TObject);
    procedure DBGrid3CellClick(Column: TColumn);
    procedure DBGrid5CellClick(Column: TColumn);
    procedure DBGrid5UserCheckboxState(Sender: TObject; Column: TColumn;
      var AState: TCheckboxState);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    RecList: TBookmarklist;
  public
    { public declarations }
  end;

procedure Openeditaquaform;

var
  frmMain: TfrmMain;

implementation

uses uDM, editaquaform, globals, rasterform, configform;

{$R *.lfm}

{ TfrmMain }

procedure TfrmMain.btnEditAquaClick(Sender: TObject);
begin
  Openeditaquaform;
end;

procedure TfrmMain.btnFoodRemoveClick(Sender: TObject);
var
  iDay, iFood: integer;
begin
  iDay := DM.qryDag.FieldByName('dagID').AsInteger;
  iFood := DM.qryFoodPerDag.FieldByName('foodID').AsInteger;
  RemoveFood(iDay, iFood);
  DM.qryFoodPerDag.Refresh;
end;

procedure TfrmMain.btnFoodAddClick(Sender: TObject);
begin
  AddFood(spinFoodAmount.Value, dtFoodTime.Time);
  DM.qryFoodPerDag.Refresh;
end;

procedure TfrmMain.btnConfigClick(Sender: TObject);
begin
  frmConfig := TfrmConfig.Create(Application);
  try
    if frmConfig.ShowModal = mrOk then;
  finally
    FreeAndNil(frmConfig);
  end;
end;

procedure TfrmMain.btnAddDayClick(Sender: TObject);
begin
  AddDay(date);
//  DM.qryDag.Last;
//  SwitchDay();
end;

procedure TfrmMain.btnNextDayClick(Sender: TObject);
begin
  DM.qryDag.Next;
  SwitchDay;
end;

procedure TfrmMain.btnPrevDayClick(Sender: TObject);
begin
  DM.qryDag.Prior;
  SwitchDay;
end;

procedure TfrmMain.Button1Click(Sender: TObject);
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


procedure TfrmMain.cbxAquaChange(Sender: TObject);
begin
  DM.tblAqua.Locate('aquaNM', cbxAqua.Caption, []);
  SwitchAqua(DM.tblAqua.FieldByName('aquaID').AsInteger);
end;

procedure TfrmMain.DBGrid3CellClick(Column: TColumn);
begin
  SwitchDay;
end;

procedure TfrmMain.DBGrid5CellClick(Column: TColumn);
begin
  if Column.Index=1 then
    RecList.CurrentRowSelected := not RecList.CurrentRowSelected;
end;

procedure TfrmMain.DBGrid5UserCheckboxState(Sender: TObject; Column: TColumn;
  var AState: TCheckboxState);
begin
  if RecList.CurrentRowSelected then
    AState := cbChecked
  else
    AState := cbUnchecked;
end;

procedure TfrmMain.FormActivate(Sender: TObject);
begin
  DM.tblAqua.Locate('aquaNM', cbxAqua.Caption, []);
  SwitchAqua(DM.tblAqua.FieldByName('aquaID').AsInteger);
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  RecList := TBookmarkList.Create(gridFoodPerDag);
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  RecList.Free;
end;


end.

