function xhat=hw930901XXXX
%[testsignal,datasignal,fs,beta]=data(19930901);
[sourcedatasignal,testsignal, datasignal, fs, beta]=data(19930901);
n=length(datasignal);
t=(0:1/fs:(n-1)/fs)';
Ytest=ftfast(testsignal,t);
%{
%ytest och plot [till rapporten och f0]
subplot(3,3,1:3)
plot(f,Ytest)
title('Ytest(f)')
%}
%{
%hitta f0:
negf = f<0;
Ytest(negf)=0;
[~, fi]=max(Ytest);
%}
tf=fft(testsignal);
fn=3000;
f0=fs/n*fn;
%f0=f(fi);
xtest=sin(2*pi*f0*t);
[Xtest f]=ftfast(xtest,t);
H0=Ytest./Xtest;
Hf0=H0(f==f0);
%A0 och A1 fås ur H(f0) => bestämmer H(f)
A1=(-1)*(imag(Hf0))/sin(2*pi*f0*beta); 
A0=real(Hf0)-A1*cos(2*pi*f0*beta);
Hf=A0+A1*exp(-2*pi*1i*beta.*fliplr(f));
%hitta x(t) => finna X(f)=Y(f)/H(f)
Y=ftfast(datasignal,t);
X=Y./Hf';
x=iftfast(X,f);
%tröskling av x(t) pga bruset e(t)
xh=round(abs(x));
stem(xh)
%{
plot av xh
%storx = xh>3;
%xh(storx)=3;
%plot av x(t) [till rapporten]
subplot(3,3,4:6)
stem(t(1:70),xh(1:70)) 
title('x(t)')
%}
%{
%plot av y trösklad
y=round(abs(datasignal));
story = y>3;
y(story)=3;
%plot av y(t) [till rapporten]
subplot(3,3,7:9)
stem(t(1:70),y(1:70)) 
title('y(t)')
%output signalen (xh)
%}
sum(sourcedatasignal==xh)
size(sourcedatasignal)