function J = pss_objf(x,FunIndex,Dim)

load('sys_IO','f11')
As = f11.a;
Bs = f11.b;
Cs = f11.c;
Ds = f11.d;
    

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



b1 = [0 T1*KG1*T11*T13*Tw (T1*KG1*T11*Tw + T1*KG1*T13*Tw) T1*KG1*Tw 0] + [0 I1*KG1*T11*T13*Tw (I1*KG1*T11*Tw + I1*KG1*T13*Tw) I1*KG1*Tw 0] + [D1*KG1*T11*T13*Tw (D1*KG1*T11*Tw + D1*KG1*T13*Tw) D1*KG1*Tw 0 0];
a1 = [0 (T12*T14*Tw)^3+(1/N1)  (T12*T14 + T12*Tw + T14*Tw)^2+(1/N1) (T12 + T14 + Tw)^1+(1/N1) (1)^0+(1/N1)] + [T12*T14*Tw  (T12*T14 + T12*Tw + T14*Tw) (T12 + T14 + Tw) 1 0] + [0 T12*T14*Tw  (T12*T14 + T12*Tw + T14*Tw) (T12 + T14 + Tw) 1];

b3 = [0 T3*KG3*T31*T33*Tw (T3*KG3*T31*Tw + T3*KG3*T33*Tw) T3*KG3*Tw 0] + [0 I3*KG3*T31*T33*Tw (I3*KG3*T31*Tw + I3*KG3*T33*Tw) I3*KG3*Tw 0] + [D3*KG3*T31*T33*Tw (D3*KG3*T31*Tw + D3*KG3*T33*Tw) D3*KG3*Tw 0 0];
a3 = [0 (T32*T34*Tw)^3+(1/N3)  (T32*T34 + T32*Tw + T34*Tw)^2+(1/N3) (T32 + T34 + Tw)^1+(1/N3) (1)^0+(1/N3)] + [T32*T34*Tw  (T32*T34 + T32*Tw + T34*Tw) (T32 + T34 + Tw) 1 0] + [0 T32*T34*Tw  (T32*T34 + T32*Tw + T34*Tw) (T32 + T34 + Tw) 1];

b4 = [0 T4*KG4*T41*T43*Tw (T4*KG4*T41*Tw + T4*KG4*T43*Tw) T4*KG4*Tw 0] + [0 I4*KG4*T41*T43*Tw (I4*KG4*T41*Tw + I4*KG4*T43*Tw) I4*KG4*Tw 0] + [D4*KG4*T41*T43*Tw (D4*KG4*T41*Tw + D4*KG4*T43*Tw) D4*KG4*Tw 0 0];
a4 = [0 (T42*T44*Tw)^3+(1/N4)  (T42*T44 + T42*Tw + T44*Tw)^2+(1/N4) (T42 + T44 + Tw)^1+(1/N4) (1)^0+(1/N4)] + [T42*T44*Tw  (T42*T44 + T42*Tw + T44*Tw) (T42 + T44 + Tw) 1 0] + [0 T42*T44*Tw  (T42*T44 + T42*Tw + T44*Tw) (T42 + T44 + Tw) 1];

b5 = [0 T5*KG5*T51*T53*Tw (T5*KG5*T51*Tw + T5*KG5*T53*Tw) T5*KG5*Tw 0] + [0 I5*KG5*T51*T53*Tw (I5*KG5*T51*Tw + I5*KG5*T53*Tw) I5*KG5*Tw 0] + [D5*KG5*T51*T53*Tw (D5*KG5*T51*Tw + D5*KG5*T53*Tw) D5*KG5*Tw 0 0];
a5 = [0 (T52*T54*Tw)^3+(1/N5)  (T52*T54 + T52*Tw + T54*Tw)^2+(1/N5) (T52 + T54 + Tw)^1+(1/N5) (1)^0+(1/N5)] + [T52*T54*Tw  (T52*T54 + T52*Tw + T54*Tw) (T52 + T54 + Tw) 1 0] + [0 T52*T54*Tw  (T52*T54 + T52*Tw + T54*Tw) (T52 + T54 + Tw) 1];

b6 = [0 T6*KG6*T61*T63*Tw (T6*KG6*T61*Tw + T6*KG6*T63*Tw) T6*KG6*Tw 0] + [0 I6*KG6*T61*T63*Tw (I6*KG6*T61*Tw + I6*KG6*T63*Tw) I6*KG6*Tw 0] + [D6*KG6*T61*T63*Tw (D6*KG6*T61*Tw + D6*KG6*T63*Tw) D6*KG6*Tw 0 0];
a6 = [0 (T62*T64*Tw)^3+(1/N6)  (T62*T64 + T62*Tw + T64*Tw)^2+(1/N6) (T62 + T64 + Tw)^1+(1/N6) (1)^0+(1/N6)] + [T62*T64*Tw  (T62*T64 + T62*Tw + T64*Tw) (T62 + T64 + Tw) 1 0] + [0 T62*T64*Tw  (T62*T64 + T62*Tw + T64*Tw) (T62 + T64 + Tw) 1];

