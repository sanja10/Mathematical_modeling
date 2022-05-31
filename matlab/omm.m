polozaj_projektila;
info;

% Vreme proteklo od trenutka ispustanja bombe do eksplozije moze se
% izracunati kao nula funkcije koja predstavlja y koordinatu projektila u
% zavisnosti od vremena t
disp('Vreme proteklo do eksplozije:');

disp(t_eksplozije);

% Poluprecnik udarnog talasa
R=@(t) brzina_talasa * (t - t_eksplozije);

% x, y, z koordinate projektila u trenutku eksplozije
x_proj = x_projektil(t_eksplozije);
y_proj = y_projektil(t_eksplozije);
z_proj = z_projektil(t_eksplozije);

% Vektori alfas i Rs cuvaju redom niz odabranih uglova koje avion pravi sa pozitivnim delom z ose, odnosno niz
% poluprecnika udarnog talasa
alfas = [];
Rs = [];

xs = [];
zs = [];

%Optimalno alfa, R i trenutak susreta
opt_alfa = 0;
opt_D = 0;
opt_t_susreta = 0;

% Ugao alfa krece se od 0 do pi/2 sa korakom 0.0001
for alfa = 0:0.0001:pi/2

   % t1 - trenutak kada avion zavrsava zaokret i nastavlja da se krece
   % pravolinijski
   t1 = (r*(pi-alfa)) / brzina_aviona;
   
   % (x0,z0) je tacka u kojoj se avion nalazi u trenutku kada nastavlja
   % pravolinijski da se krece
   x0 = r * sin(alfa);
   z0 = r + r*cos(alfa);
   
   % Razlozili smo brzinu aviona na komponenete, odnosno na brzinu vx po x
   % osi vz po z osi
   vx = brzina_aviona*sin(alfa-pi/2);
   vz = sqrt(brzina_aviona^2 - vx^2);
    
   % x, y, z koordinate aviona u zavisnosti od trenutka t
   x=@(t) polozaj_x(t1,t,alfa,x0,vx);
   y=@(t) polozaj_y();
   z=@(t) polozaj_z(t1,t,alfa,z0,vz);
   
   % D - udaljenost aviona od mesta gde je bomba pala, u zavisnosti od
   % trenutka t
   D=@(t) sqrt((x(t) - x_proj)^2 + (y(t) - y_proj)^2 + (z(t) - z_proj)^2);
   
   % Potrebna nam je nula naredne funkcije kako bismo pronasli trenutak
   % susreta talasa i aviona
   resenje=@(t) R(t) - D(t);
    
   
   % Naredna petlja sluzi da iscrtamo vise razlicitih putanja koje avion
   % pravi u zavisnosti od odabranog alfa
   
   xs = [];
   zs = [];
   for t = 0:300
       x=@(tt) polozaj_x(t1,t,alfa,x0,vx);
       x_poz = x(t);
       xs = [xs x_poz];
       z=@(tt) polozaj_z(t1,t,alfa,z0,vz);
       z_poz = z(t);
       zs = [zs z_poz];
   end
   
   plot(xs,zs);
   
   hold on;
    
   % Trenutak susreta za odabrano alfa dobijamo kao nulu funkcije resenje
   t_susreta = fsolve(resenje, t_eksplozije);
   D1 = D(t_susreta); % Poluprecnik talasa za ovo t_susreta
    
   % Dobijanje najvece udaljenosti aviona od bombe u trenutku susreta
   if(D1 > opt_D)
 	opt_D = D1;
 	opt_t_susreta = t_susreta;
 	opt_alfa = alfa;
   end
end

disp('Kada koristi optimalnu putanju, u trenutku sudara avion je udaljen:');
disp(opt_D);
disp('A vreme proteklo do sudara je:');
disp(opt_t_susreta);
disp('A alfa');
disp(opt_alfa);


%     xs = [];
%    zs = [];
%    r=4700;
%    t1 = (r*(pi-1.2502)) / brzina_aviona;
%    x0 = r * sin(1.2502);
%    z0 = r + r*cos(1.2502);
%    vx = brzina_aviona*sin(1.2502-pi/2);
%     vz = sqrt(brzina_aviona^2 - vx^2);
%    for t = 0:300
%        x=@(tt) polozaj_x(r,t1,t,1.2502,x0,vx);
%        x_poz = x(t);
%        xs = [xs x_poz];
%         z=@(tt) polozaj_z(r,t1,t,1.2502,z0,vz);
%         z_poz = z(t);
%         zs = [zs z_poz];
%    end
%    plot(xs, zs);
%    hold on;


