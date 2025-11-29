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
% We can relate the angle of the zeros to the frequency response by 
% observing the frequencies at which the magnitude response has nulls. In 
% the pezdemo magnitude plot, we see a null at π/3. This null 
% corresponds directly to the angle of the zeros measured from the positive
%  real axis in the z-plane. The normalized null frequency π/3, when 
% multiplied by the sampling frequency, gives the physical frequency w_0 
% that is attenuated (filtered out) by H(z).

% 1.6.2 6-point running-sum FIR digital filter
% H(z) = (1-z^-6)/(1-z^-1)
% a)
roots([1,0,0,0,0, 0,-1])
roots([1,1,0,0,0, 0,0])
% b) insert 1.6.2.b here

%  Based on our pole zero plot, we can see that impulse response is a 
% step function. Our frequency response has a main lobe at f = 0 and smaller side
% lobes past it. This is characteristic of a low pass filter. 
%
% c) [pi/3, 2pi/3, pi, -2pi/3,-1pi/3]
% 
% d) delta[n]-delta[n-6] is the impulse response of this comb filter.
% 
% e) This filter is called a comb filter because it equally spaced null 
% frequencies and equally spaced passed frequencies. [0, pi/3, 2pi/3, pi,
% -pi/3, -2pi/3]
% 
% f) H(z) = 1-2z^-1+2z^-2-2z^-3+2z^-4-2z^-5+1z^-6. 
% 
% g) H(z) from part f is a high-pass filter. 

% 1.7 
% a) h(n) has finite length M=3, stable, causal. Non linear phase response.
% passband like magnitude response. passband = [.2527pi rad, .899pi rad]
% stopband [-0.2552pi, 0.2552pi] 

% b) 
% Moving from the origin to z = -1/2 increases the bandwidth of the filter
% then moving from z = -1/2 to -1 increases the filter gain, with a sharp
% peak at high frequencies. For h(n), between 0 and -1/2 there is stonger 
% damping. Between -1/2 and -1 there is more oscilitary behaviour. 

% c)
% Moving the pole outside the unit circle causes h(n) to increase
% exponentially. This is characteristic of unstable system behavior. 

% (d)
% in general, to ensure stability, poles should be placed inside the unit
% circle. 

% 1.7.1
% H(z) = (1 - z^-1)/(1 + 0.9 z^-1) has a zero at z = 1 and a pole at z = -0.9.
% The zero at z = 1 forces a null at DC while the pole near z = -1 boosts high 
% frequencies, so the filter is high-pass. Moving the pole from -0.9 toward 
% +0.9 reduces the high-frequency peak and flattens the mid/high band, but 
% the response remains high-pass since the DC null is unchanged.

%1.8
% zeros at z = 1 and z = -1 on the unit circle. The poles are at 
% z = 0.8*exp(±j*2*pi/3) ≈ -0.4 ± j*0.6928, near the unit circle at angle ±2π/3.
% Zeros at DC and Nyquist force nulls at ω=0 and ω=π while the nearby pole 
% pair creates a peak near ω≈±2π/3, so the filter is bandpass.



%1.9 
% The new transfer function is H(z) = (1 + z^-1 + z^-2)/(1 + 0.8z^-1 +
% .64z^-2). The frequency response changes from a all-pass filter to a
% band-stop filter. 


