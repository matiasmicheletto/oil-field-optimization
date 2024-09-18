SCIP version 8.0.3 [precision: 8 byte] [memory: block] [mode: optimized] [LP solver: Soplex 6.0.3] [GitHash: 62fab8a2e3]
Copyright (C) 2002-2022 Konrad-Zuse-Zentrum fuer Informationstechnik Berlin (ZIB)

External libraries: 
  Readline 8.1         GNU library for command line editing (gnu.org/s/readline)
  Soplex 6.0.3         Linear Programming Solver developed at Zuse Institute Berlin (soplex.zib.de) [GitHash: f900e3d0]
  CppAD 20180000.0     Algorithmic Differentiation of C++ algorithms developed by B. Bell (github.com/coin-or/CppAD)
  ZLIB 1.2.11          General purpose compression library by J. Gailly and M. Adler (zlib.net)
  GMP 6.2.1            GNU Multiple Precision Arithmetic Library developed by T. Granlund (gmplib.org)
  ZIMPL 3.5.3          Zuse Institute Mathematical Programming Language developed by T. Koch (zimpl.zib.de)
  AMPL/MP 4e2d45c4     AMPL .nl file reader library (github.com/ampl/mp)
  bliss 0.77           Computing Graph Automorphism Groups by T. Junttila and P. Kaski (www.tcs.hut.fi/Software/bliss/)

user parameter file <scip.set> not found - using default parameters

read problem <pozos.zpl>
============


base directory for ZIMPL parsing: </home/rodrigo/Documents/Petroleo>

original problem has 156 variables (132 bin, 0 int, 0 impl, 24 cont) and 157 constraints

solve problem
=============

presolving:
(round 1, fast)       16 del vars, 13 del conss, 1 add conss, 13 chg bounds, 0 chg sides, 20 chg coeffs, 0 upgd conss, 0 impls, 12 clqs
(round 2, fast)       16 del vars, 14 del conss, 1 add conss, 13 chg bounds, 1 chg sides, 20 chg coeffs, 0 upgd conss, 0 impls, 12 clqs
(round 3, exhaustive) 16 del vars, 24 del conss, 1 add conss, 13 chg bounds, 1 chg sides, 20 chg coeffs, 0 upgd conss, 0 impls, 12 clqs
(round 4, exhaustive) 16 del vars, 24 del conss, 1 add conss, 13 chg bounds, 1 chg sides, 20 chg coeffs, 32 upgd conss, 0 impls, 12 clqs
   (0.0s) probing cycle finished: starting next cycle
   (0.0s) symmetry computation started: requiring (bin +, int -, cont +), (fixed: bin -, int +, cont -)
   (0.0s) no symmetry present
presolving (5 rounds: 5 fast, 3 medium, 3 exhaustive):
 16 deleted vars, 24 deleted constraints, 1 added constraints, 13 tightened bounds, 0 added holes, 1 changed sides, 20 changed coefficients
 205 implications, 112 cliques
presolved problem has 140 variables (120 bin, 0 int, 0 impl, 20 cont) and 134 constraints
     20 constraints of type <varbound>
     12 constraints of type <setppc>
    102 constraints of type <linear>
transformed objective value is always integral (scale: 1)
Presolving Time: 0.02

 time | node  | left  |LP iter|LP it/n|mem/heur|mdpt |vars |cons |rows |cuts |sepa|confs|strbr|  dualbound   | primalbound  |  gap   | compl. 
