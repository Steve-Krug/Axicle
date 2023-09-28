function [ newdataset ] = findandfixbrokennegativesignals( data,strings )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
indexesofsignalresults = getindexofsignalusingsignalname(data,strings);
fldnames=fieldnames(data);
for i=1:length(indexesofsignalresults)
data.(cell2mat(fldnames(indexesofsignalresults(i))))(:,2) = subtractfromsignalswhennegative(data.(cell2mat(fldnames(indexesofsignalresults(i))))(:,2));
end
newdataset=data;
end

