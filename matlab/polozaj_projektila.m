info;

% Naredne tri funkcije predstavljaju x, y i z koordinatu projektila u zavisnosti od proteklog vremena t

x_projektil=@(t) brzina_aviona * t;
y_projektil=@(t) (-g * t^2)/2 + visina_aviona;
z_projektil=@(t) 0;



