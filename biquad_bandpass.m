%%%% 
%%%% FILTER COEFFICIENTS FOR BANDPASS FILTER
%%%% USING BILINEAR TRANSFORM 
%%%% BOB BONDE 
%%%%

%% biquad_bandpass 
% @Params: fs, f0, bw 
% fs = sampling frequency in Hz (from sound function in Matlab or ALSA in Linux)
% f0 = desired frequency in Hz
% bw = desired bandwidth in Hz (will be converted to octaves)
% @Returns: b, a filter coefficients for filter of form 
% b0 + b1 z^-1 + b2 z^-2
% --------------------
% 1 + a1 z^-1 + a2 z^ -2
% that will be normalized such that the gain at f0 |G(e^jw_0)| is 1 or 0dB. 

function [b,a] = biquad_bandpass(fs, f0, bw)
    w0 = 2*pi*f0/fs;
    bw_octaves = log2((f0+(bw/2))/(f0-(bw/2))); % Convert bandwidth to octaves
    alpha = sin(w0)*sinh((log(2)/2) * bw_octaves * w0 / sin(w0));
    b0 =  sin(w0)/2;
    b1 =  0;
    b2 = -sin(w0)/2;
    a0 = 1 + alpha;
    a1 = -2*cos(w0);
    a2 = 1 - alpha;

    b = [b0 b1 b2] / a0;
    a = [1   a1/a0 a2/a0];

    W = exp(-1j * w0);
    H0 = (b(1) + b(2)*W + b(3)*W^2) / (a(1) + a(2)*W + a(3)*W^2);
    
    % scale numerator so magnitude at w0 is 1 (0 dB)
    scale = 1 / abs(H0);
    b = b * scale;
end
