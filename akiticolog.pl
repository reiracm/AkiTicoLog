:- style_check(-singleton).
:- dynamic (valorRecibido/1).

% ---------------------------------------------------------------------------------
% Base de Datos.
% ---------------------------------------------------------------------------------

famositico('Keylor Navas',[hombre,futbol,1986,31,sanjose,1.85,vivo]).
famositico('Bryan Ruíz',[hombre,futbol,1985,32,sanjose,1.88,vivo]).
famositico('Andrey Amador',[hombre,ciclismo,1986,31,alajuela,1.80,vivo]).
famositico('Nery Brenes',[hombre,atletismo,1985,32,limon,1.75,vivo]).
famositico('Shirley Cruz',[mujer,futbol,1985,32,sanjose,1.63,viva]).
famositico('Hanna Gabriels',[mujer,boxeo,1983,35,alajuela,1.87,viva]).
famositico('Claudia Poll',[mujer,natacion,1972,46,nicaragua,1.91,viva]).
famositico('Debi Nova',[mujer,cantante,1980,37,sanjose,viva]).
famositico('Maribel Guardia',[mujer,actriz,1959,58,sanjose,1.70,viva]).
famositico('Franklin Chang',[hombre,ingeniero,1950,67,sanjose,vivo]).
famositico('Sandra Cauffman',[mujer,ingeniera,1962,55,sanjose,viva]).
famositico('Jorge Debravo',[hombre,escritor,1938,29,1967,cartago,muerto]).
famositico('Oscar Arias',[hombre,politico,1940,77,heredia,vivo]).
famositico('José Capmany',[hombre,musico,1961,40,2001,sanjose,muerto]).
famositico('Fidel Gamboa',[hombre,musico,1961,50,2011,guanacaste,muerto]).

% ---------------------------------------------------------------------------------

%Función para conocer el largo de una lista.
largo([], 0):- !.
largo([_|Lr], C):- largo(Lr, C1), C is C1 + 1.

%Función  para determinar si un elemento pertenece a una lista.
miembro(E, [E|_]).
miembro(E, [_|Lr]):- miembro(E, Lr).

%Función para determinar si A es subconjunto de B.
subconjunto([], _).
subconjunto([Ah|Ar], B):- miembro(Ah, B), subconjunto(Ar, B).

% ---------------------------------------------------------------------------------

%Función que busca al famoso que cumpla las caracteristicas dadas.
buscarFamoso(X, LC):- famositico(X, LI), subconjunto(LC, LI).

%Crea un hecho en tiempo de ejecucion con el valor dado.
crearHecho([Valor|_]):- asserta(valorRecibido(Valor)).

%Limpia los hechos creados en tiempo de ejecución.
limpiarHechos:- retractall(valorRecibido(_)).

%Imprime el nombre de un personaje.
imprimirSolucion([Nombre|_]):-  nl, write(' Su personaje es: '),
                                write(Nombre), write('!'), nl.

% ---------------------------------------------------------------------------------
% LC  - Lista Características.
% NF  - Nombre Famoso
% LS  - Lista Soluciones.
% ---------------------------------------------------------------------------------

jugar:- write(' '), nl,
        write(' ¡Bienvenido a AkiTicoLog!'), nl,
        write('  Piense en un personaje tico famoso...'), nl,
        write('  Intentaremos adivinar el personaje que está pensando.'), nl,
        write('  Instrucciones de juego:  '), nl,
        write('    - Expresar cada una de sus respuestas entre parentesis cuadrados([]) y cada palabra separada por una coma'),nl,
        write('    - Finalizar cada respuesta con punto'),nl,
        write('    - En caso de no conocer la respuesta a la pregunta responder: "siguiente",seguido por un punto(.)'),nl,
        write('  !Ahora a jugar!'),nl,
        write(' '), nl,
        pregunta1.

pregunta1:- writeln(' ¿Su personaje es hombre o mujer? *'),
            read(OracionSexo),
            %El jugador ingreso una oración correcta.
            analizarFrase(OracionSexo), write(' '), nl, pregunta2, !;
            %El jugador ingreso una oración incorrecta.
            write(' No entendí, repítelo.'), pregunta1, !.

