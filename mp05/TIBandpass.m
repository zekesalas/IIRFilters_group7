%user-defined parameters:
fs = 11025; %sampling frequency
f0 = 433;
dBgain =0; %0 dB
Q = 1;
%intermediate parameters
wo = 2*pi*f0/fs;
cosW = cos(wo);
sinW = sin(wo);
A = 10^(dBgain/40);
alpha = sinW/(2*Q*A);
% %Peaking EQ coefficients
b0 = 10^(dBgain/20)*(1 + alpha*A);
b1 = 10^(dBgain/20)*(-2*cos(wo));
b2 = 10^(dBgain/20)*(1 - alpha*A);
a0 = 1 + (alpha/A);
a1 = -2*cos(wo);
a2 = 1 - (alpha/A);
%Normalize so that A0 = 1
B0 = b0/a0;
B1 = b1/(2*a0);
B2 = b2/a0;
A1 = a1/(-2*a0);
A2 = a2/(-a0);
Mx = max(abs([B0, B1, B2]));
if Mx > 1
B0new = B0/Mx;
B1new = B1/Mx;
B2new = B2/Mx;
else
B0new = B0;
B1new = B1;
B2new = B2;
end
NB = 16; % number of bits
Range = 2^(NB-1)-1;
N0 = floor(B0new*Range);
N1 = floor(B1new*Range);
N2 = floor(B2new*Range);
D1 = floor(A1*Range);
D2 = floor(A2*Range);

freqz([N0, 2*N1, N2],[2^15,-2*D1,-D2])