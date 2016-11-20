% [y,t]=iftfast(Y,f)
%
%	Calculates the inverse of the 
%       approximated continuous
%       fourier transform (see ftfast) 
%       for the Fouriertransform Y. f is 
%	the corresponding frequency vector which
%	has to be equally spaced.
%      ( utilizes the  function ifft.m )

function [y,t]=iftfast(Y,f)
f=f(:);Y=Y(:);
fs=(f(2)-f(1))*length(f);
fneg_index=find(f<0);
fpos_index=find(f>=0);
f=[f(fpos_index);f(fneg_index)+1];
Y=[Y(fpos_index);Y(fneg_index)];
  
  
y=fs*ifft(Y);
t=0:1/fs:1/fs*(length(y)-1);