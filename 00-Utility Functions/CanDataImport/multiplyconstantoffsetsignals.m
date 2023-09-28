function [ newdataset ] = multiplyconstantoffsetsignals( data, strings, offset )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
indexesofsignalresults = getindexofsignalusingsignalname(data,strings);
fldnames=fieldnames(data);
for i=1:length(indexesofsignalresults)
data.(cell2mat(fldnames(indexesofsignalresults(i))))(:,2) = data.(cell2mat(fldnames(indexesofsignalresults(i))))(:,2)*offset(i);
end
newdataset=data;

end

