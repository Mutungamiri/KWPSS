%Skrypt do grzejnika
%Sta³e nieobliczalne
Cg=4175.4; %cieplo wlasciwe wody	
Cv=1008;	  %cieplo wlasciwe powietrza
g2=1.185;  %gestosc powietrza
g=997.04;  %gestosc wody
Vg=0.02; %pojemnosc
Vp=70;
%Wartosci nominalne:
Tzewnom=-20;
Twnom=20;
Tgznom=90;
Tgpnom=70;
Pnom=20000;
%wyliczenie sta³ych
fgnom=Pnom/((Tgznom-Tgpnom)*Cg*g);
kg=Pnom/(Tgpnom-Twnom);
kstr=Pnom/(Twnom-Tzewnom)

%--------------------------------
%Wartosci poczatkowe
%--------------------------------
Tzew0=Tzewnom
Tgz0=Tgznom
fg0=1*fgnom
A=Cg*g*fg0;
%Tgp0=(A*(Tgz0+(kg/kstr)*Tgz0)+kg*Tzew0)/((kg*A/kstr)+kg+A)
%Tw0=(A/kstr)*(Tgz0-Tgp0)+Tzew0
qt0=0;



%Dane do symulacji
Twew_zad=20;
Tw0=Twew_zad;


Cvw=Cv*g2*Vp % powietrze
Cvg=Cg*g*Vg  % woda
fgtime=200;
Tgztime=200;
Tzewtime=200;
qttime=200;
dfg=0;
dTgz=0;
dTzew=0%12;
dqt=0;
dTzw=5;



%do PI
Tgp0=(kstr*(Twew_zad-Tzew0)+kg*Twew_zad)/kg
Tgz0_pi=(-kg*Twew_zad+A*Tgp0+kg*Tgp0)/A
fg0_pi=(kstr*(Twew_zad-Tzew0))/(Cg*g*(Tgz0-Tgp0))

Kp_Tgz=5.22510878283972;
Ki_Tgz=0.0379203431109515;

Kp_fg0=6.27559158531166e-005
Ki_fg0=4.55440443499984e-007







sim('grzejnik_pi_schemat');
figure(1);
hold on;
grid on;
plot(t,TwOut);






