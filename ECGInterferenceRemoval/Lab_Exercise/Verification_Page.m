
%2.1 
%H(Z) = 10 * ((1 - 1.1112z^-1 + 1.2345z^-2)/(1 - 0.9z^-1 + .81z^-2))\



%2.4a
[ecgsig, fs, fint] = ECGmake('gburdell7');

%poles: ( +0.8345 , +-0.4540 )
% zeroes: ( +0.8784 , +-0.4779 )

%2.4(b,c)
% see 2.4(b_c).png

%2.4d
% H(z) = (1 - 2*cos(wo)*z^-1 + z^-2)/(1 - 2rcos(wo)*z^-1 + r^2*z^-2)
% Define the frequency of interest for the notch filter
wo = 2 * pi * fint / fs; 
r = 0.95;


b0 = 1;
b1 = 2*cos(wo);
b2 = 1;

a0 = 1 ;
a1 = 2*r*cos(wo);
a2 = r^2; 
%
% y[n] = 1.67*y[n-1] - 0.902*y[n-2] +x[n] - 1.76x[n-1] + x[n-2]
b = [b0      -b1   b2];       % zeros (numerator)
a = [a0      -a1   a2];   % poles (denominator)


%2.4e

y = filter (b, a, ecgsig);

t = (0:length(ecgsig)-1)/fs; %time index

%make a window
t1 = 0;   t2 = 5;
i = (t >= t1) & (t <= t2);

subplot(2,1,1);
plot(t(i), ecgsig(i));
xlabel('Time (s)');
ylabel('Amplitude');
title('ECG + interference (input)');

subplot(2,1,2);
plot(t(i), y(i));
xlabel('Time (s)');
ylabel('Amplitude');
title('ECG after notch filter');