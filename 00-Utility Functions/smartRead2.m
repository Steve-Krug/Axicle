function knc_plot_def = smartRead2(fname)
% Function to Load KnC Plot Definitions in to MATLAB structure
% inputs determined by .csv files
%Inputs
% name of csv file with inputs


% Use csvread (which can only read numbers) to get the size of the csv
% Use the scale colummn because that is the only all numeric col
plot_num = size(csvread(fname, 1, 13), 1);

% Load .csv file data
fid = fopen(fname);
knc_plot_def = struct;
C = readtable(fname);
C=table2cell(C);
%C=table2array(C);
knc_plot_def.grp_chan=C(:,1:8);
knc_plot_def.grp_title=C(:,9:12);
knc_plot_def.grp_xfit_unit=C(:,13);
knc_plot_def.grp_xlim=cell2mat(C(:,14:15));
knc_plot_def.grp_ylim=cell2mat(C(:,16:23));
knc_plot_def.grp_xfitr=cell2mat(C(:,24:25));
knc_plot_def.grp_xfito=cell2mat(C(:,26));
knc_plot_def.grp_xtab_step=cell2mat(C(:,27));
knc_plot_def.grp_xfit_scale=cell2mat(C(:,28:29));

fclose(fid);
clear C;

end