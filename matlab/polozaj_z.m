% Funkcija koja predstavlja z koordinatu aviona u zavisnost od t1, t,
% odabranog ugla alfa, pocetne tacke pravolinijskog kretanja z0 i brzine po
% komponenti z
function z = polozaj_z(t1, t, alfa,z0,vz)
% U zavisnosti od toga da li se avion krece u zaokretu ili pravolinijski, koordinata z se racuna na razlicite nacine
info;
if t <= t1 % u zaokretu
    z = r + r * cos(pi - t/t1 * (pi - alfa));
else % pravolinijski
    z = z0 + (t - t1) * vz;
end
end