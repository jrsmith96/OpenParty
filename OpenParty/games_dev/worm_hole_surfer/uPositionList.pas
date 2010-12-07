unit uPositionList;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, DGLOpenGL;

type
  //Zeiger auf den Punkt
  PglVector3f = ^TglVector3f;

  //Liste die die Punkte verwaltet
  TPositionList = class(TObject)
  private
    //Get-Methoden
    function GetPoint(Index: Integer): TglVector3f;
    function GetCount: Integer;
    //Set-Methoden
    procedure SetPoint(Index: Integer; Value: TglVector3f);
  protected
    //Liste mit Zeigern auf die Punkte
    fList: TList;
  public
    //Eigenschaften
    property Points[Index: Integer]: TglVector3f read GetPoint write SetPoint; default;
    property Count                 : Integer   read GetCount;
    //Methoden
    procedure Add(const v: TglVector3f);
    procedure Insert(const v: TglVector3f; const Index: Integer);
    procedure Delete(const Index: Integer);
    function IndexOf(const v: TglVector3f): Integer;
    procedure Exchange(const Index1, Index2: Integer);
    procedure Move(const Index1, Index2: Integer);
    procedure Clear;

    constructor Create;
    destructor Destroy; override;
  end;

implementation

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//TPositionList/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//PRIVATE//PRIVATE//PRIVATE//PRIVATE//PRIVATE//PRIVATE//PRIVATE//PRIVATE//PRIVATE//PRIVATE//PRIVATE//PRIVATE//PRIVATE//PRIVATE//PRIVATE//PRIVATE//PRIVATE//PRIVATE//PRIVATE//PRIVATE//PRIVATE//PRIVATE//PRIVATE//PRIVATE//PRIVATE//PRI//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//ließt einen Punkt aus der Liste
//@Index: Index an dem der Punkt in der Liste liegt;
//@result: aus der Liste gelesener Punkt;
function TPositionList.GetPoint(Index: Integer): TglVector3f;
begin
  result := PglVector3f(fList[Index])^;
end;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//ermittelt die Anzahl der Punkt in der Liste
//@result: Anzahl der Punkte in der Liste;
function TPositionList.GetCount: Integer;
begin
  result := fList.Count;
end;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//schreibt einen Punkt in die Liste
//@Index: Index der Liste an dem der Punkt geschrieben werden soll;
//@Value: Puntk der in die Liste geschrieben werden soll;
procedure TPositionList.SetPoint(Index: Integer; Value: TglVector3f);
begin
  PglVector3f(fList[Index])^ := Value;
end;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//PUBLIC//PUBLIC//PUBLIC//PUBLIC//PUBLIC//PUBLIC//PUBLIC//PUBLIC//PUBLIC//PUBLIC//PUBLIC//PUBLIC//PUBLIC//PUBLIC//PUBLIC//PUBLIC//PUBLIC//PUBLIC//PUBLIC//PUBLIC//PUBLIC//PUBLIC//PUBLIC//PUBLIC//PUBLIC//PUBLIC//PUBLIC//PUBLIC//PUBL//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//fügt einen neuen Punkt am Ende der Liste hinzu
//@v: Punkt der hinzugefügt werden soll;
procedure TPositionList.Add(const v: TglVector3f);
var p: PglVector3f;
begin
  new(p);
  p^ := v;
  fList.Add(p);
end;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//fügt einen neuen Punkt an dem angegebenen Index zur Liste hinzu
//@v: Punkt der hinzugefügt werden soll;
//@Index: Stelle an der der Punkt eingetragen werden soll;
procedure TPositionList.Insert(const v: TglVector3f; const Index: Integer);
var p: PglVector3f;
begin
  new(p);
  p^ := v;
  fList.Insert(Index, p);
end;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//löscht einen Punkt aus der Liste
//@Index: Index des Punktes der gelöscht werden soll;
procedure TPositionList.Delete(const Index: Integer);
begin
  Dispose(PglVector3f(fList[Index]));
  fList.Delete(Index);
end;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//ermittelt den Index eines Punktes
//@v: Punkt der gesucht werden soll;
//@result: Index des Punktes in der Liste, ODER -1 wenn er nicht gefunden wurde;
function TPositionList.IndexOf(const v: TglVector3f): Integer;
var i: Integer;

  function Equals(const v1, v2: TglVector3f): Boolean;
  var i: Integer;
  begin
    for i := 0 to 2 do
      if v1[i] <> v2[i] then
        exit(false);
    exit(true);
  end;

begin
  for i := 0 to fList.Count-1 do
    if Equals(PglVector3f(fList[i])^, v) then
      exit(i);
  exit(-1);
end;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Tauscht 2 Punkte in der Liste
//@Index1: Index des 1. Punktes;
//@Index2: Index des 2. Punktes;
procedure TPositionList.Exchange(const Index1, Index2: Integer);
begin
  fList.Exchange(Index1, Index2);
end;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//verschiebt einen Punkt in der Liste und rückt dabei alle Punkte dazwischen um eine Stelle nach
//@Index1: Index des Punktes, der verschoben werden soll;
//@Index2: Index der Stelle an die verschoben werden soll;
procedure TPositionList.Move(const Index1, Index2: Integer);
begin
  fList.Move(Index1, Index2);
end;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//löscht alle Punkte in der Liste
procedure TPositionList.Clear;
begin
  while fList.Count > 0 do begin
    Dispose(PglVector3f(fList[0]));
    fList.Delete(0);
  end;
end;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//erzeugt das Objekt
constructor TPositionList.Create;
begin
  inherited Create;
  fList := TList.Create;
end;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//gibt das Objekt frei
destructor TPositionList.Destroy;
begin
  Clear;
  inherited Destroy;
end;

end.
