function [maxNote, maxPow] = noteDetect(signal, fs, threshold)

if nargin < 3
    threshold = 0;
end

f0 = 430.66; % reference frequency (Hz)
bw = 20;     % small bandwidth
maxPow = 0;
maxNote = -1;

% Note01 = 0Hz ??? % Note02 = 430.66Hz % Note03 = 990.53Hz

for note = 0:12

    % frequency of this semitone
    freq = f0 * 2^(note/12);

    % bandpass range around that frequency
    fpass = [freq - bw/2, freq + bw/2];

    % apply BPF
    filtered_signal = bandpass(signal, fpass, fs);

    % compute energy
    pow = sum(filtered_signal.^2);

    if pow > maxPow && pow > threshold 
        maxPow = pow;
        maxNote = note;

end

end