pregunta2:- writeln(' ¿En cuál provincia nació su personaje?'),
            read(OracionProvincia),
            %El jugador sabe la respuesta.
            OracionProvincia \= siguiente,
              %El jugador ingresó una oración correcta.
              (analizarFrase(OracionProvincia),
                 (%Ponemos en una lista las características recibidas.
                  findall(C, valorRecibido(C), LC),
                  %Buscamos a los famosos que cumplan las condiciones.
                  findall(NF, buscarFamoso(NF,LC), LS),
                  %Si encontramos al famoso buscado.
                  largo(LS, N), N == 1, imprimirSolucion(LS), !;
                  %No encontramos al famoso, pasamos a la siguiente pregunta.
                  write(' '), nl, pregunta3, !);
               %El jugador ingresó un oración incorrecta.
               write(' No entendí, repítelo.'), pregunta2, !);
            %El jugador no sabe la respuesta, pasamos a la siguiente pregunta.
            write(' '), nl, pregunta3, !.

pregunta3:- writeln(' ¿Cuál es el año de nacimiento de su personaje?'),
            read(OracionAnoNacimiento),
            %El jugador sabe la respuesta.
            OracionAnoNacimiento \= siguiente,
              %El jugador ingresó una oración correcta.
              (analizarFrase(OracionAnoNacimiento),
                 (%Ponemos en una lista las características recibidas.
                  findall(C, valorRecibido(C), LC),
                  %Buscamos a los famosos que cumplan las condiciones.
                  findall(NF, buscarFamoso(NF,LC), LS),
                  %Si encontramos al famoso buscado.
                  largo(LS, N), N == 1, imprimirSolucion(LS), !;
                  %No encontramos al famoso, pasamos a la siguiente pregunta.
                  write(' '), nl, pregunta4, !);
               %El jugador ingresó un oración incorrecta.
               write(' No entendí, repítelo.'), pregunta3, !);
            %El jugador no sabe la respuesta, pasamos a la siguiente pregunta.
            write(' '), nl, pregunta4, !.

pregunta4:- writeln(' ¿Cuántos años tiene su personaje?'),
            read(OracionEdad),
            %El jugador sabe la respuesta.
            OracionEdad \= siguiente,
              %El jugador ingresó una oración correcta.
              (analizarFrase(OracionEdad),
                 (%Ponemos en una lista las características recibidas.
                  findall(C, valorRecibido(C), LC),
                  %Buscamos a los famosos que cumplan las condiciones.
                  findall(NF, buscarFamoso(NF,LC), LS),
                  %Si encontramos al famoso buscado.
                  largo(LS, N), N == 1, imprimirSolucion(LS), !;
                  %No encontramos al famoso, pasamos a la siguiente pregunta.
                  write(' '), nl, pregunta5, !);
               %El jugador ingresó un oración incorrecta.
               write(' No entendí, repítelo.'), pregunta4, !);
            %El jugador no sabe la respuesta, pasamos a la siguiente pregunta.
            write(' '), nl, pregunta5, !.

pregunta5:- writeln(' ¿Su personaje se encuentra vivo o muerto?'),
            read(OracionEstado),
            %El jugador sabe la respuesta.
            OracionEstado \= siguiente,
              %El jugador ingresó una oración correcta.
              (analizarFrase(OracionEstado),
                 (%Ponemos en una lista las características recibidas.
                  findall(C, valorRecibido(C), LC),
                  %Buscamos a los famosos que cumplan las condiciones.
                  findall(NF, buscarFamoso(NF,LC), LS),
                  %Si encontramos al famoso buscado.
                  largo(LS, N), N == 1, imprimirSolucion(LS), !;
                  %No encontramos al famoso, pasamos a la siguiente pregunta.
                  write(' '), nl,
                  valorRecibido(Estado), Estado == vivo, pregunta6, !;
                  preguntaFallecimiento, !);
               %El jugador ingresó un oración incorrecta.
               write(' No entendí, repítelo.'), pregunta4, !);
            %El jugador no sabe la respuesta, pasamos a la siguiente pregunta.
            write(' '), nl, pregunta5, !.

preguntaFallecimiento:-
            writeln(' ¿Cuál es el año de fallecimiento de su personaje?'),
            read(OracionAnoFallecimiento),
            %El jugador sabe la respuesta.
            OracionAnoFallecimiento \= siguiente,
              %El jugador ingresó una oración correcta.
              (analizarFrase(OracionAnoFallecimiento),
                 (%Ponemos en una lista las características recibidas.
                  findall(C, valorRecibido(C), LC),
                  %Buscamos a los famosos que cumplan las condiciones.
                  findall(NF, buscarFamoso(NF,LC), LS),
                  %Si encontramos al famoso buscado.
                  largo(LS, N), N == 1, imprimirSolucion(LS), !;
                  %No encontramos al famoso, pasamos a la siguiente pregunta.
                  write(' '), nl, pregunta6, !);
               %El jugador ingresó un oración incorrecta.
               write(' No entendí, repítelo.'), preguntaFallecimiento, !);
            %El jugador no sabe la respuesta, pasamos a la siguiente pregunta.
            write(' '), nl, pregunta6, !.

