function [ outputvector ] = subtractfromsignalswhennegative( inputvector )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
mphmaxval=16*180;
mphtolerance = 0.15;
grademaxval = 16*1;
gradetolerance=0.02;
torquemaxval = 16*700;
torquetolerance = 0.1;
yawratemaxval = 16;
yawratetolerance = 0.05;
maxval=max(inputvector);
outputvector=inputvector;
risingedgedetected=0;

if (abs(maxval-grademaxval)<(gradetolerance*grademaxval))...
        ||(abs(maxval-mphmaxval)<(mphtolerance*mphmaxval))...
        || (abs(maxval-torquemaxval)<(torquetolerance*torquemaxval))...
        || (abs(maxval-yawratemaxval)<(yawratetolerance*yawratemaxval))
    subtractnum=maxval;
else
    subtractnum=0;
end
        
for i=1:length(inputvector)
    if length(num2str(inputvector(i),25))>2 %if not a clean integer or enum
        if (inputvector(i)< (maxval/2))
        risingedgedetected=0;
        end
        if (i == 1) && ((abs(inputvector(i)) - subtractnum) < gradetolerance)
                risingedgedetected=1;
        end
        if i>1
            if ((inputvector(i)> (maxval/2)) && (inputvector(i-1)<(maxval*0.02))) ||(risingedgedetected==1)
                risingedgedetected=1;
                outputvector(i)=inputvector(i)-subtractnum;
            end
        end
    else
        risingedgedetected=0;
    end     
end
end


