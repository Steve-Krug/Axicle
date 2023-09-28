function [out] = percentChange(in,newcol,oldcol,rowindex)
if abs(in(rowindex,oldcol)) < 0.0001
    out = NaN;
else
    out = (in(rowindex,newcol) - in(rowindex,oldcol))./in(rowindex,oldcol)*100;
end