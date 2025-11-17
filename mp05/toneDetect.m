debug clear;
[xx, fs] = audioread('Note03.wav');
noteNum = toneDetectFunction(xx, fs, 1);
disp(noteNum)

function maxNote = toneDetectFunction(signal, fs, DEBUG)

if nargin < 3
    DEBUG = 0;
end

f0 = 430.66; % reference frequency (Hz)
bw = 20;     % small bandwidth
maxPow = -Inf;
maxNote = -1;

% Note01 = 0Hz ??? % Note02 = 430.66Hz % Note03 = 990.53Hz

if DEBUG
    filtered_outputs = [];
end

for note = 0:12

    % frequency of this semitone
    freq = f0 * 2^(note/12);

    % bandpass range around that frequency
    fpass = [freq - bw/2, freq + bw/2];

    % apply BPF
    filtered_signal = bandpass(signal, fpass, fs);

    % compute energy
    pow = sum(filtered_signal.^2);

    if pow > maxPow
        maxPow = pow;
        maxNote = note;
    end

    if DEBUG
        filtered_outputs(:,note+1) = filtered_signal;
    end
end

% optional: listen to all bands
if DEBUG
    %soundsc(filtered_outputs, fs)
end

end

