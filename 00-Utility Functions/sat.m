function out=sat(in,bd);

maximum=max(bd);
minimum=min(bd);

out=in;
if in>maximum
    out=maximum;
end
if in<minimum
    out=minimum;
end
    