% y ~ N(-1,4)
mu = -1;
sig = sqrt(4);
[xi, w] = GaussHermite(5);
expec = 0;
stdev = 0;
vari  = 0;
skew = 0;
kurt = 0;
for i_q = 1:length(xi)
    x = sqrt(2)*sig*xi(i_q) + mu;
    expec = expec + w(i_q) * x;
    vari = vari + w(i_q) * (x-mu)^2;
    skew = skew + w(i_q) * ((x-mu)/sig)^3;
    kurt = kurt + w(i_q) * ((x-mu)/sig)^4;
end
expec = expec/sqrt(pi)
vari = vari/sqrt(pi)
skew = skew/sqrt(pi)
kurt = kurt/sqrt(pi)