b7 = [0 T7*KG7*T71*T73*Tw (T7*KG7*T71*Tw + T7*KG7*T73*Tw) T7*KG7*Tw 0] + [0 I7*KG7*T71*T73*Tw (I7*KG7*T71*Tw + I7*KG7*T73*Tw) I7*KG7*Tw 0]  + [D7*KG7*T71*T73*Tw (D7*KG7*T71*Tw + D7*KG7*T73*Tw) D7*KG7*Tw 0 0];
a7 = [0 (T72*T74*Tw)^3+(1/N7)  (T72*T74 + T72*Tw + T74*Tw)^2+(1/N7) (T72 + T74 + Tw)^1+(1/N7) (1)^0+(1/N7)] + [T72*T74*Tw  (T72*T74 + T72*Tw + T74*Tw) (T72 + T74 + Tw) 1 0] + [0 T72*T74*Tw  (T72*T74 + T72*Tw + T74*Tw) (T72 + T74 + Tw) 1];

b8 = [0 T8*KG8*T81*T83*Tw (T8*KG8*T81*Tw + T8*KG8*T83*Tw) T8*KG8*Tw 0] + [0 I8*KG8*T81*T83*Tw (I8*KG8*T81*Tw + I8*KG8*T83*Tw) I8*KG8*Tw 0] + [D8*KG8*T81*T83*Tw (D8*KG8*T81*Tw + D8*KG8*T83*Tw) D8*KG8*Tw 0 0];
a8 = [0 (T82*T84*Tw)^3+(1/N8)  (T82*T84 + T82*Tw + T84*Tw)^2+(1/N8) (T82 + T84 + Tw)^1+(1/N8) (1)^0+(1/N8)] + [T82*T84*Tw  (T82*T84 + T82*Tw + T84*Tw) (T82 + T84 + Tw) 1 0] + [0 T82*T84*Tw  (T82*T84 + T82*Tw + T84*Tw) (T82 + T84 + Tw) 1];

b9 = [0 T9*KG9*T91*T93*Tw (T9*KG9*T91*Tw + T9*KG9*T93*Tw) T9*KG9*Tw 0] + [0 I9*KG9*T91*T93*Tw (I9*KG9*T91*Tw + I9*KG9*T93*Tw) I9*KG9*Tw 0] + [D9*KG9*T91*T93*Tw (D9*KG9*T91*Tw + D9*KG9*T93*Tw) D9*KG9*Tw 0 0];
a9 = [0 (T92*T94*Tw)^3+(1/N9)  (T92*T94 + T92*Tw + T94*Tw)^2+(1/N9) (T92 + T94 + Tw)^1+(1/N9) (1)^0+(1/N9)] + [T92*T94*Tw  (T92*T94 + T92*Tw + T94*Tw) (T92 + T94 + Tw) 1 0] + [0 T92*T94*Tw  (T92*T94 + T92*Tw + T94*Tw) (T92 + T94 + Tw) 1];

b10 = [0 T10*KG10*T101*T103*Tw (T10*KG10*T101*Tw + T10*KG10*T103*Tw) T10*KG10*Tw 0] + [0 I10*KG10*T101*T103*Tw (I10*KG10*T101*Tw + I10*KG10*T103*Tw) I10*KG10*Tw 0] + [D10*KG10*T101*T103*Tw (D10*KG10*T101*Tw + D10*KG10*T103*Tw) D10*KG10*Tw 0 0];
a10 = [0 (T102*T104*Tw)^3+(1/N10)  (T102*T104 + T102*Tw + T104*Tw)^2+(1/N10) (T102 + T104 + Tw)^1+(1/N10) (1)^0+(1/N10)] + [T102*T104*Tw  (T102*T104 + T102*Tw + T104*Tw) (T102 + T104 + Tw) 1 0] + [0 T102*T104*Tw  (T102*T104 + T102*Tw + T104*Tw) (T102 + T104 + Tw) 1];

[A_1 B_1 C_1 D_1 ]= tf2ss(b1,a1);
[A_2 B_2 C_2 D_2 ]= tf2ss(b3,a3);
[A_3 B_3 C_3 D_3 ]= tf2ss(b4,a4);
[A_4 B_4 C_4 D_4 ]= tf2ss(b5,a5);
[A_5 B_5 C_5 D_5 ]= tf2ss(b6,a6);
[A_6 B_6 C_6 D_6 ]= tf2ss(b7,a7);
[A_7 B_7 C_7 D_7 ]= tf2ss(b8,a8);
[A_8 B_8 C_8 D_8 ]= tf2ss(b9,a9);
[A_9 B_9 C_9 D_9 ]= tf2ss(b10,a10);


Af = blkdiag(A_1,A_2,A_3,A_4,A_5,A_6,A_7,A_8,A_9);
Bf = blkdiag(B_1,B_2,B_3,B_4,B_5,B_6,B_7,B_8,B_9);
Cf = blkdiag(C_1,C_2,C_3,C_4,C_5,C_6,C_7,C_8,C_9);
Df = blkdiag(D_1,D_2,D_3,D_4,D_5,D_6,D_7,D_8,D_9);

Asys_1 = As + Bs*Df*Cs;
Asys_2 = Bs*Cf;
Asys_3 = Bf*Cs;
Asys_4 = Af + Bf*Ds*Cf;
Asys = [Asys_1 Asys_2;
    Asys_3 Asys_4];

egs = eig(Asys);

[z_val z_idx]=sort(abs(egs),'descend');
egs_new=egs;
egs_new(z_idx(end-1:end))=[];

%% unstable modes
ss_idx = find(real(egs_new)>0);
uss = egs_new(ss_idx);

%% EM modes
% Damp=-real(egs)./sqrt(real(egs).^2+imag(egs).^2)
freq = abs(imag(egs_new))/(2*pi);
em_idx = find(freq>0 & freq<3);

objf = max(real(egs_new(em_idx)))+sum(egs_new(ss_idx));

if isempty(objf)
    objf = max(real(egs_new));
end
J = objf;