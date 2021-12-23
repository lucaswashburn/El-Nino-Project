A=[Nino_12_002,Nino_12_003,Nino_12_004,Nino_12_005,Nino_12_006,Nino_12_007,Nino_12_008,Nino_12_009,Nino_12_010,Nino_12_013]
averages = mean(A,2);
time = ncread('b.e11.B20TRC5CNBDRD.f09_g16.013.pop.h.SST.192001-200512.nc','time');
%use a sample data set to find the time
Nino_averages_timeseries = timeseries(averages,time);
Nino_averages_timeseries.Name = 'Nino 1+2 Index SST vs. Time';
Nino_averages_timeseries.TimeInfo.Units = 'days';
Nino_averages_timeseries.TimeInfo.StartDate = 0000-01-01;     % Set start date.
Nino_averages_timeseries.TimeInfo.Format = 'yyyy';       % Set format for display on x-axis.
       % Express time relative to the start date.
figure;
plot(Nino_averages_timeseries)

figure;
hold on
plot(Nino_12_002);
plot(Nino_12_003);
plot(Nino_12_004);
plot(Nino_12_005);
plot(Nino_12_006);
plot(Nino_12_007);
plot(Nino_12_008);
plot(Nino_12_009);
plot(Nino_12_010);
plot(Nino_12_013);
axis([250 350 -3 5])