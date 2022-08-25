function mean_SD = cal_SD(headmodel,elec,sourceEEG)

    [headmodel1, sens] = ft_prepare_vol_sens(headmodel, elec);
    m = mean(sourceEEG.avg.pow,2);  %mean of the specified frequency band
    m(find(m<=0.004)) = 0;   %threshold
    t = find(~isnan(m)&m~=0);    %remove outside of the brain and pow <= 0.004

    [lf] = ft_compute_leadfield(sourceEEG.pos(t,:), sens, headmodel1);   %lead field

    for freq_i=1:length(sourceEEG.freq)
        for i =1:length(t)
            test1 = sourceEEG.avg.ori{t(i)};
            ori(i,:) = test1(:,freq_i)';
        end
        G_i(freq_i).G = bst_gain_orient(lf, ori);   %constraint
    end
    G = zeros(size(G_i(freq_i).G,1),size(G_i(freq_i).G,2));
    for i=1:length(sourceEEG.freq)
        G = G+G_i(freq_i).G;
    end
    G=G/length(sourceEEG.freq);  %mean of the specified frequency band
    
    
    SNR = 3;
    N_sensor = 15;
    a = trace(G*G')/(N_sensor*SNR);
    M_mne = G'/((G*G'+a*eye(15,15)));
    for m1=1:size(M_mne,1)
        M_dSPM(m1,:) = M_mne(m1,:)/norm(M_mne(m1,:));
    end
    
    K = M_dSPM*G;   %resolution matrix
    
    D = ft_dip_distance(sourceEEG.pos(t,:));   %pos distance


    %Hauk et al
    for i=1:size(K,1)
        temp1 = 0;
        temp2 = 0;
        for j=1:size(K,2)
            temp1 = temp1 + D(i,j)*K(i,j)^2;
            temp2 = temp2 + K(i,j)^2;
        end
        SD(i) = sqrt(temp1/temp2);
    end
    mean_SD = mean(SD);
    %Hauk et al

end

