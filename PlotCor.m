clear;

mm = round(logspace(0,3,10));
for j = 1:10
m = mm(j);
filename = ['m' num2str(m) '_stack_cor_white'];
load (filename);

% Plot a the HV ratio, stacked over all data.
figure(201);
[ft,f] = bft(sum(corz,2),1e-2);
[ft2] = bft(sum(cor2,2),1e-2);
 plot(f,abs(ft./ft2)); hold on;
 xlim([0 3.5]); ylim([0.9 1.5]);
 xlabel('Frequency (Hz)'); ylabel('H/V ratio');
 set(gca,'FontSize',20);
 title(['Spectra of H/V ratios in the frequency domain']);
gx=gca;



% % Plot the temporal variation of the spectral peak that occurs around 0.75
% % Hz.
% ff = zeros(150,1);
% for i = 1:200
%     [v,f] = bft(corz(:,i),1e-2);
%     h = bft(cor2(:,i),1e-2);
%     vh = abs(v./h);
%     range = find(f>0.4 & (f<0.8));
%     [~,ind] = max(vh(range));
%     ff(i) = f(range(ind));
% %     figure(i); plot(f,vh); xlim([0 3.5]); ylim([0.9 1.5]); hold on;
%     
%     figure(202); subplot(3,1,1:2); plot(i,ff(i),'o','color',...
%         gx.ColorOrder(j,:) ); hold on; drawnow;
% end
% xlabel('Day'); ylabel('Spectral Peak');
% subplot(3,1,3); histogram(ff);

% Visual the time domain stack
figure;
hv = abs(corz./cor2);
pcolor((1:150)',linspace(0,40,4002)',(hv(4000:end,1:150))); 
shading interp;  ylim([0 5]); caxis([0 10]); %colorbar; caxis([-1 2]);
xlabel('Day'); ylabel('Time (s)');

set(gca,'FontSize',20);
title([num2str(mm(j)) ' decimation periods']);
end