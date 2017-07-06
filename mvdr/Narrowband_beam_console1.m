%%%LCMV在多个来波方向约束下波束形成%%%
clc;clear all;close all;ima=sqrt(-1);esp=0.01;
%%天线参数设定%%
N=16;                               %阵元数
d_lamda=0.5;                  %阵元间距与波长的比值
theta=-90:0.5:90;            %搜索范围确定
theta1=-10;                      %来波方向1
theta2=0;                          %来波方向2
theta3=40;                        %来波方向3
theta_jam=70;                  %干扰方向
L=512;                              %采样点数
%%%%%%%%%%%%%%%%%%%%%%%%%

%%信号形成%%
for k=1:L
    a1=10*randn(1);
    a2=10*randn(1);
    a3=10*randn(1);
    ajam=10*randn(1);
    an=1;
    s(:,k)=a1*exp(ima*2*pi*d_lamda*sin(theta1*pi/180)*[0:N-1]')+...
            +a2*exp(ima*2*pi*d_lamda*sin(theta2*pi/180)*[0:N-1]')+...
            +a3*exp(ima*2*pi*d_lamda*sin(theta3*pi/180)*[0:N-1]');
    jam(:,k)=ajam*exp(ima*2*pi*d_lamda*sin(theta_jam*pi/180)*[0:N-1]');
    n(:,k)=an*(randn(N,1)+ima*randn(N,1));
end
%%%%%%%%%%%%%%%%%%%%%%%%%

%最优权矢量产生%
x=s+jam;
Rx=1/L*x*x';                          %求信号相关矩阵
R=pinv(Rx);                           %相关矩阵求逆
a1theta=exp(ima*2*pi*d_lamda*sin(theta1*pi/180)*[0:N-1]');
a2theta=exp(ima*2*pi*d_lamda*sin(theta2*pi/180)*[0:N-1]');
a3theta=exp(ima*2*pi*d_lamda*sin(theta3*pi/180)*[0:N-1]');
C=[a1theta a2theta a3theta];%方向矩阵
F=[1 1 1]';
Wopt=R*C*(inv(C'*R*C))*F;
%%%%%%%%%%%%%%%%%%%%%%%%%

%%最优波束形成%%
for m=1:length(theta)
    a=exp(ima*2*pi*d_lamda*sin(theta(m)*pi/180)*[0:N-1]');
    y(m)=Wopt'*a;
 
end
%%%%%%%%%%%%%%%%%%%%%%%%%
Y=20*log10(abs(y)/max(abs(y))+esp);

%%作图%%
plot(theta,Y);hold on;grid on;
axis([-90 90 -50 0]);
plot(theta1,-30:0,'.');
plot(theta2,-30:0,'.');
plot(theta3,-30:0,'.');
plot(theta_jam,-30:0,'.');
xlabel('\theta/o');
ylabel('Amplitude in dB');
title('LCMV准则下多个方向波束形成');