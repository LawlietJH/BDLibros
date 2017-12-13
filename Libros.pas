unit Libros;            // By LawlietJH, Versión 1.3.2

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Grids, DBGrids, DB, DBTables, Menus, ClipBrd,
  Mask, DBCtrls;

type
  TLibroForm = class(TForm)
    Label2: TLabel;
    Label1: TLabel;
    btnRefrescar: TBitBtn;
    btnBusqueda: TBitBtn;
    btnQuery: TBitBtn;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    PopupMenu1: TPopupMenu;
    Pegar1: TMenuItem;
    Limpiar1: TMenuItem;
    IrA1: TMenuItem;
    Primero1: TMenuItem;
    Ultimo1: TMenuItem;
    Label3: TLabel;
    Buscar1: TMenuItem;
    ComboBox3: TComboBox;
    Copiar1: TMenuItem;
    Modificar1: TMenuItem;
    tbLibros: TTable;
    dsQuery: TDataSource;
    dsLibros: TDataSource;
    dbgQuery: TDBGrid;
    dbgLibros: TDBGrid;
    qryLibros: TQuery;
    DBText1: TDBText;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    tbLibrosID: TAutoIncField;
    tbLibrosLibro: TStringField;
    tbLibrosAutor: TStringField;
    tbLibrosPropietario: TStringField;
    tbLibrosPrestado: TStringField;
    tbLibrosAQuien: TStringField;
    tbLibrosTomo: TFloatField;
    tbLibrosSaga: TStringField;
    tbLibrosCosto: TCurrencyField;
    tbLibrosFechaCompra: TDateField;
    tbLibrosFechaPrestamo: TDateField;
    tbLibrosFechaDebolucion: TDateField;
    tbLibrosFechaRegalo: TDateField;
    tbLibrosComentarios: TStringField;
    qryLibrosID: TIntegerField;
    qryLibrosLibro: TStringField;
    qryLibrosAutor: TStringField;
    qryLibrosPropietario: TStringField;
    qryLibrosPrestado: TStringField;
    qryLibrosAQuien: TStringField;
    qryLibrosTomo: TFloatField;
    qryLibrosSaga: TStringField;
    qryLibrosCosto: TCurrencyField;
    qryLibrosFechaCompra: TDateField;
    qryLibrosFechaPrestamo: TDateField;
    qryLibrosFechaDebolucion: TDateField;
    qryLibrosFechaRegalo: TDateField;
    qryLibrosComentarios: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure btnQueryClick(Sender: TObject);
    procedure btnBusquedaClick(Sender: TObject);
    procedure btnRefrescarClick(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure ComboBox3Change(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure Modificar1Click(Sender: TObject);
    procedure Primero1Click(Sender: TObject);
    procedure Ultimo1Click(Sender: TObject);
    procedure Buscar1Click(Sender: TObject);
    procedure Copiar1Click(Sender: TObject);
    procedure Pegar1Click(Sender: TObject);
    procedure Limpiar1Click(Sender: TObject);
    procedure dbgQueryKeyPress(Sender: TObject; var Key: Char);
    procedure BuscarID(ID: String; Componente: String = '');
    procedure Copiar(Caso: Integer);
    procedure Pegar();
    procedure Query(Query: String);
    procedure GetDatos();
    procedure EjecutarQuery(InputString: String);
    function EstaAlFinal(Buscado, Texto: string): Boolean;
    function EliminaSaltoLinea(const Cadena: string): string;

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  LibroForm: TLibroForm;
  Comprueba: String;

implementation

{$R *.dfm}

//==============================================================================

procedure TLibroForm.FormCreate(Sender: TObject);
begin
   ComboBox1.ItemIndex := 4;
   Clipboard.AsText := '';
   tbLibros.FindLast;
end;

//==============================================================================

procedure TLibroForm.btnQueryClick(Sender: TObject);
var
   InputString: String;
begin
   InputString := qryLibros.SQL.Strings[0];
   InputString := InputBox('Nuevo Query','Tecle el Query a ejecutar', InputString);
   EjecutarQuery(InputString);
end;

procedure TLibroForm.btnBusquedaClick(Sender: TObject);
var
   InputString: String;
begin
   InputString := InputBox('Buscar Libro','Escribe Un Indicio del Libro', '');

   If InputString <> '' Then
   Begin
      qryLibros.Active := False;
      qryLibros.SQL.Clear;
      qryLibros.SQL.Add('SELECT * FROM Libs WHERE LOWER(Libro) LIKE LOWER(''%'+InputString+'%'')');
      qryLibros.Active := True;
   End
end;

procedure TLibroForm.btnRefrescarClick(Sender: TObject);
begin
   EjecutarQuery(qryLibros.SQL.Strings[0]);
end;

procedure TLibroForm.EjecutarQuery(InputString: String);
Begin
   If InputString <> '' Then
   Begin
      qryLibros.Active := False;
      qryLibros.SQL.Clear;
      qryLibros.SQL.Add(InputString);
      Try
         qryLibros.Active := True;
      Except
         On EDBEngineError Do
            ShowMessage('El Query que insertó tiene un error. Verifiquelo, e intente después.');
      End;
   End
   Else ShowMessage('El Query que proporcionó no es válido.' + #13#10 + 'Verifiquelo e intente de nuevo.');
End;

//==============================================================================

procedure TLibroForm.ComboBox1Change(Sender: TObject);
begin

   Case ComboBox1.ItemIndex Of
   0: Begin
         Comprueba := 'Autor';
         GetDatos();
      End;
   1: Begin
         Query('SELECT * FROM Libs WHERE (LOWER(Prestado) = ''s'' or LOWER(Prestado) = ''si'')');
      End;
   2: Begin
         Comprueba := 'Propietario';
         GetDatos();
      End;
   3: Begin
         Comprueba := 'Saga';
         GetDatos();
      End;
   4: Begin
         Query('SELECT * FROM Libs');
      End;
   //ShowMessage(dbgLibros.Fields[5].AsString);
   //ShowMessage(dbgLibros.DataSource.DataSet.FieldByName('Saga').AsString);
   End;
end;

procedure TLibroForm.ComboBox2Change(Sender: TObject);
Var
   ComboBoxDato: String;
begin
   ComboBoxDato := ComboBox2.Text;

   If ComboBox2.ItemIndex = 0 Then
   Begin
      qryLibros.Active := False;
      qryLibros.SQL.Clear;
      qryLibros.SQL.Add('SELECT * FROM Libs');
      qryLibros.Active := True;
   End
   Else
   Begin
   
      qryLibros.Active := False;
      qryLibros.SQL.Clear;

      If ComboBoxDato = 'Sin Datos' Then ComboBoxDato := '';

      If Comprueba = 'Saga' Then qryLibros.SQL.Add('SELECT * FROM Libs WHERE '+Comprueba+' = '''+ComboBoxDato+''' ORDER BY Tomo')
      Else If Comprueba = 'Autor' Then qryLibros.SQL.Add('SELECT * FROM Libs WHERE '+Comprueba+' = '''+ComboBoxDato+''' ORDER BY Saga, Tomo, Libro, ID')
      Else If Comprueba = 'Propietario' Then qryLibros.SQL.Add('SELECT * FROM Libs WHERE '+Comprueba+' = '''+ComboBoxDato+''' ORDER BY Saga, Tomo, Libro, ID'); //NU.

      qryLibros.Active := True;

   End;
end;

procedure TLibroForm.ComboBox3Change(Sender: TObject);
Var
   Query:   String;
begin
   if (ComboBox1.Text = 'Todo') or (ComboBox2.Text = 'Todos') Then
   Begin
      if ComboBox3.Text = 'Descendente' Then
      Begin
         Query := Trim(qryLibros.SQL.Text);
         Query := EliminaSaltoLinea(Query);
         If NOT EstaAlFinal('DESC', Query) Then
         Begin
            If EstaAlFinal('ASC', Query) Then SetLength(Query, Length(Query)-19);
            Query := Query + ' ORDER BY Libro DESC';
            qryLibros.Active := False;
            qryLibros.SQL.Clear;
            qryLibros.SQL.Add(Query);
            qryLibros.Active := True;
         End;
      End Else
      if ComboBox3.Text = 'Ascendente' Then
      Begin
         Query := Trim(qryLibros.SQL.Text);
         Query := EliminaSaltoLinea(Query);
         If NOT EstaAlFinal('ASC', Query) Then
         Begin
            If EstaAlFinal('DESC', Query) Then SetLength(Query, Length(Query)-20);
            Query := Query + ' ORDER BY Libro ASC';
            qryLibros.Active := False;
            qryLibros.SQL.Clear;
            qryLibros.SQL.Add(Query);
            qryLibros.Active := True;
         End;
      End Else
      If ComboBox3.Text = 'Normal' Then
      Begin
         qryLibros.Active := False;
         qryLibros.SQL.Clear;
         qryLibros.SQL.Add('SELECT * FROM Libs');
         qryLibros.Active := True;
      End;
   End
   Else
   Begin
      if ComboBox3.Text = 'Descendente' Then
      Begin
        Query := Trim(qryLibros.SQL.Text);
        Query := EliminaSaltoLinea(Query);
        If NOT EstaAlFinal('DESC', Query) Then
        Begin
           If EstaAlFinal('ASC', Query) Then SetLength(Query, Length(Query)-4);
           Query := Query + ' DESC';
           qryLibros.Active := False;
           qryLibros.SQL.Clear;
           qryLibros.SQL.Add(Query);
           qryLibros.Active := True;
        End;
      End Else
      If ComboBox3.Text = 'Ascendente' Then
      Begin
        Query := Trim(qryLibros.SQL.Text);
        Query := EliminaSaltoLinea(Query);
        If NOT EstaAlFinal('ASC', Query) Then
        Begin
           If EstaAlFinal('DESC', Query) Then SetLength(Query, Length(Query)-5);
           Query := Query + ' ASC';
           qryLibros.Active := False;
           qryLibros.SQL.Clear;
           qryLibros.SQL.Add(Query);
           qryLibros.Active := True;
        End;
      End Else
      If ComboBox3.Text = 'Normal' Then
      Begin
        Query := Trim(qryLibros.SQL.Text);
        Query := EliminaSaltoLinea(Query);
        If EstaAlFinal('ASC', Query) Then SetLength(Query, Length(Query)-4)
        Else If EstaAlFinal('DESC', Query) Then SetLength(Query, Length(Query)-5);
        qryLibros.Active := False;
        qryLibros.SQL.Clear;
        qryLibros.SQL.Add(Query);
        qryLibros.Active := True;
        //Posy := pos('D',Query);
        //For X := 0 To 4 Do Delete(Query, Posy-1, 1);
      End;
   End;
end;

procedure TLibroForm.GetDatos();
Var
   Cony: Integer;
   Cont: Integer;
   Pos:  Integer;
   xD:   Boolean;
Begin
   ComboBox2.Items.Clear;
   ComboBox2.Items.Add('Todos');
   ComboBox2.Visible := True;
   ComboBox2.Sorted := False;

   qryLibros.Active := False;
   qryLibros.SQL.Clear;
   qryLibros.SQL.Add('SELECT * FROM Libs');
   qryLibros.Active := True;

   qryLibros.FindLast;
   Cony := qryLibros.FindField('ID').AsInteger;
   qryLibros.FindFirst;

   For Pos := 0 To Cony - 1 Do
   Begin
      xD := False;
      For Cont := 0 To ComboBox2.Items.Count - 1 Do
      Begin
         If qryLibros.FindField(Comprueba).AsString = ComboBox2.Items[Cont] Then xD := True;
      End;
      If xD = False Then ComboBox2.Items.Add(qryLibros.FindField(Comprueba).AsString);

      qryLibros.Next;
   End;

   For Pos := 0 To ComboBox2.Items.Count - 1 Do
   Begin
      If ComboBox2.Items[Pos] = '' Then
      Begin
         ComboBox2.Items[Pos] := 'Sin Datos';
      End Else
   End;

   qryLibros.FindFirst;
   ComboBox2.ItemIndex := 0;
   ComboBox2.SelStart;
End;

//==============================================================================

procedure TLibroForm.PopupMenu1Popup(Sender: TObject);
Begin
   If TComponent(PopUpMenu1.PopupComponent).Name = 'dbgLibros' Then
   Begin                                 
      PopUpMenu1.Items[1].Visible := True;
      PopUpMenu1.Items[2].Visible := True;
      PopUpMenu1.Items[3].Visible := False;
   End
   Else If TComponent(PopUpMenu1.PopupComponent).Name = 'dbgQuery' Then
   Begin
      PopUpMenu1.Items[1].Visible := False;
      PopUpMenu1.Items[2].Visible := False;
      PopUpMenu1.Items[3].Visible := True;
   End;
End;

procedure TLibroForm.Copiar1Click(Sender: TObject);
Var
   Caso : Integer;
Begin

   Caso := 0;

   If TComponent(PopUpMenu1.PopupComponent).Name = 'dbgLibros' Then Caso := 0
   Else If TComponent(PopUpMenu1.PopupComponent).Name = 'dbgQuery' Then Caso := 1;

   Copiar(Caso);

end;

procedure TLibroForm.Pegar1Click(Sender: TObject);
Begin

   //Columna := dbgLibros.SelectedField.FieldName;  //Obtiene el nombre de la columna actual.

   If TComponent(PopUpMenu1.PopupComponent).Name = 'dbgLibros' Then
   Begin
      dbgLibros.DataSource.Edit;
      Pegar();
   End;

End;

procedure TLibroForm.Limpiar1Click(Sender: TObject);
begin
   dbgLibros.DataSource.Edit;
   Copiar(0);
   dbgLibros.SelectedField.Clear;
End;

procedure TLibroForm.Modificar1Click(Sender: TObject);
begin
   BuscarID(IntToStr(qryLibrosID.Value), 'dbgLibros');
end;

procedure TLibroForm.Buscar1Click(Sender: TObject);
var
   ID: String;
begin
   ID := InputBox('Buscar ID','Escribe Un Número ID', '');
   BuscarID(ID);
end;

procedure TLibroForm.Primero1Click(Sender: TObject);
begin
   If TComponent(PopUpMenu1.PopupComponent).Name = 'dbgLibros' Then tbLibros.FindFirst
   Else If TComponent(PopUpMenu1.PopupComponent).Name = 'dbgQuery' Then qryLibros.FindFirst;
end;

procedure TLibroForm.Ultimo1Click(Sender: TObject);
begin
   If TComponent(PopUpMenu1.PopupComponent).Name = 'dbgLibros' Then tbLibros.FindLast
   Else If TComponent(PopUpMenu1.PopupComponent).Name = 'dbgQuery' Then qryLibros.FindLast;
end;

procedure TLibroForm.Copiar(Caso: Integer);
Var
   Resp : String;
   Comp : String;
Begin

   Resp := Clipboard.AsText;

   Case Caso Of
   0: If dbgLibros.SelectedField.Text <> '' Then Comp := dbgLibros.SelectedField.Text;
   1: If dbgQuery.SelectedField.Text <> '' Then Comp := dbgQuery.SelectedField.Text;
   End;

   If Comp = '' Then Clipboard.AsText := Resp
   Else Clipboard.AsText := Comp;

End;

procedure TLibroForm.Pegar();
Begin
   dbgLibros.DataSource.Edit;
   dbgLibros.SelectedField.Text := Clipboard.AsText;
End;

//==============================================================================

procedure TLibroForm.dbgQueryKeyPress(Sender: TObject; var Key: Char);
Var
   X : Integer;
Begin
   If key = 'p' Then qryLibros.FindFirst Else   // P = Primero:   Va Al Primer Elemento.
   If key = 'u' Then qryLibros.FindLast Else    // U = Último:    Va Al Último Elemento.
   If key = 'a' Then qryLibros.FindPrior Else   // A = Anterior:  Va Al Elemento Anterior.
   If key = 's' Then qryLibros.FindNext Else    // S = Siguiente: Va Al Elemento Siguiente.
   If key = 'b' Then                            // B = Bloque:    Va Al Siguiente Bloque de Elementos.
   Begin                                        // Va De 6 en 6 Descendente.
      If qryLibros.FindField('ID').AsInteger = 1 Then
         For X := 1 To 4 Do qryLibros.FindNext
      Else For X := 1 To 5 Do qryLibros.FindNext;
   End Else
   If key = 'v' Then                            // V = Bloque: Va Al Siguiente Bloque de Elementos.
   Begin                                        // Va De 6 en 6 Ascendente.
      For X := 1 To 5 Do qryLibros.FindPrior
   End Else
   If key = ' ' Then qryLibros.FindNext;
   //Clipboard.AsText := key;
   //qryLibros.Refresh;
End;

procedure TLibroForm.Query(Query: String);
Begin
   ComboBox2.Items.Clear;
   ComboBox2.Visible := False;

   qryLibros.Active := False;
   qryLibros.SQL.Clear;
   qryLibros.SQL.Add(Query);
   qryLibros.Active := True;
End;

procedure TLibroForm.BuscarID(ID: String; Componente: String = '');
var
   Cont:       Integer;
   Total:      Integer;
   Actual:     Integer;
   Encontrado: Boolean;
begin

   Cont := 0;
   Total := tbLibros.RecordCount;
   Actual := qryLibros.RecordCount;
   Encontrado := False;

   If Componente = '' then Componente := TComponent(PopUpMenu1.PopupComponent).Name;

   If Componente = 'dbgLibros' Then
   Begin
      If ID <> '' Then
      Begin
        tbLibros.FindFirst;
        Try
           If StrToInt(ID) > Total Then
           Begin                                                                                                                         
              tbLibros.FindLast;
              ShowMessage('                 Ese ID No Existe!' + #10#13#10#13 + 'Solo Existen En Total: '+IntToStr(Total)+' Registros.');
           End
           Else
           Begin
              While (Not Encontrado) and (Cont < Total) do
              Begin
                 If tbLibros.FindField('ID').AsInteger = StrToInt(ID) Then Break;
                 Cont := Cont + 1;
                 tbLibros.Next;
              End;
           End;
        Except On EConvertError Do ShowMessage('Escribe Un Número');
        End;
      End;
   End Else
   If Componente = 'dbgQuery' Then
   Begin
      If ID <> '' Then
      Begin
        qryLibros.FindFirst;
        Try
           If StrToInt(ID) > Total Then
           Begin
              qryLibros.FindFirst;
              ShowMessage('                 Ese ID No Existe!' + #10#13#10#13 + 'Solo Existen En Total: '+IntToStr(Total)+' Registros.');
           End
           Else
           Begin
              While (Not Encontrado) and (Cont < Actual) do
              Begin
                 If qryLibros.FindField('ID').AsInteger = StrToInt(ID) Then Break;
                 Cont := Cont + 1;
                 qryLibros.Next;
              End;
              If Cont = Actual Then
              Begin                                                          
                 qryLibros.FindFirst;
                 ShowMessage('No se Encontro El ID Buscado en Esta Muestra');
              End;
           End;
        Except On EConvertError Do ShowMessage('Escribe Un ID');
        End;
      End;
   End;
End;

//==============================================================================

function TLibroForm.EliminaSaltoLinea(const Cadena: string): string;
var
  Fuente, FuenteEnd: PChar;
begin
  Fuente := Pointer(Cadena);
  FuenteEnd := Fuente + Length(Cadena);
  while Fuente < FuenteEnd do
  begin
    case Fuente^ of
      #10: Fuente^ := #32;
      #13: Fuente^ := #32;
    end;
    Inc(Fuente);
  end;
  Result := Cadena;
end;

function TLibroForm.EstaAlFinal(Buscado, Texto: string): Boolean;
var
  i: Integer;
begin
  Result:= False;
  i:= Length(Buscado);
  while Texto[Length(Texto)-Length(Buscado)+i] = Buscado[i] do
    Dec(i);
  if i = 0 then
    Result:= True;
end;

end.
