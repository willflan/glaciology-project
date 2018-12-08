clear;

filename = 'm2_stack_cor_white';
load (filename);

c = 0;
for i = 1:400
%     c = c + corz(4000:end,i);
%     plot( (000:4001)/100, c/i ,'linewidth',4);

    plot( (000:4001)/100, corz(4000:end,i) ,'linewidth',4);
    
    ylim(100e-3*[-1 1]); xlim([0 6]); drawnow;
    title(num2str(i)); drawnow;
    pause(0.1);
    
end