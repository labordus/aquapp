{-----------------------------------------------------------------------------
  Unit Name: Rasterform
  Author:    Mark labordus
  Date:      23-april-2003
  Purpose:
  History:
-----------------------------------------------------------------------------}
unit Rasterform;

interface

uses
  Forms, Windows, ExtCtrls, JvComponent, JvRollOut,
  fcButton, fcImgBtn, fcShapeBtn, Controls, Classes, StdCtrls, Graphics,
  SysUtils, JvEdit, Mask, wwdbedit, Wwdotdot, Wwdbcomb,
  JvLabel, Buttons, JvBitBtn, JvColorBox, JvColorButton, IvDictio, IvMulti,
  JvExButtons, JvExControls, JvImageSquare;

type
  TfrmRaster = class(TForm)
    Panel1: TPanel;
    Bevel9: TBevel;
    Label134: TLabel;
    Label1: TLabel;
    btnCancel: TJvBitBtn;
    btnOK: TJvBitBtn;
    edtJaar: TComboBox;
    btnJaarTerug: TSpeedButton;
    btnJaarVerder: TSpeedButton;
    IvTranslator1: TIvTranslator;
    JvImageSquare1: TJvImageSquare;
    Label2: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure edtJaarChange(Sender: TObject);
    procedure btnJaarTerugClick(Sender: TObject);
    procedure btnJaarVerderClick(Sender: TObject);
  private
    procedure SetNewYear;
  public
    { Public declarations }
  end;

var
  frmRaster: TfrmRaster;

implementation

{$R *.DFM}

uses jvYearGrid, Mainform;

{-----------------------------------------------------------------------------
  Procedure: TfrmRaster.FormCreate
  Author:    Mark labordus
  Date:      23-april-2003
  Arguments: Sender: TObject
  Result:    None
-----------------------------------------------------------------------------}
procedure TfrmRaster.FormCreate(Sender: TObject);
var
  Ras: TjvyearGrid;
  FToday, FNotLoged, FLoged, FBorderColor: TColor;
begin
  Ras := TjvYearGrid.Create(Self);
  Ras.Parent := Panel1;
  Ras.Left := 0;
  Ras.Top := 0;
  FToday := clRed;
  FLoged := $0000C600;
  FNotLoged := $00EAFFFF;
  FBorderColor := $00FF8484;
  Ras.TodayColor := FToday;
  Ras.NotLogedColor := FNotLoged;
  Ras.LogedColor := FLoged;
  Ras.BorderColor := FBorderColor;
//  Ras.OnExit := Button1Click;

  edtJaar.ItemIndex := edtJaar.Items.IndexOf(IntToStr(Ras.GridYear));
end;

{-----------------------------------------------------------------------------
  Procedure: TfrmRaster.btnOKClick
  Author:    Mark labordus
  Date:      23-april-2003
  Arguments: Sender: TObject
  Result:    None
-----------------------------------------------------------------------------}
procedure TfrmRaster.btnOKClick(Sender: TObject);
begin
  frmMain.Settings1.Save;
  Close;
end;

{-----------------------------------------------------------------------------
  Procedure: TfrmRaster.btnCancelClick
  Author:    Mark labordus
  Date:      23-april-2003
  Arguments: Sender: TObject
  Result:    None
-----------------------------------------------------------------------------}
procedure TfrmRaster.btnCancelClick(Sender: TObject);
begin
  frmMain.Settings1.Load;
  Close;
end;

{-----------------------------------------------------------------------------
  Procedure: TfrmRaster.SetNewYear
  Author:    Mark labordus
  Date:      23-april-2003
  Arguments: None
  Result:    None
-----------------------------------------------------------------------------}
procedure TfrmRaster.SetNewYear;
var
  i: Integer;
  ayear: word;
begin
  for i := 1 to ComponentCount -1 do
  begin
    if Components[i] is TjvyearGrid then
    begin
      ayear := strtoint(edtJaar.Text);
      if ((ayear < 1999)or(ayear > 2050)) then exit;
      TjvyearGrid(Components[i]).GridYear := ayear;
    end;
  end;
end;

{-----------------------------------------------------------------------------
  Procedure: TfrmRaster.edtJaarChange
  Author:    Mark labordus
  Date:      23-april-2003
  Arguments: Sender: TObject
  Result:    None
-----------------------------------------------------------------------------}
procedure TfrmRaster.edtJaarChange(Sender: TObject);
begin
  SetNewYear;
end;

{-----------------------------------------------------------------------------
  Procedure: TfrmRaster.btnJaarTerugClick
  Author:    Mark labordus
  Date:      23-april-2003
  Arguments: Sender: TObject
  Result:    None
-----------------------------------------------------------------------------}
procedure TfrmRaster.btnJaarTerugClick(Sender: TObject);
begin
  edtJaar.ItemIndex := edtJaar.ItemIndex - 1;
  SetNewYear;
end;

{-----------------------------------------------------------------------------
  Procedure: TfrmRaster.btnJaarVerderClick
  Author:    Mark labordus
  Date:      23-april-2003
  Arguments: Sender: TObject
  Result:    None
-----------------------------------------------------------------------------}
procedure TfrmRaster.btnJaarVerderClick(Sender: TObject);
begin
  edtJaar.ItemIndex := edtJaar.ItemIndex + 1;
  SetNewYear;
end;

end.
