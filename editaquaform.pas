unit editaquaform;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, EditBtn,
  Spin, DbCtrls, StdCtrls;

type

  { TfrmEditAqua }

  TfrmEditAqua = class(TForm)
    DateEdit1: TDateEdit;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    SpinEdit2: TSpinEdit;
    SpinEdit3: TSpinEdit;
    spinHeight: TSpinEdit;
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmEditAqua: TfrmEditAqua;

implementation

uses uDM;

{$R *.lfm}

end.

