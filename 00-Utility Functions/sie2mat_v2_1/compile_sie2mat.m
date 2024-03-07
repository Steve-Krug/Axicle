clear all
close all
clc
%{
compile_sie2mat can be used to compele the sie2mat mex function.
1 - Download the latest sie2mat.cpp code 
        (located in the source_code folder). 
2 - Download the latest libsie and libapr libaries
        ( located in the lib folder - all files in the x86/x64 subfolder)
3 - Make sure that the source code and the necessary libaries are in the
same folder.
3 - Run this code
%}

%% compile sie2mat
mex sie2mat.cpp libsie.lib libapr-1.lib
clear mex

%% test sie2mat
file2read='example.sie';
data=sie2mat(file2read);
clear mex

    