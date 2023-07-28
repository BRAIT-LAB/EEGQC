%% "Script for running the funtion "simulatedData_generation_with_volume_conduction"
% Created on  Apr 19 2019
% Modified on Apr  8 2021

%1 Load real data for AR coefficients
%       The real sources provided in the structure sLOR_cortical_sources come from
%       resting state EEG recorded on healthy subjects, recontructed in the
%       source domain emploing the algorithm sLORETA[1]. 
%
%       Instruction for the user:
%       - sLOR_cortical_sources (or ECoG signals)
%       - specify the directory
%       - if a different read dataset is preferred, be sure to organize it
%       as 'samples x channels x trials' (trials can be equal to 1)
clear all; clc;
% mkdir('E:\BCI\my_workplace\icoh\ft_test1\data200\',['data' num2str(i)]);
% data_path = ['E:\BCI\my_workplace\icoh\ft_test1\data200\' 'data' num2str(i) '\'];
% mkdir('E:\BCI\PaLOS-source-analysis-by-SEED-G\data');
data_path = 'E:\BCI\PaLOS-source-analysis-by-SEED-G\data\';
datadir   = 'E:\BCI\PaLOS-source-analysis-by-SEED-G\real data';
name      = 'sLOR_cortical_sources.mat'; %125samples x 65dipoles x 130realizations
Struct    = loadname(fullfile(datadir,name));

%2 Set parameters
DataLength =    2500;
Trials =        1;
ModelDel =      [];
SNR =           10;
sig_num =       15;
density =       0.3;
% density =       0.1;
val_Range =     [-0.5 0.5];
AR_perc =       0.5;
AR_choice =     1;
popt =          10;

%3. Specify if the data should be projected on the scapl after the
%        generation
forward = 1;
%       1 for forward problem solution
%       0 otherwise (no prjection in the sensor space)

% If you select forwar = 1 --> please specify channel labels and ROI labels
% 3.1 Specify list of electrodes for forward model
    sensors_labels = {'Fp1' 'Fpz' 'Fp2' 'F5' 'Fz' 'F6' 'C5' 'Cz' 'C6' 'P5' 'Pz' 'P6' 'O1' 'Oz' 'O2'}; % Example with 15 channels
%3.2 ROI selection
    %   Each generated signal will be located on the brain cortex according to
    %   the provided list of ROIs labels
    ROI_labels = {'Brodmann.1 L' 'Brodmann.10 L' 'Brodmann.18 R' 'Brodmann.19 L' 'Brodmann.2 R' 'Brodmann.21 L' 'Brodmann.22 R' 'Brodmann.38 L' 'Brodmann.40 L' 'Brodmann.44 L' 'Brodmann.47 R' 'Brodmann.6 R' 'Brodmann.7 R' 'Brodmann.8 L' 'Brodmann.9 R'};
    if length(ROI_labels)~=sig_num
        error('The number of ROI lables must be equal to the number of generated signals.')
    end
%3.3 path for dependencies NYH and Fieldtrip
nyh_path = 'E:\BCI\PaLOS-source-analysis-by-SEED-G\dependencies\NYH'; 
ft_path = 'E:\BCI\PaLOS-source-analysis-by-SEED-G\dependencies\Fieldtrip'; 

[Y_gen, E_gen, ModelDel, flag_out]=data_simulation(DataLength,...
    Trials,ModelDel,SNR,Struct.samp,sig_num,density,val_Range,AR_perc,AR_choice,popt,forward,sensors_labels,ROI_labels,nyh_path,ft_path,data_path);
