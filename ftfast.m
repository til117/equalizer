% [Y,f]=ftfast(y,t)   
%
%	Calculates the approximated continuous
%       fourier transform for signal y.
%	t is the time vector corresponding to y and should
%	be equally spaced.
%       ( utilizes the  function fft.m )
%		
function [Y,f]=ftfast(y,t)

T=t(2)-t(1);
Y=T*fft(y);
ny=length(y);
f=[(0:ny-1)./ny];
Y=fftshift(Y);
f=fftshift(f);
f_index=find(f>=0.5);
f(f_index)=f(f_index)-1;
f=1/T*f;