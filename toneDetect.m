[xx, fs] = audioread('Note01.wav');
noteNum = noteDetect(xx, fs, 1);
disp(noteNum)


