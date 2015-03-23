clear all
N=4;
I = eye(N);
[D,y]=cheb(N);
D2=D^2;
Dx2 = kron(I,kron(I,D2));
Dy2 = kron(I,kron(D2,I));
Dz2 = kron(D2,kron(I,I));

L = Dx2+Dy2+Dz2;