p 0.0s|     1 |     0 |    31 |     - |shiftand|   0 | 140 | 141 | 134 |   0 |  0 |   7 |   0 | 0.000000e+00 | 2.050000e+03 |    Inf | unknown
  0.0s|     1 |     0 |    60 |     - |  2764k |   0 | 140 | 141 | 134 |   0 |  0 |   7 |   0 | 1.410957e+03 | 2.050000e+03 |  45.29%| unknown
  0.0s|     1 |     0 |    60 |     - |  2764k |   0 | 140 | 141 | 134 |   0 |  0 |   7 |   0 | 1.410957e+03 | 2.050000e+03 |  45.29%| unknown
  0.0s|     1 |     0 |    62 |     - |  2792k |   0 | 140 | 141 | 137 |   3 |  1 |   7 |   0 | 1.450854e+03 | 2.050000e+03 |  41.30%| unknown
  0.0s|     1 |     0 |    75 |     - |  2815k |   0 | 140 | 141 | 140 |   6 |  2 |   7 |   0 | 1.664789e+03 | 2.050000e+03 |  23.14%| unknown
  0.0s|     1 |     0 |    75 |     - |  2815k |   0 | 140 | 142 | 140 |   6 |  2 |   8 |   0 | 1.664789e+03 | 2.050000e+03 |  23.14%| unknown
  0.0s|     1 |     0 |    83 |     - |  2837k |   0 | 140 | 142 | 144 |  10 |  3 |   8 |   0 | 1.734095e+03 | 2.050000e+03 |  18.22%| unknown
  0.0s|     1 |     0 |    83 |     - |  2839k |   0 | 140 | 142 | 144 |  10 |  3 |   8 |   0 | 1.734095e+03 | 2.050000e+03 |  18.22%| unknown
  0.0s|     1 |     0 |    87 |     - |  2962k |   0 | 140 | 142 | 147 |  13 |  4 |   8 |   0 | 1.792924e+03 | 2.050000e+03 |  14.34%| unknown
  0.0s|     1 |     0 |    87 |     - |  2971k |   0 | 140 | 142 | 147 |  13 |  4 |   8 |   0 | 1.792924e+03 | 2.050000e+03 |  14.34%| unknown
  0.0s|     1 |     0 |    95 |     - |  2999k |   0 | 140 | 142 | 152 |  22 |  5 |   8 |   0 | 1.810753e+03 | 2.050000e+03 |  13.21%| unknown
  0.0s|     1 |     0 |    95 |     - |  3001k |   0 | 140 | 142 | 151 |  22 |  5 |   8 |   0 | 1.810753e+03 | 2.050000e+03 |  13.21%| unknown
  0.0s|     1 |     0 |   102 |     - |  3069k |   0 | 140 | 140 | 153 |  24 |  6 |   8 |   0 | 1.818287e+03 | 2.050000e+03 |  12.74%| unknown
  0.1s|     1 |     0 |   102 |     - |  3071k |   0 | 140 | 140 | 152 |  24 |  6 |   8 |   0 | 1.818287e+03 | 2.050000e+03 |  12.74%| unknown
  0.1s|     1 |     0 |   108 |     - |  3093k |   0 | 140 | 140 | 152 |  26 |  7 |   8 |   0 | 1.829785e+03 | 2.050000e+03 |  12.04%| unknown
 time | node  | left  |LP iter|LP it/n|mem/heur|mdpt |vars |cons |rows |cuts |sepa|confs|strbr|  dualbound   | primalbound  |  gap   | compl. 
  0.1s|     1 |     0 |   108 |     - |  3093k |   0 | 140 | 140 | 152 |  26 |  7 |   8 |   0 | 1.829785e+03 | 2.050000e+03 |  12.04%| unknown
  0.1s|     1 |     0 |   118 |     - |  3093k |   0 | 140 | 140 | 154 |  28 |  8 |   8 |   0 | 1.970208e+03 | 2.050000e+03 |   4.05%| unknown
  0.1s|     1 |     0 |   118 |     - |  3095k |   0 | 140 | 141 | 154 |  28 |  8 |   9 |   0 | 1.970208e+03 | 2.050000e+03 |   4.05%| unknown
  0.1s|     1 |     0 |   126 |     - |  3167k |   0 | 140 | 141 | 151 |  38 |  9 |   9 |   0 | 1.983599e+03 | 2.050000e+03 |   3.35%| unknown
  0.1s|     1 |     0 |   126 |     - |  3168k |   0 | 140 | 142 | 150 |  38 |  9 |  10 |   0 | 1.983599e+03 | 2.050000e+03 |   3.35%| unknown
  0.1s|     1 |     0 |   127 |     - |  3197k |   0 | 140 | 141 | 153 |  41 | 10 |  10 |   0 | 2.050000e+03 | 2.050000e+03 |   0.00%| unknown
  0.1s|     1 |     0 |   127 |     - |  3197k |   0 | 140 | 141 | 153 |  41 | 10 |  10 |   0 | 2.050000e+03 | 2.050000e+03 |   0.00%| unknown

