program BDLibros;            // By LawlietJH, Versi�n 1.2.7

uses
  Forms,
  Libros in 'Libros.pas' {LibroForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TLibroForm, LibroForm);
  Application.Run;
end.
