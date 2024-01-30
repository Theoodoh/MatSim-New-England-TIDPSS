%% This m-file initiats MatSim1.0
clc
clear all
close all

%% Define Variables
global_var

%% Execute Power Flow Using MatPower4.1
addpath('F:\MatSim project\Matpower4.1')
m=10;
n=39;

%% Execute Power Flow Using MatPower4.1
pf = runpf(case39_1);
Vm=pf.bus(:,8);
Va=pf.bus(:,9);
Vb=Vm.*exp(1j*(Va*pi/180));

sys_data = case39_1;

baseMVA=sys_data.baseMVA;
bus=sys_data.bus;
branch1=sys_data.branch;
BRX=branch1(:,1:5);
[Ybus, Yf, Yt] = makeYbus(baseMVA, bus, branch1);
YB=full(Ybus);
clear Ybus Yf Yt

v=Vb;

Pg=pf.gen(:,2)/baseMVA;
Qg=pf.gen(:,3)/baseMVA;
Pd=sys_data.bus(:,3)/baseMVA;
Qd=sys_data.bus(:,4)/baseMVA;
Ybus=YB;

%% Enter Dynamic parameters for the Generators
m=10;
n=39;
%         H      Xd     Xpd    Xq    Xpq    Tpd0   Tpq0
GenData = [
    30.3  0.2950 0.0647 0.2820 0.0647 6.560  1.500
    500.0 0.0200 0.0060 0.0190 0.0060 6.000  0.700
    35.8  0.2495 0.0531 0.2370 0.0531 5.700  1.500
    26.0  0.3300 0.0660 0.3100 0.0660 5.400  0.440
    28.6  0.2620 0.0436 0.2580 0.0436 5.690  1.500
    34.8  0.2540 0.0500 0.2410 0.0500 7.300  0.400
    26.4  0.2950 0.0490 0.2920 0.0490 5.660  1.500
    24.3  0.2900 0.0570 0.2800 0.0570 6.700  0.410
    34.5  0.2106 0.0570 0.2050 0.0570 4.790  1.960
    42.0  0.2000 0.0040 0.1900 0.0040 5.700  1.0
    ];

%        KA   TA   KE  TE   KF   TF
ExData=[ 25  0.025  1   0   0    0.5
         25  0.025  1   0   0    0.5
         25  0.025  1   0   0    0.5
         25  0.025  1   0   0    0.5
         25  0.025  1   0   0    0.5         
         25  0.025  1   0   0    0.5
         25  0.025  1   0   0    0.5       
         25  0.025  1   0   0    0.5
         25  0.025  1   0   0    0.5    
         25  0.025  1   0   0    0.5];

%%
H=GenData(:,1);
Xd=GenData(:,2);
Xpd=GenData(:,3);
Xq=GenData(:,4);
Xpq=GenData(:,5);
Tpd0=GenData(:,6);
Tpq0=GenData(:,7);
ws=377;
M=2*H/ws;
D(1,1)=0.1*M(1);
D(2,1)=0.2*M(2);
D(3,1)=0.3*M(3);
D(4,1)=0.4*M(4);
D(5,1)=0.5*M(5);
D(6,1)=0.6*M(6);
D(7,1)=0.7*M(7);
D(8,1)=0.8*M(8);
D(9,1)=0.9*M(9);
D(10,1)=M(10);
D=0*D;
KA=ExData(:,1);
TA=ExData(:,2);
KE=ExData(:,3);
TE=ExData(:,4);
KF=ExData(:,5);
TF=ExData(:,6);
Rs=[0 0 0 0 0 0 0 0 0 0];

YN=Ybus;

%% apply fault on the system
% fault=1 ; the system with fault
% fault=0 ; the system without fault

fault=1;

%% Select fault Type
% ftype=1; small change in references
% ftype=2; symetrical three phase faults
% ftype=3; load changes

ftype=2;


fPd=Pd;
fQd=Qd;

if ftype == 3
    fPd(5,1)=Pd(5,1)/2;
    fQd(5,1)=Qd(5,1)/2;
