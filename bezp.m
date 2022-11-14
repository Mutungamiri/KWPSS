clear all;clc;
%parametry symulacji
model='bezpmod';
czas=10000000;
tmin=0.1;
tmax=50;
terr=1e-5;
opcje = simget(model);
opcje = simset('MaxStep', tmax, 'RelTol',terr);
%==========================
%parametry "dynamiczne"
cpp=4175.4; %J/kg K, woda
cpow=1008; %c pow
rpow=1.185; %ro pow
rop=997.04; %kg/m3, woda
V=9^3; %m3
Vg=1*1*0.2;
Vk=1;
Cvw=cpow*rpow*V
Cvg=cpp*rop*Vg
Cvk=cpp*rop*Vk
%wartoœci nominalne
Tzewn=-20;
Pgn=20000; %20kW
Twewn=20;
Tgzn=90;
Tgpn=70;
qt=0;
dqt=0;
Tkpn  = 70;       % st. C
Tkzn  = 90;       % st. C
Pkn    = 20000;   % 20 kW
%identyfikacja parametrów statycznych
kg=(Pgn)/(Tgpn-Twewn);
fgn=Pgn/(cpp*rop*(Tgzn-Tgpn));
kstrat=Pgn/(Twewn-Tzewn);
fkn=Pkn/((cpp*rop)*(Tkzn-Tkpn));
%==========================
%warunki pocz¹tkowe
Tzew0=Tzewn+7; %Tzewn+5;
Tgz0=Tgzn-7; %Tgzn-10;
fg0=fgn; %fgn*0.50;
% warunki poczatkowe i zaklocenia
Tkp0 = Tkpn;
fk0 = fkn;

dTkp = 0;
dfk = 0;
dPk = 0;
czas_skok=100000;
czas_przeplywu=60;
%stan równowagi
% Tkz0 = (Pk0 +(cpp * rop * fk0 * Tkp0))/(cpp * rop * fk0);
% Tgp0 =( Tzew0*( (kstrat^2/(kg+kstrat))- kstrat ) - cpp*rop*fg0*Tgz0 ) / (-cpp*rop*fg0 - (kstrat * kg)/(kg+kstrat) )  ;
% Twew0 = (kg*Tgp0 + kstrat *  Tzew0)/(kg+kstrat);
Twewzad0=20+5;
Pk0 = kstrat*(Twewzad0-Tzew0);
Twew0=Twewzad0;
Tgp0=(Pk0+kg*Twew0)/kg;
Tgz0=(Pk0+cpp*rop*fg0*Tgp0)/(cpp*rop*fg0);
Tkz0=Tgz0;
Tkp0=Tgp0;



%wyliczenie wspolczynnikow do regulacji pogodowej (a i b)

a=1+((Tgzn-Twewn)/(Twewn-Tzewn));
b=(Twewn-Tgzn)/(Twewn-Tzewn);
% kp=-821.2598;
% ki=9.0397e+003;
% kp=22.67;
kp=11.335;
%Ti=4726.67;
Ti=2364.335;
ki=1/Ti;
war_pocz=Pk0;
%==========================
% badanie odpowiedzi dynamicznej na skok wejscia w roznych punktach pracy
% wyliczenie nowych punktow pracy

% %reakcja na zaklocenie Tgz
% czas_skok=1000;
dqt   = 0;
dTgz  = 0;
dfg   = 0;
dTzew = 0;
dTwewzad=0;
% % regulator
% kp = 20;
% Ti = 80;
% ki = 1/Ti;
% Twewzad0 = Twewn;
% dTwewzad =1.5;
% % warunki poczatkowe
% % Tgp0 = (kstrat*Twewzad0 - kstrat*Tzew0 + kg*Twewzad0)/kg
% Tgp0 =( Tzew0*( (kstrat^2/(kg+kstrat))- kstrat ) - cpp*rop*fg0*Tgz0 ) / (-cpp*rop*fg0 - (kstrat * kg)/(kg+kstrat) )  ;
% war_pocz = (kg*Tgp0 - kg*Twewzad0 + cpp*rop*fgn*Tgp0)/(cpp*rop*fgn) %Tgz0
% Twew0 = Twewzad0

[t]=sim(model,czas,opcje);

% nowe_dane_fg = (dane_fg/fg_n)*100;
% % wykres fg
% plot(t,nowe_dane_fg,'k', 'LineWidth', 2),hold on, grid minor;
% xlabel('czas');ylabel('przeplyw [%]');
% title('wykres fg (zmiennej sterujacej)');
% figure;
% wykres Twew
plot(t,aTwew,'k', 'LineWidth', 2.5),hold on, grid on;
xlabel('czas');ylabel('temperatura');
title('wykres Twew');

ISE=ise(length(ise))
