addpath("../../");
fs = 48000;

% === 13 musical center frequencies ===
f0_list = 430.66 * 2.^((0:12)/12);

bw = 50;   % example bandwidth in Hz — adjust as needed

figure; hold on;

for k = 1:length(f0_list)
    f0 = f0_list(k);

    [b,a] = biquad_bandpass(fs, f0, bw);

    [H, w] = freqz(b, a, 4096, fs);
    plot(w, 20*log10(abs(H)));
end

title('13 Biquad Bandpass Filters');
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
grid on;

