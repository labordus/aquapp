unit jvYearGrid;

{$MODE Delphi}

interface

uses
  LCLIntf, LCLType, LMessages,Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids,menus,clipbrd;

type
    TYearData=record
     DisPlaytext:string;
     InfoText:string;
     DefaultColor:Tcolor;
     DoneDay: integer;
//     Custom:Boolean;
    end;

  TonYearChanged= procedure(sender:Tobject;AYear:integer) of object;
  TonSelectDate=procedure(sender:Tobject;Adate:TDate;InfoText:string;InfoColor:Tcolor) of object;
  TonInfoChanging=procedure(sender:Tobject;var InfoText:string; var CanChange:boolean) of object;
  TjvYearGrid = class(TDrawGrid)
  private
    GridPop:TPopupMenu;
    thisyear,thismonth,thisday:word;
    FHTMLBorder: boolean;
    FGridYear: integer;
    FonYearChanged: TOnYearChanged;
    FHTMLFontName: string;
    FonSelectDate: TonselectDate;
    FBorderColor: TColor;
    FTodayColor: TColor;
    FNotLogedColor: TColor;
    FLogedColor: TColor;
    FonInfoChanging: TonInfoChanging;
    { Private declarations }

    procedure DoShowHint(var HintStr: string; var CanShow: Boolean;
      var HintInfo: THintInfo);
    procedure SetHTMLBorder(const Value: boolean);
    procedure SetGridYear(const Value: integer);
    procedure SetonYearChanged(const Value: TOnYearChanged);
    procedure setYear(AYear: word);
//    procedure LoadYear;
//    procedure SaveYear;
    procedure SetupYearData(AYear: word);
    procedure setupmonths;
    function GetCellData(var s: string): boolean;
    function SetCellData(s: string): Boolean;
    procedure CreatePopup;
    procedure year1Click(Sender: TObject);
    procedure SetupGridPop(sender:TObject);
    procedure Launch(Afile: string);
    procedure SetHTMLFontName(const Value: string);
    procedure SetonSelectDate(const Value: TonselectDate);
    procedure SetBorderColor(const Value: TColor);
    procedure SetTodayColor(const Value: TColor);
    procedure SetNotLogedColor(const Value: TColor);
    procedure SetLogedColor(const Value: TColor);
    procedure SetonInfoChanging(const Value: TonInfoChanging);
    function DateToCell(ADate:TDate;var Acol, aRow: integer): Boolean;

  protected
    { Protected declarations }
    procedure DrawCell(ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);override;
    function SelectCell(ACol, ARow: Integer):boolean;override;
    procedure dblclick;override;
  public
    { Public declarations }
    constructor create (AOwner:Tcomponent);override;
    destructor destroy;override;
    function GetSelDateText:string;
    procedure SetSelDateText(Atext:string);
    function GetDateInfo(aDate:TDate;var aText:string):boolean;
    function SetDateInfo(aDate:TDate; aText:string):Boolean;
  published
    { Published declarations }
    property HTMLBorder:boolean read FHTMLBorder write SetHTMLBorder;
    property HTMLFontName:string read FHTMLFontName write SetHTMLFontName;
    property GridYear:integer read FGridYear write SetGridYear;
    property BorderColor:TColor read FBorderColor write SetBorderColor;
    property TodayColor:TColor read FTodayColor write SetTodayColor;
    property NotLogedColor:TColor read FNotLogedColor write SetNotLogedColor;
    property LogedColor:TColor read FLogedColor write SetLogedColor;
    property onYearChanged:TOnYearChanged read FonYearChanged write SetonYearChanged;
    property onSelectDate:TonselectDate read FonSelectDate write SetonSelectDate;
    property onInfoChanging:TonInfoChanging read FonInfoChanging write SetonInfoChanging;
  end;

implementation

uses uDM, Mainform, Rasterform, globals;

const
  cr = chr(13)+chr(10);
  tab = chr(9);


