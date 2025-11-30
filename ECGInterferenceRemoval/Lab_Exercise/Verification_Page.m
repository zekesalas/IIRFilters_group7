
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

figure(1)
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


% 2.4f

Fs = 750;                 % sampling frequency (Hz)

% FFT of original and filtered signals
ECGFFT = fft(ecgsig);
YFFT   = fft(y);

N = length(ECGFFT);       % assume ecgsig and y have same length

% Shift zero frequency to the center (for -Fs/2 ... Fs/2 view)
ECGFFT = fftshift(ECGFFT);
YFFT   = fftshift(YFFT);

% Frequency axis in Hz
f = (-N/2:N/2-1) * (Fs/N);   % goes from -Fs/2 to Fs/2

% Convert magnitude to dB (add eps to avoid log of zero)
ECG_dB = 20*log10(abs(ECGFFT) + eps);
Y_dB   = 20*log10(abs(YFFT)   + eps);

figure;

% Full spectrum in dB
subplot(2,1,1);
plot(f, ECG_dB, 'LineWidth', 1); hold on;
plot(f, Y_dB,   'LineWidth', 1);
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
title('Original vs Filtered ECG Spectrum (dB)');
legend('Original','Filtered');
grid on;

% Zoom in around the notch region to highlight the interference removal
notchWidth = 40;  % Hz window around 60 Hz for zoom
xlim1 = [0 200];  % broad low-frequency region
xlim2 = [40 80];  % tight zoom around 60 Hz

subplot(2,1,2);
plot(f, ECG_dB, 'LineWidth', 1); hold on;
plot(f, Y_dB,   'LineWidth', 1);
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
title('Zoom Around 60 Hz Region');
xlim(xlim2);      % focus around the interference frequency
legend('Original','Filtered');
grid on;

% Using a dB (log-magnitude) spectrum makes it easier to see that,
% near 59.4 Hz the filtered spectrum is strongly attenuated relative
% to the original, while at other frequencies the two spectra nearly
% overlap. This indicates that the notch filter suppresses the narrowband
% 59.4 Hz interference while largely preserving the rest of the ECG spectrum.
