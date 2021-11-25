function [Nino_final,time_matrix] = Calculate_Nino_Index_Function(latmin,latmax,longmin_180,longmax_180)

cd ~/Downloads/
ncdisp('b.e11.B1850C5CN.f09_g16.005.pop.h.SST.040001-049912.nc');

cd /Users/lucaswashburn/github/El-Nino-Project

T = ncread('b.e11.B1850C5CN.f09_g16.005.pop.h.SST.040001-049912.nc','SST');
time = ncread('b.e11.B1850C5CN.f09_g16.005.pop.h.SST.040001-049912.nc','time');
TAREA = ncread('b.e11.B1850C5CN.f09_g16.005.pop.h.SST.040001-049912.nc','TAREA')';
TLAT = ncread('b.e11.B1850C5CN.f09_g16.005.pop.h.SST.040001-049912.nc','TLAT')';
TLONG =  ncread('b.e11.B1850C5CN.f09_g16.005.pop.h.SST.040001-049912.nc','TLONG')';

%T Grid defines points from center of each square
time_matrix = datevec(time);
size(T);

Nino_avgs = [];

Monthly_Data_Matrix = [];


%% mask method setup

%latmin is input
%latmax is input
longmin = Convert_to_360_longitude(longmin_180)
longmax = Convert_to_360_longitude(longmax_180)

mask = ones(size(TAREA)); 

mask(TLAT < latmin) = nan; 
mask(TLAT > latmax) = nan; 
mask(TLONG > longmax) = nan; 
mask(TLONG < longmin) = nan;

%1's and 0's, the 0's are the masked values
mask10 = ~isnan(mask);

%%

surface = T(:,:,1,:);
temperatures_permuted = permute(surface,[2 1 4 3]);
Nino_temperatures = bsxfun(@times,temperatures_permuted,mask10);


%mask = ~isnan(Nino_12_temperatures(:,:,1)); 
denom = nansum(mask10.*TAREA,[1 2]);

Nino_avgs = squeeze(nansum(bsxfun(@times,Nino_temperatures,mask10.*TAREA),[1 2]))/denom; 

% group by month
Monthly_Data_Matrix = reshape(Nino_avgs,[12,100]);

%calculate monthly averages
monthly_averages = nanmean(Monthly_Data_Matrix,2);

% calculate anomaly
Anomaly  = bsxfun(@minus,Monthly_Data_Matrix,monthly_averages);
Anomaly_reshaped = reshape(Anomaly, [1200,1]);

%take 5-month running mean
Nino_smoothed = movmean(Anomaly_reshaped,[2 2]); 

%%
%calculate the
Nino_smoothed_STDEV = std(Nino_smoothed);

%normalized for standard deviation
Nino_final = Nino_smoothed./Nino_smoothed_STDEV;


figure;
hold on;
plot(time_matrix(:,1,1,1),Nino_final)
fplot(0, [time_matrix(1,1),time_matrix(length(time),1)]);
title('Nino 1+2 Index SST vs. Time')
ylabel('Standard Deviations from Monthly Climatological SST')
xlabel('year')


