clear;

mm = round(logspace(0,3,10));
for i = 1:10
    m = mm(i);
    filename = ['m' num2str(m) '_stack_cor_white'];
    load (filename);

    % Plot a the HV ratio, stacked over all data.
    figure(1);
    [ft,f] = bft(sum(corz,2),1e-2);
    [ft2] = bft(sum(cor2,2),1e-2);
     plot(f,abs(ft./ft2)); hold on;
     xlim([0 3.5]); ylim([0.9 1.5]);
    gx=gca;
end 