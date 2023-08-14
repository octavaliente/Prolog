cantante(megurineLuka).
cantante(hatsuneMiku).
cantante(gumi).
cantante(seeU).
cantante(kaito).

cancion(nigthFever).
cancion(foreverYoung).
cancion(tellYourWorld).
cancion(novemberRain).

%canta(Cantante, Cancion, Duracion).
canta(megurineLuka, nigthFever, 4).
canta(megurineLuka, foreverYoung, 5).
canta(hatsuneMiku, tellYourWorld, 4).
canta(gumi, foreverYoung, 4).
canta(gumi, tellYourWorld, 5).
canta(seeU, novemberRain, 6).
canta(seeU, nigthFever, 5).

%1
esNovedoso(Cantante):-
    cantante(Cantante),
    cancionesCantadas(Cantante, CantidadCanciones),
    CantidadCanciones > 1,
    tiempoCantando(Cantante, Tiempo),
    Tiempo < 15.

cancionesCantadas(Cantante, Cantidad):-
    findall(Cancion, canta(Cantante, Cancion, _), Canciones),
    length(Canciones, Cantidad).

tiempoCantando(Cantante, Tiempo):-
    findall(Duracion, canta(Cantante, _, Duracion), Duraciones),
    sum_list(Duraciones, Tiempo).

%2
esAcelerado(Cantante):-
    cantante(Cantante),
    forall(canta(Cantante,_,Duracion), Duracion =< 4).

%Conciertos
%1
concierto(mikuExpo, 2000, gigante).
concierto(magicalMirai, 3000, gigante).
concierto(vocalektVisions, 1000, mediano).
concierto(mikuFest, 100, pequenio).

requisitos(mikuExpo, CantidadCanciones, TiempoTotal):-
    CantidadCanciones > 2,
    TiempoTotal > 6.
requisitos(magicalMirai, CantidadCanciones, TiempoTotal):-
    CantidadCanciones > 3,
    TiempoTotal > 10.
requisitos(vocalektVisions, CantidadCanciones, TiempoTotal):-
    CantidadCanciones > 0,
    TiempoTotal < 10.
requisitos(mikuFest, CantidadCanciones, TiempoTotal):-
    CantidadCanciones >= 1,
    TiempoTotal >= 4.

%2
puedeParticipar(hatsuneMiku, Concierto):-
    concierto(Concierto,_,_).

puedeParticipar(Cantante, Concierto):-
    cantante(Cantante),
    tiempoCantando(Cantante, TiempoTotal),
    cancionesCantadas(Cantante, CantidadCanciones),
    requisitos(Concierto, CantidadCanciones, TiempoTotal).

%3
famaTotal(Cantante, FamaTotal):-
    cantante(Cantante),
    findall(Fama,famaDeUnConcierto(Cantante, Fama), Famas),
    sum_list(Famas, SumaFama),
    cancionesCantadas(Cantante, CantidadCanciones),
    FamaTotal is CantidadCanciones * SumaFama.

famaDeUnConcierto(Cantante, Fama):-
    puedeParticipar(Cantante, Concierto),
    concierto(Concierto, Fama, _).

elMasFamoso(Cantante):-
    famaTotal(Cantante, FamaMaxima),
    forall(famaTotal(_,Fama), FamaMaxima >= Fama).

%4

conoce(megurineLuka, hatsuneMiku).
conoce(megurineLuka, gumi).
conoce(gumi, seeU).
conoce(seeU, kaito).

unicoParticipante(Cantante, Concierto):-
    puedeParticipar(Cantante, Concierto),
    not(conocido(Cantante, OtroCantante)),
    puedeParticipar(OtroCantante, Concierto).

conocido(Cantante, OtroCantante):-
    conoce(Cantante, OtroCantante).

conocido(Cantante, OtroCantante):-
    conoce(Cantante, UnCantante),
    conocido(UnCantante, OtroCantante).

