function [col] = findIndexCol(indexraw,columnname)
% Returns column number given a heading row name
% Returns 0 if column not found
col = 1;
while col <= size(indexraw,2) && ~strcmp(indexraw{1,col},columnname)
    col = col+1;
end
if col > size(indexraw,2)
    col = 0;
end