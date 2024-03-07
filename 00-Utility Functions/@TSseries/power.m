function [out] = power(A,B)
%POWER Is an overload of the power function

    out = A;
    out.Data = out.Data.^B;

end

