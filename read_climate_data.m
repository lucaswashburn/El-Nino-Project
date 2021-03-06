clear;
close all;

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

Nino_12_avgs = [];


Monthly_Data_Matrix = [];

%permute, in order for x and y coordinates to be the right side up

%x-axis: 1° = 0.888888 data points
%y-axis: 1° = 2.133333 data points

%Niño 1+2 (0-10S, 90W-80W):


% 
% lat0 = -10
% lat1 = 0
% long0 = Convert_to_360_longitude(-90)
% long1 = Convert_to_360_longitude(-80)
% 
% 
% 
% %bottom left coordinates
% [m,long_coord] = min(abs(TLONG(1,:)-long0));
% [m,lat_coord] = min(abs(TLAT(:,long_coord)-lat0));
% coord00 = [long_coord, lat_coord]
% 
% %top left coordinates
% [m,long_coord] = min(abs(TLONG(1,:)-long0));
% [m,lat_coord] = min(abs(TLAT(:,long_coord)-lat1));
% coord01 = [long_coord, lat_coord]
% 
% %top right coordinates
% [m,long_coord] = min(abs(TLONG(1,:)-long1));
% [m,lat_coord] = min(abs(TLAT(:,long_coord)-lat1));
% coord11 = [long_coord, lat_coord]
% 
% %bottom right coordinates
% [m,long_coord] = min(abs(TLONG(1,:)-long1));
% [m,lat_coord] = min(abs(TLAT(:,long_coord)-lat0));
% coord10 = [long_coord, lat_coord]
% 

%% mask method setup

latmin = -10
latmax = 0
longmin = Convert_to_360_longitude(-90)
longmax = Convert_to_360_longitude(-80)

mask = ones(size(TAREA)); 

mask(TLAT < latmin) = nan; 
mask(TLAT > latmax) = nan; 
mask(TLONG > longmax) = nan; 
mask(TLONG < longmin) = nan;

%1's and 0's, the 0's are the masked values
mask10 = ~isnan(mask);

%%
% test

% for counter = 1:size(T,4)
%     
%     surface = T(:,:,1,counter);
%     temperatures_permuted = permute(surface,[2 1]);               
%     %pcolor(temperatures_permuted(:,:));
%     %shading flat;
% 
%     Nino_12_temperatures = temperatures_permuted([coord00(2):coord11(2)],[coord00(1):coord11(1)]);
%     Nino_12_areas = TAREA([coord00(2):coord11(2)],[coord00(1):coord11(1)]);
%     Nino_12_avgs(counter,1) = time_matrix(counter, 1);
%     %find weighted mean
%     Nino_12_avgs(counter,2) = sum(Nino_12_temperatures.*Nino_12_areas,'all','omitnan')/sum(Nino_12_temperatures./Nino_12_temperatures.*Nino_12_areas,'all','omitnan');
%     Nino_12_avgs(counter,3) = counter;
%     
%     %get data by month
%     Monthly_Data_Matrix(time_matrix(counter, 2),time_matrix(counter, 1) + 1 - time_matrix(1,1),1) = Nino_12_avgs(counter,2);
% 
% end

surface = T(:,:,1,:);
temperatures_permuted = permute(surface,[2 1 4 3]);
Nino_12_temperatures = bsxfun(@times,temperatures_permuted,mask10);
%Nino_12_temperatures = temperatures_permuted([coord00(2):coord11(2)],[coord00(1):coord11(1)],:);
%Nino_12_areas = TAREA([coord00(2):coord11(2)],[coord00(1):coord11(1)]);


%mask = ~isnan(Nino_12_temperatures(:,:,1)); 
denom = nansum(mask10.*TAREA,[1 2]);

Nino_12_avgs = squeeze(nansum(bsxfun(@times,Nino_12_temperatures,mask10.*TAREA),[1 2]))/denom; 


%replace with better solution
% for counter = 1:size(T,4)
%     Monthly_Data_Matrix(time_matrix(counter, 2),time_matrix(counter, 1) + 1 - time_matrix(1,1),1) = Nino_12_avgs(counter);
% end

Monthly_Data_Matrix = reshape(Nino_12_avgs,[12,100]);

%calculate monthly averages
monthly_averages = nanmean(Monthly_Data_Matrix,2);

%calculate monthly averages
% for month_number = 1:12
%     monthly_averages(month_number) = sum(Monthly_Data_Matrix(month_number,:))/length(nonzeros(Monthly_Data_Matrix(month_number,:)));
% end

