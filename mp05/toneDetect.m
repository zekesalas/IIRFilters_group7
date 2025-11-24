addpath("../")
[xx, fs] = audioread('Note03.wav');
noteNum = noteDetect(xx, fs, 1);
disp(noteNum)