var
//   appldir:string;
   daysinmonth:array[1..12] of integer;
   startdays:array[1..12] of integer;
   theyear:word;
   thisdaystr:string;
   isthisyear:boolean;
   YearData: array [0..37,0..12] of TYearData;
//   YearFile:string;
//   LegendFile:string;
//   YearShift:Tshiftstate;
//   DragCol,DragRow:integer;


{ TjvYearGrid }

constructor TjvYearGrid.create(AOwner: Tcomponent);
begin
 inherited create(AOwner);
 width:= 746;
 height:= 250; //353;
 defaultcolwidth:=16;
 defaultrowheight:=18; //24;
 colcount:=38;
 rowcount:=13;
 FBordercolor := $00FF8484;
 FTodayColor := $0062AAF2;
 FNotLogedColor := $00EAFFFF;
 FNotLogedColor := $0000C600;
// CreatePopup;
// popupmenu:=GridPop;
// GridPop.OnPopup :=SetupGridPop;
 ColWidths [0]:=70;
 showhint:=true;
// Application.ShowHint := True;
// Application.OnShowHint := DoShowHint;
 decodedate(now,thisyear,thismonth,thisday);
 thisdaystr:=inttostr(thisday);
 HTMLFontName:='Arial';
 application.HintHidePause := 5000;
 setYear(0);
end;

destructor TjvYearGrid.destroy;
begin
// SaveYear;
 GridPop.free;
 inherited destroy;
end;