pregunta6:- writeln(' ¿Su personaje se dedica a los deportes (si|no)? *'),
            read(Deportista), write(' '), nl,
            Deportista == si, preguntaDeportes1, !;
            %Sino es un deportista.
            pregunta7, !.

preguntaDeportes1:-
            writeln(' ¿Cuál deporte practica su personaje?'),
            read(OracionDeporte),
            %El jugador sabe la respuesta.
            OracionDeporte \= siguiente,
              %El jugador ingresó una oración correcta.
              (analizarFrase(OracionDeporte),
                 (%Ponemos en una lista las características recibidas.
                  findall(C, valorRecibido(C), LC),
                  %Buscamos a los famosos que cumplan las condiciones.
                  findall(NF, buscarFamoso(NF,LC), LS),
                  %Si encontramos al famoso buscado.
                  largo(LS, N), N == 1, imprimirSolucion(LS), !;
                  %No encontramos al famoso, pasamos a la siguiente pregunta.
                  write(' '), nl, pregunta8, !);
               %El jugador ingresó un oración incorrecta.
               write(' No entendí, repítelo.'), preguntaDeportes1, !);
            %El jugador no sabe la respuesta, pasamos a la siguiente pregunta.
            write(' '), nl, pregunta8, !.

pregunta7:- writeln(' ¿Cuál es la profesión de su personaje?'),
            read(OracionProfesion),
            %El jugador sabe la respuesta.
            OracionProfesion \= siguiente,
              %El jugador ingresó una oración correcta.
              (analizarFrase(OracionProfesion),
                 (%Ponemos en una lista las características recibidas.
                  findall(C, valorRecibido(C), LC),
                  %Buscamos a los famosos que cumplan las condiciones.
                  findall(NF, buscarFamoso(NF,LC), LS),
                  %Si encontramos al famoso buscado.
                  largo(LS, N), N == 1, imprimirSolucion(LS), !;
                  %No encontramos al famoso, pasamos a la siguiente pregunta.
                  write(' '), nl, pregunta8, !);
               %El jugador ingresó un oración incorrecta.
               write(' No entendí, repítelo.'), pregunta7, !);
            %El jugador no sabe la respuesta, pasamos a la siguiente pregunta.
            write(' '), nl, pregunta8, !.

pregunta8:- writeln(' ¿Cuál es la estatura de su personaje?'),
            read(OracionEstatura),
            %El jugador sabe la respuesta.
            OracionEstatura \= siguiente,
              (%El jugador ingresó una oración correcta.
               analizarFrase(OracionEstatura), etapaFinal, !;
               %El jugador ingresó un oración incorrecta.
               write(' No entendí, repítelo.'), pregunta8, !);
            %El jugador no sabe la respuesta, pasamos a la siguiente pregunta.
            write(' '), nl, etapaFinal, !.

etapaFinal:- %Ponemos en una lista las características recibidas.
             findall(C, valorRecibido(C), LC),
             %Buscamos a los famosos que cumplan las condiciones.
             findall(NF, buscarFamoso(NF,LC), LS),
             %Limpiamos todo los valores recibidos del jugador.
             limpiarHechos,
             %Se encontro al famoso buscado.
             largo(LS, N), N == 1, imprimirSolucion(LS), !;
             %No se encontro al famoso buscado.
             writeln('No pudimos adivinar su personaje :('), !.

% ---------------------------------------------------------------------------------

