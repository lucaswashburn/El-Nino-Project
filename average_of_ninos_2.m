%average_of_ninos_2
[~,idx] = sort(Number_of_Nino_Events(:,3)); % sort just the first column
Number_of_Nino_Events_list = Number_of_Nino_Events(idx,:); % sort the whole matrix using the sort indices
years_difference1 = diff(Number_of_Nino_Events_list(:,3));
years_difference2 = diff(Number_of_Nino_Events_list(:,4));

Average_Number_of_Nino_Events = [];
nino_sum = Number_of_Nino_Events_list(1,1);
counter1 = 1;
number_of_datapoints = 1;
for i = 1:length(years_difference1)
    if years_difference1(i) == 0 && years_difference2(i) == 0
        nino_sum = nino_sum + Number_of_Nino_Events_list(i+1,1);
        number_of_datapoints = number_of_datapoints + 1;
    else
        Average_Number_of_Nino_Events(counter1,:) = [nino_sum/(Number_of_Nino_Events_list(i,4)-Number_of_Nino_Events_list(i,3)+1)/number_of_datapoints, Number_of_Nino_Events_list(i,3), Number_of_Nino_Events_list(i,4)];
        nino_sum = Number_of_Nino_Events_list(i+1,1); 
        counter1 = counter1 + 1;
        number_of_datapoints = 1;
    end
end 
Average_Number_of_Nino_Events(counter1,:) = [nino_sum/(Number_of_Nino_Events_list(i,4)-Number_of_Nino_Events_list(i,3)+1)/number_of_datapoints, Number_of_Nino_Events_list(i,3), Number_of_Nino_Events_list(i,4)];