procedure TjvYearGrid.DrawCell(ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var
  s: string;
  d: Integer;
begin
 if assigned(onDrawCell) then
  onDrawCell(self,acol,arow,rect,state);

 s := YearData[acol,arow].DisplayText;
 d := YearData[acol,arow].DoneDay;

 with canvas do begin
  font.Color := clblack;
  font.Style := font.Style - [fsbold];

  if  ((acol = 0)or ((arow = 0)and (YearData[acol,arow].defaultcolor = clwhite))) then
   brush.Color := bordercolor

// Hier kan ik misschien nog eens 'de actieve dag' weergeven.
 
// Vandaag
  else if (isthisyear and (arow=  thismonth)and (s = thisdaystr)) then
  begin
    font.Color := clRed;
    brush.Color := FTodayColor;
    font.Style := font.Style + [fsbold];
  end
// Dag bestaat niet, niet ingelogd
  else if (d <> 0) and (s <> '') then
    brush.Color := FNotLogedColor
// Dag bestaat wel,  ingelogd
  else if (d = 0) and (s <> '') then
    brush.Color := FLogedColor
// alle andere gevallen
  else
    brush.Color := clGray;
    FillRect(rect);

    brush.Color := $00EAFFFF; //YearData[acol,arow].defaultcolor;
    textrect(rect,rect.left,rect.top,s);
   end;
end;


procedure TjvYearGrid.DoShowHint(var HintStr: string; var CanShow: Boolean;
  var HintInfo: THintInfo);
var acol,arow,x,y:integer;
    s,ds:string;
begin
  if HintInfo.HintControl = self then begin
   x:=HintInfo.CursorPos.x;
   y:=HintInfo.cursorPos.y;
   MouseToCell (x,y,acol,arow);
   if ((acol<0)or(arow<0)) then exit;
   ds:=YearData[acol,arow].displaytext;
//   ds:=YearData[acol,arow].doneday;
   if (isthisyear and (arow=thismonth)and (ds=thisdaystr)) then
     s:=sVandaag + ' ';
   canshow:=false;
   if ((acol>=0)and (arow>=0)) then begin
    s:=s+YearData[acol,arow].infotext;
    if s<>'' then begin
     Hintinfo.CursorRect :=CellRect (acol,arow);
     Hintstr:=s;
     canshow:=true;
     end;
    end;
   end;
end;

procedure TjvYearGrid.SetHTMLBorder(const Value: boolean);
begin
  FHTMLBorder := Value;
end;

procedure TjvYearGrid.SetonYearChanged(const Value: TOnYearChanged);
begin
  FonYearChanged := Value;
end;

procedure TjvYearGrid.SetGridYear(const Value: integer);
begin
  if value<>FGridYear then begin
    FGridYear := Value;
    setYear(FGridYear);
    if assigned(onYearChanged) then
     onYearChanged(self,FGridYear);
    end;
end;

procedure TjvYearGrid.setYear(AYear:word);
var year,month,day:word;
begin
 if Ayear=0 then begin
  decodedate(now,year,month,day);
  theyear:=year;
  FGridYear:=theyear;
  end
  else begin
//  SaveYear;
  theyear:=AYear;
  end;
// YearFile:=appldir+'year'+inttostr(theyear)+'.csv';
 isthisyear:= theyear=thisyear;
// if fileexists(YearFile) then
//  LoadYear
//  else
  setupYearData(theyear);
end;

{
procedure TjvYearGrid.SaveYear;
var arow,acol:integer;
    YList,DList:tstringlist;
    s:string;
begin
 YList:=tstringlist.create;
 DList:=tstringlist.create;
 for arow:=0 to 12 do begin
  for acol:=0 to 37 do begin
    Dlist.clear;
    Dlist.append(YearData[acol,arow].DisplayText);
    Dlist.append(IntToStr(YearData[acol,arow].DoneDay));

    YList.Append (DList.commatext);
  end;
 end;
 YList.SaveToFile (YearFile);
 Dlist.free;
 Ylist.free;
end;
}

{
procedure TjvYearGrid.LoadYear;
var arow,acol,index:integer;
    YList,DList:TStringList;
begin
 YList:=tstringlist.create;
 DList:=tstringlist.create;
 YList.LoadFromFile (YearFile);
 index:=0;
 for arow:=0 to 12 do begin
   for acol:=0 to 37 do begin
    Dlist.commatext:=YList[index];
    inc(index);
    YearData[acol,arow].DisplayText:=DList[0];
    YearData[acol,arow].DoneDay := StrToInt(DList[1]);
    YearData[acol,arow].DefaultColor := clWhite;
    end;
  end;
 Dlist.free;
 Ylist.free;
 Invalidate;
end;
}

procedure TjvYearGrid.SetupYearData(AYear: word);
var s,d:string;
    i,acol,arow:integer;
    Acolor:Tcolor;
    iDoneDay: integer;
    thisDate: TDate;
    iUser: Integer;
begin
// iUser := DM.ADOdsUsers.FieldByName('USID').AsInteger;
 setupmonths;
 iDoneDay := 0; // default
 for arow:=0 to 12 do
  for acol:=0 to 37 do begin
 s:='';
 if acol>0 then begin
  i:=((acol-1)mod 7)+1;
  d:=shortdaynames[i][1];
  end;
  if ((arow=0)and(acol=0))then
    s:=inttostr(theyear);
  if ((arow=0)and (acol>0)) then
    s:=d;
  if ((arow<>0)and (acol=0)) then
    s:=longmonthnames[arow];
  if ((arow<>0) and (acol>0)) then begin
    if ((acol>=startdays[arow])and(acol<(startdays[arow]+daysinmonth[arow]))) then
    begin
     s:=inttostr(acol-startdays[arow]+1);

// AYear - jaar - word
// arow - maand - integer
// s - dag - string
     thisdate := EncodeDate(AYear, arow, StrToInt(s));
//     if not DateExist(thisdate, iUser) then
//       iDoneday := 1
//     else
       iDoneday := 0;
    end;
  end;
  if ((acol>0)and (d='S')) then
    Acolor:=clsilver;
  if ((acol>0)and (d<>'S')) then
    Acolor:=clwhite;
//    Yeardata[acol,arow].
  YearData[acol,arow].DisPlayText:=s;
  YearData[acol,arow].DoneDay := iDoneday;
  YearData[acol,arow].InfoText:='';
  YearData[acol,arow].DefaultColor:=Acolor;
  end;
  Invalidate ;
end;

procedure TjvYearGrid.setupmonths;
var year,month,day:word;
    Adate:tdate;
    i:integer;
begin
  for i:=1 to 12 do begin
   year:=theyear;
   month:=i+1;
   if month=13 then begin
    year:=year+1;
    month:=1;
    end;
   day:=1;
   Adate:=encodedate(year,month,day);
   adate:=Adate-1;
   decodedate(Adate,year,month,day);
   daysinmonth[i]:=day;
   year:=theyear;
   month:=i;
   day:=1;
   adate:=encodedate(year,month,day);
   startdays[i]:=dayofweek(adate);
   end;
end;

function TjvYearGrid.GetCellData(var s:string):boolean;
var acol,arow:integer;
begin
 acol:=col;
 arow:=row;
 result:=false;
 if ((acol>0) and (arow>0)) then
  if YearData[acol,arow].displaytext<>'' then begin
   s:=YearData[acol,arow].infotext;
//   s:=YearData[acol,arow].doneday;
   result:=true;
   end;
end;

function TjvYearGrid.SetCellData(s:string):boolean;
var acol,arow:integer;
begin
 acol:=col;
 arow:=row;
 result:=false;
 if ((acol>0) and (arow>0)) then
  if YearData[acol,arow].displaytext<>'' then begin
   YearData[acol,arow].infotext:=s;
//   YearData[acol,arow].doneday:=s;
   result:=true;
   end;
end;

procedure TjvYearGrid.year1Click(Sender: TObject);
var s:string;
    Ayear:word;
begin
{ s:=inputbox(sJaar,sVoerJaarIn,inttostr(GridYear));
 try
  if s='' then exit;
  ayear:=strtoint(s);
  if ((ayear<1999)or(ayear>2050)) then exit;
  GridYear:=ayear;
  except
  mlDialoog('mededeling', sOngeldigJaar, '');
//  showmessage('ongeldig jaar');
  end;
 }
end;

procedure TjvYearGrid.CreatePopup;
var g:Tpopupmenu;
    m:tmenuitem;
begin
{ GridPop:=Tpopupmenu.create(self);
 g:=GridPop;
 m:=tmenuitem.Create (g);
 m.Caption := sJaarPopup;
 m.OnClick := year1click;
 m.tag := 1;
 g.Items.Add (m);
 m:=tmenuitem.Create (g);
 m.Caption :='-';
 g.Items.Add (m);
 m:=tmenuitem.Create (g);
 m.Caption :='-';
 g.Items.Add (m);
 m:=tmenuitem.Create (g);
 m.Caption :='-';
 g.Items.Add (m);
 m:=tmenuitem.Create (g);
 m.Caption :='-';
 g.Items.Add (m);
 m:=tmenuitem.Create (g);
 m.Caption :='-';
 g.Items.Add (m);
 }
end;

procedure TjvYearGrid.SetupGridPop(sender:TObject);
var i,c:integer;
begin
  c:=GridPop.items.count;
  if (col>0) and (row>0) and (YearData[col,row].Displaytext<>'') then
   for i:=0 to c -1 do
    GridPop.items[i].enabled:=true
   else
   for i:=0 to c-1 do
    GridPop.items[i].enabled:=(GridPop.items[i].tag=1);
end;

procedure TjvYearGrid.Launch(Afile: string);
var command,params,workdir:string;
begin
//command:=afile;
//params:=#0;
//workdir:=#0;
// OpenDocument(@command[1]); { *Converted from ShellExecute* }

end;

procedure TjvYearGrid.SetHTMLFontName(const Value: string);
begin
  FHTMLFontName := Value;
end;

function TjvYearGrid.GetSelDateText: string;
var
   ds:string;
//   acol,arow:integer;
begin
  if (col<1) or (row<1) then exit;
  ds:=YearData[col,row].displaytext;
  if ds='' then exit;
  result:=YearData[col,row].infotext;
end;

procedure TjvYearGrid.SetSelDateText(Atext: string);
var ds,s:string;
//    acol,arow:integer;
begin
  if (col<1) or (row<1) then exit;
  ds:=YearData[col,row].displaytext;
  if ds='' then exit;
  YearData[col,row].infotext:=s;
end;

procedure TjvYearGrid.SetonSelectDate(const Value: TonselectDate);
begin
  FonSelectDate := Value;
end;

function TjvYearGrid.SelectCell(ACol, ARow: Longint):boolean;
var
   ds: string;
   Adate: tdate;
   Infotext: string;
   Infocolor: TColor;
   month,day: word;
   Canselect: Boolean;
   s: string;
begin
{  CanSelect:=true;
  if assigned(onselectcell) then
   onselectcell(self,acol,arow,canselect);
  if not CanSelect then begin
   result:=false;
   exit;
   end;
  if (Acol<1) or (Arow<1) then exit;
  ds:=YearData[acol,arow].displaytext;
//  ds:=YearData[acol,arow].doneday;
  if ds='' then exit;
  month:=arow;
  day:=strtoint(YearData[acol,arow].displaytext);
  adate:=encodedate(theyear,month,day);
  infotext:=YearData[acol,arow].infotext;
  infocolor:=YearData[acol,arow].defaultcolor;
//  infotext:=YearData[acol,arow].doneday;

//  decodedate(myDate,theyear,month,day);
  if not DateExist(adate, iCurrentUser) then
  begin
//  begin
//     Dag bestaat niet, aanmaken dus..
    s := DateToStr(adate);
    MaakDag(adate);
  end;
//    YearData[acol,arow].doneday := 1;
//  end;
//  frmMain.JvDateTimePicker1.Date := adate;
  frmMain.wwDBDateTimePicker1.Date := adate;
  HandleAndereDag;
  frmRaster.Close;
//  frmRaster.Visible := False;

  if assigned(onselectDate) then
   onselectdate(self,Adate,Infotext,infocolor);
  result:=true;
  }
end;

procedure TjvYearGrid.dblclick;
begin
 if assigned (ondblclick) then
  ondblclick(self);
end;

procedure TjvYearGrid.SetBorderColor(const Value: TColor);
begin
  if value<>FBorderColor then begin
   FBorderColor := Value;
   invalidate;
   end;
end;

procedure TjvYearGrid.SetTodayColor(const Value: TColor);
begin
  if value<>FTodayColor then begin
   FTodayColor := Value;
   invalidate;
   end;
end;

procedure TjvYearGrid.SetNotLogedColor(const Value: TColor);
begin
  if value<>FNotLogedColor then begin
   FNotLogedColor := Value;
   invalidate;
   end;
end;

procedure TjvYearGrid.SetLogedColor(const Value: TColor);
begin
  if value<>FLogedColor then begin
   FLogedColor := Value;
   invalidate;
   end;
end;

procedure TjvYearGrid.SetonInfoChanging(const Value: TonInfoChanging);
begin
  FonInfoChanging := Value;
end;

function TjvYearGrid.DateToCell(ADate:TDate;var Acol,aRow:integer):boolean;
var ayear,amonth,aday:word;
    wd:integer;
begin
 result:=false;
 decodedate(Adate,ayear,amonth,aday);
 if ayear<>GridYear then exit;
 arow:=Amonth;
 wd:=dayofweek(encodeDate(ayear,amonth,1));
 acol:=wd+aday-1;
 result:=true;
end;


function TjvYearGrid.GetDateInfo(aDate: TDate; var aText: string): boolean;
var acol,arow:integer;
begin
 if DateToCell(aDate,acol,arow) then begin
  Atext:=YearData[acol,arow].infotext;
  result:=true;
  end
  else
   result:=false;
end;

function TjvYearGrid.SetDateInfo(aDate: TDate; aText: string): boolean;
var acol,arow:integer;
begin
 if DateToCell(aDate,acol,arow) then begin
  YearData[acol,arow].infotext:=atext;
  result:=true;
  end
  else
   result:=false;
end;

end.