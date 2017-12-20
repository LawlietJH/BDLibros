object LibroForm: TLibroForm
  Left = 312
  Top = 26
  VertScrollBar.ParentColor = False
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Base de Datos de Libros'
  ClientHeight = 596
  ClientWidth = 745
  Color = clBackground
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  PopupMenu = PopupMenu1
  Position = poScreenCenter
  ShowHint = True
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label2: TLabel
    Left = 6
    Top = 13
    Width = 75
    Height = 19
    Caption = 'Filtrar Por'
    Font.Charset = TURKISH_CHARSET
    Font.Color = clTeal
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label1: TLabel
    Left = 8
    Top = 392
    Width = 251
    Height = 19
    Caption = 'Registro y Modificaci'#243'n de Datos'
    Font.Charset = TURKISH_CHARSET
    Font.Color = clTeal
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object DBText1: TDBText
    Left = 27
    Top = 47
    Width = 56
    Height = 14
    Hint = 'ID del Libro'
    Alignment = taCenter
    Color = clHighlightText
    DataField = 'ID'
    DataSource = dsQuery
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
  end
  object Version: TLabel
    Left = 662
    Top = 6
    Width = 76
    Height = 13
    Caption = 'Versi'#243'n 1.4.1'
    Color = clBackground
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clTeal
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
  end
  object btnRefrescar: TBitBtn
    Left = 632
    Top = 48
    Width = 105
    Height = 21
    Hint = 
      'Si Modificaste un Registro, Actualiza Los Datos de la Tabla de F' +
      'iltros'
    BiDiMode = bdLeftToRight
    Caption = '&Refrescar'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ModalResult = 4
    ParentBiDiMode = False
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    OnClick = btnRefrescarClick
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333444444
      33333333333F8888883F33330000324334222222443333388F3833333388F333
      000032244222222222433338F8833FFFFF338F3300003222222AAAAA22243338
      F333F88888F338F30000322222A33333A2224338F33F8333338F338F00003222
      223333333A224338F33833333338F38F00003222222333333A444338FFFF8F33
      3338888300003AAAAAAA33333333333888888833333333330000333333333333
      333333333333333333FFFFFF000033333333333344444433FFFF333333888888
      00003A444333333A22222438888F333338F3333800003A2243333333A2222438
      F38F333333833338000033A224333334422224338338FFFFF8833338000033A2
      22444442222224338F3388888333FF380000333A2222222222AA243338FF3333
      33FF88F800003333AA222222AA33A3333388FFFFFF8833830000333333AAAAAA
      3333333333338888883333330000333333333333333333333333333333333333
      0000}
    Layout = blGlyphRight
    NumGlyphs = 2
  end
  object btnBusqueda: TBitBtn
    Left = 632
    Top = 26
    Width = 105
    Height = 21
    Hint = 
      'Busca Un Libro Escribiendo un Indicio: el, la, los, las, un, etc' +
      '.'
    Caption = '&Buscar Libro'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    OnClick = btnBusquedaClick
  end
  object btnQuery: TBitBtn
    Left = 632
    Top = 4
    Width = 105
    Height = 21
    Hint = 'Crea Tu Propio Filtro Personalizado'
    Caption = '&Filtro Personalizado'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    OnClick = btnQueryClick
  end
  object ComboBox1: TComboBox
    Left = 88
    Top = 13
    Width = 89
    Height = 21
    Hint = 'Selecciona El Tipo De Busqueda'
    Style = csDropDownList
    Color = clDefault
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGradientActiveCaption
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ItemHeight = 13
    ItemIndex = 4
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    Sorted = True
    TabOrder = 3
    Text = 'Todo'
    OnChange = ComboBox1Change
    Items.Strings = (
      'Autores'
      'Prestados'
      'Propietario'
      'Saga'
      'Todo')
  end
  object ComboBox2: TComboBox
    Left = 312
    Top = 13
    Width = 209
    Height = 21
    Hint = 'Selecciona Un Filtro'
    Style = csDropDownList
    Color = clDefault
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGradientActiveCaption
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ItemHeight = 13
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    Sorted = True
    TabOrder = 4
    Visible = False
    OnChange = ComboBox2Change
  end
  object dbgQuery: TDBGrid
    Left = 8
    Top = 72
    Width = 729
    Height = 309
    Color = clSilver
    DataSource = dsQuery
    FixedColor = clGradientActiveCaption
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
    ParentFont = False
    PopupMenu = PopupMenu1
    TabOrder = 5
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = [fsBold]
    OnKeyPress = dbgQueryKeyPress
  end
  object dbgLibros: TDBGrid
    Left = 8
    Top = 422
    Width = 729
    Height = 165
    Color = clSilver
    DataSource = dsLibros
    FixedColor = clGradientActiveCaption
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
    ParentFont = False
    PopupMenu = PopupMenu1
    TabOrder = 6
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = [fsBold]
  end
  object DBEdit1: TDBEdit
    Left = 86
    Top = 44
    Width = 245
    Height = 18
    Hint = 'Nombre del Libro'
    TabStop = False
    AutoSize = False
    DataField = 'Libro'
    DataSource = dsQuery
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    ParentShowHint = False
    ReadOnly = True
    ShowHint = True
    TabOrder = 7
  end
  object DBEdit2: TDBEdit
    Left = 330
    Top = 44
    Width = 186
    Height = 18
    Hint = 'Nombre del Autor'
    TabStop = False
    AutoSize = False
    DataField = 'Autor'
    DataSource = dsQuery
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    ParentShowHint = False
    ReadOnly = True
    ShowHint = True
    TabOrder = 8
  end
  object DBEdit3: TDBEdit
    Left = 515
    Top = 44
    Width = 78
    Height = 18
    Hint = 'Nombre del Propietario del Libro'
    TabStop = False
    AutoSize = False
    DataField = 'Propietario'
    DataSource = dsQuery
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    ParentShowHint = False
    ReadOnly = True
    ShowHint = True
    TabOrder = 9
  end
  object ComboBox3: TComboBox
    Left = 192
    Top = 13
    Width = 105
    Height = 21
    Hint = 'Filtrado Ascendente/Descendente'
    Style = csDropDownList
    Color = clDefault
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGradientActiveCaption
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ItemHeight = 13
    ItemIndex = 0
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 10
    Text = 'Normal'
    OnChange = ComboBox3Change
    Items.Strings = (
      'Normal'
      'Ascendente'
      'Descendente')
  end
  object PopupMenu1: TPopupMenu
    OnPopup = PopupMenu1Popup
    Left = 536
    Top = 11
    object Copiar1: TMenuItem
      Caption = '&Copiar'
      OnClick = Copiar1Click
    end
    object Pegar1: TMenuItem
      Caption = '&Pegar'
      OnClick = Pegar1Click
    end
    object Limpiar1: TMenuItem
      Caption = '&Limpiar Campo'
      OnClick = Limpiar1Click
    end
    object Modificar1: TMenuItem
      Caption = '&Modificar'
      OnClick = Modificar1Click
    end
    object IrA1: TMenuItem
      Caption = '&Ir A'
      object Buscar1: TMenuItem
        Caption = '&Buscar'
        OnClick = Buscar1Click
      end
      object Primero1: TMenuItem
        Caption = '&Primero'
        OnClick = Primero1Click
      end
      object Ultimo1: TMenuItem
        Caption = '&Ultimo'
        OnClick = Ultimo1Click
      end
    end
    object FiltroPersonalizado1: TMenuItem
      AutoCheck = True
      Caption = '&Filtro Personalizado'
      OnClick = FiltroPersonalizado1Click
    end
    object BuscarLibro1: TMenuItem
      AutoCheck = True
      Caption = '&Buscar Libro'
      Checked = True
      Default = True
      OnClick = BuscarLibro1Click
    end
    object Refrescar2: TMenuItem
      AutoCheck = True
      Caption = '&Refrescar'
      Checked = True
      OnClick = Refrescar2Click
    end
  end
  object tbLibros: TTable
    Active = True
    DatabaseName = 'ZioN'
    TableName = 'Libs.db'
    Left = 568
    Top = 387
    object tbLibrosID: TAutoIncField
      FieldName = 'ID'
      ReadOnly = True
    end
    object tbLibrosLibro: TStringField
      FieldName = 'Libro'
      Size = 40
    end
    object tbLibrosAutor: TStringField
      FieldName = 'Autor'
      Size = 30
    end
    object tbLibrosPropietario: TStringField
      FieldName = 'Propietario'
      Size = 12
    end
    object tbLibrosPrestado: TStringField
      FieldName = 'Prestado'
      Size = 2
    end
    object tbLibrosAQuien: TStringField
      FieldName = 'AQuien'
      Size = 12
    end
    object tbLibrosTomo: TFloatField
      FieldName = 'Tomo'
    end
    object tbLibrosSaga: TStringField
      FieldName = 'Saga'
      Size = 30
    end
    object tbLibrosCosto: TCurrencyField
      FieldName = 'Costo'
    end
    object tbLibrosFechaCompra: TDateField
      FieldName = 'FechaCompra'
    end
    object tbLibrosFechaPrestamo: TDateField
      FieldName = 'FechaPrestamo'
    end
    object tbLibrosFechaDebolucion: TDateField
      FieldName = 'FechaDebolucion'
    end
    object tbLibrosFechaRegalo: TDateField
      FieldName = 'FechaRegalo'
    end
    object tbLibrosComentarios: TStringField
      FieldName = 'Comentarios'
      Size = 50
    end
  end
  object dsQuery: TDataSource
    DataSet = qryLibros
    Left = 600
    Top = 11
  end
  object dsLibros: TDataSource
    DataSet = tbLibros
    Left = 600
    Top = 387
  end
  object qryLibros: TQuery
    Active = True
    DatabaseName = 'ZioN'
    SQL.Strings = (
      'SELECT * FROM Libs')
    Left = 568
    Top = 11
    object qryLibrosID: TIntegerField
      FieldName = 'ID'
      Origin = 'ZION."Libs.DB".ID'
    end
    object qryLibrosLibro: TStringField
      FieldName = 'Libro'
      Origin = 'ZION."Libs.DB".Libro'
      Size = 40
    end
    object qryLibrosAutor: TStringField
      FieldName = 'Autor'
      Origin = 'ZION."Libs.DB".Autor'
      Size = 30
    end
    object qryLibrosPropietario: TStringField
      FieldName = 'Propietario'
      Origin = 'ZION."Libs.DB".Propietario'
      Size = 12
    end
    object qryLibrosPrestado: TStringField
      FieldName = 'Prestado'
      Origin = 'ZION."Libs.DB".Prestado'
      Size = 2
    end
    object qryLibrosAQuien: TStringField
      FieldName = 'AQuien'
      Origin = 'ZION."Libs.DB".AQuien'
      Size = 12
    end
    object qryLibrosTomo: TFloatField
      FieldName = 'Tomo'
      Origin = 'ZION."Libs.DB".Tomo'
    end
    object qryLibrosSaga: TStringField
      FieldName = 'Saga'
      Origin = 'ZION."Libs.DB".Saga'
      Size = 30
    end
    object qryLibrosCosto: TCurrencyField
      FieldName = 'Costo'
      Origin = 'ZION."Libs.DB".Costo'
    end
    object qryLibrosFechaCompra: TDateField
      FieldName = 'FechaCompra'
      Origin = 'ZION."Libs.DB".FechaCompra'
    end
    object qryLibrosFechaPrestamo: TDateField
      FieldName = 'FechaPrestamo'
      Origin = 'ZION."Libs.DB".FechaPrestamo'
    end
    object qryLibrosFechaDebolucion: TDateField
      FieldName = 'FechaDebolucion'
      Origin = 'ZION."Libs.DB".FechaDebolucion'
    end
    object qryLibrosFechaRegalo: TDateField
      FieldName = 'FechaRegalo'
      Origin = 'ZION."Libs.DB".FechaRegalo'
    end
    object qryLibrosComentarios: TStringField
      FieldName = 'Comentarios'
      Origin = 'ZION."Libs.DB".Comentarios'
      Size = 50
    end
  end
  object MainMenu1: TMainMenu
    Left = 536
    Top = 387
    object Habilitar1: TMenuItem
      Caption = '&Habilitar'
      object FiltroPersonalizado2: TMenuItem
        AutoCheck = True
        Caption = 'Filtro &Personalizado'
        OnClick = FiltroPersonalizado2Click
      end
      object BuscarLibro2: TMenuItem
        AutoCheck = True
        Caption = '&Buscar Libro'
        Checked = True
        OnClick = BuscarLibro2Click
      end
      object Refrescar1: TMenuItem
        AutoCheck = True
        Caption = '&Refrescar'
        Checked = True
        OnClick = Refrescar1Click
      end
      object LineadeDatos1: TMenuItem
        AutoCheck = True
        Caption = '&Linea de Datos Actuales'
        Checked = True
        OnClick = LineadeDatos1Click
      end
    end
    object Mostar1: TMenuItem
      Caption = '&Mostar'
      object SoloRegistro1: TMenuItem
        AutoCheck = True
        Caption = 'Solo &Registro'
        OnClick = SoloRegistro1Click
      end
      object SoloFiltro1: TMenuItem
        AutoCheck = True
        Caption = 'Solo &Filtro'
        OnClick = SoloFiltro1Click
      end
    end
    object ElegirTema1: TMenuItem
      Caption = 'Elegir &Tema'
      object OscuroPorDefecto1: TMenuItem
        Caption = '&Oscuro (Por Defecto)'
        Checked = True
        Default = True
        OnClick = OscuroPorDefecto1Click
      end
      object Claro1: TMenuItem
        Caption = '&Claro'
        OnClick = Claro1Click
      end
    end
  end
end
