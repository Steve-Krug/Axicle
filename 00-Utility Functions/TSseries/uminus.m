function [out] = uminus(in)
%UMINUS Is an overload of the uminus function for DMT series

    out = in;
    out.Data = -1.*out.Data;

end

