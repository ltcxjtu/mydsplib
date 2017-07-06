%%%LCMV�ڶ����������Լ���²����γ�%%%
clc;clear all;close all;ima=sqrt(-1);esp=0.01;
%%���߲����趨%%
N=16;                               %��Ԫ��
d_lamda=0.5;                  %��Ԫ����벨���ı�ֵ
theta=-90:0.5:90;            %������Χȷ��
theta1=-10;                      %��������1
theta2=0;                          %��������2
theta3=40;                        %��������3
theta_jam=70;                  %���ŷ���
L=512;                              %��������
%%%%%%%%%%%%%%%%%%%%%%%%%

%%�ź��γ�%%
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

%����Ȩʸ������%
x=s+jam;
Rx=1/L*x*x';                          %���ź���ؾ���
R=pinv(Rx);                           %��ؾ�������
a1theta=exp(ima*2*pi*d_lamda*sin(theta1*pi/180)*[0:N-1]');
a2theta=exp(ima*2*pi*d_lamda*sin(theta2*pi/180)*[0:N-1]');
a3theta=exp(ima*2*pi*d_lamda*sin(theta3*pi/180)*[0:N-1]');
C=[a1theta a2theta a3theta];%�������
F=[1 1 1]';
Wopt=R*C*(inv(C'*R*C))*F;
%%%%%%%%%%%%%%%%%%%%%%%%%

%%���Ų����γ�%%
for m=1:length(theta)
    a=exp(ima*2*pi*d_lamda*sin(theta(m)*pi/180)*[0:N-1]');
    y(m)=Wopt'*a;
 
end
%%%%%%%%%%%%%%%%%%%%%%%%%
Y=20*log10(abs(y)/max(abs(y))+esp);

%%��ͼ%%
plot(theta,Y);hold on;grid on;
axis([-90 90 -50 0]);
plot(theta1,-30:0,'.');
plot(theta2,-30:0,'.');
plot(theta3,-30:0,'.');
plot(theta_jam,-30:0,'.');
xlabel('\theta/o');
ylabel('Amplitude in dB');
title('LCMV׼���¶���������γ�');