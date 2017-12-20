unit Libros;            // By LawlietJH, Versión 1.4.0

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
    Version: TLabel;
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
    FiltroPersonalizado1: TMenuItem;
    BuscarLibro1: TMenuItem;
    MainMenu1: TMainMenu;
    Habilitar1: TMenuItem;
    FiltroPersonalizado2: TMenuItem;
    BuscarLibro2: TMenuItem;
    Refrescar1: TMenuItem;
    LineadeDatos1: TMenuItem;
    Refrescar2: TMenuItem;
    Mostar1: TMenuItem;
    SoloRegistro1: TMenuItem;
    SoloFiltro1: TMenuItem;
    ElegirTema1: TMenuItem;
    OscuroPorDefecto1: TMenuItem;
    Claro1: TMenuItem;
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
    procedure FiltroPersonalizado1Click(Sender: TObject);
    procedure BuscarLibro1Click(Sender: TObject);
    procedure FiltroPersonalizado2Click(Sender: TObject);
    procedure BuscarLibro2Click(Sender: TObject);
    procedure Refrescar1Click(Sender: TObject);
    procedure LineadeDatos1Click(Sender: TObject);
    procedure Refrescar2Click(Sender: TObject);
    procedure SoloRegistro1Click(Sender: TObject);
    procedure SoloFiltro1Click(Sender: TObject);
    procedure OscuroPorDefecto1Click(Sender: TObject);
    procedure Claro1Click(Sender: TObject);

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

//============================== 0 - Principal =======================================

procedure TLibroForm.FormCreate(Sender: TObject);
begin
   ComboBox1.ItemIndex := 4;
   Clipboard.AsText := '';
   tbLibros.FindLast;
   btnQuery.Visible := False;
end;

//=============================== 1 - Botones ==================================

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

   ComboBox1.ItemIndex := 4;
   ComboBox2.Visible := False;
   ComboBox3.ItemIndex := 0;

   Comprueba := 'Buscar Libro';

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

//================================ 2 - ComboBoxs ===============================

