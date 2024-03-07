function array = arrayOfStr2Array(arrayofstruct,fieldname)
array = zeros(length(arrayofstruct),1);
for i = 1:length(arrayofstruct)
    try
        array(i) = eval(['arrayofstruct(i).' fieldname]);
    catch
        array(i) = eval(['arrayofstruct(i).' fieldname '(1)']); % Take first element of a vector result (e.g., filterA)
    end
end