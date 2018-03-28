:- dynamic (valorRecibido/1).

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

%Crea un hecho en tiempo de ejecucion con el valor dado.
crearHecho([Valor|_]):- assert(valorRecibido(Valor)).

% ---------------------------------------------------------------------------------

jugar :- write(' '), nl,
         write(' ¡Bienvenido a AkiTicoLog!'), nl,
         write(' Piense en un personaje tico famoso...'), nl,
         write(' Intentaremos adivinar el personaje que está pensando.'), nl,
         write(' '), nl,
         pregunta1([]).

pregunta1(LC) :-
             writeln(' ¿Su personaje es hombre o mujer?'),
             read(OracionSexo),
             analizarFrase(OracionSexo),
             valorRecibido(Sexo),
             %Agregamos la respuesta del jugador a la lista de características.
             agregar(Sexo, LC, LCA),
             %Buscamos a los famosos que cumplan las condiciones actuales.
             findall(X, buscarFamoso(X,LCA), LS),
             write(LCA), nl,
             write(LS), nl,
             %No encontramos al famoso, llamamos a la siguiente pregunta.
             write(' '), nl,
             retractall(valorRecibido(_)),
             pregunta2(LCA), !.

pregunta2(LC) :-
             writeln(' ¿En cuál provincia nació su personaje?'),
             read(OracionProvincia),
             OracionProvincia \= siguiente,
             ( analizarFrase(OracionProvincia),
               valorRecibido(Provincia),
               %Agregamos la respuesta del jugador a lista de características.
               agregar(Provincia, LC, LCA),
               %Buscamos a los famosos que cumplan las condiciones actuales.
               findall(X, buscarFamoso(X,LCA), LS),
               write(LCA), nl,
               write(LS), nl,
               %Encontramos al famoso buscado.
               %No encontramos al famoso, pasamos a la siguiente pregunta.
               write(' '), nl,
               retractall(valorRecibido(_)),
               pregunta3(LCA), !);
             %El jugador no sabe la respuesta, pasamos a la siguiente pregunta.
             write(LC), nl, write(' '), nl, pregunta3(LC), !.

pregunta3(LC) :-
             writeln(' ¿Cuál es el año de nacimiento de su personaje?'),
             read(OracionAnoNacimiento),
             OracionAnoNacimiento \= siguiente,
             ( analizarFrase(OracionAnoNacimiento),
               valorRecibido(AnoNacimiento),
               %Agregamos la respuestas del jugador a lista de características.
               agregar(AnoNacimiento, LC, LCA),
               %Buscamos a los famosos que cumplan las condiciones actuales.
               findall(X, buscarFamoso(X,LCA), LS),
               write(LCA), nl,
               write(LS), nl,
               %Encontramos al famoso buscado.
               %No encontramos al famoso, pasamos a la siguiente pregunta.
               write(' '), nl,
               retractall(valorRecibido(_)),
               pregunta4(LCA), !);
             %El jugador no sabe la respuesta, pasamos a la siguiente pregunta.
             write(LC), nl, write(' '), nl, pregunta4(LC), !.

pregunta4(LC) :-
             writeln(' ¿Cuál es la edad de su personaje?'),
             read(OracionEdad),
             OracionEdad \= siguiente,
             ( analizarFrase(OracionEdad),
               valorRecibido(Edad),
               %Agregamos la respuestas del jugador a lista de características.
               agregar(Edad, LC, LCA),
               %Buscamos a los famosos que cumplan las condiciones actuales.
               findall(X, buscarFamoso(X,LCA), LS),
               write(LCA), nl,
               write(LS), nl,
               %Encontramos al famoso buscado.
               %No encontramos al famoso, pasamos a la siguiente pregunta.
               write(' '), nl,
               retractall(valorRecibido(_)),
               pregunta5(LCA), !);
             %El jugador no sabe la respuesta, pasamos a la siguiente pregunta.
             write(LC), nl, write(' '), nl, pregunta5(LC), !.

pregunta5(LC) :-
             writeln(' ¿Su personaje se encuentra vivo o muerto?'),
             read(OracionEstado),
             analizarFrase(OracionEstado),
             valorRecibido(Estado),
             %Agregamos la respuesta del jugador a la lista de características.
             agregar(Estado, LC, LCA),
             %Buscamos a los famosos que cumplan las condiciones actuales.
             findall(X, buscarFamoso(X,LCA), LS),
             write(LCA), nl,
             write(LS), nl,
             write(' '), nl,

             Estado = muerto,
             ( retractall(valorRecibido(_)),
               preguntaFallecimiento(LCA), !);

             retractall(valorRecibido(_)),
             pregunta6(LCA), !.

