clear all;
% Membuat penguat dengan nilai Gp tertentu
% Parameter :
s11 = 0.641*exp(j*deg2rad(-171.3));
s12 = 0.057*exp(j*deg2rad(16.3));
s21 = 2.058*exp(j*deg2rad(28.5));
s22 = 0.572*exp(j*deg2rad(-95.7));
Gp = 9; #dB

%% menentukan kemantapan transistor
Delta = s11*s22 - s12*s21;
K = (1-abs(s11)^2-abs(s22)^2+abs(Delta)^2)/2/abs(s12*s21);

if abs(Delta)<1 && K>1
  printf("MANTAP TANPA SYARAT \n");
else
  printf("MANTAP BERSYARAT \n");
endif
K
absDelta=abs(Delta)

linGp = 10^(Gp/10);
gp = linGp/(abs(s21)^2);

%% menghitung titik pusat Cp, radius Rp, dan lingkaran Gp konstan
C2 = s22 - Delta*conj(s11);
Cp = (gp*conj(C2))/(1+gp*(abs(s22)^2-abs(Delta)^2));

rp = sqrt(1-2*K*abs(s12*s21)*gp+abs(s12*s21)^2*gp^2);
rp = rp/abs(1+gp*(abs(s22)^2-abs(Delta)^2));

Cp
Cp_pol = [abs(Cp) rad2deg(angle(Cp))]
rp

%% pilih gammaL sembarang -> yang penting ada di Gp konstan
gammaL = 0.44*exp(j*deg2rad(117.36)); #ambil sembarang di dalam Gp konstan

gammaIn = s11 + (s12*s21*gammaL)/(1-s22*gammaL);
gammaS = conj(gammaIn);
gammaOut = s22 + (s12*s21*gammaS)/(1-s11*gammaS);

gammaIn
gammaIn_pol = [abs(gammaIn) rad2deg(angle(gammaIn))]
gammaOut
gammaOut_pol = [abs(gammaOut) rad2deg(angle(gammaOut))]

%% membuat RPIM dan RPIK
%%% GAWE SMITH CHART CUK. ENAK MEN PROGRAM TRS -_-
