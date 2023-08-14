mago(harry).
mago(draco).
mago(hermione).

sangre(hermione,impura).
sangre(harry,mestiza).
sangre(draco,pura).

caracteristicas(harry,[corajudo,amistoso,orgulloso,inteligente]).
caracteristicas(draco,[orgulloso,inteligente]).
caracteristicas(hermione,[responsable,orgulloso,inteligente]).

odia(harry, slytherin).
odia(draco, hufflepuff).

casa(gryffindor).
casa(slytherin).
casa(ravenclaw).
casa(hufflepuff).



requerimento(gryffindor,corajudo).
requerimento(slytherin,inteligente).
requerimento(slytherin,orgulloso).
requerimento(ravenclaw,inteligente).
requerimento(ravenclaw,responsable).
requerimento(hufflepuff,amistoso).
%1.1
%permiteIngreso(Casa,Mago)
permiteIngreso(Casa,_):- 
    casa(Casa),
    Casa \= slytherin.
permiteIngreso(slytherin,Mago):-
    mago(Mago),
    not(esSangreImpura(Mago)).

esSangreImpura(Mago):-
    sangre(Mago,impura).
%1.2
%esApropiado(Casa,Mago)
tieneCaracterApropiado(Mago,Casa):-
    caracteristicas(Mago,Caracteristicas),
    casa(Casa),
    forall(requerimento(Casa,Requerimento),member(Requerimento,Caracteristicas)).
    
%1.3
destino(Mago, Casa):-
    permiteIngreso(Casa, Mago),
    tieneCaracterApropiado(Mago, Casa),
    not(odia(Mago,Casa)).
destino(hermione,gryffindor).

%1.4
cadenaDeAmistades([Mago,OtroMago|Magos]):-
    esAmistoso(Mago),
    esAmistoso(OtroMago),
    compartenCasa(Mago,OtroMago),
    cadenaDeAmistades(Magos).

esAmistoso(Mago):-
    caracteristicas(Mago,Caracteristicas),
    member(amistoso,Caracteristicas).

compartenCasa(Mago,OtroMago):-
    findall(Casa,destino(Mago,Casa),CasasMago),
    forall(destino(OtroMago,OtraCasa),member(OtraCasa,CasasMago)).

%2.1
hizo(harry,fueraCama).
hizo(hermione,tercerPiso).
hizo(hermione,salaRestringida).
hizo(harry,irABosque).
hizo(harry,tercerPiso).
hizo(draco,mazmorras).
hizo(ron,ganarAjedrez).
hizo(hermione,usarIntelecto).
hizo(harry,ganarAVoldemort).

buenAlumno(Mago):-
    mago(Mago),
    forall(hizo(Mago,Accion),not(malaAccion(Accion))).

malaAccion(fueraCama).
malaAccion(bosque).
malaAccion(salaRestringida).
malaAccion(tercerPiso).

esAccionRecurrente(UnaAccion):-
    hizo(_,UnaAccion),
    findall(Mago,hizo(Mago,UnaAccion),Magos),
    length(Magos, Cantidad),
    Cantidad > 1.

%2.2
%esDe(Mago, Casa)
esDe(hermione, gryffindor).
esDe(ron, gryffindor).
esDe(harry, gryffindor).
esDe(draco, slytherin).
esDe(luna, ravenclaw).

%puntaje(Accion, Puntos)
puntaje(fueraCama, -50).
puntaje(irABosque, -50).
puntaje(salaRestringida, -10).
puntaje(tercerPiso, -75).
puntaje(ganarAjedrez, 50).
puntaje(usarIntelecto, 50).
puntaje(ganarAVoldemort, 60).
puntaje(mazmorras, 0).

puntajeTotal(Casa, Cantidad):-
    esDe(_,Casa),
    findall(PuntosMago,(esDe(Mago, Casa), puntajeMago(Mago, PuntosMago)), PuntajeTotal),
    sum_list(PuntajeTotal, Cantidad).

puntajeMago(Mago, PuntosMago):-
    hizo(Mago, _),
    findall(Puntaje, (hizo(Mago, Accion), puntaje(Accion, Puntaje)), PuntajeTotal),
    sum_list(PuntajeTotal, PuntosMago).
     
%2.3


