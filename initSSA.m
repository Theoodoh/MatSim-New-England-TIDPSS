%% this m-file perfrmes small-signal analysis
initDyn
      
  
x = [26.8786      13.1175      22.6213      13.2129      21.9767       15.433      17.6992      20.5856      26.3528    0.0311597    0.0166022     0.227527      0.18776     0.016675   0.00913479     0.340124     0.106208     0.027962   0.00894737      0.28123     0.189134    0.0220203   0.00576467     0.358199     0.554659    0.0262386   0.00986242     0.472132     0.347141    0.0236124     0.020641     0.081414     0.463935     0.028471    0.0105258     0.381812     0.496658    0.0121361    0.0121205     0.366675     0.466404    0.0239354   0.00712085     0.426921    0.0704638     0.386904      3.94243      4.04644      3.04701      4.12345      4.03988      2.84925       4.6408      5.71078      1.26788      3.79476      7.99687      2.56161      3.03267      3.98886       5.0773      2.60179       5.2383      8.90591     0.819055      7.87675      3.11659      5.74902      5.18242     0.888822     0.827145       1.9705      8.72756       25.461      6.26915      13.6617      12.4536      13.1276      4.69929       10.844      11.3051];


Tw = 10;
KG1 = x(1);
T11 = x(10);
T12 = x(11);
T13 = x(12);
T14 = x(13);
T1 = x(46);
I1 = x(47);
D1 = x(48);
N1 = x(73);
Kpss1 = KG1*T11*T13/(T12*T14);

KG3 = x(2);
T31 = x(14);
T32 = x(15);
T33 = x(16);
T34 = x(17);
T3 = x(49);
I3 = x(50);
D3 = x(51);
N3 = x(74);
Kpss3 =  KG3*T31*T33/(T32*T34);

KG4 = x(3);
T41 = x(18);
T42 = x(19);
T43 = x(20);
T44 = x(21);
T4 = x(52);
I4 = x(53);
D4 = x(54);
N4 = x(75);
Kpss4 =  KG4*T41*T43/(T42*T44);

KG5 = x(4);
T51 = x(22);
T52 = x(23);
T53 = x(24);
T54 = x(25);
T5 = x(55);
I5 = x(56);
D5 = x(57);
N5 = x(76);
Kpss5 =  KG5*T51*T53/(T52*T54);

KG6 = x(5);
T61 = x(26);
T62 = x(27);
T63 = x(28);
T64 = x(29);
T6 = x(58);
I6 = x(59);
D6 = x(60);
N6 = x(77);
Kpss6 =  KG6*T61*T63/(T62*T64);

KG7 = x(6);
T71 = x(30);
T72 = x(31);
T73 = x(32);
T74 = x(33);
T7 = x(61);
I7 = x(62);
D7 = x(63);
N7 = x(78);
Kpss7 =  KG7*T71*T73/(T72*T74);

KG8 = x(7);
T81 = x(34);
T82 = x(35);
T83 = x(36);
T84 = x(37);
T8 = x(64);
I8 = x(65);
D8 = x(66);
N8 = x(79);
Kpss8 =  KG8*T81*T83/(T82*T84);

KG9 = x(8);
T91 = x(38);
T92 = x(39);
T93 = x(40);
T94 = x(41);
T9 = x(67);
I9 = x(68);
D9 = x(69);
N9 = x(80);
Kpss9 =  KG9*T91*T93/(T92*T94);

KG10 = x(9);
T101 = x(42);
T102 = x(43);
T103 = x(44);
T104 = x(45);
T10 = x(70);
I10= x(71);
D10= x(72);
N10 = x(81);
Kpss10 =  KG10*T101*T103/(T102*T104);

%% Linearize Power System
% f11=linmod('sys10m');
f11=linmod('sys10m_pss');

% dx/dt = A.x + B.u
% y = C.x + D.u

Asys = f11.a ;
Bsys = f11.b ;
Csys = f11.c ;
Dsys = f11.d ;

%% Calculate Eigenvalues
egs = eig(Asys)
Ns = length(egs);
Damp=-real(egs)./sqrt(real(egs).^2+imag(egs).^2)
freq=abs(imag(egs))/(2*pi)

%% calculae Participation Factors
[Vs,D_eig] = eig(Asys);
Ws=inv(Vs);
for i=1:Ns
    for k=1:Ns
        Pfact1(k,i)=abs(Vs(k,i))*abs(Ws(i,k));
    end
end

for i=1:Ns
     Pfact(i,:)=Pfact1(i,:)/sum(Pfact1(i,:));
end

for i=1:Ns
    [s_val s_idx]=sort(Pfact(:,i),'descend');
    mod_idx(i,:)=s_idx(1:4)';
    pf_fact(i,:)=s_val(1:4)';
end
mod_idx;
pf_fact;

idx_zero = find(abs(egs)<1e-6)
EG_new = egs;
EG_new(idx_zero)=[];

idx_EMs = find(max(real(EG_new)))
EMs = EG_new(idx_EMs)
