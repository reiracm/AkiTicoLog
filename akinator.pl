% ---------------------------------------------------------------------------------
% Base de Datos
% ---------------------------------------------------------------------------------
% famositico(nombre,sexo,profesion,edad,añoDeNacimiento,lugarDeNacimiento,estatura)

famositico('Keylor Navas',  hombre, futbolista, 31, 1986, 'San José',  1.85).
famositico('Andrey Amador', hombre, ciclista,   31, 1986, 'Alajuela',  1.80).
famositico('Nery Brenes',   hombre, corredor,   32, 1985, 'Limón',     1.75).
famositico('Shirley Cruz',  mujer,  futbolista, 32, 1985, 'San José',  1.63).
famositico('Hanna Gabriels',mujer,  boxeadora,  35, 1983, 'Alajuela',  1.87).
famositico('Claudia Poll',  mujer,  nadadora,   46, 1972, 'Nicaragua', 1.91).

famositico('Franklin Chang',  hombre, ingeniero, 67, 1950, 'San José', 9.99).
famositico('Sandra Cauffman', mujer,  ingeniera, 55, 1962, 'San José', 9.99).

famositico('Oscar Arias', hombre, politica, 77, 1940, 'Heredia', 9.99).

famositico('Maribel Guardia', mujer, actriz, 58, 1959, 'San José', 1.70).

famositico('José Capmany', hombre, musico, 40, 1961, 'San José',   9.99).
famositico('Fidel Gamboa', hombre, musico, 50, 1961, 'Guanacaste', 9.99).

% ---------------------------------------------------------------------------------
% Función para conocer el largo de una lista
largo([], 0).
largo([_|Lr], C) :- largo(Lr, C1), C is C1 + 1.

% ---------------------------------------------------------------------------------

% ---------------------------------------------------------------------------------

jugar :- write(' '), nl,
         write('¡Bienvenido a AkiTicoLog!'), nl,
         write('Piense en un personaje tico famoso...'), nl,
         write('¡Intentaremos adivinar el personaje que está pensando!'), nl,
         write(' '), nl,
         pregunta1.

pregunta1 :- writeln('Su personaje es un hombre o una mujer?'),
             read(Sexo),
             findall(X, famositico(X,Sexo,_,_,_,_,_),ListaPersonajes),

             largo(ListaPersonajes, N), N == 1,
             famositico(Z, Sexo,_,_,_,_,_),
             write('Su personaje es: '), write(Z), write('!.');

             write(' '), nl,
             pregunta2, !.


pregunta2 :- writeln('A que se dedica su personaje?'),
             read(Profesion),
             findall(X, famositico(X,Sexo,Profesion,_,_,_,_),ListaPersonajes),

             largo(ListaPersonajes, N), N == 1,
             famositico(Z, Sexo,Profesion,_,_,_,_),
             write('Su personaje es: '), write(Z), write('!.');

             write(' '), nl,
             pregunta3, !.


pregunta3 :- writeln('En cuál provincia nació su personaje?'),
             read(Provincia),
             write(' '), nl,
             pregunta4, !.


pregunta4 :- writeln('Cuál es la edad de su personaje?'),
             read(Edad).
