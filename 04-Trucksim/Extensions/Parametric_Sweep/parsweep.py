# Pre- and post-processing example
# Tested/intended for using with VS Browser on Windows
# Mechanical Simulation Corporation
# June 2022

import os
import shutil

# Read simfile to get simulation information.
with open("simfile.sim") as f:
    lines = f.readlines()
for line in lines:
    if "SET_MACRO $(ROOT_FILE_NAME)$" in line:
        root_file_name = line.split()[2]
    elif "INPUT " in line:
        input = line.replace("INPUT", "").strip()
    elif "PROGDIR" in line:
        progdir = line.replace("PROGDIR", "").strip()
    elif "DATADIR" in line:
        datadir = line.replace("DATADIR", "").strip()
vs_solver_wrapper = progdir+"Programs\\VS_SolverWrapper_CLI_64.exe"
base_run_all = input.replace("$(ROOT_FILE_NAME)$", root_file_name)

# Read Run_all.par to get information about the parametric sweep.
with open(base_run_all) as f:
    lines = f.readlines()
for line in lines:
    if "DEFINE_PARAMETER PARSWEEP_VAR" in line:
        parsweep_var = line.split(";")[2].strip()
    elif "DEFINE_PARAMETER PARSWEEP_MIN" in line:
        parsweep_min = float(line.split(";")[0].split()[-1])
    elif "DEFINE_PARAMETER PARSWEEP_MAX" in line:
        parsweep_max = float(line.split(";")[0].split()[-1])

# Set the number of variants between min and max.
# WARNING: You can adjust the number of variants, but you must also adjust the
# vehicle colors, and vehicle colors may no longer match the plot colors.
n_variants = 6
run_col = ["0 0 0", "0.6 1 0.2", "0.6 0.6 0.6", "0 0.4 0", "0.8 0 0", "0 0 1"]
parsweep_step = (parsweep_max-parsweep_min)/(n_variants-1)
        
# Create results directory
results_dir = "Extensions\\Parametric_Sweep\\Results\\"
if os.path.exists(results_dir):
    shutil.rmtree(results_dir)
os.makedirs(results_dir)

# Loop through variants, performing the following tasks:
#   - Create Run_all.par
#   - Set parameter/color/title
#   - Run using VS Solver Wrapper
#   - Add information to the animator.par
run_all = []
vs = []
animator = ["PARSFILE\n"]
animator.append("SEARCH_PATH APPEND ."+"\n")
animator.append("SEARCH_PATH_APPEND "+datadir+"\n")
animator.append("SEARCH_PATH_APPEND "+progdir+"\n")
animator.append("SEARCH_PATH_APPEND "+progdir+"Resources\n")
for ii in range(n_variants):
    parsweep_val = str(parsweep_min + ii*parsweep_step)
    run_num = str(format(ii+1, "02d"))
    run_all.append(results_dir+"Run_"+run_num+"_all.par")
    vs.append(results_dir+"Run_"+run_num+".vs")
    f = open(run_all[ii], "w")
    for line in lines:
        if (parsweep_var.split("(")[0] in line and
            "DEFINE_PARAMETER PARSWEEP_VAR" not in line and
            "DATASET_TITLE" not in line):
            line_out = line+parsweep_var+" "+parsweep_val+"\n"
        elif "USE_RUN_COLOR" in line:
            line_out = "USE_RUN_COLOR\nSET_COLOR "+run_col[ii]+"\n"
        elif "DATASET_TITLE" in line:
            line_out = "DATASET_TITLE "+parsweep_var+" = "+parsweep_val+"\n"
        else:
            line_out = line
        f.write(line_out)
    f.close()
    print("\nRunning with "+parsweep_var+" = "+parsweep_val+"\n")
    os.system("\""+vs_solver_wrapper+"\" -par "+run_all[ii])
    
    animator.append("SET_RUN_SLOT "+str(ii)+"\n") 
    animator.append("DATASET "+datadir+vs[ii]+"\n")
    animator.append("PARSFILE "+datadir+run_all[ii]+"\n")
animator.append("END")

# Write the animator.par
f = open(results_dir+"animator.par", "w")
for line in animator:
    f.write(line)
f.close()

# VS Visualizer instructions
post_wrapper = (progdir+
  "Programs\\VsVisualizer\\VsVisualizer64\\VsVisualizer.exe "+
  "-c SGUI_Post_aniplot.ini -uimode aniplot "+
  "-i \"Parametric Sweep of "+parsweep_var+"\" "+
  "\""+datadir+results_dir+"animator.par\"")

# Create the post-run wrapper which launches VS Visualizer to show results
f = open(results_dir+"view_results.bat", "w")
for line in post_wrapper:
    f.write(line)
f.close()