SCIP Status        : problem is solved [optimal solution found]
Solving Time (sec) : 0.07
Solving Nodes      : 1
Primal Bound       : +2.05000000000000e+03 (3 solutions)
Dual Bound         : +2.05000000000000e+03
Gap                : 0.00 %

primal solution (original space):
=================================

objective value:                                 2050
z#1                                                 1 	(obj:0)
x#0#1                                               1 	(obj:0)
x#1#0                                               1 	(obj:0)
rp#1                                 4.66666666666669 	(obj:0)
rp#2                                               23 	(obj:0)
rp#3                                               18 	(obj:0)
rp#4                                               15 	(obj:0)
rp#5                                               27 	(obj:0)
rp#6                                               15 	(obj:0)
rp#7                                               24 	(obj:0)
rp#8                                               12 	(obj:0)
rp#9                                               12 	(obj:0)
rp#10                                              28 	(obj:0)
distancia                                        2050 	(obj:1)
perdida                                          4170 	(obj:0)

Statistics
==========

SCIP Status        : problem is solved [optimal solution found]
Total Time         :       0.08
  solving          :       0.07
  presolving       :       0.02 (included in solving)
  reading          :       0.01
  copying          :       0.00 (0 times copied the problem)
Original Problem   :
  Problem name     : pozos.zpl
  Variables        : 156 (132 binary, 0 integer, 0 implicit integer, 24 continuous)
  Constraints      : 157 initial, 157 maximal
  Objective        : minimize, 1 non-zeros (abs.min = 1, abs.max = 1)
Presolved Problem  :
  Problem name     : t_pozos.zpl
  Variables        : 140 (120 binary, 0 integer, 0 implicit integer, 20 continuous)
  Constraints      : 134 initial, 142 maximal
  Objective        : minimize, 110 non-zeros (abs.min = 270, abs.max = 1672)
  Nonzeros         : 660 constraint, 45 clique table
Presolvers         :   ExecTime  SetupTime  Calls  FixedVars   AggrVars   ChgTypes  ChgBounds   AddHoles    DelCons    AddCons   ChgSides   ChgCoefs
  boundshift       :       0.00       0.00      0          0          0          0          0          0          0          0          0          0
  convertinttobin  :       0.00       0.00      0          0          0          0          0          0          0          0          0          0
  domcol           :       0.00       0.00      1          0          0          0          0          0          0          0          0          0
  dualagg          :       0.00       0.00      0          0          0          0          0          0          0          0          0          0
  dualcomp         :       0.00       0.00      1          0          0          0          0          0          0          0          0          0
  dualinfer        :       0.00       0.00      0          0          0          0          0          0          0          0          0          0
  dualsparsify     :       0.00       0.00      1          0          0          0          0          0          0          0          0          0
  gateextraction   :       0.00       0.00      0          0          0          0          0          0          0          0          0          0
  implics          :       0.00       0.00      3          0          0          0          0          0          0          0          0          0
  inttobinary      :       0.00       0.00      0          0          0          0          0          0          0          0          0          0
  qpkktref         :       0.00       0.00      0          0          0          0          0          0          0          0          0          0
  redvub           :       0.00       0.00      0          0          0          0          0          0          0          0          0          0
  sparsify         :       0.00       0.00      1          0          0          0          0          0          0          0          0          0
  stuffing         :       0.00       0.00      0          0          0          0          0          0          0          0          0          0
  trivial          :       0.00       0.00      5          0          0          0          0          0          0          0          0          0
  tworowbnd        :       0.00       0.00      0          0          0          0          0          0          0          0          0          0
  dualfix          :       0.00       0.00      5          3          0          0          0          0          0          0          0          0
  genvbounds       :       0.00       0.00      0          0          0          0          0          0          0          0          0          0
  probing          :       0.01       0.00      1          0          0          0          0          0          0          0          0          0
  pseudoobj        :       0.00       0.00      0          0          0          0          0          0          0          0          0          0
  symmetry         :       0.00       0.00      1          0          0          0          0          0          0          0          0          0
  vbounds          :       0.00       0.00      1          0          0          0          0          0          0          0          0          0
  varbound         :       0.00       0.00      2          0          0          0          0          0          0          0          0          0
  setppc           :       0.00       0.00      3          0          0          0          0          0          0          0          0          0
  linear           :       0.00       0.00      8         11          2          0         13          0         24          1          1         20
  logicor          :       0.00       0.00      0          0          0          0          0          0          0          0          0          0
  benders          :       0.00       0.00      0          0          0          0          0          0          0          0          0          0
  components       :       0.00       0.00      1          0          0          0          0          0          0          0          0          0
  root node        :          -          -      -         99          -          -         99          -          -          -          -          -
