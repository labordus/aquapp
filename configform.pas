unit configform;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ComCtrls,
  DBGrids, DbCtrls, StdCtrls, ExtCtrls, EditBtn, Spin, db;

type

  { TfrmConfig }

  TfrmConfig = class(TForm)
    DateEdit1: TDateEdit;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    gridFood: TDBGrid;
    gridToevoeg: TDBGrid;
    gridToevoegsoort: TDBGrid;
    gridWaardes: TDBGrid;
    gridWaardes1: TDBGrid;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    navFood: TDBNavigator;
    navWaardes: TDBNavigator;
    navWaardes1: TDBNavigator;
    pageConfData: TPageControl;
    PageConf: TPageControl;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    SpinEdit2: TSpinEdit;
    SpinEdit3: TSpinEdit;
    spinHeight: TSpinEdit;
    tabAqua: TTabSheet;
    tabBewoner: TTabSheet;
    tabFood: TTabSheet;
    tabToevoegingen: TTabSheet;
    tabTabelOnderhoud: TTabSheet;
    TabSheet2: TTabSheet;
    tabWaardes: TTabSheet;
    procedure gridToevoegCellClick(Column: TColumn);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmConfig: TfrmConfig;

implementation

uses uDM;

{$R *.lfm}

{ TfrmConfig }

procedure TfrmConfig.gridToevoegCellClick(Column: TColumn);
begin
  with DM.qryToevoegsoort do
  begin
    Close;
    ParamByName('Toevoeg').Value := DM.tblToevoeg.FieldByName('toevoegsoortID').AsInteger;
    Open;
  end;
end;

{ TfrmConfig }

end.

