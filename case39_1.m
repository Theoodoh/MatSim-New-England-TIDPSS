function mpc = case39_1
%CASE39 Power flow data for 39 bus New England system.
%   Please see CASEFORMAT for details on the case file format.
%
%   Data taken from [1] with the following modifications/additions:
%
%       - renumbered gen buses consecutively (as in [2] and [4])
%       - added Pmin = 0 for all gens
%       - added Qmin, Qmax for gens at 31 & 39 (copied from gen at 35)
%       - added Vg based on V in bus data (missing for bus 39)
%       - added Vg, Pg, Pd, Qd at bus 39 from [2] (same in [4])
%       - added Pmax at bus 39: Pmax = Pg + 100
%       - added line flow limits and area data from [4]
%       - added voltage limits, Vmax = 1.06, Vmin = 0.94
%       - added identical quadratic generator costs
%       - increased Pmax for gen at bus 34 from 308 to 508
%         (assumed typo in [1], makes initial solved case feasible)
%       - re-solved power flow
% 
%   Notes:
%       - Bus 39, its generator and 2 connecting lines were added
%         (by authors of [1]) to represent the interconnection with
%         the rest of the eastern interconnect, and did not include
%         Vg, Pg, Qg, Pd, Qd, Pmin, Pmax, Qmin or Qmax.
%       - As the swing bus, bus 31 did not include and Q limits.
%       - The voltages, etc in [1] appear to be quite close to the
%         power flow solution of the case before adding bus 39 with
%         it's generator and connecting branches, though the solution
%         is not exact.
%       - Explicit voltage setpoints for gen buses are not given, so
%         they are taken from the bus data, however this results in two
%         binding Q limits at buses 34 & 37, so the corresponding
%         voltages have probably deviated from their original setpoints.
%       - The generator locations and types are as follows:
%           1   30      hydro
%           2   31      nuke01
%           3   32      nuke02
%           4   33      fossil02
%           5   34      fossil01
%           6   35      nuke03
%           7   36      fossil04
%           8   37      nuke04
%           9   38      nuke05
%           10  39      interconnection to rest of US/Canada
%
%   This is a solved power flow case, but it includes the following
%   violations:
%       - Pmax violated at bus 31: Pg = 677.87, Pmax = 646
%       - Qmin violated at bus 37: Qg = -1.37,  Qmin = 0
%
%   References:
%   [1] G. W. Bills, et.al., "On-Line Stability Analysis Study"
%       RP90-1 Report for the Edison Electric Institute, October 12, 1970,
%       pp. 1-20 - 1-35.
%       prepared by E. M. Gulachenski - New England Electric System
%                   J. M. Undrill     - General Electric Co.
%       "generally representative of the New England 345 KV system, but is
%        not an exact or complete model of any past, present or projected
%        configuration of the actual New England 345 KV system.
%   [2] M. A. Pai, Energy Function Analysis for Power System Stability,
%       Kluwer Academic Publishers, Boston, 1989.
%       (references [3] as source of data)
%   [3] Athay, T.; Podmore, R.; Virmani, S., "A Practical Method for the
%       Direct Analysis of Transient Stability," IEEE Transactions on Power
%       Apparatus and Systems , vol.PAS-98, no.2, pp.573-584, March 1979.
%       URL: http://ieeexplore.ieee.org/stamp/stamp.jsp?arnumber=4113518&isnumber=4113486
%       (references [1] as source of data)
%   [4] Data included with TC Calculator at http://www.pserc.cornell.edu/tcc/
%       for 39-bus system.

%   MATPOWER
%   $Id: case39.m,v 1.14 2010/03/10 18:08:13 ray Exp $

%% MATPOWER Case Format : Version 2
mpc.version = '2';

%%-----  Power Flow Data  -----%%
%% system MVA base
mpc.baseMVA = 100;