%calculate anomaly
% for month_number = 1:12
%     for year_number = 1:time_matrix(size(time),1) + 1 - time_matrix(1,1);
%         if Monthly_Data_Matrix(month_number,year_number,1) ~= 0
%             Monthly_Data_Matrix(month_number,year_number,2) = Monthly_Data_Matrix(month_number,year_number,1) - monthly_averages(month_number);
%         end
%     end
% end



% for counter = 1:size(T,4)
%     month_number = time_matrix(counter,2)
%     %calculate anomaly
%     Nino_12_avgs(counter,4) = Nino_12_avgs(counter,2) - monthly_averages(month_number);
%     
% end

Anomaly  = bsxfun(@minus,Monthly_Data_Matrix,monthly_averages);
Anomaly_reshaped = reshape(Anomaly, [1200,1]);

% fatmatrix(:,1) = [1/0; 1/0; Nino_12_avgs(1:length(Nino_12_avgs)-2)];
% fatmatrix(:,2) = [1/0; Nino_12_avgs(1:length(Nino_12_avgs)-1)];
% fatmatrix(:,3) = [Nino_12_avgs];
% fatmatrix(:,4) = [Nino_12_avgs(2:length(Nino_12_avgs)); 1/0];
% fatmatrix(:,5) = [Nino_12_avgs(3:length(Nino_12_avgs)); 1/0; 1/0];

% NaN = std(1/0,2,1)


%%
% fatmatrix(:,1) = [NaN; NaN; Anomaly_reshaped(1:length(Anomaly_reshaped)-2)];
% fatmatrix(:,2) = [NaN; Anomaly_reshaped(1:length(Anomaly_reshaped)-1)];
% fatmatrix(:,3) = [Anomaly_reshaped];
% fatmatrix(:,4) = [Anomaly_reshaped(2:length(Anomaly_reshaped)); NaN];
% fatmatrix(:,5) = [Anomaly_reshaped(3:length(Anomaly_reshaped)); NaN; NaN];

Nino_12_smoothed = movmean(Anomaly_reshaped,[2 2]); 

% Nino_12_smoothed = nanmean(fatmatrix,2)

%%

Nino_12_smoothed_STDEV = std(Nino_12_smoothed);

%normalized for standard deviation
Nino_12_normalized = Nino_12_smoothed./Nino_12_smoothed_STDEV

% %Niño 3 (5N-5S, 150W-90W): 
% lat5N = 183;
% lat5S = 161;
% long90W = 275;
% long150W = 222;
% 
% Nino_3 = surface_permuted([lat5S:lat5N],[long150W:long90W]);
% Nino_3_avgs(counter,1) = counter;
% Nino_3_avgs(counter,2) = mean(Nino_3,'all','omitnan');
% 
% %Niño 3.4 (5N-5S, 170W-120W):
% lat5N = 183;
% lat5S = 161;
% long120W = 248;
% long170W = 204;
% 
% Nino_34 = surface_permuted([lat5S:lat5N],[long170W:long120W]);
% Nino_34_avgs(counter,1) = counter;
% Nino_34_avgs(counter,2) = mean(Nino_34,'all','omitnan');
% 
% %Niño 4 (5N-5S, 160E-150W): 
% lat5N = 183;
% lat5S = 161;
% long161E = 177;
% long150W = 222;
% 
% Nino_4 = surface_permuted([lat5S:lat5N],[long161E:long150W]);
% Nino_4_avgs(counter,1) = counter;
% Nino_4_avgs(counter,2) = mean(Nino_4,'all','omitnan');







figure;
hold on;
plot(time_matrix(:,1,1,1),Nino_12_normalized)
fplot(0, [time_matrix(1,1),time_matrix(length(time),1)]);
title('Nino 1+2 Index SST vs. Time')
ylabel('Standard Deviations from Monthly Climatological SST')
xlabel('year')


% figure;
% plot(Nino_3_avgs(:,1),Nino_3_avgs(:,2))
% title('Nino 3 Index SST vs. Time')
% ylabel('Sea Surface Temperature (°C)')
% figure;
% plot(Nino_34_avgs(:,1),Nino_34_avgs(:,2))
% title('Nino 3.4 Index SST vs. Time')
% ylabel('Sea Surface Temperature (°C)')
% xlabel('time in months')
% figure;
% plot(Nino_4_avgs(:,1),Nino_4_avgs(:,2))
% title('Nino 4 Index SST vs. Time')
% ylabel('Sea Surface Temperature (°C)')
