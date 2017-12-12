unit Libros;            // By LawlietJH, Versión 1.2.8

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Grids, DBGrids, DB, DBTables, Menus, ClipBrd,
  Mask, DBCtrls;

type
  TLibroForm = class(TForm)
    Label2: TLabel;
    Label1: TLabel;
    btnID: TBitBtn;
    btnBusqueda: TBitBtn;
    btnQuery: TBitBtn;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    PopupMenu1: TPopupMenu;
    Pegar1: TMenuItem;
    Limpiar1: TMenuItem;
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
    Copiar1: TMenuItem;
    Modificar1: TMenuItem;
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
    IrA1: TMenuItem;
    Primero1: TMenuItem;
    Ultimo1: TMenuItem;
    Label3: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnQueryClick(Sender: TObject);
    procedure btnBusquedaClick(Sender: TObject);
    procedure btnIDClick(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure Copiar1Click(Sender: TObject);
    procedure Pegar1Click(Sender: TObject);
    procedure Limpiar1Click(Sender: TObject);
    procedure dbgQueryKeyPress(Sender: TObject; var Key: Char);
    procedure BuscarID(ID: String);
    procedure Copiar(Caso: Integer);
    procedure Pegar();
    procedure Query(Query: String);
    procedure GetDatos();
    procedure PopupMenu1Popup(Sender: TObject);
    procedure Modificar1Click(Sender: TObject);
    procedure Primero1Click(Sender: TObject);
    procedure Ultimo1Click(Sender: TObject);

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

procedure TLibroForm.FormCreate(Sender: TObject);
begin
   ComboBox1.ItemIndex := 4;
   Clipboard.AsText := '';
   tbLibros.FindLast;
end;

procedure TLibroForm.btnQueryClick(Sender: TObject);
var
   InputString: String;
begin
   InputString := qryLibros.SQL.Strings[0];
   InputString := InputBox('Nuevo Query','Tecle el Query a ejecutar', InputString);

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

procedure TLibroForm.btnIDClick(Sender: TObject);
var
   ID:         String;
begin
   ID := InputBox('Buscar ID','Escribe Un Número ID', '');
   BuscarID(ID);
end;

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

   If TComponent(PopUpMenu1.PopupComponent).Name = 'dbgLibros' Then Caso := 0
   Else If TComponent(PopUpMenu1.PopupComponent).Name = 'dbgQuery' Then Caso := 1;

   Copiar(Caso);

end;

procedure TLibroForm.Pegar1Click(Sender: TObject);
Var
   Columna: String;
Begin

   Columna := dbgLibros.SelectedField.FieldName;

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
   qryLibros.Refresh;
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

procedure TLibroForm.Modificar1Click(Sender: TObject);
begin
   BuscarID(IntToStr(qryLibrosID.Value));
end;

procedure TLibroForm.BuscarID(ID: String);
var
   Cont:       Integer;
   Total:      Integer;
   Encontrado: Boolean;
begin
   If ID <> '' Then
   Begin
      Cont := 0;
      Encontrado := False;

      tbLibros.FindLast;
      Total := tbLibros.FindField('ID').AsInteger;
      tbLibros.FindFirst;

      Try
         If StrToInt(ID) > Total Then
         Begin
            ShowMessage('Ese ID No Existe!');
            tbLibros.FindLast;
         End
         Else
         Begin
            While (not Encontrado) and (Cont < Total) do
            Begin
               If tbLibros.FindField('ID').AsInteger = StrToInt(ID) Then
               Begin
                  Encontrado := True;
                  Break;
               End;
               Cont := Cont + 1;
               tbLibros.Next;
            End;
         End;
      Except On EConvertError Do ShowMessage('Escribe Un Número');
      End;
   End;
End;

end.
