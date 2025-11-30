
%2.1 
%H(Z) = 10 * ((1 - 1.1112z^-1 + 1.2345z^-2)/(1 - 0.9z^-1 + .81z^-2))\



%2.4a
[ecgsig, fs, fint] = ECGmake('gburdell7');
%fint = 59.4
%fs = 750 

%poles: ( +0.8345 , +-0.4540 )
% zeroes: ( +0.8784 , +-0.4779 )

%2.4(b,c)
% see 2.4(b_c).png

%2.4d
% H(z) = (1 - 2*cos(wo)*z^-1 + z^-2)/(1 - 2rcos(wo)*z^-1 + r^2*z^-2)
% b0 = 1
% b1 = -1.7574
% b2 = 1
% 
% a0 = 1 
% a1 = -1.6696
% a2 = .9025
%
% y[n] = 1.67*y[n-1] - 0.902*y[n-2] +x[n] - 1.76x[n-1] + x[n-2]

b = [1      -1.7574   1];        % zeros (numerator)
a = [1      -1.6696   0.9025];   % poles (denominator)


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