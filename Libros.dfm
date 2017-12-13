object LibroForm: TLibroForm
  Left = 339
  Top = 75
  Width = 761
  Height = 648
  VertScrollBar.ParentColor = False
  Caption = 'Base de Datos de Libros'
  Color = clBackground
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label2: TLabel
    Left = 6
    Top = 29
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
    Top = 402
    Width = 238
    Height = 19
    Caption = 'Registro/Modificaci'#243'n de Datos'
    Font.Charset = TURKISH_CHARSET
    Font.Color = clTeal
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object DBText1: TDBText
    Left = 27
    Top = 60
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
  object Label3: TLabel
    Left = 336
    Top = 7
    Width = 62
    Height = 13
    Caption = 'Versi'#243'n 1.3.2'
    Color = clBackground
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clTeal
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentColor = False
    ParentFont = False
  end
  object btnRefrescar: TBitBtn
    Left = 632
    Top = 400
    Width = 105
    Height = 23
    Caption = 'Refrescar'
    TabOrder = 0
    OnClick = btnRefrescarClick
  end
  object btnBusqueda: TBitBtn
    Left = 632
    Top = 48
    Width = 105
    Height = 23
    Caption = 'Buscar Libro'
    TabOrder = 1
    OnClick = btnBusquedaClick
  end
  object btnQuery: TBitBtn
    Left = 632
    Top = 24
    Width = 105
    Height = 23
    Hint = 'Crea Tu Propio Filtro Personalizado'
    Caption = 'Filtro Personalizado'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    OnClick = btnQueryClick
  end
  object ComboBox1: TComboBox
    Left = 88
    Top = 29
    Width = 81
    Height = 21
    Hint = 'Selecciona El Tipo De Busqueda'
    Style = csDropDownList
    Color = clInactiveCaption
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
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
    Left = 320
    Top = 29
    Width = 169
    Height = 21
    Hint = 'Selecciona Un Filtro'
    Style = csDropDownList
    Color = clInactiveCaption
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
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
    Top = 80
    Width = 729
    Height = 309
    Color = clSilver
    DataSource = dsQuery
    FixedColor = clGradientActiveCaption
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
    PopupMenu = PopupMenu1
    TabOrder = 5
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnKeyPress = dbgQueryKeyPress
  end
  object dbgLibros: TDBGrid
    Left = 8
    Top = 432
    Width = 729
    Height = 165
    Color = clSilver
    DataSource = dsLibros
    FixedColor = clGradientActiveCaption
    Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
    PopupMenu = PopupMenu1
    TabOrder = 6
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  object DBEdit1: TDBEdit
    Left = 86
    Top = 57
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
    Top = 57
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
    Top = 57
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
    Left = 184
    Top = 29
    Width = 121
    Height = 21
    Style = csDropDownList
    Color = clBackground
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindow
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ItemHeight = 13
    ItemIndex = 0
    ParentFont = False
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
    Left = 640
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
  end
  object tbLibros: TTable
    Active = True
    DatabaseName = 'ZioN'
    TableName = 'Libs.db'
    Left = 568
    Top = 397
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
    Left = 704
  end
  object dsLibros: TDataSource
    DataSet = tbLibros
    Left = 600
    Top = 397
  end
  object qryLibros: TQuery
    Active = True
    DatabaseName = 'ZioN'
    SQL.Strings = (
      'SELECT * FROM Libs')
    Left = 672
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
end
