function [rval] = parse_int16_v1(hex)

%S. Krug
% 1/11/24

j = 1;
if isempty(hex(1:2)) %This ends up not being necessary because asm converter doesn't use parse_int16 with no size
    rval = 0;
end

if hex(1:2) == '0x'

    hex = hex(3:end);

    while length(hex)>= 4 %hex is 12 characters long now

        unsigned = hex2dec(hex(1:2)) + hex2dec(hex(3:4))*256;

        if unsigned < 32768

            rval(1,j) = unsigned;
        else
            rval(1,j) = unsigned - 65536;
        end

        hex = hex(5:end);
        j = j + 1;

    end

end