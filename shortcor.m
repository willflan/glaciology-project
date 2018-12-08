function shortcor(m)
%
% shortcor(m) computes autocorrelations with daily data decimated
% into m windows per day.
%

% m=10;
tic;

DD = 400; % number of days
N = 4000; 
[b,a]=butter(2,[0.001 0.99],'bandpass');
date0 = datenum(2005,11,30);
corz = zeros(2*N+1,DD);
cor2 = zeros(2*N+1,DD);
cor3 = zeros(2*N+1,DD);
ZN = zeros(2*N+1,DD);
ZE = zeros(2*N+1,DD);

for i = 1:DD
    datei = date0 + i;
    start = datestr(datei,'YYYY-mm-DD HH:MM:SS');
    stop = datestr(datei+1,'YYYY-mm-DD HH:MM:SS');
    load(['data_z_' num2str(datenum(start))],'data_z');
    load(['data_2_' num2str(datenum(start))],'data_2');
    load(['data_3_' num2str(datenum(start))],'data_3');


    if numel(data_z) == 1 && numel(data_2) == 1 && numel(data_3) == 1
        
        ne = data_2.sampleCount;
        l = (ne/m);
        for j = 1:m
            
            range = floor(1+ (j-1)*l) : floor(l*j);
            
            z = data_z.data(range);
            two = data_2.data(range);
            three = data_3.data(range);
            
            fz = fft(z);
            f2 = fft(two);
            f3 = fft(three);
            
            z = ifft (  fz./ abs(fz) );
            two = ifft ( f2 ./ abs(f2) );
            three = ifft ( f3 ./ abs(f3) );

%             z = sign(ifft (  fz./ abs(fz) ));
%             two = sign(ifft ( f2 ./ abs(f2) ));
%             three = sign(ifft ( f3 ./ abs(f3) ));

            cz = xcorr(z,z,N);
            c2 = xcorr(two,two,N);
            c3 = xcorr(three,three,N);
            
%             crap=ifftshift(ifft(f2.*conj(fz)./(smooth(abs(fz)).^2)) );
%             ZN(:,i) =  ZN(:,i)+ crap(length(crap)/2-N:length(crap)/2+N); 
%             crap=ifftshift(ifft(f3.*conj(fz)./(smooth(abs(fz)).^2)) );
%             ZE(:,i) =  ZE(:,i)+ crap(length(crap)/2-N:length(crap)/2+N); 
            
            corz(:,i) = corz(:,i) + cz/max(cz);
            cor2(:,i) = cor2(:,i) + c2/max(c2);
            cor3(:,i) = cor3(:,i) + c3/max(c3);
        end
        
        corz(:,i) = corz(:,i)/m;
        cor2(:,i) = cor2(:,i)/m;
        cor3(:,i) = cor3(:,i)/m;
        ZN(:,i) = ZN(:,i)/m;
        ZE(:,i) = ZE(:,i)/m;
        
    end
    toc
end

filename = ['m' num2str(m) '_stack_cor_white'];
% save(filename,'corz','cor2','cor3','ZN','ZE');
save(filename,'corz','cor2','cor3');