Constraints        :     Number  MaxNumber  #Separate #Propagate    #EnfoLP    #EnfoRelax  #EnfoPS    #Check   #ResProp    Cutoffs    DomReds       Cuts    Applied      Conss   Children
  benderslp        :          0          0          0          0          0          0          0         18          0          0          0          0          0          0          0
  integral         :          0          0          0          0          0          0          0         18          0          0          0          0          0          0          0
  varbound         :         20         20         10        656          0          0          0         12         10          0          0          0          0          0          0
  setppc           :         12+        14         10        664          0          0          0          5         17          2          0          0          0          0          0
  linear           :        102+       105         10        664          0          0          0          3          5          7          0         19          2          0          0
  logicor          :          0+         4          8         27          0          0          0          0          0          0          0          0          0          0          0
  benders          :          0          0          0          0          0          0          0          4          0          0          0          0          0          0          0
  countsols        :          0          0          0          0          0          0          0          4          0          0          0          0          0          0          0
  components       :          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0
Constraint Timings :  TotalTime  SetupTime   Separate  Propagate     EnfoLP     EnfoPS     EnfoRelax   Check    ResProp    SB-Prop
  benderslp        :       0.00       0.00       0.00       0.00       0.00       0.00       0.00       0.00       0.00       0.00
  integral         :       0.00       0.00       0.00       0.00       0.00       0.00       0.00       0.00       0.00       0.00
  varbound         :       0.00       0.00       0.00       0.00       0.00       0.00       0.00       0.00       0.00       0.00
  setppc           :       0.00       0.00       0.00       0.00       0.00       0.00       0.00       0.00       0.00       0.00
  linear           :       0.01       0.00       0.00       0.00       0.00       0.00       0.00       0.00       0.00       0.00
  logicor          :       0.00       0.00       0.00       0.00       0.00       0.00       0.00       0.00       0.00       0.00
  benders          :       0.00       0.00       0.00       0.00       0.00       0.00       0.00       0.00       0.00       0.00
  countsols        :       0.00       0.00       0.00       0.00       0.00       0.00       0.00       0.00       0.00       0.00
  components       :       0.00       0.00       0.00       0.00       0.00       0.00       0.00       0.00       0.00       0.00
Propagators        : #Propagate   #ResProp    Cutoffs    DomReds
  dualfix          :          2          0          0          0
  genvbounds       :          0          0          0          0
  nlobbt           :          0          0          0          0
  obbt             :          0          0          0          0
  probing          :          0          0          0          0
  pseudoobj        :         30          0          0          0
  redcost          :         19          0          0         88
  rootredcost      :          0          0          0          0
  symmetry         :          0          0          0          0
  vbounds          :         90          0          0          0
