function freq = my_ft_return_freq(data)

    
%     sub_cfg = [];
%     sub_cfg.order = 5;
%     sub_cfg.method = 'bsmart';
%     mdata = ft_mvaranalysis(sub_cfg,data);
    
    sub_cfg = [];
    sub_cfg.method = 'mtmfft';
    sub_cfg.taper = 'dpss';
    %sub_cfg.taper = 'hanning';
    
    sub_cfg.output = 'fourier';
    %sub_cfg.foi = 10;
    sub_cfg.foilim    = [8 13];
    sub_cfg.tapsmofrq = 4;


   
    freq = ft_freqanalysis(sub_cfg,data);
end

