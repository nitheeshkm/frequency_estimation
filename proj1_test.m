fs = 10e3;
f1 = 1e3;
f2 = f1 + 200;
N=32;
a=20/20;
A=10^a;
n = 0:N-1 ;
x1 = A*exp(1i*2*pi*f1/fs*n);
x2 = A*exp(1i*2*pi*f2/fs*n);
noise = (randn(1,N) + 1i*randn(1,N))*sqrt(0.5);
x = x1  + x2 + noise;

freq = man_ras_sha(x,f1,2);

freq