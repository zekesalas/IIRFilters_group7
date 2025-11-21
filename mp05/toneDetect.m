[xx, fs] = audioread('Note02.wav');
noteNum = noteDetect(xx, fs, 1);
disp(noteNum)


