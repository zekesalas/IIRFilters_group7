
f0 = 430.66; % reference frequency (Hz)


close all

[xx, fs] = audioread('Note02.wav');
figure; plot(xx)

freqs = f0*2.^((0:12)/12);

w = linspace(-pi,pi,length(xx))';
XX = fftshift(fft(xx));
sti = length(xx)/2 + 1;


figure; 

subplot(2,1,1)
stem(freqs/fs,ones(size(freqs))); xticks([freqs/fs .5]); ylim([0 2]); 
% xlim([freqs(1) freqs(end)]/fs)
xlim([0 .5])

subplot(2,1,2)
plot(w(sti:end)/(2*pi),abs(XX(sti:end))); xticks([freqs/fs .5]);
% xlim([freqs(1) freqs(end)]/fs)
