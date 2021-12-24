clear;
close all;

[Nino_12_002,El_Nino_12_Years_002,La_Nina_12_Years_002] = Calculate_Nino_Index_Function(-10,0,-90,-80, 'b.e11.B20TRC5CNBDRD.f09_g16.002.pop.h.SST.192001-200512.nc');
[Nino_12_003,El_Nino_12_Years_003,La_Nina_12_Years_003] = Calculate_Nino_Index_Function(-10,0,-90,-80, 'b.e11.B20TRC5CNBDRD.f09_g16.003.pop.h.SST.192001-200512.nc');
[Nino_12_004,El_Nino_12_Years_004,La_Nina_12_Years_004] = Calculate_Nino_Index_Function(-10,0,-90,-80, 'b.e11.B20TRC5CNBDRD.f09_g16.004.pop.h.SST.192001-200512.nc');
[Nino_12_005,El_Nino_12_Years_005,La_Nina_12_Years_005] = Calculate_Nino_Index_Function(-10,0,-90,-80, 'b.e11.B20TRC5CNBDRD.f09_g16.005.pop.h.SST.192001-200512.nc');
[Nino_12_006,El_Nino_12_Years_006,La_Nina_12_Years_006] = Calculate_Nino_Index_Function(-10,0,-90,-80, 'b.e11.B20TRC5CNBDRD.f09_g16.006.pop.h.SST.192001-200512.nc');
[Nino_12_007,El_Nino_12_Years_007,La_Nina_12_Years_007] = Calculate_Nino_Index_Function(-10,0,-90,-80, 'b.e11.B20TRC5CNBDRD.f09_g16.007.pop.h.SST.192001-200512.nc');
[Nino_12_008,El_Nino_12_Years_008,La_Nina_12_Years_008] = Calculate_Nino_Index_Function(-10,0,-90,-80, 'b.e11.B20TRC5CNBDRD.f09_g16.008.pop.h.SST.192001-200512.nc');
[Nino_12_009,El_Nino_12_Years_009,La_Nina_12_Years_009] = Calculate_Nino_Index_Function(-10,0,-90,-80, 'b.e11.B20TRC5CNBDRD.f09_g16.009.pop.h.SST.192001-200512.nc');
[Nino_12_010,El_Nino_12_Years_010,La_Nina_12_Years_010] = Calculate_Nino_Index_Function(-10,0,-90,-80, 'b.e11.B20TRC5CNBDRD.f09_g16.010.pop.h.SST.192001-200512.nc');
[Nino_12_013,El_Nino_12_Years_013,La_Nina_12_Years_013] = Calculate_Nino_Index_Function(-10,0,-90,-80, 'b.e11.B20TRC5CNBDRD.f09_g16.013.pop.h.SST.192001-200512.nc');
%Nino_12 = Calculate_Nino_Index_Function(-10,0,-90,-80, 'b.e11.B1850C5CN.f09_g16.005.pop.h.SST.040001-049912.nc')
% 
% 
[Nino_12_002_1,El_Nino_12_Years_002_1,La_Nina_12_Years_002_1] = Calculate_Nino_Index_Function(-10,0,-90,-80, 'b.e11.BRCP85C5CNBDRD.f09_g16.031.pop.h.SST.200601-208012.nc');
[Nino_12_003_1,El_Nino_12_Years_003_1,La_Nina_12_Years_003_1] = Calculate_Nino_Index_Function(-10,0,-90,-80, 'b.e11.BRCP85C5CNBDRD.f09_g16.032.pop.h.SST.200601-208012.nc');
[Nino_12_004_1,El_Nino_12_Years_004_1,La_Nina_12_Years_004_1] = Calculate_Nino_Index_Function(-10,0,-90,-80, 'b.e11.BRCP85C5CNBDRD.f09_g16.033.pop.h.SST.200601-208012.nc');
[Nino_12_005_1,El_Nino_12_Years_005_1,La_Nina_12_Years_005_1] = Calculate_Nino_Index_Function(-10,0,-90,-80, 'b.e11.BRCP85C5CNBDRD.f09_g16.034.pop.h.SST.200601-210012.nc');
[Nino_12_006_1,El_Nino_12_Years_006_1,La_Nina_12_Years_006_1] = Calculate_Nino_Index_Function(-10,0,-90,-80, 'b.e11.BRCP85C5CNBDRD.f09_g16.035.pop.h.SST.200601-210012.nc');
[Nino_12_007_1,El_Nino_12_Years_007_1,La_Nina_12_Years_007_1] = Calculate_Nino_Index_Function(-10,0,-90,-80, 'b.e11.BRCP85C5CNBDRD.f09_g16.101.pop.h.SST.200601-210012.nc');
[Nino_12_008_1,El_Nino_12_Years_008_1,La_Nina_12_Years_008_1] = Calculate_Nino_Index_Function(-10,0,-90,-80, 'b.e11.BRCP85C5CNBDRD.f09_g16.102.pop.h.SST.200601-210012.nc');
[Nino_12_009_1,El_Nino_12_Years_009_1,La_Nina_12_Years_009_1] = Calculate_Nino_Index_Function(-10,0,-90,-80, 'b.e11.BRCP85C5CNBDRD.f09_g16.103.pop.h.SST.200601-210012.nc');
[Nino_12_010_1,El_Nino_12_Years_010_1,La_Nina_12_Years_010_1] = Calculate_Nino_Index_Function(-10,0,-90,-80, 'b.e11.BRCP85C5CNBDRD.f09_g16.104.pop.h.SST.200601-210012.nc');
[Nino_12_013_1,El_Nino_12_Years_013_1,La_Nina_12_Years_013_1] = Calculate_Nino_Index_Function(-10,0,-90,-80, 'b.e11.BRCP85C5CNBDRD.f09_g16.105.pop.h.SST.200601-210012.nc');
% 
%Nino_3 = Calculate_Nino_Index_Function(-5,5,-150,-90, 'b.e11.B1850C5CN.f09_g16.005.pop.h.SST.040001-049912.nc')
%Nino_34 = Calculate_Nino_Index_Function(-5,5,-170,-120, 'b.e11.B1850C5CN.f09_g16.005.pop.h.SST.040001-049912.nc')
%Nino_4 = Calculate_Nino_Index_Function(-5,5,160,-170, 'b.e11.B1850C5CN.f09_g16.005.pop.h.SST.040001-049912.nc')