% Determinantes
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
sustantivo(singular,fem,[mujer|S],S).
sustantivo(singular,masc,[31|S],S).
sustantivo(singular,masc,[2001|S],S).
sustantivo(plural,fem,[31|S],S).
sustantivo(plural,fem,[32|S],S).
sustantivo(plural,fem,[35|S],S).
sustantivo(plural,fem,[46|S],S).
sustantivo(plural,fem,[67|S],S).
sustantivo(plural,fem,[55|S],S).
sustantivo(plural,fem,[77|S],S).
sustantivo(plural,fem,[58|S],S).
sustantivo(plural,fem,[40|S],S).
sustantivo(plural,fem,[50|S],S).
sustantivo(singular,masc,[1986|S],S).
sustantivo(singular,masc,[1985|S],S).
sustantivo(singular,masc,[1983|S],S).
sustantivo(singular,masc,[1972|S],S).
sustantivo(singular,masc,[1980|S],S).
sustantivo(singular,masc,[1959|S],S).
sustantivo(singular,masc,[1950|S],S).
sustantivo(singular,masc,[1962|S],S).
sustantivo(singular,masc,[1938|S],S).



%Adjetivos
adjetivo(plural,fem,[31|S],S).
adjetivo(plural,fem,[32|S],S).
adjetivo(plural,fem,[35|S],S).
adjetivo(plural,fem,[46|S],S).
adjetivo(plural,fem,[67|S],S).
adjetivo(plural,fem,[55|S],S).
adjetivo(plural,fem,[77|S],S).
adjetivo(plural,fem,[58|S],S).
adjetivo(plural,fem,[40|S],S).
%adjetivo(plural,fem,[50|S],S).

sustantivo(plural,fem,[1.85|S],S).
sustantivo(plural,fem,[1.80|S],S).
sustantivo(plural,fem,[1.75|S],S).
sustantivo(plural,fem,[1.63|S],S).
sustantivo(plural,fem,[1.87|S],S).
sustantivo(plural,fem,[1.91|S],S).
sustantivo(plural,fem,[1.70|S],S).
sustantivo(plural,fem,[1.88|S],S).

sustantivo(singular,fem,[vivo|S],S).
sustantivo(singular,fem,[viva|S],S).
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

analizarFrase(S):-oracion(_,_,S,[]).

% ---------------------------------------------------------------------------------

%Función que analiza ambos sintagmas de la oracion
oracion(Num,Genero,S0,S):-   sintagma_nominal(Num,Genero,S0,S1),
                             sintagma_verbal(Num,S1,S).

% ---------------------------------------------------------------------------------

%Sintagma nominal y verbal
% El sigtagma verbal contiene dos partes: determinante (en caso de que
% lo tenga) y sujeto.
sintagma_nominal(Num,Genero,S0,S):- determinante(Num,Genero,S0,S1),
                                    sujeto(Num,Genero,S1,S),!.

% En algunas ocasiones el sigtagma nominal solo tiene determinante y el
% sujeto es tácito
sintagma_nominal(Num,Genero,S0,S):- determinante(Num,Genero,S0,S),!.

% En algunas ocasiones el sintagma nominal solamente se conforma de
% sujeto.
sintagma_nominal(Num,Genero,S0,S):- sujeto(Num,Genero,S0,S),!.

%Sintagma verbal es toda aquella parte de la oración a partir del verbo.

sintagma_verbal(Num,S0,S):- verbo(Num,S0,S1), compl_dir(S1,S),!.

% En algunas ocasiones el verbo se encuentra después del complemento
% directo

sintagma_verbal(Num,S0,S):- compl_dir(S0,S1), verbo(Num,S1,S),!.

%Algunas oraciones solo contienen verbo.

sintagma_verbal(Num,S0,S):- verbo(Num,S0,S),!.

%El sujeto puede estar constituido de un sustantivo
sujeto(Num,Genero,S0,S):- sustantivo(Num,Genero,S0,S),
                          crearHecho(S0), !.


%El sujeto contiene un sustantivo y un pronombre
sujeto(Num,Genero,S0,S):- sustantivo(Num,Genero,S0,S1),conex(Num,S1,S),!.

%Entre el sintagma nominal y verbal muchas veces existen conectores.
conex(Num,[conex|S0],S):- sintagma_verbal(Num,S0,S).


%Complemento directo constituido por preposiones y sintagmas nominales
compl_dir(S0,S):- preposicion(S0,S1), sintagma_nominal(_,_,S1,S),!.

%Constituido por adjetivos en algunos casos
compl_dir(S0,S):- adjetivo(_,_,S0,S),!.

%Constituido por adjetivos y sintagma nominal
compl_dir(S0,S):- adjetivo(_,_,S0,S1),
                  sintagma_nominal(_,_,S1,S),!.

%Algunas veces solo constituido por sintagma nominal
compl_dir(S0,S):- sintagma_nominal(_,_,S0,S),!.
