% Funkcija koja predstavlja x koordinatu aviona u zavisnost od t1, t,
% odabranog ugla alfa, pocetne tacke pravolinijskog kretanja x0 i brzine po
% komponenti x

function x = polozaj_x(t1,t,alfa,x0,vx)
info;
% U zavisnosti od toga da li se avion krece u zaokretu ili pravolinijski, koordinata x se racuna na razlicite nacine
if t <= t1 % u zaokretu
    x = r * sin(pi - t/t1 * (pi - alfa));
else % pravolinijski

    x = x0 + (t-t1) * vx;
end
end