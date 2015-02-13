unit uDM;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, DB, FileUtil, ZConnection, ZDataset;

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
    tblAquaaquaDepth: TLargeintField;
    tblAquaaquaHeight: TLargeintField;
    tblAquaaquaID: TLargeintField;
    tblAquaaquaNM: TStringField;
    tblAquaaquaOpstart: TDateField;
    tblAquaaquaWidth: TLargeintField;
    tblDagaquaID: TLargeintField;
    tblDagdagDatum: TDateField;
    tblDagdagID: TLargeintField;
    ZConnection1: TZConnection;
    qryDag: TZQuery;
    qryAqua: TZQuery;
    tblDag: TZTable;
    tblAqua: TZTable;
    tblFoodinfo: TZTable;
    tblFood: TZTable;
    qryFoodPerDag: TZQuery;
    ZTable1: TZTable;
  private
    { private declarations }
  public
    { public declarations }
  end;

procedure SwitchAqua(iAqua: integer);
procedure SwitchDay();

var
  DM: TDM;

implementation

{$R *.lfm}

procedure SwitchAqua(iAqua: integer);
begin
  with DM.qryDag do
  begin
    Close;
    ParamByName('ThisAqua').Value := iAqua;
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

end.