preguntaFallecimiento(LC) :-
             writeln(' ¿Cuál es el año de fallecimiento de su personaje?'),
             read(OracionAnoFallecimiento),
             OracionAnoFallecimiento \= siguiente,
             ( analizarFrase(OracionAnoFallecimiento),
               valorRecibido(AnoFallecimiento),
               %Agregamos la respuestas del jugador a lista de características.
               agregar(AnoFallecimiento, LC, LCA),
               %Buscamos a los famosos que cumplan las condiciones actuales.
               findall(X, buscarFamoso(X,LCA), LS),
               write(LCA), nl,
               write(LS), nl,
               %Encontramos al famoso buscado.
               %No encontramos al famoso, pasamos a la siguiente pregunta.
               write(' '), nl,
               retractall(valorRecibido(_)),
               pregunta6(LCA), !);
             %El jugador no sabe la respuesta, pasamos a la siguiente pregunta.
             write(LC), nl, write(' '), nl, pregunta6(LC), !.

pregunta6(LC) :-
             writeln(' ¿Su personaje se dedica a los deportes? (si/no)'),
             read(Deportista),

             Deportista == si,
             write(' '), nl,
             preguntaDeportes1(LC), !;

             write(' '), nl,
             pregunta7(LC), !.

preguntaDeportes1(LC) :-
             writeln(' ¿Cuál deporte practica su personaje?'),
             read(OracionDeporte),
             analizarFrase(OracionDeporte),
             valorRecibido(Deporte),
             %Agregamos la respuesta del jugador a la lista de características
             agregar(Deporte, LC, LCA),
             %Buscamos a los famosos que cumplan las condiciones actuales
             findall(X, buscarFamoso(X,LCA), ListaSoluciones),

             write(LCA), nl,
             write(ListaSoluciones), nl,

             %Sino llamamos a la siguiente pregunta.
             retractall(valorRecibido(_)),
             write(' '), nl,
             pregunta8(LCA), !.

pregunta7(LC) :-
             writeln(' ¿Cuál es la profesión de su personaje?'),
             read(OracionProfesion),
             analizarFrase(OracionProfesion),
             valorRecibido(Profesion),
             %Agregamos la respuestas del jugador a lista de características
             agregar(Profesion, LC, LCA),
             %Buscamos a los famosos que cumplan las condiciones actuales
             findall(X, buscarFamoso(X,LCA), LS),

             write(LCA), nl,
             write(LS), nl,

             %Sino llamamos a la siguiente pregunta.
             write(' '), nl,
             retractall(valorRecibido(_)),
             pregunta8(LCA), !.

pregunta8(LC) :-
             writeln(' ¿Cuál es la estatura de su personaje'),
             read(OracionEstatura),
             OracionEstatura \= siguiente,
             ( analizarFrase(OracionEstatura),
               valorRecibido(Estatura),
               %Agregamos la respuestas del jugador a lista de características.
               agregar(Estatura, LC, LCA),
               %Buscamos a los famosos que cumplan las condiciones actuales.
               findall(X, buscarFamoso(X,LCA), LS),
               write(LCA), nl,
               write(LS), nl,
               write(' '), nl,
               retractall(valorRecibido(_)),
               respuestaFinal(LCA), !);
             %El jugador no sabe la respuesta, pasamos a la siguiente pregunta.
             write(LC), nl, write(' '), nl, respuestaFinal(LC), !.

respuestaFinal(LC) :-
             %Buscamos a los famosos que cumplan las condiciones actuales
             findall(X, buscarFamoso(X,LC), LS),
             %Se encontro el famoso buscado.
             write(LS), nl,
             %No se encontro al famoso buscado.
             write(' '), nl,
             writeln('No pudimos adivinar su personaje :(').


%Determinantes
determinante(singular,masc,[un|S],S).
determinante(singular,fem,[una|S],S).
determinante(singular,masc,[todo|S],S).
determinante(singular,fem,[toda|S],S).
determinante(singular,fem,[si|S],S).
determinante(singular,fem,[no|S],S).

%Preposiciones
preposicion([a|S],S).
preposicion([de|S],S).
preposicion([desde|S],S).
preposicion([en|S],S).
preposicion([sin|S],S).
preposicion([por|S],S).