Propagator Timings :  TotalTime  SetupTime   Presolve  Propagate    ResProp    SB-Prop
  dualfix          :       0.00       0.00       0.00       0.00       0.00       0.00
  genvbounds       :       0.00       0.00       0.00       0.00       0.00       0.00
  nlobbt           :       0.00       0.00       0.00       0.00       0.00       0.00
  obbt             :       0.00       0.00       0.00       0.00       0.00       0.00
  probing          :       0.01       0.00       0.01       0.00       0.00       0.00
  pseudoobj        :       0.00       0.00       0.00       0.00       0.00       0.00
  redcost          :       0.00       0.00       0.00       0.00       0.00       0.00
  rootredcost      :       0.00       0.00       0.00       0.00       0.00       0.00
  symmetry         :       0.00       0.00       0.00       0.00       0.00       0.00
  vbounds          :       0.00       0.00       0.00       0.00       0.00       0.00
Conflict Analysis  :       Time      Calls    Success    DomReds  Conflicts   Literals    Reconvs ReconvLits   Dualrays   Nonzeros   LP Iters   (pool size: [10000,10000])
  propagation      :       0.00          3          3          -          4        2.5          0        0.0          -          -          -
  infeasible LP    :       0.00          4          4          -          7       11.1          0        0.0          4        6.2          0
  bound exceed. LP :       0.00          0          0          -          0        0.0          0        0.0          0        0.0          0
  strong branching :       0.00          0          0          -          0        0.0          0        0.0          -          -          0
  pseudo solution  :       0.00          0          0          -          0        0.0          0        0.0          -          -          -
  applied globally :       0.00          -          -          0          5        3.2          -          -          4          -          -
  applied locally  :          -          -          -          0          1       46.0          -          -          0          -          -
Separators         :   ExecTime  SetupTime      Calls  RootCalls    Cutoffs    DomReds  FoundCuts ViaPoolAdd  DirectAdd    Applied ViaPoolApp  DirectApp      Conss
  cut pool         :       0.00          -         19         19          -          -        195        109          -          -          -          -          -    (maximal pool size:        195)
  aggregation      :       0.01       0.00         10         10          0          0         61         35          0          5          5          0          0
  > cmir           :          -          -          -          -          -          -          -         29          0          2          2          0          -
  > flowcover      :          -          -          -          -          -          -          -          3          0          1          1          0          -
  > knapsackcover  :          -          -          -          -          -          -          -          3          0          2          2          0          -
  cgmip            :       0.00       0.00          0          0          0          0          0          0          0          0          0          0          0
  clique           :       0.00       0.00         10         10          0          0          0          0          0          0          0          0          0
  closecuts        :       0.00       0.00          0          0          0          0          0          0          0          0          0          0          0
  convexproj       :       0.00       0.00          0          0          0          0          0          0          0          0          0          0          0
  disjunctive      :       0.00       0.00          0          0          0          0          0          0          0          0          0          0          0
  eccuts           :       0.00       0.00          0          0          0          0          0          0          0          0          0          0          0
  gauge            :       0.00       0.00          0          0          0          0          0          0          0          0          0          0          0
  gomory           :       0.01       0.00         10         10          0          0        130         60         14         19          8         11          0
  > gomorymi       :          -          -          -          -          -          -          -         36          7          8          1          7          -
  > strongcg       :          -          -          -          -          -          -          -         24          7         11          7          4          -
  impliedbounds    :       0.00       0.00         10         10          0          8         13         12          0         12         12          0          0
  interminor       :       0.00       0.00          0          0          0          0          0          0          0          0          0          0          0
  intobj           :       0.00       0.00          0          0          0          0          0          0          0          0          0          0          0
  mcf              :       0.00       0.00          1          1          0          0          0          0          0          0          0          0          0
  minor            :       0.00       0.00          0          0          0          0          0          0          0          0          0          0          0
  mixing           :       0.00       0.00         10         10          0          0          0          0          0          0          0          0          0
  oddcycle         :       0.00       0.00          0          0          0          0          0          0          0          0          0          0          0
  rapidlearning    :       0.00       0.00          0          0          0          0          0          0          0          0          0          0          0
  rlt              :       0.00       0.00         10         10          0          0          0          0          0          0          0          0          0
  zerohalf         :       0.00       0.00         10         10          0          0          5          2          0          0          0          0          0
