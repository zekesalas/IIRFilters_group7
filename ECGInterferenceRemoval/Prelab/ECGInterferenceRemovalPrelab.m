% ECG Interference Removal Prelab

% 1.5 

% 1.5.1 
%complete after lab


% 1.6.1
% H(z) = 1 - z^-1 + z^-2
% H(z) = (z^2 - z + 1)/z^2
    % zeros: 1/2 +/- isqrt(3)/2, 
    % poles: 0, M=2 
% 1.6.1.mat pole/zero plot here
% we can correlate the angle of our zeros to the frequency response by
% observing the frequency at which our nulls our. From the magnitude
% response plot of pezdemo, we can see there are nulls at pi/3. This 
% corresponds to the angle of our zeros from the positive real axis. pi/3
% (our null normalized frequency) multiplied by our sampling frequency is 
% equivalent to some frequency w_0 that can be filtered out by H(z). 
% 


% 1.6.2 6-point running-sum FIR digital filter
% H(z) = (1-z^-6)/(1-z^-1)
% a)
roots([1,0,0,0,0, 0,-1])
roots([1,1,0,0,0, 0,0])
% b) insert 1.6.2.b here

%  Based on our pole zero plot, we can see that impulse response is all
%  ones. Our frequency response has a main lobe at f = 0 and smaller side
% lobes past it. This is chracteristic of a low pass filter. 
%
%
%





