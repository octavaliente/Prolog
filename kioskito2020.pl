%1
%atiende(Quien,Dia,HorarioInicial,HorarioFinal)
atiende(dodain,lunes,9,15).
atiende(dodain,miercoles,9,15).
atiende(dodain,viernes,9,15).
atiende(lucas,martes,10,20).
atiende(juanC,sabados,18,22).
atiende(juanC,domingos,18,22).
atiende(juanFdS,jueves,10,20).
atiende(juanFdS,viernes,12,22).
atiende(leoC,lunes,14,18).
atiende(leoC,miercoles,14,18).
atiende(martu,miercoles,23,24).

atiende(vale,Dia,HorarioInicial,HorarioFinal):-
    atiende(dodain,Dia,HorarioInicial,HorarioFinal).
atiende(vale,Dia,HorarioInicial,HorarioFinal):-
    atiende(juanC,Dia,HorarioInicial,HorarioFinal).

%2
estaAtendiendo(UnaPersona,UnDia,UnHorarioPuntual):-
    atiende(UnaPersona, UnDia, HorarioInicial, HorarioFinal),
    between(HorarioInicial, HorarioFinal, UnHorarioPuntual).

%3
foreverAlone(UnaPersona,UnDia,UnHorarioPuntual):-
    estaAtendiendo(UnaPersona,UnDia,UnHorarioPuntual),
    not(horarioCompartido(UnDia,UnHorarioPuntual)).

horarioCompartido(UnDia,UnHorarioPuntual):-
    findall(Persona,estaAtendiendo(Persona,UnDia,UnHorarioPuntual),PersonasAtendiendo),
    length(PersonasAtendiendo,Cantidad),
    Cantidad > 1.

%4
atendiendo(Personas,UnDia):-
    atiende(_,UnDia,_,_),
    findall(Persona, atiende(Persona, UnDia,_,_), Personas).

atendiendo(Personas,UnDia):-
    atiende(Persona,UnDia,_,_),
    findall(Persona, atiende(Persona, UnDia,_,_), Personas).

atendiendo(Personas,UnDia):-
    horarioCompartido(UnDia,UnHorarioPuntual),
    findall(Persona,estaAtendiendo(Persona,UnDia,UnHorarioPuntual),Personas).

%5
%golosinas(monto)
vendio(dodain,lunes,10,[golosinas(1000),cigarrillos([jockey]),golosinas(50)]).
vendio(dodain,miercoles,12,[bebida(alcoholica,8),bebida(no-alcoholica,1),golosinas(10)]).
vendio(martu,miercoles,12,[golosinas(1200),cigarrillos([chesterfield,colorado,parisiennes])]).

esSuertuda(Persona):-
    vendedor(Persona),
    forall(vendio(Persona,_,_,[Venta|_]), granVenta(Venta)).

vendedor(Persona):-
    vendio(Persona,_,_,_).

granVenta(golosinas(Monto)):-
    Monto > 100.
granVenta(cigarrillos(Lista)):-
    length(Lista,Cantidad),
    Cantidad > 2.
granVenta(bebida(alcoholica,_)).
granVenta(bebida(_,Cantidad)):-
    Cantidad > 5.