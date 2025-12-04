addpath("../")
for suf = 1:9
    fullfilename = "Note0" + num2str(suf) + ".wav"
    [xx, fs] = audioread(fullfilename);
    noteNum = noteDetect(xx, fs, 1);
    disp(noteNum)
end

