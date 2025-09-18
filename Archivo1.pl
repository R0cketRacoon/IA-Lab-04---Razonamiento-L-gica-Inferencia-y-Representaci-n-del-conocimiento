% -----------------------------------------
% Sistema Experto: Identificacion de Animales
% Ejecutar con: ?- go.
% -----------------------------------------

:- dynamic yes/1, no/1.

go :-
    hypothesis(Animal),
    nl, write('El animal es: '), write(Animal), nl,
    undo.

% Hipotesis principales (NOTA: todas en minusculas)
hypothesis(ciprinodontiformes) :- ciprinodontiformes, !.
hypothesis(poecilidos)         :- poecilidos, !.
hypothesis(ciclidos)           :- ciclidos, !.
hypothesis(pez_desconocido).  % fallback

% Reglas de identificacion (caracteristicas en minusculas y sin tildes)
ciprinodontiformes :-
    verify(boca_pequena),
    verify(vive_en_rios_de_america_del_sur),
    verify(macho_posee_gonopodio),
    verify(hembra_3cm_mas_grande_que_macho).

poecilidos :-
    verify(tiene_manchas_a_lo_largo_del_cuerpo),
    verify(color_gris),
    verify(rayas_verdes),
    verify(raza_gambusia).

ciclidos :-
    verify(boca_pequena),
    verify(manchas_oscuras).

% Preguntar al usuario
ask(Question) :-
    write('El animal tiene la siguiente caracteristica?: '),
    write(Question), write('? (yes/no) '),
    read(Response), nl,
    ( (Response == yes ; Response == y)
      -> assert(yes(Question))
      ;  assert(no(Question)), fail ).

% Verificar caracteristica
verify(S) :-
    ( yes(S) -> true
    ; no(S)  -> fail
    ; ask(S)
    ).

% Limpiar respuestas (para nueva corrida)
undo :- retract(yes(_)), fail.
undo :- retract(no(_)),  fail.
undo.
