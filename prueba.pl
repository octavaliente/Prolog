%Tía Agatha, el mayordomo y Charles son las únicas personas que viven en la mansión Dreadbury.
viveEnlaMansion(tiaAgatha).
viveEnlaMansion(mayordomo).
viveEnlaMansion(charles).
%Agatha odia a todos los que viven en la mansión, excepto al mayordomo
odia(tiaAgatha,Odiados):-
    viveEnlaMansion(Odiados),
    Odiados \= mayordomo.
%Charles odia a todas las personas de la mansión que no son odiadas por la tía Agatha.
odia(charles,Odiados):-
    viveEnlaMansion(Odiados),
    not(odia(tiaAgatha,Odiados)).
%El mayordomo odia a las mismas personas que odia tía Agatha.
odia(mayordomo,Odiados):-
    odia(tiaAgatha,Odiados).
%Quien no es odiado por el mayordomo y vive en la mansión, es más rico que tía Agatha
esMasRico(Alguien,tiaAgatha):-
    viveEnlaMansion(Alguien),
    not(odia(mayordomo,Alguien)).
%Quien mata es porque odia a su víctima y no es más rico que ella. 
%Además, quien mata debe vivir en la mansión Dreadbury.
mata(Asesino,Victima):-
    viveEnlaMansion(Asesino),
    viveEnlaMansion(Victima),
    odia(Asesino,Victima), 
    not(esMasRico(Asesino,Victima)).
