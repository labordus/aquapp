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
    gridWaardes: TDBGrid;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    navFood: TDBNavigator;
    navWaardes: TDBNavigator;
    pageConf: TPageControl;
    Panel1: TPanel;
    Panel2: TPanel;
    SpinEdit2: TSpinEdit;
    SpinEdit3: TSpinEdit;
    spinHeight: TSpinEdit;
    tabFood: TTabSheet;
    tabAqua: TTabSheet;
    tabWaardes: TTabSheet;
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

end.

