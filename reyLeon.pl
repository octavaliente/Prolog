%comio(Personaje, Bicho)
comio(pumba, vaquitaSanAntonio(gervasia,3)).
comio(pumba, hormiga(federica)).
comio(pumba, hormiga(tuNoEresLaReina)).
comio(pumba, cucaracha(ginger,15,6)).
comio(pumba, cucaracha(erikElRojo,25,70)).
comio(timon, vaquitaSanAntonio(romualda,4)).
comio(timon, cucaracha(gimeno,12,8)).
comio(timon, cucaracha(cucurucha,12,5)).
comio(simba, vaquitaSanAntonio(remeditos,4)).
comio(simba, hormiga(schwartzenegger)).
comio(simba, hormiga(niato)).
comio(simba, hormiga(lula)).

comio(shenzi,hormiga(conCaraDeSimba)).

pesoHormiga(2).
%peso(Personaje, Peso)
peso(pumba, 100).
peso(timon, 50).
peso(simba, 200).

peso(scar, 300).
peso(shenzi, 400).
peso(banzai, 500).

%1.a
jugosita(cucaracha(_,Tamanio, Peso)):-
    comio(_,cucaracha(_,Tamanio, OtroPeso)),
    Peso > OtroPeso.
%1.b
esHormigofilico(Personaje):-
    comio(Personaje, _),
    findall(Hormiga, comio(Personaje, hormiga(Hormiga)), Hormigas),
    length(Hormigas, Cantidad),
    Cantidad >= 2.
%1.c
esCucarachofobico(Personaje):-
    comio(Personaje,_),
    findall(Bicho, comio(Personaje, Bicho), Bichos),
    not(member(cucaracha(_,_,_), Bichos)).
%1.d
picarones(Personajes):-
    findall(Personaje, esPicaron(Personaje), Personajes).

esPicaron(pumba).
esPicaron(Personaje):-
    comio(Personaje, cucaracha(_,Tamanio,Peso)),
    jugosita(cucaracha(_,Tamanio,Peso)).
esPicaron(Personaje):-
    comio(Personaje, vaquitaSanAntonio(remeditos,_)).

%2
persigue(scar, timon).
persigue(scar, pumba).
persigue(shenzi, simba).
persigue(shenzi, scar).
persigue(banzai, timon).

persigue(scar, mufasa).

cuantoEngorda(Personaje, Peso):-
    comio(Personaje, _),
    not(persigue(Personaje, _)),
    pesoDeBichos(Personaje, Peso).

cuantoEngorda(Personaje, Peso):-
    persigue(Personaje, _),
    not(comio(Personaje,_)),
    pesoDePerseguidos(Personaje, Peso).

cuantoEngorda(Personaje, PesoTotal):-
    persigue(Personaje, _),
    comio(Personaje, _),
    pesoDeBichos(Personaje, PesoBichos),
    pesoDePerseguidos(Personaje, PesoPerseguidos),
    PesoTotal is PesoBichos + PesoPerseguidos.

pesoDeBichos(Personaje, Peso):-
    findall(PesoBicho, pesoPorBichoComido(Personaje, PesoBicho), PesosBichos),
    sum_list(PesosBichos, Peso).

pesoDePerseguidos(Personaje, PesoTotal):-
    findall(PesoPerseguido, pesoPerseguido(Personaje, PesoPerseguido), PesosPerseguidos),
    sum_list(PesosPerseguidos, Peso1),
    findall(PesoEngordado, (persigue(Personaje, OtroPersonaje), distinct(cuantoEngorda(OtroPersonaje, PesoEngordado))), PesosEngordados),
    sum_list(PesosEngordados, Peso2),
    PesoTotal is Peso1 + Peso2.

pesoPerseguido(Personaje, Peso):-
    persigue(Personaje, OtroPersonaje),
    peso(OtroPersonaje, Peso).

pesoPorBichoComido(Personaje, PesoBicho):-
    comio(Personaje, cucaracha(_,_,PesoBicho)).

pesoPorBichoComido(Personaje, PesoBicho):-
    comio(Personaje, vaquitaSanAntonio(_,PesoBicho)).

pesoPorBichoComido(Personaje, PesoBicho):-
    comio(Personaje, hormiga(_)),
    pesoHormiga(PesoBicho).

%3
personaje(scar).
personaje(mufasa).
personaje(shenzi).
personaje(banzai).
personaje(pumba).
personaje(timon).
personaje(simba).

rey(UnPersonaje):-
    personaje(UnPersonaje),
    not(comio(UnPersonaje,_)),
    perseguidores(UnPersonaje, 1),
    forall(personaje(OtroPersonaje), adora(OtroPersonaje, UnPersonaje)).

adora(UnPersonaje, OtroPersonaje):-
    not(persigue(OtroPersonaje, UnPersonaje)).

perseguidores(UnPersonaje, Cantidad):-
    findall(Perseguidor, persigue(Perseguidor, UnPersonaje), Perseguidores),
    length(Perseguidores, Cantidad).
