% Homework 2
% Created by Nguyen Van Chuong, ID: 20161199
% Normalized_8 point algorithm

Corr_1_data=load('fig1.txt');
Corr_2_data=load('fig2.txt');

Corr_1=Corr_1_data(1:7:500,:);
Corr_2=Corr_2_data(1:7:500,:);
[rows columns] = size(Corr_1);


mu_u=ones(rows,1)'*Corr_1(:,1)*ones(rows,1)/rows;
mu_v=ones(rows,1)'*Corr_1(:,2)*ones(72,1)/rows;
mu_uprime=ones(rows,1)'*Corr_2(:,1)/rows*ones(rows,1);
mu_vprime=ones(rows,1)'*Corr_2(:,2)/rows*ones(rows,1);

sigma_u=sqrt((Corr_1(:,1)-mu_u)'*(Corr_1(:,1)-mu_u)/rows);
sigma_v=sqrt((Corr_1(:,2)-mu_v)'*(Corr_1(:,2)-mu_v)/rows);
sigma_uprime=sqrt((Corr_2(:,1)-mu_uprime)'*(Corr_2(:,1)-mu_uprime)/rows);
sigma_vprime=sqrt((Corr_2(:,2)-mu_vprime)'*(Corr_2(:,2)-mu_vprime)/rows);

% Normalized data point

Q_Corr_1=[(Corr_1(:,1)-mu_u)/sigma_u  (Corr_1(:,2)-mu_v)/sigma_v];
Q_Corr_2=[(Corr_2(:,1)-mu_uprime)/sigma_uprime  (Corr_2(:,2)-mu_vprime)/sigma_vprime];

% Matrix Transform
T=[1/sigma_u(1) 0 -mu_u(1)/sigma_u(1);
    0 1/sigma_v(1) -mu_v(1)/sigma_v(1);
    0 0 1];

T_prime=[1/sigma_uprime(1) 0 -mu_uprime(1)/sigma_uprime(1);
    0 1/sigma_vprime(1) -mu_vprime(1)/sigma_vprime(1);
    0 0 1];

A(1:rows,1:9)=0;
for i=1:rows
    A(i,1)=Q_Corr_1(i,1)*Q_Corr_2(i,1);
    A(i,2)=Q_Corr_1(i,1)*Q_Corr_2(i,2);
    A(i,3)=Q_Corr_1(i,1);
    A(i,4)=Q_Corr_1(i,2)*Q_Corr_2(i,1);
    A(i,5)=Q_Corr_1(i,2)*Q_Corr_2(i,2);
    A(i,6)=Q_Corr_1(i,2);
    A(i,7)=Q_Corr_2(i,1);
    A(i,8)=Q_Corr_2(i,2);
    A(i,9)=1;
end

[U1,S1,V1]=svd(A);
f=V1(1:9,9);
F1=[f(1) f(2) f(3); f(4) f(5) f(6); f(7) f(8) f(9)];
I=[1 0 0; 0 1 0; 0 0 0];
[U,S,V]=svd(F1);
S=S*I;
F=U*S*transpose(V);
F=T'*F*T_prime;


Corr_1_data(:,3)=1;
Corr_2_data(:,3)=1;

% Draw epipolar lines and correspondence
figure;
subplot(121);
imshow(img1);
hold on;
    
for i=1:11:660
    e_line=F*Corr_2_data(i,:)';
    e_line=e_line/e_line(3);
    x=[1 size(img1,2)];
    y=-(e_line(1)/e_line(2))*x-(1/e_line(2))*[1 1];
    plot(Corr_1_data(i,1),Corr_1_data(i,2),'r-o','MarkerSize',5)
    plot(x,y)
end

subplot (122)
imshow(img2);
hold on;
for i=1:11:660
    e_line=F'*Corr_1_data(i,:)';
    e_line=e_line/e_line(3);
    a=-e_line(1)/e_line(2);b=-1/e_line(2);
    x=[1 size(img2,2)];
    y=a*x+b*[1 1];
    plot(Corr_2_data(i,1),Corr_2_data(i,2),'r-o','MarkerSize',5)
    plot(x,y)
end