procedure TLibroForm.ComboBox1Change(Sender: TObject);
begin
   ComboBox3.ItemIndex := 0;
   Case ComboBox1.ItemIndex Of
   0: Begin
         Comprueba := 'Autor';
         GetDatos();
      End;
   1: Query('SELECT * FROM Libs WHERE (LOWER(Prestado) = ''s'' or LOWER(Prestado) = ''si'') ORDER BY ID');
   2: Begin
         Comprueba := 'Propietario';
         GetDatos();
      End;
   3: Begin
         Comprueba := 'Saga';
         GetDatos();
      End;
   4: Query('SELECT * FROM Libs');
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
      Else If Comprueba = 'Autor' Then qryLibros.SQL.Add('SELECT * FROM Libs WHERE '+Comprueba+' = '''+ComboBoxDato+''' ORDER BY Saga, Tomo')
      Else If Comprueba = 'Propietario' Then qryLibros.SQL.Add('SELECT * FROM Libs WHERE '+Comprueba+' = '''+ComboBoxDato+''' ORDER BY Saga, Tomo');
      qryLibros.Active := True;
   End;
end;

procedure TLibroForm.ComboBox3Change(Sender: TObject);
Var
   Query:   String;
begin

   Query := Trim(qryLibros.SQL.Text);
   Query := EliminaSaltoLinea(Query);

   If (ComboBox1.Text = 'Todo') or (ComboBox2.Text = 'Todos') Then
   Begin
      If ComboBox3.Text = 'Descendente' Then
      Begin
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
      If ComboBox3.Text = 'Ascendente' Then
      Begin
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
         If EstaAlFinal('%'')', Query) or EstaAlFinal('ASC', Query) or EstaAlFinal('DESC', Query) Then
         Begin
            If EstaAlFinal('ASC', Query) Then SetLength(Query, Length(Query)-19)
            Else If EstaAlFinal('DESC', Query) Then SetLength(Query, Length(Query)-20);
            qryLibros.Active := False;
            qryLibros.SQL.Clear;
            qryLibros.SQL.Add(Query);
            qryLibros.Active := True;
         End
         Else
         Begin
            qryLibros.Active := False;
            qryLibros.SQL.Clear;
            qryLibros.SQL.Add('SELECT * FROM Libs');
            qryLibros.Active := True;
         End;
      End;
   End
   Else
   Begin
      If ComboBox3.Text = 'Descendente' Then
      Begin
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

//======================= 3 - PopUp Menu [Validaciones] ========================

procedure TLibroForm.PopupMenu1Popup(Sender: TObject);
Begin
   If TComponent(PopUpMenu1.PopupComponent).Name = 'dbgLibros' Then
   Begin
      PopUpMenu1.Items[0].Visible := True;
      PopUpMenu1.Items[1].Visible := True;
      PopUpMenu1.Items[2].Visible := True;
      PopUpMenu1.Items[3].Visible := False;
      PopUpMenu1.Items[4].Visible := True;
      PopUpMenu1.Items[5].Visible := False;
      PopUpMenu1.Items[6].Visible := False;
      PopUpMenu1.Items[7].Visible := False;
   End
   Else If TComponent(PopUpMenu1.PopupComponent).Name = 'dbgQuery' Then
   Begin
      PopUpMenu1.Items[0].Visible := True;
      PopUpMenu1.Items[1].Visible := False;
      PopUpMenu1.Items[2].Visible := False;
      PopUpMenu1.Items[3].Visible := True;
      PopUpMenu1.Items[4].Visible := True;
      PopUpMenu1.Items[5].Visible := False;
      PopUpMenu1.Items[6].Visible := False;
      PopUpMenu1.Items[7].Visible := False;
   End
   Else
   Begin
      PopUpMenu1.Items[0].Visible := False;
      PopUpMenu1.Items[1].Visible := False;
      PopUpMenu1.Items[2].Visible := False;
      PopUpMenu1.Items[3].Visible := False;
      PopUpMenu1.Items[4].Visible := False;
      PopUpMenu1.Items[5].Visible := True;
      PopUpMenu1.Items[6].Visible := True;
      PopUpMenu1.Items[7].Visible := True;
   End;
End;

//============================ 4 - PopUp Menu [DBGrids] ========================

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

//========================== 5 - PopUp Menu [Botonoes] =========================

procedure TLibroForm.FiltroPersonalizado1Click(Sender: TObject);
begin
   Version.Left := 672;
   If btnQuery.Visible = False Then
   Begin
      MainMenu1.Items[0].Items[0].Checked := True;
      If btnBusqueda.Visible = True Then
      Begin
         If btnRefrescar.Visible = True Then
         Begin
            Version.Left := 560;
            btnQuery.Top := 4;
         End
         Else btnQuery.Top := 26;
      End
      Else
      Begin
         If btnRefrescar.Visible = True Then btnQuery.Top := 26
         Else btnQuery.Top := 48;
      End;
      btnQuery.Visible := True;
   End
   Else
   Begin
      MainMenu1.Items[0].Items[0].Checked := False;
      btnQuery.Visible := False;
   End;
end;

procedure TLibroForm.BuscarLibro1Click(Sender: TObject);
begin
   Version.Left := 672;
   If btnBusqueda.Visible = False Then
   Begin
      MainMenu1.Items[0].Items[1].Checked := True;
      If btnRefrescar.Visible = True Then
      Begin
         If btnQuery.Visible = True Then
         Begin
            Version.Left := 560;
            btnQuery.Top := 4;
         End;
         btnBusqueda.Top := 26;
      End
      Else
      Begin
         If btnQuery.Visible = True Then btnQuery.Top := 26;
         btnBusqueda.Top := 48;
      End;
      btnBusqueda.Visible := True;
   End
   Else
   Begin
      MainMenu1.Items[0].Items[1].Checked := False;
      If btnRefrescar.Visible = True Then
      Begin
         If btnQuery.Visible = True Then btnQuery.Top := 26;
      End
      Else
      Begin
         If btnQuery.Visible = True Then btnQuery.Top := 48;
      End;
      btnBusqueda.Visible := False;
   End;
end;

procedure TLibroForm.Refrescar2Click(Sender: TObject);
begin
   Version.Left := 672;
   If btnRefrescar.Visible = False Then
   Begin
      MainMenu1.Items[0].Items[2].Checked := True;
      btnRefrescar.Visible := True;
      If btnQuery.Visible = True Then
      Begin
         If btnBusqueda.Visible = True Then
         Begin
            Version.Left := 560;
            btnQuery.Top := 4
         End
         Else btnQuery.Top := 26;
      End;
      btnBusqueda.Top := 26;
   End
   Else If btnRefrescar.Visible = True Then
   Begin
      MainMenu1.Items[0].Items[2].Checked := False;
      btnRefrescar.Visible := False;
      If btnQuery.Visible = True Then
      Begin
         If btnBusqueda.Visible = True Then btnQuery.Top := 26
         Else btnQuery.Top := 48;
      End;
      btnBusqueda.Top := 48;
   End;
end;

//========================= 6 - Main Menu [Habilitar] ==========================

procedure TLibroForm.FiltroPersonalizado2Click(Sender: TObject);
begin
   Version.Left := 662;
   If btnQuery.Visible = False Then
   Begin
      PopUpMenu1.Items[5].Checked := True;
      If btnBusqueda.Visible = True Then
      Begin
         If btnRefrescar.Visible = True Then
         Begin
            Version.Left := 550;
            btnQuery.Top := 4;
         End
         Else btnQuery.Top := 26;
      End
      Else
      Begin
         If btnRefrescar.Visible = True Then btnQuery.Top := 26
         Else btnQuery.Top := 48;
      End;
      btnQuery.Visible := True;
   End
   Else
   Begin
      PopUpMenu1.Items[5].Checked := False;
      btnQuery.Visible := False;
   End;
end;

procedure TLibroForm.BuscarLibro2Click(Sender: TObject);
begin
   Version.Left := 672;
   If btnBusqueda.Visible = False Then
   Begin
      PopUpMenu1.Items[6].Checked := True;
      If btnRefrescar.Visible = True Then
      Begin
         If btnQuery.Visible = True Then
         Begin
            Version.Left := 560;
            btnQuery.Top := 4;
         End;
         btnBusqueda.Top := 26;
      End
      Else
      Begin
         If btnQuery.Visible = True Then btnQuery.Top := 26;
         btnBusqueda.Top := 48;
      End;
      btnBusqueda.Visible := True;
   End
   Else
   Begin
      PopUpMenu1.Items[6].Checked := False;
      If btnRefrescar.Visible = True Then
      Begin
         If btnQuery.Visible = True Then btnQuery.Top := 26;
      End
      Else
      Begin
         If btnQuery.Visible = True Then btnQuery.Top := 48;
      End;
      btnBusqueda.Visible := False;
   End;
end;

procedure TLibroForm.Refrescar1Click(Sender: TObject);
begin
   Version.Left := 672;
   If btnRefrescar.Visible = False Then
   Begin
      PopUpMenu1.Items[7].Checked := True;
      btnRefrescar.Visible := True;
      If btnQuery.Visible = True Then
      Begin
         If btnBusqueda.Visible = True Then
         Begin
            Version.Left := 560;
            btnQuery.Top := 4
         End
         Else btnQuery.Top := 26;
      End;
      btnBusqueda.Top := 26;
   End
   Else If btnRefrescar.Visible = True Then
   Begin
      PopUpMenu1.Items[7].Checked := False;
      btnRefrescar.Visible := False;
      If btnQuery.Visible = True Then
      Begin
         If btnBusqueda.Visible = True Then btnQuery.Top := 26
         Else btnQuery.Top := 48;
      End;
      btnBusqueda.Top := 48;
   End;
end;

procedure TLibroForm.LineadeDatos1Click(Sender: TObject);
begin
   If DBText1.Visible = True Then
   Begin
      Label2.Top := 42;
      ComboBox1.Top := 42;
      ComboBox2.Top := 42;
      ComboBox3.Top := 42;
      DBText1.Visible := False;
      DBEdit1.Visible := False;
      DBEdit2.Visible := False;
      DBEdit3.Visible := False;
   End Else
   If DBText1.Visible = False Then
   Begin
      Label2.Top := 14;
      ComboBox1.Top := 14;
      ComboBox2.Top := 14;
      ComboBox3.Top := 14;
      DBText1.Visible := True;
      DBEdit1.Visible := True;
      DBEdit2.Visible := True;
      DBEdit3.Visible := True;
   End;
end;

//========================== 7 - Main Menu [Mostrar] ===========================

procedure TLibroForm.SoloRegistro1Click(Sender: TObject);
begin
   If dbgQuery.Visible = True Then
   Begin
      
      dbgLibros.Top := 72;
      dbgLibros.Height := 515;

      dbgQuery.Visible := False;
      
      MainMenu1.Items[0].Enabled := False;
      MainMenu1.Items[1].Items[1].Enabled := False;

      PopupMenu1.Items[5].Enabled := False;
      PopupMenu1.Items[6].Enabled := False;
      PopupMenu1.Items[7].Enabled := False;

      btnQuery.Enabled := False;
      btnBusqueda.Enabled := False;
      btnRefrescar.Enabled := False;
                              
      Label1.Top := 28;
      Label2.Visible := False;

      ComboBox1.Visible := False;
      If ComboBox2.Visible = False Then ComboBox2.Enabled := False
      Else ComboBox2.Visible := False;
      ComboBox3.Visible := False;

      If DBText1.Visible = False Then
      Begin
         DBText1.Enabled := False;
         DBEdit1.Enabled := False;
         DBEdit2.Enabled := False;
         DBEdit3.Enabled := False;
      End
      Else
      Begin
         DBText1.Visible := False;
         DBEdit1.Visible := False;
         DBEdit2.Visible := False;
         DBEdit3.Visible := False;
      End;

   End Else
   If dbgQuery.Visible = False Then
   Begin
   
      dbgLibros.Top := 422;
      dbgLibros.Height := 165;

      dbgQuery.Visible := True;

      MainMenu1.Items[0].Enabled := True;
      MainMenu1.Items[1].Items[1].Enabled := True;

      PopupMenu1.Items[5].Enabled := True;
      PopupMenu1.Items[6].Enabled := True;
      PopupMenu1.Items[7].Enabled := True;

      btnQuery.Enabled := True;
      btnBusqueda.Enabled := True;
      btnRefrescar.Enabled := True;
                             
      Label1.Top := 392;
      Label2.Visible := True;

      ComboBox1.Visible := True;
      If ComboBox2.Enabled = False Then
      Begin
         ComboBox2.Enabled := True;
      End
      Else ComboBox2.Visible := True;
      ComboBox3.Visible := True;

      If DBText1.Enabled = False Then
      Begin
         DBText1.Enabled := True;
         DBEdit1.Enabled := True;
         DBEdit2.Enabled := True;
         DBEdit3.Enabled := True;
      End
      Else
      Begin
         DBText1.Visible := True;
         DBEdit1.Visible := True;
         DBEdit2.Visible := True;
         DBEdit3.Visible := True;
      End;

   End;
end;

procedure TLibroForm.SoloFiltro1Click(Sender: TObject);
begin
   If dbgLibros.Visible = True Then
   Begin
      MainMenu1.Items[1].Items[0].Enabled := False;
      dbgQuery.Height := 515;
      dbgLibros.Visible := False;
      Label1.Visible := False;
      PopupMenu1.Items[3].Enabled := False;
   End Else
   If dbgLibros.Visible = False Then
   Begin
      MainMenu1.Items[1].Items[0].Enabled := True;
      dbgQuery.Height := 309;
      dbgLibros.Visible := True;
      Label1.Visible := True;
      PopupMenu1.Items[3].Enabled := True;
   End;
end;

//=========================== 7 - Main Menu [Tema] =============================

procedure TLibroForm.OscuroPorDefecto1Click(Sender: TObject);
begin
   If LibroForm.Color <> clBackground Then
   Begin                        
      LibroForm.Color := clBackground;
      
      Label1.Color    := clBackground;    Label1.Font.Color    := clTeal;
      Label2.Color    := clBackground;    Label2.Font.Color    := clTeal;

      Version.Color   := clBackground;    Version.Font.Color   := clTeal;

      ComboBox1.Color := clDefault;       ComboBox1.Font.Color := clGradientActiveCaption;
      ComboBox2.Color := clDefault;       ComboBox2.Font.Color := clGradientActiveCaption;
      ComboBox3.Color := clDefault;       ComboBox3.Font.Color := clGradientActiveCaption;

      DBText1.Color   := clHighlightText; DBText1.Font.Color   := clWindowText;
      DBEdit1.Color   := clWindow;        DBEdit1.Font.Color   := clWindowText;
      DBEdit2.Color   := clWindow;        DBEdit2.Font.Color   := clWindowText;
      DBEdit3.Color   := clWindow;        DBEdit3.Font.Color   := clWindowText;

      dbgQuery.Color  := clSilver;        dbgQuery.Font.Style  := [];
      dbgLibros.Color := clSilver;        dbgLibros.Font.Style := [];


   End;
   MainMenu1.Items[2].Items[0].Checked := True;
   MainMenu1.Items[2].Items[1].Checked := False;
end;

procedure TLibroForm.Claro1Click(Sender: TObject);
begin
   If LibroForm.Color <> clCream Then
   Begin                                                          
      LibroForm.Color := clWhite;

      Label1.Color    := clWhite; Label1.Font.Color    := clBlack;
      Label2.Color    := clWhite; Label2.Font.Color    := clBlack;

      Version.Color   := clWhite; Version.Font.Color   := clBlack;

      ComboBox1.Color := clMenu;  ComboBox1.Font.Color := clBlack;
      ComboBox2.Color := clMenu;  ComboBox2.Font.Color := clBlack;
      ComboBox3.Color := clMenu;  ComboBox3.Font.Color := clBlack;

      DBText1.Color   := clMenu;  DBText1.Font.Color   := clBlack;
      DBEdit1.Color   := clMenu;  DBEdit1.Font.Color   := clTeal;
      DBEdit2.Color   := clMenu;  DBEdit2.Font.Color   := clTeal;
      DBEdit3.Color   := clMenu;  DBEdit3.Font.Color   := clTeal;

      dbgQuery.Color  := clMenu;  dbgQuery.Font.Style  := [fsBold];
      dbgLibros.Color := clMenu;  dbgLibros.Font.Style := [fsBold];
   End;
   MainMenu1.Items[2].Items[0].Checked := False;
   MainMenu1.Items[2].Items[1].Checked := True;
end;

//================================= 8 - Query ==================================

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

//============================== 9 - Buscar ID =================================

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

//=============================== 10 - Funciones ===============================

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

//================================ 11 - Nuevos =================================

end.
