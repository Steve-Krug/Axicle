%csv_separator_vtti_v1.m
clear
close all
clc

file = 'C:\Users\slkru\OneDrive - Axicle\Public\9. Data\VTTI Truck IMU Data\Initial Data\Combined\4238451through7161900.csv';
% combined files:
% 474805through1945933.csv done
% 1973086through4225122.csv done
% 4238451through7161900.csv done
csvData = readtable(file);

%Format of columns is: (file_id, timestamp, variableID, data value)

%Sort rows of entire matrix "data" based on values in 1st column, which are
%the discrete runs, then bin them

dataSorted = sortrows(csvData, 1);
index1 = 1;
startIndex = 1;

for i = 2:length(dataSorted.FILE_ID)

    newCSV = dataSorted.FILE_ID(i);
    oldCSV = dataSorted.FILE_ID(i-1);

    if newCSV == oldCSV
        index1 = index1 + 1;

        %save scraped dataset as csv file with file_id as name
    else
        writetable(dataSorted(startIndex:index1,:),...
            'C:\Users\slkru\OneDrive - Axicle\Public\9. Data\VTTI Truck IMU Data\Initial Data\Separated\'...
            + string(dataSorted.FILE_ID(i-1)) +  '.csv');

        
        %index1 = 0;
        startIndex = index1+1;

    end
i/length(dataSorted.FILE_ID)
end