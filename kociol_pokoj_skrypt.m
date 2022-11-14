%Sta³e nieobliczalne
Cg=4175.4; %cieplo wlasciwe wody	
Cv=1008;	  %cieplo wlasciwe powietrza
g2=1.185;  %gestosc powietrza
g=997.04;  %gestosc wody
Vg=0.02; %pojemnosc
Vp=70;%70;
Vk=1;
Cvk=Cg*g*Vk;
Cvw=Cv*g2*Vp; % powietrze
Cvg=Cg*g*Vg;  % woda
time=2; % czas startu

%Wartosci nominalne:
Tzewnom=-20; % temperatura zewnetrzna
Twnom=20;	 % temperatura wewnatrz
Tgznom=90;	 % temperatura wchodzaca do grzejnika
Tkznom=90;
Tgpnom=70;	 % temperatura wychodzaca z grzejnika
Pnom=20000;	 % Moc
Tkpnom=70;	 % temperatura wody powracajaca do kotla
qt=0;
dqt=0;
%wyliczenie sta³ych
fgnom=Pnom/((Tgznom-Tgpnom)*Cg*g);
kg=Pnom/(Tgpnom-Twnom);
kstr=Pnom/(Twnom-Tzewnom);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% DANE DO KOTLA



fknom=Pnom/(Cg*g*(90-Tkpnom));
Tkp0=Tkpnom;
fk0=fknom;
Pk0=Pnom;



dPk=0;
dTkp=0;
dfk=0;

Tkz0=(Cg*g*fk0*Tkp0+Pk0)/(Cg*g*fk0);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% DANE DO POMIESZCZENIA
Twew_zad=20;


Tzew0=Tzewnom;
Tgz0=Tgznom;
Tgp0=Tgpnom;
Tkz0=Tgz0;
Tkp0=Tgp0;


%Dane do symulacji


dfg=0;
dTgz=0;
dTzew=0;
dTzw=2;
dqt=0;

%% WARUNKI POCZATKOWE
qt0=0;
Tw0= (Pk0+Tzew0*kstr)/kstr;
Tgp0= (kg*Tw0+Pk0)/kg;
Tgz0= (Cg*g*fk0*Tgp0+22000)/(Cg*g*fk0);
Tkz0= Tgz0
Pk0=kstr*Twew_zad+kg*Tgp0-kg*Twew_zad-kstr*Twew_zad;

Kp=691.32;
Ki=1.29;


