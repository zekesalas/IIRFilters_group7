addpath("..\mp05") %imports noteDetect from mp05, needs to be "../mp05" o
% on Mac/Linux 
[songVector, fs] = audioread("AuntRhody.wav");

blockSize = ceil(0.100 * fs);  % number of samples per 100 ms block
N = length(songVector);

% how many samples needed to complete the final block?
padAmount = mod(-N, blockSize);   % same as: blockSize - mod(N, blockSize)

% pad zeros at end
songVectorPadded = [songVector; zeros(padAmount, 1)];

% now reshape safely
songBlock = reshape(songVectorPadded, blockSize, []);
threshold = 0;

notesPlayed = zeros(1,size(songBlock,1));
for ii = 1:size(songBlock, 2)
    [noteNum, maxPow] = noteDetect(songBlock(:,ii), fs, threshold);
    %fprintf('%d is note %d, max=%d\n', ii, noteNum, maxPow);
    notesPlayed(ii) = noteNum;
end
disp(notesPlayed)



