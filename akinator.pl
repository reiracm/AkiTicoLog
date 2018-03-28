% ---------------------------------------------------------------------------------
% Base de Datos.
% ---------------------------------------------------------------------------------

famositico('Keylor Navas',[hombre,futbol,1986,31,sanjose,1.85,vivo]).
famositico('Bryan Ruíz',[hombre,futbol,1985,32,sanjose,1.88,vivo]).
famositico('Andrey Amador',[hombre,ciclismo,1986,31,alajuela,1.80,vivo]).
famositico('Nery Brenes',[hombre,atletismo,1985,32,limon,1.75,vivo]).
famositico('Shirley Cruz',[mujer,futbol,1985,32,sanjose,1.63,vivo]).
famositico('Hanna Gabriels',[mujer,boxeo,1983,35,alajuela,1.87,vivo]).
famositico('Claudia Poll',[mujer,natacion,1972,46,nicaragua,1.91,vivo]).

famositico('Debi Nova',[mujer,cantante,1980,37,sanjose,vivo]).

famositico('Maribel Guardia',[mujer,actriz,1959,58,sanjose,1.70,vivo]).

famositico('Franklin Chang',[hombre,ingeniero,1950,67,sanjose,vivo]).
famositico('Sandra Cauffman',[mujer,ingeniera,1962,55,sanjose,vivo]).

famositico('Jorge Debravo',[hombre,escritor,1938,29,1967,cartago,muerto]).

famositico('Oscar Arias',[hombre,politico,1940,77,heredia,vivo]).

famositico('José Capmany',[hombre,musico,1961,40,2001,sanjose,muerto]).
famositico('Fidel Gamboa',[hombre,musico,1961,50,2011,guanacaste,muerto]).

% ---------------------------------------------------------------------------------

% Función para conocer el largo de una lista.
largo([], 0) :- !.
largo([_|Lr], C) :- largo(Lr, C1), C is C1 + 1.

% Función  que agrega un elemento al final de una lista.
agregar(X, [], [X]).
agregar(X, [C|R], [C|R1]) :- agregar(X, R, R1).

% Función  para determinar si un elemento pertenece a una lista.
miembro(E, [E|_]).
miembro(E, [_|Lr]) :- miembro(E, Lr).

% Función para determinar si A es subconjunto de B.
subconjunto([], _).
subconjunto([Ah|Ar], B) :- miembro(Ah, B), subconjunto(Ar, B).

% ---------------------------------------------------------------------------------

% Función que busca los famosos en la base de datos que cumplan con las
% caracteristicas dadas.
buscarFamoso(X, LC) :- famositico(X, LI), subconjunto(LC, LI).

% ---------------------------------------------------------------------------------

jugar :- write(' '), nl,
         write(' ¡Bienvenido a AkiTicoLog!'), nl,
         write(' Piense en un personaje tico famoso...'), nl,
         write(' Intentaremos adivinar el personaje que está pensando.'), nl,
         write(' '), nl,
         pregunta1([]).

pregunta1(LC) :-
             writeln(' ¿Su personaje es hombre o mujer?'),
             read(Sexo),
             %Agregamos la respuesta del jugador a la lista de características.
             agregar(Sexo, LC, LCA),
             %Buscamos a los famosos que cumplan las condiciones actuales.
             findall(X, buscarFamoso(X,LCA), LS),

             write(LCA), nl,
             write(LS), nl,

             %No encontramos al famoso, llamamos a la siguiente pregunta.
             write(' '), nl,
             pregunta2(LCA), !.

pregunta2(LC) :-
             writeln(' ¿En cuál provincia nació su personaje?'),
             read(Provincia),

             %El jugador no sabe la respuesta, llamamos la siguiente pregunta.
             %Provincia == siguiente,
             %write(' '), nl, pregunta3(LC), !;

             %Agregamos la respuesta del jugador a lista de características.
             agregar(Provincia, LC, LCA),
             %Buscamos a los famosos que cumplan las condiciones actuales.
             findall(X, buscarFamoso(X,LCA), LS),

             write(LCA), nl,
             write(LS), nl,

             %No encontramos al famoso, llamamos a la siguiente pregunta.
             write(' '), nl,
             pregunta3(LCA), !.

pregunta3(LC) :-
             writeln(' ¿Cuál es el año de nacimiento de su personaje?'),
             read(AnoNacimiento),

             %El jugador no sabe la respuesta, llamamos la siguiente pregunta.
             %AnoNacimiento == siguiente,
             %pregunta4(LC), !;

             %Agregamos la respuestas del jugador a lista de características.
             agregar(AnoNacimiento, LC, LCA),
             %Buscamos a los famosos que cumplan las condiciones actuales.
             findall(X, buscarFamoso(X,LCA), LS),

             write(LCA), nl,
             write(LS), nl,

             %No encontramos al famoso, llamamos a la siguiente pregunta.
             write(' '), nl,
             pregunta4(LCA), !.

