%**********WARTOŒCI NOMINALNE***************%

TzewN = -20;
TwewN = 20;
TgzN = 90;
TgpN = 70;
Vp = 5*6*3;
Vg = 10;
cpp = 1000;
rop = 1.2;
cpw = 4175;
row = 960;
Cvw = cpp * rop * Vp;
Cvg = cpw * row * Vg;
qgN = 20000;
Cvk = Cvg;
%******PARAMETRY************%

Kcw = qgN/(TwewN-TzewN);
Kcg = qgN/(TgpN - TwewN);
fmgN = qgN/(TgzN-TgpN);
fmkN = qgN/(TgzN-TgpN);

%******WARUNKI POCZ¥TKOWE*****%

Tzew0 = TzewN;
Tgz0 = TgzN;
Twew0 = TwewN;
Tgp0 = TgpN;
Tkz0 = TgzN;
qk0 = qgN;
fmk0 = fmkN;
dTzew = 0;
dfmg = 0;
dTgz = 0;
dTkz = 0;
dqk = 0;
dfmk = 0;


[t] = sim('schemat.slx', 1000);

figure(1)
grid on;
plot(t, Twew);
title('Twew');
figure(2)
grid on;
plot(t, Tgp);
title('Tgp');
