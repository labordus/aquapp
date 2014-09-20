unit uDM;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, ZConnection, ZDataset;

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
    qryFoodperdag: TZQuery;
  private
    { private declarations }
  public
    { public declarations }
  end;

  procedure SwitchAqua(iAqua: Integer);
  procedure SwitchDay();

var
  DM: TDM;

implementation

{$R *.lfm}

procedure SwitchAqua(iAqua: Integer);
begin
  with DM.qryDag do
  begin
    close;
    ParamByName('ThisAqua').Value := iAqua;
    open;
  end;
end;

procedure SwitchDay();
begin
  with DM.qryFoodperdag do
  begin
    close;
//    ParamByName('ThisDay').Value := 1;
      ParamByName('ThisDay').Value := DM.qryDag.FieldByName('dagID').AsInteger;
    open;
  end;
end;

end.

