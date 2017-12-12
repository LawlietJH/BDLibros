program BDLibros;

uses
  Forms,
  Libros in 'Libros.pas' {LibroForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TLibroForm, LibroForm);
  Application.Run;
end.
