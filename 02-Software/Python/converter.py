import sys
import glob
import argparse 

parser = argparse.ArgumentParser( 
    prog='FarProbe/Axicle/Board1/Stream/Parser',
    description='Convert Streaming log - RP2040 misuse as system/CPU',
    epilog='FarProbe Tools: (C) FarProbe Inc.',
)

parser.add_argument('filename')
parser.add_argument('-p', '--progress', action='store_true') 
parser.add_argument('-o', '--output') 

args = parser.parse_args() 

stdout_fileno = sys.stdout


if args.progress:
    from tqdm import tqdm
else:
    tqdm = lambda x: x


fn = args.filename 

data_raw=[]

def parse_int16(hex):
    if hex[0:2] == "  ": 
        return [] 
    if hex[0:2] == "0x":
        hex = hex[2:] 

    rval = []
    while len(hex)>=4:
        unsigned = int(hex[0:2], 16) + int(hex[2:4],16) * 256
        rval.append(unsigned if unsigned < 32768 else unsigned - 65536)
        hex = hex[4:]

    #print (hex, rval)
    return rval 


gyros=[-1, -1, -1] 
xls=[-1, -1, -1] 

if args.output: 
    if args.output != '-':
        sys.stdout = open(args.output, 'w') 
else: 
    sys.stdout = open(fn+'.csv', 'w')

with open(fn) as f:
    for i, line in tqdm(enumerate(f)):
        if len(line) != 79: 
            # Debug statements.. shitty heuristic but OK for now
            continue

        # print (i, line, len(line))

        ts = line[1:13] 

        sts = int(ts[0:2]) * 3600 + int(ts[3:5]) * 60 + float(ts[6:])
        
        line = line[15:]
        
        status_reg = line[6:10]

        gyro_reg = line[23:37]

        xlr_reg = line[49:63]
        
        # print (i, status_reg, gyro_reg, xlr_reg)

        
        dps = 2000
        if gyro_reg[0] != ' ':
            gyros = [float(s)*dps/32768 for s in parse_int16(gyro_reg)]
        
        xlm = 8
        if xlr_reg[0] != ' ':
            xls = [float(s)*xlm/32768 for s in parse_int16(xlr_reg)]
        print (f"{i},{sts},{int(status_reg,16)},{','.join(str(g) for g in gyros)},{','.join(str(g) for g in xls)}") 


        data_raw.append([sts, gyros[0], gyros[1], gyros[2], xls[0], xls[1], xls[2]])
        if i > 15:
            #break 
            pass

sys.stdout = stdout_fileno