Cutselectors       :   ExecTime  SetupTime      Calls  RootCalls   Selected     Forced   Filtered  RootSelec   RootForc   RootFilt 
  hybrid           :       0.00       0.00         10         10         27         14        115         27         14        115
Pricers            :   ExecTime  SetupTime      Calls       Vars
  problem variables:       0.00          -          0          0
Branching Rules    :   ExecTime  SetupTime   BranchLP  BranchExt   BranchPS    Cutoffs    DomReds       Cuts      Conss   Children
  allfullstrong    :       0.00       0.00          0          0          0          0          0          0          0          0
  cloud            :       0.00       0.00          0          0          0          0          0          0          0          0
  distribution     :       0.00       0.00          0          0          0          0          0          0          0          0
  fullstrong       :       0.00       0.00          0          0          0          0          0          0          0          0
  inference        :       0.00       0.00          0          0          0          0          0          0          0          0
  leastinf         :       0.00       0.00          0          0          0          0          0          0          0          0
  lookahead        :       0.00       0.00          0          0          0          0          0          0          0          0
  mostinf          :       0.00       0.00          0          0          0          0          0          0          0          0
  multaggr         :       0.00       0.00          0          0          0          0          0          0          0          0
  nodereopt        :       0.00       0.00          0          0          0          0          0          0          0          0
  pscost           :       0.00       0.00          0          0          0          0          0          0          0          0
  random           :       0.00       0.00          0          0          0          0          0          0          0          0
  relpscost        :       0.00       0.00          0          0          0          0          0          0          0          0
  vanillafullstrong:       0.00       0.00          0          0          0          0          0          0          0          0
Primal Heuristics  :   ExecTime  SetupTime      Calls      Found       Best
  LP solutions     :       0.00          -          -          0          0
  relax solutions  :       0.00          -          -          0          0
  pseudo solutions :       0.00          -          -          0          0
  strong branching :       0.00          -          -          0          0
  actconsdiving    :       0.00       0.00          0          0          0
  adaptivediving   :       0.00       0.00          0          0          0
  alns             :       0.00       0.00          0          0          0
  bound            :       0.00       0.00          0          0          0
  clique           :       0.00       0.00          1          0          0
  coefdiving       :       0.00       0.00          0          0          0
  completesol      :       0.00       0.00          0          0          0
  conflictdiving   :       0.00       0.00          0          0          0
  crossover        :       0.00       0.00          0          0          0
  dins             :       0.00       0.00          0          0          0
  distributiondivin:       0.00       0.00          0          0          0
  dps              :       0.00       0.00          0          0          0
  dualval          :       0.00       0.00          0          0          0
  farkasdiving     :       0.00       0.00          0          0          0
  feaspump         :       0.00       0.00          0          0          0
  fixandinfer      :       0.00       0.00          0          0          0
  fracdiving       :       0.00       0.00          0          0          0
  gins             :       0.00       0.00          0          0          0
  guideddiving     :       0.00       0.00          0          0          0
  indicator        :       0.00       0.00          0          0          0
  intdiving        :       0.00       0.00          0          0          0
  intshifting      :       0.00       0.00          0          0          0
  linesearchdiving :       0.00       0.00          0          0          0
  localbranching   :       0.00       0.00          0          0          0
  locks            :       0.00       0.00          1          0          0
  lpface           :       0.00       0.00          0          0          0
  mpec             :       0.00       0.00          0          0          0
  multistart       :       0.00       0.00          0          0          0
  mutation         :       0.00       0.00          0          0          0
  nlpdiving        :       0.00       0.00          0          0          0
  objpscostdiving  :       0.00       0.00          0          0          0
  octane           :       0.00       0.00          0          0          0
  ofins            :       0.00       0.00          0          0          0
  oneopt           :       0.00       0.00          1          0          0
  padm             :       0.00       0.00          0          0          0
  proximity        :       0.00       0.00          0          0          0
  pscostdiving     :       0.00       0.00          0          0          0
  randrounding     :       0.00       0.00         10          0          0
  rens             :       0.00       0.00          0          0          0
  reoptsols        :       0.00       0.00          0          0          0
  repair           :       0.00       0.00          0          0          0
  rins             :       0.00       0.00          0          0          0
  rootsoldiving    :       0.00       0.00          0          0          0
  rounding         :       0.00       0.00         10          0          0
  shiftandpropagate:       0.00       0.00          1          1          1
  shifting         :       0.00       0.00         10          2          0
  simplerounding   :       0.00       0.00          0          0          0
  subnlp           :       0.00       0.00          0          0          0
  trivial          :       0.00       0.00          2          0          0
  trivialnegation  :       0.00       0.00          0          0          0
  trustregion      :       0.00       0.00          0          0          0
  trysol           :       0.00       0.00          0          0          0
  twoopt           :       0.00       0.00          0          0          0
  undercover       :       0.00       0.00          0          0          0
  vbounds          :       0.00       0.00          1          0          0
  veclendiving     :       0.00       0.00          0          0          0
  zeroobj          :       0.00       0.00          0          0          0
  zirounding       :       0.00       0.00          0          0          0
  other solutions  :          -          -          -          0          -
