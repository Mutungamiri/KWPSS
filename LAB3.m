%sta³e 
cpw = 4175;
TzewN = -20;
cpp = 1000;
rop = 1.2;
cpw = 4175;
row = 960;
TS=1000000;
t0 = 0.1*TS;
%
%POKÓJ 1
%
Vp1 = 5*6*3;
Vg = 0.1*0.3*0.5;
Cvw1 = cpp * rop * Vp1;
Cvg1 = cpw * row * Vg;
qg1 = 5000;
Twew1N = 20;

%
%POKÓJ 2
%
Vp2 = 1.2 * Vp1;
Cvw2 = cpp * rop * Vp2;
qg2 = 1.2 * qg1;
Twew2N = 20;

%
%KOCIO£
%

Cvk = cpw * cpp * 1*1*1;
qkN = qg1 + qg2;
TkpN = 70;
TkzN = 90;

fmkN = qkN/(cpw * (TkzN-TkpN));

%
% PARAMETRY POMIESZCZEÑ
%

Tgp1N = TkpN;
Tgp2N = TkpN;

fmg1 = qg1/(cpw*(TkzN-Tgp1N));
fmg2 = qg2/(cpw*(TkzN-Tgp2N));

Kcg1 = (cpw*fmg1*(TkzN-Tgp1N))/(Tgp1N-Twew1N);
Kcg2 = (cpw*fmg2*(TkzN-Tgp2N))/(Tgp2N-Twew2N);

Kcp = (3*4)/0.20;

Kcw1 =(Kcg1*(Tgp1N-Twew1N)-Kcp*(Twew1N-Twew2N))/(Twew1N-TzewN);
Kcw2 =(Kcg2*(Tgp2N-Twew2N)-Kcp*(Twew1N-Twew2N))/(Twew2N-TzewN);

%
%WARTOŒCI POCZ¥TKOWE
%

delta_t=25000;

qk0 = qkN;
dqk = 0.2*qkN;

Tzew0 = TzewN;
dT = 0;


f10 = fmg1;
df1 = 0;

f20 = fmg2;
df2 = 0;


fmk0 = fmkN;
dfmk = 0;


%
% WARUNKI POCZ¥TKOWE
%

A =[ -(Kcg1+Kcw1+Kcp), Kcp, Kcg1, 0,0;
        Kcg1, 0, -(cpw*fmg1+Kcg1), 0,cpw*fmg1;
        Kcp, -(Kcg2+Kcw2+Kcp), 0, Kcg2,0;
        0, Kcg2, 0, -(cpw*fmg2+Kcg2),cpw*fmg2;
        0,0,fmg1/(fmg1+fmg2),fmg2/(fmg1+fmg2),-1];
y =[-Kcw1*Tzew0;0;-Kcw2*Tzew0;0;-qk0/(cpw*fmk0)];

x = pinv(A)*y;

Twew10 = x(1);
Twew20 = x(2);
Tgp10 = x(3);
Tgp20 = x(4);
Tkz0 = x(5);

Tkp0 = (fmg1*Tgp10+fmg2*Tgp20)/(fmg1+fmg2);

out = sim("grzej_ret.slx");

figure();
subplot(411);
plot(out.tout,out.Twew1);grid on; grid minor;
xlabel("$t\ [s]$","Interpreter","latex");ylabel("$T_{wew1}$","Interpreter","latex");
subplot(412);
plot(out.tout,out.Twew2);grid on; grid minor;
xlabel("$t\ [s]$","Interpreter","latex");ylabel("$T_{wew2}$","Interpreter","latex");
subplot(413);
plot(out.tout,out.Tgp1);grid on; grid minor;
xlabel("$t\ [s]$","Interpreter","latex");ylabel("$T_{gp1}$","Interpreter","latex");
subplot(414);
plot(out.tout,out.Tgp2);grid on; grid minor;
xlabel("$t\ [s]$","Interpreter","latex");ylabel("$T_{gp2}$","Interpreter","latex");


figure();
plot(out.tout,out.Tkp);grid on; grid minor; hold on
plot(out.tout,out.Tzew + Tkp0 + abs(Tzew0));
xlabel("$t\ [s]$","Interpreter","latex");ylabel("$T_{kp}$","Interpreter","latex");


%
% STATYCZNE
%

i = 0;
for iterator= -30.0: 0.2: 10.0
    i=i+1;
    Tzew0stat(i) = iterator;
    
    %znowu rówania statyczne
    Astat =[ -(Kcg1+Kcw1+Kcp), Kcp, Kcg1, 0,0;
        Kcg1, 0, -(cpw*fmg1+Kcg1), 0,cpw*fmg1;
        Kcp, -(Kcg2+Kcw2+Kcp), 0, Kcg2,0;
        0, Kcg2, 0, -(cpw*fmg2+Kcg2),cpw*fmg2;
        0,0,fmg1/(fmg1+fmg2),fmg2/(fmg1+fmg2),-1];
ystat =[-Kcw1*Tzew0stat(i);0;-Kcw2*Tzew0stat(i);0;-qk0/(cpw*fmk0);];

xstat = pinv(A)*ystat;

Twew10stat(i) = xstat(1);
Twew20stat(i) = xstat(2);
Tgp10stat(i) = xstat(3);
Tgp20stat(i) = xstat(4);
Tkz0stat(i) = xstat(5);


end
figure();
subplot(411);
plot(Tzew0stat,Twew10stat);
xlabel("$T_{zew}$","Interpreter","latex");ylabel("$T_{wew1}$","Interpreter","latex");
subplot(412);
plot(Tzew0stat,Twew20stat);
xlabel("$T_{zew}$","Interpreter","latex");ylabel("$T_{wew2}$","Interpreter","latex");
subplot(413);
plot(Tzew0stat,Tgp10stat);
xlabel("$T_{zew}$","Interpreter","latex");ylabel("$T_{gp1}$","Interpreter","latex");
subplot(414);
plot(Tzew0stat,Tgp20stat);
xlabel("$T_{zew}$","Interpreter","latex");ylabel("$T_{gp2}$","Interpreter","latex");
    
