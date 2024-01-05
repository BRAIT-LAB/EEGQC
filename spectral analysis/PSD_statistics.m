clear;
clc;
dataset = 200;
Fs = 250;
Fm = 50;
deltaf = 1;
for num = 1:dataset

    %-----clean
    EEG = pop_loadset('samp.set',['E:\BCI\my_workplace\debrain_use_pvaf\data\data' num2str(num)]);
    [~,F,~,clean_PSD] = pvaf_xspectrum(EEG.data,Fs,Fm,deltaf);
    clean_clean(num,:) = mean(clean_PSD-clean_PSD,1);
    clean(num).PSD = clean_PSD;
    %-----clean

    for noise_t = 1:41
        EEG = pop_loadset(['noise' num2str(noise_t) '.set'],['E:\BCI\my_workplace\debrain_use_pvaf\data\data' num2str(num)]);
        [~,F,~,noise_PSD] = pvaf_xspectrum(EEG.data,Fs,Fm,deltaf);
        noise_clean(num,noise_t,:) = mean(noise_PSD-clean_PSD,1);
        noise(num,noise_t).PSD = noise_PSD;
    end

    for debrain_t = 1:12
        EEG = pop_loadset(['debrain' num2str(debrain_t) '.set'],['E:\BCI\my_workplace\debrain_use_pvaf\data\data' num2str(num)]);
        [~,F,~,debrain_PSD] = pvaf_xspectrum(EEG.data,Fs,Fm,deltaf);
        debrain_clean(num,debrain_t,:) = mean(debrain_PSD-clean_PSD,1);
        debrain(num,debrain_t).PSD = debrain_PSD;
    end

end

% % plot(F,mean(clean_clean,1),F,mean(noise25_clean,1),F,mean(noise15_clean,1),F,mean(noise5_clean,1),F,mean(debrain5_clean,1));legend('c','n30','n25','n20','d5');
% % 
% % 
% % plot(F,mean(clean_clean,1),'LineWidth',4);hold on;
% % plot(F,mean(noise30_clean,1),'LineWidth',4);hold on;
% % plot(F,mean(noise25_clean,1),'LineWidth',4);hold on;
% % plot(F,mean(noise20_clean,1),'LineWidth',4);hold on;
% % plot(F,mean(debrain5_clean,1),'LineWidth',4);hold on;
% % legend('CE','IPE(SNR=20)','IPE(SNR=15)','IPE(SNR=10)','EPE');
% % 
% psd_plot1(1,:) = mean(noise25_clean,1);psd_plot1(2,:) = mean(noise20_clean,1);psd_plot1(3,:) = mean(noise15_clean,1);psd_plot1(4,:) = mean(debrain4_clean,1);psd_plot1(5,:) = mean(debrain8_clean,1);psd_plot1(6,:) = mean(debrain12_clean,1);
% figure(2);
% polarplot(test_psd_plot1','LineWidth',1.5);legend('IPE(SNR=15)','IPE(SNR=10)','IPE(SNR=5)','EPE(SDR=20%)','EPE(SDR=50%)','EPE(SDR=80%)');
% title('power deviation compare to CE')
% pax = gca;
% pax.FontSize = 14;
% thetaticks(0:72:288);
% pax.ThetaTickLabel = {'0 HZ','10 HZ','20 HZ','30 HZ','40 HZ'};
% pax.FontName = 'Times New Roman';
% pax.ThetaAxisUnits = 'radians';
% rticklabels({});
% pax.ThetaColor = 'blue';
% pax.GridColor = 'm';            % 设置刻度线颜色 
% pax.GridLineStyle ='-.';
% pax.ThetaDir = 'clockwise';		   % 按顺时针方式递增
% pax.ThetaZeroLocation = 'top';     % 将0度放在顶部 
% ch = pax.Children;
% ch(4).Color = [0.98 0.64 0.49];
% ch(3).Color = [0.99 0.48 0.27];
% %ch(2).Color = [0.99 0.31 0.02];
% ch(2).Color = [1 0 0];
% ch(1).Color = [0.47 0.67 0.19];
% 
% % % ch(4).Color = [0.86 0.94 0.75];
% % ch(4).Color = [0.77 0.99 0.47];
% % % ch(3).Color = [0.74 0.94 0.48];
% % ch(3).Color = [0.65 0.99 0.21];
% % ch(2).Color = [0 1 0];
% % ch(1).Color = [0.85 0.33 0.10];