LP                 :       Time      Calls Iterations  Iter/call   Iter/sec  Time-0-It Calls-0-It    ItLimit
  primal LP        :       0.00          0          0       0.00          -       0.00          0
  dual LP          :       0.01         21         96       8.73          -       0.00         10
  lex dual LP      :       0.00          0          0       0.00          -
  barrier LP       :       0.00          0          0       0.00          -       0.00          0
  resolve instable :       0.00          0          0       0.00          -
  diving/probing LP:       0.00          5         31       6.20          -
  strong branching :       0.00          0          0       0.00          -          -          -          0
    (at root node) :          -          0          0       0.00          -
  conflict analysis:       0.00          0          0       0.00          -
B&B Tree           :
  number of runs   :          1
  nodes            :          1 (0 internal, 1 leaves)
  feasible leaves  :          0
  infeas. leaves   :          0
  objective leaves :          0
  nodes (total)    :          1 (0 internal, 1 leaves)
  nodes left       :          0
  max depth        :          0
  max depth (total):          0
  backtracks       :          0 (0.0%)
  early backtracks :          0 (0.0%)
  nodes exc. ref.  :          0 (0.0%)
  delayed cutoffs  :          0
  repropagations   :          0 (0 domain reductions, 0 cutoffs)
  avg switch length:       2.00
  switching time   :       0.00
Root Node          :
  First LP value   : +1.41095743985550e+03
  First LP Iters   :         29 (60542.80 Iter/sec)
  First LP Time    :       0.00
  Final Dual Bound : +2.05000000000000e+03
  Final Root Iters :         96
  Root LP Estimate :                     -
Solution           :
  Solutions found  :          3 (1 improvements)
  First Solution   : +2.05000000000000e+03   (in run 1, after 1 nodes, 0.03 seconds, depth 29, found by <shiftandpropagate>)
  Gap First Sol.   :   infinite
  Gap Last Sol.    :   infinite
  Primal Bound     : +2.05000000000000e+03   (in run 1, after 1 nodes, 0.03 seconds, depth 29, found by <shiftandpropagate>)
  Dual Bound       : +2.05000000000000e+03
  Gap              :       0.00 %
Integrals          :      Total       Avg%
  primal-dual      :       3.19      47.18
  primal-ref       :          -          - (not evaluated)
  dual-ref         :          -          - (not evaluated)
