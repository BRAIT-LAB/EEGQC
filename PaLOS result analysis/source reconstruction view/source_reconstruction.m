    clear;clc;
    load('E:\BCI\fieldtrip-master\Subject01\headmodel.mat');
    load('E:\BCI\fieldtrip-master\Subject01\Subject01_sourcemodel_15684.mat');
    cfg = [];
    cfg.dataset = 'clean.set';
    data = ft_preprocessing(cfg);
    elec = data.elec;
    
    cfg           = [];
    cfg.method    = 'interactive';
    cfg.elec      = elec;
    cfg.headshape = headmodel.bnd(1);
    elec  = ft_electroderealign(cfg);  %interactive elec registration
    
    data.elec = elec; %eles registration
    freq = my_ft_return_freq(data);
    
    
    cfg = [];
    cfg.sourcemodel = sourcemodel;
    cfg.headmodel   = headmodel;
    cfg.elec        = elec;
    leadfield = ft_prepare_leadfield(cfg);
    
    cfg               = [];
    cfg.method        = 'eloreta';
    cfg.sourcemodel   = leadfield;
    cfg.headmodel     = headmodel;
    cfg.eloreta.lambda = 0.05;
    cfg.eloreta.keepmom = 'yes';
    cfg.mne.keepmom = 'yes';
    cfg.eloreta.keepfilter = 'yes';
    sourceEEG = ft_sourceanalysis(cfg,freq);
    figure(5);
    test_pow = sourceEEG.avg.pow;
    m=mean(test_pow,2);
    m(find(m<=0.004)) = 0;
    c = white2red2yellow(256);
    ft_plot_mesh(sourceEEG,'vertexcolor', m);colormap(c);colorbar;temp=caxis;caxis([0,0.0079]);%caxis(temp);caxis([0,0.0031]);temp=caxis;
    view([87 90]); h = light; set(h, 'position', [0 1 0.2]); lighting gouraud; material dull;%material shiny  %set(h, 'position', [0 1 0.2]);
    
    
    %%---SD
    %% SD = cal_SD(headmodel,data.elec,sourceEEG);