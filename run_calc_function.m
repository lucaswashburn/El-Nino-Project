clear;
close all;


Nino_12 = Calculate_Nino_Index_Function(-10,0,-90,-80, 'b.e11.B1850C5CN.f09_g16.005.pop.h.SST.040001-049912.nc')
% 
% figure;
% hold on;
% plot(time_matrix(:,1,1,1),Nino_12)
% fplot(0, [time_matrix(1,1),time_matrix(length(time),1)]);
% title('Nino 1+2 Index SST vs. Time')
% ylabel('Standard Deviations from Monthly Climatological SST')
% xlabel('year')


% Nino_3 = Calculate_Nino_Index_Function(-5,5,-150,-90)
% Nino_34 = Calculate_Nino_Index_Function(-5,5,-170,-120)
% Nino_4 = Calculate_Nino_Index_Function(-5,5,160,-170)
