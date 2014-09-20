unit mainform;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, DBGrids,
  DbCtrls, ComCtrls, StdCtrls, Spin, EditBtn, Buttons, ExtCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    DateEdit1: TDateEdit;
    DateEdit2: TDateEdit;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    DBGrid3: TDBGrid;
    DBGrid4: TDBGrid;
    DBGrid5: TDBGrid;
    DBGrid6: TDBGrid;
    cbxAqua: TDBLookupComboBox;
    DBText1: TDBText;
    DBText2: TDBText;
    Label1: TLabel;
    Label10: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    PageControl1: TPageControl;
    btnEditAqua: TSpeedButton;
    spinHeight: TSpinEdit;
    SpinEdit2: TSpinEdit;
    SpinEdit3: TSpinEdit;
    tabAqua: TTabSheet;
    tabDagen: TTabSheet;
    tabDagOverzicht: TTabSheet;
    procedure btnEditAquaClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure cbxAquaChange(Sender: TObject);
    procedure DBGrid3CellClick(Column: TColumn);
  private
    { private declarations }
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


end.

