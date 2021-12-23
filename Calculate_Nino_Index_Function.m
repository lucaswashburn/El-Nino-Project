function [Nino_final,El_Nino_Years,La_Nina_Years] = Calculate_Nino_Index_Function(latmin,latmax,longmin_180,longmax_180, filename)

cd ~/Downloads/
%ncdisp(filename);

cd /Users/lucaswashburn/github/El-Nino-Project

T = ncread(filename,'SST');
time = ncread(filename,'time');
TAREA = ncread(filename,'TAREA')';
TLAT = ncread(filename,'TLAT')';
TLONG =  ncread(filename,'TLONG')';


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
Monthly_Data_Matrix = reshape(Nino_avgs,[12,time_matrix(end,1)-time_matrix(1,1)]);

%calculate monthly averages
monthly_averages = nanmean(Monthly_Data_Matrix,2);

% calculate anomaly
Anomaly  = bsxfun(@minus,Monthly_Data_Matrix,monthly_averages);
Anomaly_reshaped = reshape(Anomaly, [length(time),1]);

%take 5-month running mean
Nino_smoothed = movmean(Anomaly_reshaped,[2 2]); 

%%
%calculate the
Nino_smoothed_STDEV = std(Nino_smoothed);

%normalized for standard deviation
Nino_final = Nino_smoothed./Nino_smoothed_STDEV;





Nino_timeseries = timeseries(Nino_final,time);

Nino_timeseries.Name = 'Nino 1+2 Index SST vs. Time';
Nino_timeseries.TimeInfo.Units = 'days';
Nino_timeseries.TimeInfo.StartDate = 0000-01-01;     % Set start date.
Nino_timeseries.TimeInfo.Format = 'yyyy';       % Set format for display on x-axis.
       % Express time relative to the start date.

%figure;
%plot(Nino_timeseries)

Nino_Years_Matrix = zeros(length(Nino_final),3);

signofIndex = 0;
NinoLengthCounter = 0;
i_initial = 1;

for i = 1:length(Nino_final)
    %figure out what happens on first case
    signEquivalenceTest = signofIndex;
    switch sign(Nino_final(i))
        case 1
            signofIndex = 1;
        otherwise
            signofIndex = -1;
    end
    
    if signEquivalenceTest ~= signofIndex
        Nino_strength = -1*signofIndex*max(abs(Nino_final(i_initial:i)));
        Nino_Years_Matrix(i,:) = [Nino_strength,i_initial,i];
        
        NinoLengthCounter = 0;
        i_initial = i;
    end
end

El_Nino_Years = [];
La_Nina_Years = [];

i=0;

for i = 1:length(Nino_final)
    if Nino_Years_Matrix(i,1) > 2
        El_Nino_Years = [El_Nino_Years; Nino_Years_Matrix(i,:)];
    elseif Nino_Years_Matrix(i,1) < -2
        La_Nina_Years = [La_Nina_Years; Nino_Years_Matrix(i,:)];
    end
end

% Localmaxes = bsxfun(@times,Nino_final,islocalmax(Nino_final,1))
% Localmins = bsxfun(@times,Nino_final,islocalmin(Nino_final,1))
% 
% q = find(Nino_final > 2);
% Nino_positive = Nino_final(Nino_final > 0)
% 
% %a = find(x(1:end-1)>0 & x(2:end) < 0);

Nino_final;
El_Nino_Years;
La_Nina_Years;
% figure;
% hold on;
% plot(time_matrix(:,1,1,1),Nino_final)
% fplot(0, [time_matrix(1,1),time_matrix(length(time),1)]);
% title('Nino 1+2 Index SST vs. Time')
% ylabel('Standard Deviations from Monthly Climatological SST')
% xlabel('year')


