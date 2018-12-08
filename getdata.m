% clear;
tic;
addpath ../irisFetch-matlab-2.0.10/

DD = 400;
N = 4000;
[b,a]=butter(2,[0.001 0.99],'bandpass');
date0 = datenum(2005,11,30);
corz = zeros(2*N+1,DD);
cor2 = zeros(2*N+1,DD);
cor3 = zeros(2*N+1,DD);

% Data available from 2005-11-17 - 2006-12-29

for i = 1:DD

    datei = date0 + i;
    start = datestr(datei,'YYYY-mm-DD HH:MM:SS');
    stop = datestr(datei+1,'YYYY-mm-DD HH:MM:SS');

%     data_z = irisFetch.Traces('XV','RIS2','01','HHZ',start,stop);
%     data_2 = irisFetch.Traces('XV','RIS2','01','HH2',start,stop);
%     data_3 = irisFetch.Traces('XV','RIS2','01','HH3',start,stop);
%     save(['data_z_' num2str(datenum(start))],'data_z');
%     save(['data_2_' num2str(datenum(start))],'data_2');
%     save(['data_3_' num2str(datenum(start))],'data_3');
    load(['data_z_' num2str(datenum(start))],'data_z');
    load(['data_2_' num2str(datenum(start))],'data_2');
    load(['data_3_' num2str(datenum(start))],'data_3');

    if numel(data_z) == 1 && numel(data_2) == 1 && numel(data_3) == 1
        z = filtfilt(b,a,data_z.data);
        two = filtfilt(b,a,data_2.data);
        three = filtfilt(b,a,data_3.data);

        corz(:,i) = xcorr(z,z,N);
        cor2(:,i) = xcorr(two,two,N);
        cor3(:,i) = xcorr(three,three,N);
    end
    toc
end

% [ft_z,f] = bft(corz(:,1),1/100);
% ft_2 = bft(cor2(:,1),1/100);
% ft_3 = bft(cor3(:,1),1/100);
% plot(f,abs(ft_z./ft_2));