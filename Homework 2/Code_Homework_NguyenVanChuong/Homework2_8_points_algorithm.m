% Homework 2
% Created by Nguyen Van Chuong, ID: 20161199 
% 8_point algorithm
Corr_1_data=load('fig1.txt');
Corr_2_data=load('fig2.txt');

Corr_1=Corr_1_data(1:7:500,:);
Corr_2=Corr_2_data(1:7:500,:);
[rows columns] = size(Corr_1);

img1=imread('img1.PNG');
img2=imread('img2.PNG');

A(1:rows,1:9)=0;
for i=1:rows
    A(i,1)=Corr_1(i,1)*Corr_2(i,1);
    A(i,2)=Corr_1(i,1)*Corr_2(i,2);
    A(i,3)=Corr_1(i,1);
    A(i,4)=Corr_1(i,2)*Corr_2(i,1);
    A(i,5)=Corr_1(i,2)*Corr_2(i,2);
    A(i,6)=Corr_1(i,2);
    A(i,7)=Corr_2(i,1);
    A(i,8)=Corr_2(i,2);
    A(i,9)=1;
end

[U1,S1,V1]=svd(A);
f=V1(:,9);
F1=[f(1) f(2) f(3); f(4) f(5) f(6); f(7) f(8) f(9)];

[U,S,V]=svd(F1);
I=[1 0 0; 0 1 0; 0 0 0];

F=U*S*V';
F=F./F(3,3);

% Draw epipolar lines and correspondence

Corr_1_data(:,3)=1;
Corr_2_data(:,3)=1;
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
hold off;

% Data points to compute F
figure;
subplot(121);
imshow(img1);
hold on;
for i=1:72
    plot(Corr_1(i,1),Corr_1(i,2),'b-*','MarkerSize',6)
end

subplot(122);
imshow(img2);
hold on
for i=1:72
    plot(Corr_2(i,1),Corr_2(i,2),'b-*','MarkerSize',6)
end

% Data points to check validity
figure;
subplot(121);
imshow(img1);
hold on;
for i=1:11:660
    plot(Corr_1_data(i,1),Corr_1_data(i,2),'r-o','MarkerSize',5)
end

subplot(122);
imshow(img2);
hold on
for i=1:11:660
    plot(Corr_2_data(i,1),Corr_2_data(i,2),'r-o','MarkerSize',5)
end

