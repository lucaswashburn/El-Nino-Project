
sum_now = 0;
sum_future = 0;
firstyear = 2;
lastyear = 9;


for i = firstyear:lastyear
    El_BaseName='El_Nino_12_Years_00';
    El_FileName=[El_BaseName,num2str(i)];
    BaseName='Nino_12_00';
    FileName=[BaseName,num2str(i)];
    sum_now = sum_now + length(eval(El_FileName))/length(eval(FileName))/(lastyear-firstyear)*12;
end
%sum_now is the frequency of el nino events, unit is 1/year

for i = firstyear:lastyear
    El_BaseName='El_Nino_12_Years_00';
    El_FileName=[El_BaseName,num2str(i),'_1'];
    BaseName='Nino_12_00';
    FileName=[BaseName,num2str(i),'_1'];
    sum_future = sum_future + length(eval(El_FileName))/length(eval(FileName))/(lastyear-firstyear)*12;
end
%sum_future is the frequency of el nino events, unit is 1/year