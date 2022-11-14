clear all;close all;clc;

%==========================
%parametry symulacji
%==========================
model='pokoje';
czas=200000;
czas_przeplywu=100*60;
tmin=0.1;
tmax=50;
terr=1e-5;
opcje = simget(model);
opcje = simset('MaxStep', tmax, 'RelTol',terr);
czas_przesuniecia=1000;  %czas skoku

%==========================
%parametry "dynamiczne"
%==========================
cpp=4175.4;    %J/kg K, woda
cpow=1008;     %c pow
rpow=1.185;    %ro pow
rop=997.04;    %kg/m3, woda
V=9^3;         %pomieszczenia
Vg=1*1*0.2;    %grzejnika
Vk=1;          %kotla
Cvw=cpow*rpow*V; 
Cvg=cpp*rop*Vg;  
Cvk=cpp*rop*Vk;  


%==========================
%wartoœci nominalne
%==========================
Tzewn=-20;
Pgn=20000; % jeden pokój
Twewn=20;
Tgzn=90;   
Tgpn=70;
Tkpn  = 70;       % st. C
Tkzn  = 90;       % st. C
Pkn   = 3*Pgn;     % 3 pokoje
Pkh   = 10000;      %Pa

%==========================
%identyfikacja parametrów statycznych
%==========================
kg=(Pgn)/(Tgpn-Twewn);
fgn=Pgn/(cpp*rop*(Tgzn-Tgpn));
kstrat=Pgn/(Twewn-Tzewn);
fkn=Pkn/((cpp*rop)*(Tkzn-Tkpn));

%==========================
%identyfikacja hydrauliki
%==========================
Rk = (0.01*Pkh)/(3*fgn);
R1 = (0.99*Pkh)/fgn;
R2 = R1;
R3 = R1;

%==========================
% warunki poczatkowe i zaklocenia
%==========================
Tzew0=Tzewn; 
Tgz0=Tgzn; 
fg0=fgn; 
Tkp0 = Tkpn;
fk0 = fkn;
Twewzad0=20;
Tgp0=Tgpn;
Tkz0=Tkzn;
Tkp0=Tkpn;
Twew0=Twewzad0;
Tgz0=Tgzn;
qt=0;
qt1=0;
qt2=0;
qt3=0;
fg1=fgn;
fg2=fgn;
fg3=fgn;
Pk=Pkn;
z_1 = 0;  %zawor 1
z_2 = 0;  %zawor 2
z_3 = 0;  %zawor 3
%=============
%    SKOKI
%=============
dfg1=0;
dfg2=0;
dfg3=0;
dTzew0=0;
dqt1=0;
dqt2=0;
dqt3=0;
dqt   = 0;
dTgz  = 0;
dfg   = 0;
dTzew = 0;
dTwewzad=0;
dTkp = 0;
dfk = 0;
dPk = 0.1*Pkn;
dqt=0;
dz_1 = 0;
dz_2 = 0;
dz_3 = 0;

% ==================
% RYSOWANIE WYKRESÓW
% ==================
figure
[t]=sim(model,czas,opcje);
plot(t,Twew1,'k', 'LineWidth', 2.5),hold on, grid on;

figure
[t]=sim(model,czas,opcje);
plot(t,Twew2,'r', 'LineWidth', 2.5),hold on, grid on;

figure
[t]=sim(model,czas,opcje);
plot(t,Twew3,'m', 'LineWidth', 2.5),hold on, grid on;

figure
[t]=sim(model,czas,opcje);
plot(t,Tkp,'m', 'LineWidth', 2.5),hold on, grid on;

