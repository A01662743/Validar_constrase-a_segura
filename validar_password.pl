:- use_module(library(plunit)).

%%%; ====================================================================
%%%; LÓGICA PRINCIPAL (STC0101)
%%%; ====================================================================

% Predicado principal
% Una cadena es una contraseña segura si satisface las 4 sub-reglas lógicas.
contrasenia_segura(String) :-
    string_chars(String, Chars),
    tiene_mayuscula(Chars),
    tiene_minuscula(Chars),
    tiene_numero(Chars),
    tiene_especial(Chars).

% Sub-reglas lógicas mediante pertenencia de conjuntos
tiene_mayuscula(Chars) :- member(C, Chars), char_type(C, upper).
tiene_minuscula(Chars) :- member(C, Chars), char_type(C, lower).
tiene_numero(Chars)    :- member(C, Chars), char_type(C, digit).

% Lista explícita de caracteres especiales permitidos
tiene_especial(Chars)  :- 
    member(C, Chars), 
    member(C, ['!', '@', '#', '$', '%', '*', '&', '-']).


%%%; ====================================================================
%%%; PRUEBAS AUTOMATIZADAS (STC0104)
%%%; ====================================================================

:- begin_tests(validador_contrasenias).

test(password_valida_estandar, [true]) :-
    contrasenia_segura("Contra123!").

test(password_valida_desordenada, [true]) :-
    contrasenia_segura("!3bA").

test(falla_sin_mayuscula, [fail]) :-
    contrasenia_segura("contra123!").

test(falla_sin_minuscula, [fail]) :-
    contrasenia_segura("CONTRA123!").

test(falla_sin_numero, [fail]) :-
    contrasenia_segura("Contraseña!").

test(falla_sin_especial, [fail]) :-
    contrasenia_segura("Contra12345").

test(falla_vacio, [fail]) :-
    contrasenia_segura("").

:- end_tests(validador_contrasenias).

% Instrucción opcional para correr los tests directamente al cargar el archivo:
% :- run_tests.