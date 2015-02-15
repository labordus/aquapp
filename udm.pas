unit uDM;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, DB, FileUtil, ZConnection, ZDataset, Dialogs;

type

  { TDM }

  TDM = class(TDataModule)
    dsFoodperdag: TDatasource;
    dsFood: TDatasource;
    dsFoodinfo: TDatasource;
    dsDagPerAqua: TDatasource;
    dsAquaALL: TDatasource;
    dsAqua: TDatasource;
    dsDag: TDatasource;
    dsWaardes: TDataSource;
    qryDelFoodinfo: TZQuery;
    qryFoodPerDagdagID: TLargeintField;
    qryFoodPerDagfoodID: TLargeintField;
    qryFoodPerDagfoodinfoAmount: TFloatField;
    qryFoodPerDagfoodinfoTime: TTimeField;
    qryFoodPerDagfoodNM: TStringField;
    qryFoodPerDagfoodOM: TStringField;
    tblAquaaquaDepth: TLargeintField;
    tblAquaaquaHeight: TLargeintField;
    tblAquaaquaID: TLargeintField;
    tblAquaaquaNM: TStringField;
    tblAquaaquaOpstart: TDateField;
    tblAquaaquaWidth: TLargeintField;
    tblDagaquaID: TLargeintField;
    tblDagdagDatum: TDateField;
    tblDagdagID: TLargeintField;
    tblWaardes: TZTable;
    ZConnection1: TZConnection;
    qryDag: TZQuery;
    qryAqua: TZQuery;
    tblDag: TZTable;
    tblAqua: TZTable;
    tblFoodinfo: TZTable;
    tblFood: TZTable;
    qryFoodPerDag: TZQuery;
    ZTable1: TZTable;
    procedure tblFoodBeforeDelete(DataSet: TDataSet);
  private
    { private declarations }
  public
    { public declarations }
  end;

procedure SwitchAqua(iAqua: integer);
procedure SwitchDay();
procedure AddFood(iAmount: integer; foodtime: TTime);
procedure RemoveFood(iDay: integer; iFood: integer);

var
  DM: TDM;

implementation

{$R *.lfm}

{ TDM }

procedure SwitchAqua(iAqua: integer);
begin
  with DM.qryDag do
  begin
    Close;
    ParamByName('ThisAqua').Value := iAqua;
    Open;
  end;
end;

procedure AddFood(iAmount: integer; foodtime: TTime);
begin
  with DM.tblFoodinfo do
  begin
//    BM := GetBookmark;
    Insert;
    FieldByName('dagID').AsInteger := DM.qryDag.FieldByName('dagID').AsInteger;
    FieldByName('foodID').AsInteger := DM.tblFood.FieldByName('foodID').AsInteger; // zoals geselecteerd in grid.
    FieldByName('foodinfoAmount').AsInteger := iAmount;
    FieldByName('foodinfoTime').AsDateTime := foodtime;
    Post;
    ApplyUpdates;
//    GotoBookmark(BM);
  end;
end;

procedure RemoveFood(iDay: integer; iFood: integer);
begin
  with DM.qryDelFoodinfo do
  begin
    Close;
    ParamByName('ThisDay').Value := iDay;
    ParamByName('ThisFood').Value := iFood;
    Open;
  end;
end;

procedure SwitchDay();
begin
  with DM.qryFoodperdag do
  begin
    Close;
    //    ParamByName('ThisDay').Value := 1;
    ParamByName('ThisDay').Value := DM.qryDag.FieldByName('dagID').AsInteger;
    Open;
  end;
end;

procedure TDM.tblFoodBeforeDelete(DataSet: TDataSet);
begin
  if (DM.tblFoodinfo.Locate('foodID', DM.tblFood.FieldByName('foodID').AsInteger, [])) then
    begin
        MessageDlg('Error', 'Constraint error', mtError, [mbOK], 0);
        Abort;
    end;
end;

end.

