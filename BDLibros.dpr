program BDLibros;            // By LawlietJH, Versi�n 1.4.0

uses
  Forms,
  Libros in 'Libros.pas' {LibroForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TLibroForm, LibroForm);
  Application.Run;
end.
