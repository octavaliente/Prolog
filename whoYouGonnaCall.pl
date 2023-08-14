%functor: aspiradora(potencia minima requerida paraa hacer la tarea)
herramientasRequeridas(ordenarCuarto, [aspiradora(100), trapeador, plumero]).
herramientasRequeridas(limpiarTecho, [escoba, pala]).
herramientasRequeridas(cortarPasto, [bordedadora]).
herramientasRequeridas(limpiarBanio, [sopapa, trapeador]).
herramientasRequeridas(encerarPisos, [lustradpesora, cera, aspiradora(300)]).

%1
tiene(egon,aspiradora(200)).
tiene(egon,trapeador).
tiene(peter,trapeador).
tiene(winston,varitaDeNeutrones).

%2
satisfaceNecesidadDeTener(UnaPersona,UnaHerramienta):-
    tiene(UnaPersona,UnaHerramienta).
satisfaceNecesidadDeTener(UnaPersona,aspiradora(PotenciaRequerida)):-
    tiene(UnaPersona,aspiradora(Potencia)),
    Potencia >= PotenciaRequerida.

%3
puedeRealizar(UnaTarea,UnaPersona):-
    tiene(UnaPersona,varitaDeNeutrones),
    requiere(UnaTarea,_).

puedeRealizar(UnaTarea,UnaPersona):-
    requiere(UnaTarea,_),
    tiene(UnaPersona,_),
    forall(requiere(UnaTarea,UnaHerramienta),satisfaceNecesidadDeTener(UnaPersona,UnaHerramienta)).

requiere(UnaTarea,UnaHerramienta):-
    herramientasRequeridas(UnaTarea,Herramientas),
    member(UnaHerramienta,Herramientas).

%4
%un pedido tiene muchas tareas dentro
%precio(UnaTarea, UnPrecioXMetroCuadrado)
%tareaPedida(UnCLiente, UnaTarea, CantidadMetros)
precioACobrar(UnCliente,Total):-
    tareaPedida(UnCliente,_,_),
    findall(PrecioTarea,precioPorTareaPedida(UnCliente,_,PrecioTarea), PrecioPedido),
    sum_list(PrecioPedido, Total).

precioPorTareaPedida(UnCliente, UnaTarea, PrecioTarea):-
    tareaPedida(UnCliente, UnaTarea, CantidadMetros),
    precio(UnaTarea, PrecioPorMetro),
    PrecioTarea is CantidadMetros * PrecioPorMetro.

%5
aceptaPedido(UnaPersona, UnCliente):-
    puedeHacerPedido(UnaPersona, UnCliente),
    estaDispuestoAHacer(UnaPersona, UnCliente).

puedeHacerPedido(UnaPersona, UnCliente):-
    tareaPedida(UnCliente,_,_),
    tiene(Trabajador,_),
    forall(tareaPedida(UnCliente,UnaTarea,_), puedeRealizar(UnaTarea, UnaPersona)).

estaDispuestoAHacer(ray, UnCliente):-
    tareas(UnCliente, ListaTareas),
    not(member(limpiarTecho, ListaTareas)).

tareas(UnCliente, ListaTareas):-
    tareaPedida(UnCliente, _, _),
    findall(Tarea, tareaPedida(UnCliente, Tarea, _), ListaTareas).

estaDispuestoAHacer(winston, UnCliente):-
    precioACobrar(UnCliente, UnPrecio),
    UnPrecio > 500.

estaDispuestoAHacer(egon, UnCliente):-
    forall(tareaPedida(UnCliente, UnaTarea, _), not(esTareaCompleja(UnaTarea))).

esTareaCompleja(limpiarTecho).

esTareaCompleja(UnaTarea):-
    herramientasRequeridas(UnaTarea, ListaHerramientas),
    length(ListaHerramientas, Cantidad),
    Cantidad > 2.

estaDispuestoAHacer(peter, _).