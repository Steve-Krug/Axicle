function [ dataindexes ] = getindexofsignalusingsignalname( datastructure, signames )
%this function searches a structure for data signals given string inputs of
%their names. it returns the index of every signal which contains at least
%one of the string inputs
fldnames = fieldnames(datastructure);
fldnumber = length(fldnames);
if isa(signames,'struct')|| isa(signames,'cell')
stringnumbers=length(signames);
signamestruct = signames;
elseif isa(signames,'char') 
    stringnumbers = 1;
    signamestruct{1}=signames;
else
    fprintf('error, invalid input')
    return
end
    k=1;
    flag=0;
    dataindexes = [];
for j=1:stringnumbers %for every string to check
    for i = 1 : fldnumber %check every field in the structure
        if strncmpi(fldnames(i),signamestruct{j},length(signamestruct{j}))==1 %if the current string exists in the current field
            for z=1:k-1 %check existing dataindexes to be sure you don't duplicate one
                if dataindexes(z)==i 
                    flag=1;
                    break
                end
            end
            if flag~=1
            dataindexes(k)= i; 
            k=k+1;
            end
        end
    end
end

end