%% bus data
% bus_i	type  Pd   Qd	Gs	Bs	area Vm	    Va baseKV zone	Vmax	Vmin
mpc.bus = [ 
	1	 3	 9.2   4.6	 0	0	 2	.98	    0	345    1	1.06	0.94;
	2	 2	 1104  250	 0	0	 2	1.03	0	345	   1	1.06	0.94;
	3	 2	  0     0	 0	0	 2	.98   	0	345    1	1.06	0.94;
	4	 2	  0     0	 0	0	 1	1.01	0	345	   1	1.06	0.94;
	5	 2	  0	    0	 0	0	 1	.99  	0	345	   1	1.06	0.94;
	6	 2	  0	    0	 0	0	 1	1.04    0	345	   1	1.06	0.94;
	7	 2	  0     0	 0	0	 1	1.06    0	345	   1	1.06	0.94;
	8	 2	  0     0	 0	0	 1	1.02    0	345	   1	1.06	0.94;
	9	 2	  0     0	 0	0	 1	1.02	0	345	   1	1.06	0.94;
	10	 2	  0	    0	 0	0	 1	1.04	0	345	   1	1.06	0.94;
	11	 1	  0	    0	 0	0	 1	1       0	345	   1	1.06	0.94;
	12	 1	  0     0	 0	0	 1	1	    0	345    1	1.06	0.94;
	13	 1	 322   2.4	 0	0	 1	1	    0	345	   1	1.06	0.94;
	14	 1	 500   184	 0	0	 1	1	    0	345	   1	1.06	0.94;
	15	 1	  0     0	 0	0	 3	1	    0	345	   1	1.06	0.94;
	16	 1	  0     0	 0	0	 3	1	    0	345	   1	1.06	0.94;
	17	 1	 233.8 84	 0	0	 2	1	    0	345	   1	1.06	0.94;
	18	 1	 522   176	 0	0	 2	1	    0	345	   1	1.06	0.94;
	19	 1	  0	    0	 0	0	 3	1	    0	345	   1	1.06	0.94;
	20	 1	  0     0	 0	0	 3	1	    0	345	   1	1.06	0.94;
	21	 1	 274   115	 0	0	 3	1	    0	345	   1	1.06	0.94;
	22	 1	 0    	0	 0	0	 3	1	    0	345	   1	1.06	0.94;
	23	 1	 274.5 84.0  0	0	 3	1	    0	345	   1	1.06	0.94;
	24	 1	 308.6 92.2  0	0	 3	1	    0	345	   1	1.06	0.94;
	25	 1	 224   47.2	 0	0	 2	1	    0	345	   1	1.06	0.94;
	26	 1	 139   17	 0	0	 2	1       0	345	   1	1.06	0.94;
	27	 1	 281   75.5	 0	0	 2	1	    0	345	   1	1.06	0.94;
	28	 1	 206   27.6	 0	0	 3	1       0	345	   1	1.06	0.94;
	29	 1	 283.5 26.9	 0	0	 3	1       0	345	   1	1.06	0.94;
	30	 1	 628   103	 0	0	 2	1	    0	345	   1	1.06	0.94;
	31	 1	 0      0	 0	0	 1	1       0	345	   1	1.06	0.94;
	32	 1	 7.5   88	 0	0	 1	1	    0	345	   1	1.06	0.94;
	33	 1	 0	    0    0	0	 3	1	    0	345	   1	1.06	0.94;
	34	 1	 0	    0	 0	0	 3	1	    0	345	   1	1.06	0.94;
	35	 1	 320   153	 0	0	 3	1	    0	345	   1	1.06	0.94;
	36	 1	 329.4 32.3	 0	0	 3	1	    0	345	   1	1.06	0.94;
	37	 1	 0	    0	 0	0	 2	1	    0	345	   1	1.06	0.94;
	38	 1	 158	30	 0	0	 3	1    	0	345	   1	1.06	0.94;
	39	 1	 0      0	 0	0	 1	1       0	345	   1	1.06	0.94;
];



%% generator data
%  bus	   Pg	  Qg Qmax  Qmin  Vg    mBase status Pmax  Pmin Pc1 Pc2 Qc1min Qc1max Qc2min	Qc2max ramp_agc ramp_10	ramp_30	ramp_q apf
mpc.gen = [ 
	1	552.700  150  300  -50	.98000	100	   1	600    0	0	0	  0	    0	  0   	0	    0	      0      0	      0	    0;
	2	1000.00	 150  300  -50  1.0300  100	   1	1100   0	0	0	  0	    0	  0  	0	    0	      0      0	      0	    0;
	3	650.000	 150  300  -50	.98000	100	   1	750    0	0	0	  0	    0     0	    0	    0	      0	     0        0	    0;
	4	508.000	 150  300  -50	1.0100	100	   1	608    0	0	0	  0	    0	  0   	0	    0	      0	     0	      0	    0;
	5	632.000	 150  300  -50	.99000	100	   1	732    0	0	0	  0	    0	  0	    0	    0	      0	     0	      0	    0;
	6	650.000	 150  300  -50  1.0400  100	   1	750    0	0	0	  0	    0	  0  	0	    0	      0	     0	      0	    0;
	7	560.000	 150  300  -50	1.0600  100	   1	660	   0	0	0	  0	    0	  0	    0	    0	      0	     0	      0	    0;
	8	540.000	 150  300  -50	1.0200	100	   1	640	   0	0	0	  0	    0	  0	    0	    0	      0      0	      0	    0;
	9	830.000	 150  300  -50	1.0200	100	   1	930	   0	0	0	  0	    0	  0  	0	    0	      0	     0        0	    0;
	10	250.000	 150  300  -50	1.0400	100	   1	350    0	0	0	  0	    0	  0	    0	    0	      0	     0	      0	    0;
];

