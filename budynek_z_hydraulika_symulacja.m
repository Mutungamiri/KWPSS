close all;clear all;clc;
%% parametry symulacji
model='budynek_z_hydraulika';
czas=25000;
tmin=0.1;
tmax=50;
terr=1e-5;
opcje = simget(model);
opcje = simset('MaxStep', tmax, 'RelTol',terr);
%========================
%% wartosci nominalne
Tkp_n  = 70;       % st. C
Tkz_n  = 90;       % st. C
Tzew_n =-20;       % st. C
Twew_n = 20;       % st. C
Tgz_n  = 90;       % st. C
Tgp_n  = 70;       % st. C
P_n    = 20000;    % 20 kW
liczba_pomieszczen = 3;
Pk_n = P_n*liczba_pomieszczen;   % 20 kW
Pk_h = 10000;      %Pa
%=========================
%% parametry dynamiczne
Cp_woda = 4175.4;   % J/kgK
Cp_pow  = 1008;     % J/kgK
Ro_woda = 997.04;   % kg/m^3
Ro_pow  = 1.185;    % kg/m^3
V_woda  = 0.24;     % m^3
V_pow   = 70;       % m^3
V_kotla = 0.06;     % m^3
Cvg = (Cp_woda*Ro_woda*V_woda);
Cvw = (Cp_pow*Ro_pow*V_pow);
Cvk = (Cp_woda*Ro_woda*V_kotla);
%=========================
%% identyfikacja 
fg_n = P_n/((Tgz_n-Tgp_n)*Cp_woda*Ro_woda);  % przeplyw
fk_n = Pk_n/((Cp_woda*Ro_woda)*(Tkz_n-Tkp_n));
kg   = P_n/(Tgp_n-Twew_n);
kstr = P_n/(Twew_n-Tzew_n);
%=========================
%% identyfikacja oporow hydraulicznych
Rk = (0.1*Pk_h)/(3*fg_n);
R1 = (0.9*Pk_h)/fg_n;
R2 = R1;
R3 = R1;
%==========================
%% warunki poczatkowe
Tgp_0 = Tgp_n;
Twew_0 = Twew_n;
Tgz_0 = Tgz_n;
Tkz_0 = Tgz_0;
Tzew_0 = Tzew_n;
Pk_0 = Pk_n;

Q_1 = 0;
Q_2 = 0;
Q_3 = 0;

%poczatkowo opor zaworow wynosi 0, czyli sa maksymalnie 
%odkrecone, a przeplyw jest rowny nominalnemu. Aby zakrecic
%zawor i ustawic zerowy przeplyw trzeba podac wartosc 
%zmiennej zawor rzedzu 10^7 - 10^8
zawor_1 = 0;
zawor_2 = 0
zawor_3 = 0

% czas skoku
czas_skok = 2000;
% opoznienia
czas_przeplywu1 = 1000;
czas_przeplywu2 = 2000;
czas_przeplywu3 = 4000;
%==========================
%% zaklocenia
dTzew = 0;
dPk_0 = 0;
dQ_1 = 0;
dQ_2 = 0;
dQ_3 = 0;
dzawor_1 = 3*10^7;
dzawor_2 = 0;
dzawor_3 = 0;
%============================
%%wykresy
figure
[t]=sim(model,czas,opcje);
hold on;
%  rysowanie Twew1 
plot(t,dane_Twew1,'k', 'LineWidth', 2),hold on, grid on;
xlabel('czas');ylabel('temperatura');
title('wykres Twew 1');
figure;
%  rysowanie Twew2
plot(t,dane_Twew2,'g', 'LineWidth', 2),hold on, grid on;
xlabel('czas');ylabel('temperatura');
title('wykres Twew 2');
%  rysowanie Twew3
figure;
plot(t,dane_Twew3,'b', 'LineWidth', 2),hold on, grid on;
xlabel('czas');ylabel('temperatura');
title('wykres Twew 3');






 
 
 