end
event=[0 1 1.10 10;
       0 1  0   0];
small_d=[
    0  1 1.1 10
    1  1.00 1 1;];
fYN = YN;
for i=1:n
    YL(i,i) = (Pd(i)-sqrt(-1)*Qd(i))/abs(v(i))^2;
    fYL(i,i) = (fPd(i)-sqrt(-1)*fQd(i))/abs(v(i))^2;
    
    YN(i,i) = YB(i,i)+YL(i,i);
    fYN(i,i) = YB(i,i)+fYL(i,i);
end
YGG = YN(1:m,1:m);
YGL = YN(1:m,m+1:n);
YLG = YN(m+1:n,1:m);
YLL = YN(m+1:n,m+1:n);

Yred = YGG-YGL*inv(YLL)*YLG;
Zred = inv(Yred);
iYLL = inv(YLL);
if fault 
    if ftype == 1   % small change in references
        fYred=Yred;
        fZred = inv(fYred);
        small_d=[
            0  1 1.1 10
            1  1.05 1 1;];
    end
    if ftype == 2 % symetrical three phase faults
        fYred=YN(1:m,1:m)-YN(1:m,m+1:n-1)*inv(YN(m+1:n-1,m+1:n-1))*YN(m+1:n-1,1:m);
        fZred = inv(fYred);
    end
    if ftype == 3 % load changes
        fYGG = fYN(1:m,1:m);
        fYGL = fYN(1:m,m+1:n);
        fYLG = fYN(m+1:n,1:m);
        fYLL = fYN(m+1:n,m+1:n);
        
        fYred = fYGG-fYGL*inv(fYLL)*fYLG;
        fZred = inv(fYred);
        ifYLL = inv(fYLL);
    end
    if ftype == 4 % line outage
        
    end
end

YLV=-inv(YN(m+1:n,m+1:n))*YN(m+1:n,1:m);
%Initial Condition Calculation----------------------------------------
V0=abs(v);
Teta0=angle(v);

for i=1:10
    IG0(i)=(Pg(i)-sqrt(-1)*Qg(i))/conj(v(i));
    delta0(i)=angle(v(i)+(Rs(i)+sqrt(-1)*Xq(i))*IG0(i));
    
    Id0(i)=real(abs(IG0(i))*exp(sqrt(-1)*(pi/2+angle(IG0(i))-delta0(i))));
    Iq0(i)=imag(abs(IG0(i))*exp(sqrt(-1)*(pi/2+angle(IG0(i))-delta0(i))));
    Vd0(i)=real(V0(i)*exp(sqrt(-1)*(pi/2+Teta0(i)-delta0(i))));
    Vq0(i)=imag(V0(i)*exp(sqrt(-1)*(pi/2+Teta0(i)-delta0(i))));
    
    Epq0(i)=Vq0(i)+Rs(i)*Iq0(i)+Xpd(i)*Id0(i);
    Epd0(i)=(Xq(i)-Xpq(i))*Iq0(i);
    Efd0(i)=Epq0(i)+(Xd(i)-Xpd(i))*Id0(i);
    TM(i)=Epq0(i)*Iq0(i)+(Xq(i)-Xpd(i))*Id0(i)*Iq0(i);
    VR0(i)=(KE(i)+0.0039*exp(1.555*Efd0(i)))*Efd0(i);
    Rf0(i)=KF(i)*Efd0(i)/TF(i);
    Vref(i)=V0(i)+VR0(i)/KA(i);
    Vref1(i)=V0(i)+Efd0(i)/KA(i);
end
%%   ALgebraic equation

Rsm=diag(Rs);
Xpqm=diag(Xpq);
Xpdm=diag(Xpd);

XXpdq=[Xpq-Xpd];
XXdpd=[Xd-Xpd];
XXqpq=[Xq-Xpq];

Zdq=[Rsm -Xpqm;Xpdm Rsm];
iZdq=inv(Zdq);

MT = sum(M);