%% branch data
%  fbus  tbus     r	    x	  b   rateA rateB rateC  ratio angle status	angmin angmax
mpc.branch=[
	39	  30   .0007 .0138	  0	   600	 600   600	   1	0   	1	-360	360;
	39	  5	   .0007 .0142	  0	   1000  1000  1000	   1	0	    1	-360	360;
	32	  33   .0016 .0435	  0	   500	 500   500	   1	0	    1	-360	360;
	32	  31   .0016 .0435	  0	   500	 500   500     1	0	    1	-360	360;
	30	  4    .0009 .0180	  0    900	 900   2500	   1	0	    1	-360	360;
	29	  9    .0008 .0156	  0	   500	 500   500	   1	0	    1	-360	360;
	25	  8	   .0006 .0232	  0	   500   500   500	   1	0	    1	-360	360;
	23	  7	   .0005 .0272	  0	   600   600   600	   1	0	    1	-360	360;
	22	  6	     0   .0143	  0	   500	 500   500	   1	0	    1	-360	360;
	20	  3 	 0 	 .0200	  0	   1200  1200  1200	   1	0	    1	-360	360;
	16	  1	     0   .0250	  0	   900   900   900	   1	0	    1	-360	360;
	12	  10	 0	 .0181	  0	   900   900   900	   1	0	    1	-360	360;
	37	  27   .0013 .0173	.3216  480   480   480	   0	0	    1	-360	360;
	37	  38   .0007 .0082	.1319  800   1800  1800	   0	0	    1	-360	360;
	36	  24   .0003 .0059	.068   900   900   900	   0	0	    1	-360	360;
	36	  21   .0008 .0135	.2548  900	 900   900	   0	0	    1	-360	360;
	36	  39   .0016 .0195	.3040  900   900   900	   0	0	    1	-360	360;
	36	  37   .0007 .0089	.1342  600   600   600	   0	0	    1	-360	360;
	35	  36   .0009 .0094	.1710  600	 600   600     0	0	    1	-360	360;
	34	  35   .0018 .0217	.3660  900	 900   2500	   0	0	    1	-360	360;
	33	  34   .0009 .0101	.1723  500	 500   500	   0	0	    1	-360	360;
	28	  29   .0014 .0151	.2490  500	 500   500	   0	0	    1	-360	360;
	26 	  29   .0057 .0625	1.029  600	 600   600	   0	0	    1	-360	360;
	26	  28   .0043 .0474	.7802  600	 600   600	   0	0	    1	-360	360;
	26	  27   .0014 .0147	.2396  600	 600   600	   0	0	    1	-360	360;
	25	  26   .0032 .0323	.5130  600	 600   600	   0	0    	1	-360	360;
	23	  24   .0022 .0350	.3610  600	 600   2500	   0	0	    1	-360	360;
	22	  23   .0006 .0096	.1846  600	 600   600	   0	0	    1	-360	360;
	21	  22   .0008 .0135	.2548  600	 600   600	   0	0	    1	-360	360;
	20	  33   .0004 .0043	.0729  600	 600   600	   0	0	    1	-360	360;
	20	  31   .0004 .0043	.0729  600	 600   600	   0	0	    1	-360	360;
	19	  2	   .0010 .0250	1.200  900	 900   2500	   0	0	    1	-360	360;
	18	  19   .0023 .0363	.3804  900	 900   2500	   0	0	    1	-360	360;
	17	  18   .0004 .0046	.0780  900	 900   2500	   0	0	    1	-360	360;
	16	  31   .0007 .0082	.1389  900	 900   900	   0	0	    1	-360	360;
	16	  17   .0006 .0092	.1130  600	 600   600	   0	0	    1	-360	360;
	15	  18   .0008 .0112	.1476  900	 900   2500	   0	0	    1	-360	360;
	15	  16   .0002 .0026	.0434  600	 600   600	   0	0    	1	-360	360;
	14	  34   .0008 .0129	.1382  900	 900   2500	   0	0	    1 	-360	360;
	14	  15   .0008 .0128	.1342  600	 600   600	   0	0	    1	-360	360;
	13	  38   .0011 .0133	.2138  900	 900   2500	   0	0	    1	-360	360;
	13	  14   .0013 .0213	.2214  600	 600   600	   0	0	    1	-360	360;
	12	  25   .0070 .0086	.1460  600	 600   600	   0	0	    1	-360	360;
	12	  13   .0013 .0151	.2572  600	 600   600	   0	0    	1	-360	360;
	11	  12   .0035 .0411	.6987  600	 600   600     0	0	    1	-360	360;
	11	  2	   .0010 .0250	.7500  1200	 1200  2500    0	0	    1	-360	360;
];

%%-----  OPF Data  -----%%
%% generator cost data
%	1	startup	shutdown	n	x1	y1	...	xn	yn
%	2	startup	shutdown	n	c(n-1)	...	c0
mpc.gencost = [
	2	  0     	0	    3	0.01	0.3    0.2;
	2	  0	        0	    3	0.01	0.3	   0.2;
	2	  0      	0	    3	0.01	0.3	   0.2;
	2	  0     	0	    3	0.01	0.3	   0.2;
	2	  0	        0	    3	0.01	0.3	   0.2;
	2	  0      	0	    3	0.01	0.3	   0.2;
	2	  0      	0	    3	0.01	0.3	   0.2;
	2	  0	        0	    3	0.01	0.3	   0.2;
	2	  0	        0	    3	0.01	0.3	   0.2;
	2	  0	        0	    3	0.01	0.3	   0.2;
];
