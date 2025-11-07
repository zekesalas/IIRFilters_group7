%% IIR Filters: Mini-Project 05: Note Detection

% determine f0 with specgram() function MATLAB

% Code used to fetch Fs
[y, Fs] = audioread('Note07.wav');
if size(y, 2) > 1
    y = mean(y, 2);
end
[S, F, T] = specgram(y, [], Fs); 
P = abs(S).^2; 
mean_power_per_frequency = mean(P, 2);
[~, idx] = max(mean_power_per_frequency);
dominant_frequency = F(idx);
fprintf('Dominant frequency (using specgram output): %.2f Hz\n', dominant_frequency);

% Note01 = 0Hz
% Note02 = 430.66Hz
% Note03 = 990.53Hz


%{
function maxNote = toneDetect(xx, fs, DEBUG)
%
%
%
%
%

%
%

if (nargin < 3)
    DEBUG = 0;
end

% f0 = our value of f0
all = xx'
max = 0;
maxNote = -1;

for note = 0:12
        freq = f0 * 2.^(note/12)

        %what = % insert code to compute omega (what) based on freq and sampling rate

        %aa % insert code to make a bandpass filter with center at omega
        %(what)

        bb = 1;
        
        % pow = % Insert code to find the total power in the signal yy

        if pow > max % is this the loudest note?
            max = power; % yes it is, remember it
        end
        all = [all yy']; % save output for debugging
end 

if(DEBUG) % if debugging is on, play outputs of all the filters
    sounds(all, fs)
end

% test code with the following
% [xx, fs] = wavread('note1')
% noteNum = toneDetect(xx, fs);

%}