% Written by Nguyen Van Chuong, ID 20161199

N=8;
X(1:N)=0;Y(1:N)=0;Z(1:N)=0;
X(1)=36; X(2)=12; X(3)=0;X(5)=24;X(6)=36; X(7)=48;
Y(4)=48;Y(5)=36;Y(6)=12; Y(3)=0;Y(8)=48;
Z(1)=36; Z(2)=36; Z(4)=48;Z(3)=0;Z(8)=24;

u=[545 703 760 1136 853 621 469 1101];
v=[405 321 531 370 772 717 715 555];
A(1:2*N,1:11)=0;
% creat matrix A based on 8 points in world coordinates and image
% coordinates
i=1;
% Construct matrix A
for k=1:2:2*N
        A(k,1)=X(i);A(k,2)=Y(i);A(k,3)=Z(i);A(k,4)=1;
        A(k,9)=-u(i)*X(i);
        A(k,10)=-u(i)*Y(i); A(k,11)=-u(i)*Z(i);
        
        A(k+1,5)=X(i);A(k+1,6)=Y(i);A(k+1,7)=Z(i);
        A(k+1,8)=1;A(k+1,9)=-v(i)*X(i);
        A(k+1,10)=-v(i)*Y(i);A(k+1,11)=-v(i)*Z(i);
i=i+1;
end

D=[u(1) v(1) u(2) v(2) u(3) v(3) u(4) v(4) u(5) v(5) u(6) v(6) u(7) v(7) u(8) v(8)];

p=inv(A'*A)*A'*D';
P(1:3,1:4)=0;
P=[p(1) p(2) p(3) p(4)
   p(5) p(6) p(7) p(8)
   p(9) p(10) p(11) 1];

[U,S,V]=svd(P);
%C is the unit singular vector of $\mathbf{P}$ corresponding to the smallest singular value, 
% or the last column of V
C = V(1:4, 4);
C=C/C(4);
C_tidle=[C(1) C(2) C(3)];
C_tidle=C_tidle';

M=P(1:3,1:3);
[Q_de, R_de] = qr (M (3:-1:1, 3:-1:1)', 0) ;
K = R_de (end:-1:1, end:-1:1)' ;
R = Q_de (end:-1:1, end:-1:1)' ;
t=-R*C_tidle;