pregunta4(LC) :-
             writeln(' ¿Cuál es la edad de su personaje?'),
             read(Edad),

             %El jugador no sabe la respuesta, llamamos la siguiente pregunta.
             %Edad == siguiente,
             %pregunta5(LC), !;

             %Agregamos la respuesta del jugador a lista de características.
             agregar(Edad, LC, LCA),
             %Buscamos a los famosos que cumplan las condiciones actuales.
             findall(X, buscarFamoso(X,LCA), LS),

             write(LCA), nl,
             write(LS), nl,

             write(' '), nl,
             pregunta5(LCA), !.

pregunta5(LC) :-
             writeln(' ¿Su personaje se encuentra vivo o muerto?'),
             read(Estado),
             %Agregamos la respuesta del jugador a la lista de características.
             agregar(Estado, LC, LCA),
             %Buscamos a los famosos que cumplan las condiciones actuales.
             findall(X, buscarFamoso(X,LCA), LS),

             write(LCA), nl,
             write(LS), nl,

             write(' '), nl,

             Estado == muerto,
             preguntaFallecimiento(LC), !;

             pregunta6(LC), !.

preguntaFallecimiento(LC) :-
             writeln(' ¿Cuál es el año de fallecimiento de su personaje?'),
             read(AnoFallecimiento),

             %El jugador no sabe la respuesta, llamamos la siguiente pregunta.
             %AnoFallecimiento == siguiente,
             %pregunta6(LC), !;

             %Agregamos la respuesta del jugador a la lista de características.
             agregar(AnoFallecimiento, LC, LCA),
             %Buscamos a los famosos que cumplan las condiciones actuales.
             findall(X, buscarFamoso(X,LCA), LS),

             write(LCA), nl,
             write(LS), nl,

             write(' '), nl,
             pregunta6(LCA), !.

pregunta6(LC) :-
             writeln(' ¿Su personaje se dedica a los deportes?'),
             read(Deportista),

             Deportista == si,
             write(' '), nl,
             preguntaDeportes1(LC), !;

             write(' '), nl,
             pregunta7(LC), !.

preguntaDeportes1(LC) :-
             writeln(' ¿Cuál deporte practica su personaje?'),
             read(Deporte),
             %Agregamos la respuesta del jugador a la lista de características
             agregar(Deporte, LC, LCA),
             %Buscamos a los famosos que cumplan las condiciones actuales
             findall(X, buscarFamoso(X,LCA), ListaSoluciones),

             write(LCA), nl,
             write(ListaSoluciones), nl,

             %Si encontramos al famoso buscado.
             %largo(ListaSoluciones, N), N == 1,
             %imprimirSolucion(ListaSoluciones), !;

             %Sino llamamos a la siguiente pregunta.
             write(' '), nl,
             pregunta8(LCA), !.

pregunta7(LC) :-
             writeln(' ¿Cuál es la profesión de su personaje?'),
             read(Profesion),
             %Agregamos la respuestas del jugador a lista de características
             agregar(Profesion, LC, LCA),
             %Buscamos a los famosos que cumplan las condiciones actuales
             findall(X, buscarFamoso(X,LCA), LS),

             write(LCA), nl,
             write(LS), nl,

             %Si encontramos al famoso buscado.
             %largo(ListaSoluciones, N), N == 1,
             %imprimirSolucion(ListaSoluciones), !;

             %Sino llamamos a la siguiente pregunta.
             write(' '), nl,
             pregunta8(LCA), !.

pregunta8(LC) :-
             writeln(' ¿Cuál es la altura de su personaje'),
             read(Altura),

             %El jugador no sabe la respuesta, llamamos la siguiente pregunta.
             Altura == siguiente,
             respuestaFinal(LC), !;

             %Agregamos la respuestas del jugador a lista de características
             agregar(Altura, LC, LCA),
             write(LCA), nl,

             write(' '), nl,
             respuestaFinal(LCA), !.

respuestaFinal(LC) :-
             %Buscamos a los famosos que cumplan las condiciones actuales
             findall(X, buscarFamoso(X,LC), LS),
             write(LS), nl,

             %Se encontro el famoso buscado

             %No se encontro al famoso buscado.
             write(' '), nl,
             writeln('El personaje que está pensando no se encuentra').







