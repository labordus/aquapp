unit configform;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ComCtrls,
  DBGrids, DbCtrls, StdCtrls, ExtCtrls, EditBtn, Spin, db;

type

  { TfrmConfig }

  TfrmConfig = class(TForm)
    cbxToevoegsoort: TDBLookupComboBox;
    DateEdit1: TDateEdit;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    DBGrid1: TDBGrid;
    gridFood: TDBGrid;
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
    navWaardes2: TDBNavigator;
    pageConfData: TPageControl;
    PageConf: TPageControl;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
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
    procedure cbxToevoegsoortChange(Sender: TObject);
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
//  with DM.qryToevoegsoort do
//  begin
//    Close;
//    ParamByName('Toevoeg').Value := DM.tblToevoeg.FieldByName('toevoegID').AsInteger;
//    Open;
//  end;
end;

procedure TfrmConfig.cbxToevoegsoortChange(Sender: TObject);
var
  iRec: integer;
begin
//  DM.tblTabset.Locate('tabsetNM', DBLookupComboBox1.Caption, []);
//  SwitchTabset(DM.tblTabset.FieldByName('tabsetID').AsInteger);
  DM.tblToevoegsoort.Locate('toevoegsoortNM', cbxToevoegsoort.Caption, []);
  with DM.qryToevoegpersoort do
  begin
    Close;
    ParamByName('Toevoegsoort').Value := DM.tblToevoegsoort.FieldByName('toevoegsoortID').AsInteger;
//      ParamByName('Toevoeg').Value := 5;
    Open;
  end;


end;

{ TfrmConfig }

end.

