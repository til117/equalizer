%function [testsignal,datasignal,fs,beta]=data(dateofbirth)

function [sourcedatasignal,testsignal,datasignal,fs,beta]=data(dateofbirth)

% This function generates data for the 
% equalization problem
%
% [testsignal,datasignal,fs,beta]=data(dateofbirth)
%
% where 
%
%	testdata is the sinusoidal identification data to be used
%                to identify the channel and the frequency
%	data     is the received data to be equalized
%	fs       is the sampling frequency in [Hz]
%	beta	 is the time delay [s]

sigma=0.1;	% Noise std

% Data
[sourcetestsignal,sourcedatasignal,fs,A,alpha,f0]=sourcedata(dateofbirth);

% Channel data
kd=6;	% # of samples in time delay
beta=kd/fs;	% Time delay

N=length(sourcedatasignal);

% Received identifcation data
randn('seed',dateofbirth*317)
t=(0:1/fs:(N-1)/fs)';
testsignal=A*(sin(2*pi*f0*t)+alpha*sin(2*pi*f0*(t-beta)))+1.4*randn(N,1);

% Received datasignal
randn('seed',dateofbirth*955)
datasignal=A*(sourcedatasignal+alpha*[zeros(kd,1);sourcedatasignal(1:end-kd)])+sigma*randn(N,1);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [sourcetestsignal,sourcedatasignal,fs,A,alpha,f0]=sourcedata(dateofbirth)

% This function generates the transmitted data for the 
% equalization homework problem
%
% [sourcetestsignal,sourcedatasignal,fs,A,alpha,f0]=sourcedata(dateofbirth)
%
% where 
%
%	sourcetestsignal  is the sinusoid transmitted for identification
%	sourcedatasignal  is the transmitted signal 
%	f0		  				frequency of sinusoid in sourcetestsignal
%	fs       	  		is the sampling frequency
%	A		  				is the amplitude
%	alpha		  			is the amplitude of the echo

fs=11025;

% Channel data
kd=6;	        			% # of samples in time delay
beta=kd/fs;				% Time delay
alpha=(dateofbirth/10)-floor(dateofbirth/10); 
alpha=0.3+0.5*alpha; if alpha==0, alpha=0.8; end
A=floor(((dateofbirth/100)-floor(dateofbirth/100))*10)/10+0.7;


N=32768;
t=(0:1/fs:(N-1)/fs)';

P=3000;					% Number of periods

f0=fs/N*P;

% Frequency function at f0
H=A*(1+alpha*exp(-i*2*pi*f0*beta));

% Identification signal
sourcetestsignal=sin(2*pi*f0*t);


rand('seed',dateofbirth*779)
sourcedatasignal=rand(N,1);

sourcedatasignal=3*(sourcedatasignal>0.75)+...
             2*((sourcedatasignal<=0.75) & (sourcedatasignal>0.5))+...
             1*((sourcedatasignal<=0.5) & (sourcedatasignal>0.25));