%Sustantivos
sustantivo(singular,masc,[futbolista|S],S).
sustantivo(singular,masc,[futbol|S],S).
sustantivo(singular,fem,[boxeadora|S],S).
sustantivo(singular,masc,[boxeo|S],S).
sustantivo(singular,masc,[cantante|S],S).
sustantivo(singular,fem,[ingeniera|S],S).
sustantivo(singular,masc,[ingeniero|S],S).
sustantivo(singular,masc,[politico|S],S).
sustantivo(singular,fem,[actriz|S],S).
sustantivo(singular,masc,[corredor|S],S).
sustantivo(singular,masc,[atletismo|S],S).
sustantivo(singular,masc,[ciclista|S],S).
sustantivo(singular,masc,[ciclismo|S],S).
sustantivo(singular,fem,[nadadora|S],S).
sustantivo(singular,masc,[natacion|S],S).
sustantivo(singular,masc,[musico|S],S).
sustantivo(singular,masc,[sanjose|S],S).
sustantivo(singular,fem,[heredia|S],S).
sustantivo(singular,fem,[alajuela|S],S).
sustantivo(singular,masc,[limon|S],S).
sustantivo(singular,masc,[guanacaste|S],S).
sustantivo(singular,fem,[deportes|S],S).
sustantivo(plural,fem,[años|S],S).
sustantivo(plural,fem,[metros|S],S).
sustantivo(singular,masc,[personaje|S],S).
sustantivo(singular,masc,[hombre|S],S).
sustantivo(singular,masc,[31|S],S).
sustantivo(singular,masc,[2001|S],S).

%Adjetivos
%adjetivo(plural,fem,[31|S],S).
%adjetivo(plural,fem,[32|S],S).
%adjetivo(plural,fem,[35|S],S).
%adjetivo(plural,fem,[46|S],S).
%adjetivo(plural,fem,[67|S],S).
%adjetivo(plural,fem,[55|S],S).
%adjetivo(plural,fem,[77|S],S).
%adjetivo(plural,fem,[58|S],S).
%adjetivo(plural,fem,[40|S],S).
%adjetivo(plural,fem,[50|S],S).

adjetivo(plural,fem,[1.85|S],S).
adjetivo(plural,fem,[1.80|S],S).
adjetivo(plural,fem,[1.75|S],S).
adjetivo(plural,fem,[1.63|S],S).
adjetivo(plural,fem,[1.87|S],S).
adjetivo(plural,fem,[1.91|S],S).
adjetivo(plural,fem,[1.70|S],S).
adjetivo(plural,fem,[1.88|S],S).

sustantivo(singular,fem,[vivo|S],S).
sustantivo(singular,fem,[muerto|S],S).

%Verbos
verbo(singular,[mide|S],S).
verbo(singular,[murio|S],S).
verbo(singular,[nacio|S],S).
verbo(singular,[tiene|S],S).
verbo(singular,[es|S],S).
verbo(singular,[dedica|S],S).
verbo(singular,[se|S],S).
verbo(singular,[esta|S],S).
verbo(singular,[vive|S],S).

%Sujeto
sujeto(singular,fem,[ella|S],S).
sujeto(singular,masc,[el|S],S).
sujeto(singular,masc,[yo|S],S).

% ---------------------------------------------------------------------------------

analizarFrase(S):-% read_line_to_codes(user_input,Cs),
    %atom_codes(A, Cs),
    %atomic_list_concat(S,' ',A),
    oracion(_,_,S,[]).

% ---------------------------------------------------------------------------------

%Función que analiza ambos sintagmas de la oracion
oracion(Num,Genero,S0,S):-   sintagma_nominal(Num,Genero,S0,S1),
                             sintagma_verbal(Num,S1,S).

% ---------------------------------------------------------------------------------

%Sintagma nominal y verbal
sintagma_nominal(Num,Genero,S0,S):- determinante(Num,Genero,S0,S1),
                                    sujeto(Num,Genero,S1,S),!.

sintagma_nominal(Num,Genero,S0,S):- determinante(Num,Genero,S0,S),!.

sintagma_nominal(Num,Genero,S0,S):- sujeto(Num,Genero,S0,S),!.

sintagma_verbal(Num,S0,S):- verbo(Num,S0,S1),
                            %write(S1),
                            %crearHecho2(S1),
                            compl_dir(S1,S),!.

sintagma_verbal(Num,S0,S):- compl_dir(S0,S1),
                            verbo(Num,S1,S),!.

sintagma_verbal(Num,S0,S):- verbo(Num,S0,S),!.

sujeto(Num,Genero,S0,S):- sustantivo(Num,Genero,S0,S),
                          %write(S0),
                          crearHecho(S0), !.

sujeto(Num,Genero,S0,S):- sustantivo(Num,Genero,S0,S1),que(Num,S1,S),!.

que(Num,[que|S0],S):- sintagma_verbal(Num,S0,S).

compl_dir(S0,S):- preposicion(S0,S1), sintagma_nominal(_,_,S1,S),!.

compl_dir(S0,S):- adjetivo(_,_,S0,S),!.

compl_dir(S0,S):- adjetivo(_,_,S0,S1),
                  write(S0),
                  %crearHecho3(S0),
                  sintagma_nominal(_,_,S1,S),!.

compl_dir(S0,S):- sintagma_nominal(_,_,S0,S),!.
