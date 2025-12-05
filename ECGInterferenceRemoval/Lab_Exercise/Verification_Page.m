
%2.1 
%H(Z) = 8.1 * ((1 - 1.1112z^-1 + 1.2345z^-2)/(1 - 0.9z^-1 + .81z^-2))



%2.4a
[ecgsig, fs, fint] = ECGmake('gburdell7');
disp(fs)
disp(fint)

%2.4(b,c)
% choose r = 0.95 (typical choice)
% For F0 = 59.4 Hz and Fs = 750 Hz, w0 = 2*pi*(59.4/750) = 0.1584*pi rad/sample ≈ pi/6.31 rad/sample

% poles: ( +0.8345 , +-0.4540 )
% zeroes: ( +0.8784 , +-0.4779 )

% Design of 2nd-order IIR notch: the interference frequency F0 and sampling
% rate Fs determine the digital notch frequency w0 = 2*pi*F0/Fs (rad/sample).
% Complex-conjugate zeros are placed on the unit circle at z = e^{±j*w0} to
% force a notch at F0, and complex-conjugate poles are placed at z = r*e^{±j*w0}
% with 0 < r < 1 to control the notch bandwidth while keeping the filter stable.

% see 2.4(b_c).png
% also see IIRnotchPEZ.png

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

N = length(ECGFFT);       

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

window   = 1024;
noverlap = 512;
nfft     = 1024;

figure;
subplot(2,1,1);
spectrogram(ecgsig, window, noverlap, nfft, fs, 'yaxis');
title('Spectrogram of Original ECG + Interference');

subplot(2,1,2);
spectrogram(y, window, noverlap, nfft, fs, 'yaxis');
title('Spectrogram of Filtered ECG');

%In these spectrograms, you can see that the 60Hz noize gets removed and
%you can better see the ECG signals.There is a clear bright yellow band at
%60Hz in the first image, which dissapears in the second one. 