function[freqHz] = man_ras_sha(xInput,f1,P)
%Please Input the following
%xInput = x1 + x2; (or) x1;
%f1 = frequency of x1;
%P = No. of frequencies to find;
%f1 and f2 are required to check the rms value

fs = 10e3;
% N = 32;
res = zeros([1000,1]);
freqHz_x1 = zeros([1000,1]);
freqHz_x2 = zeros([1000,1]);

    for K = 1:1000
%         noise = (randn(1,N) + 1i*randn(1,N))*sqrt(0.5);
%         x = xInput + noise;
        [~,R] = corrmtx(xInput,14,'mod');
        [S,F] = pmusic(R,P,[],fs,'corr');
         if(P==1)
            [~,idx] = max(S);
            freq = F(idx);
            res(K) = freq; 
         else
            [~,locs] = findpeaks(S);
            x_atpeak = F(locs);
            freqHz_x1(K) = x_atpeak(1);
            freqHz_x2(K) = x_atpeak(2);
         end
    end
    
if(P==2)
    freqHz(1) = mean(freqHz_x1);
    freqHz(2) = mean(freqHz_x2);
    
    rms_1 = sqrt((mean((freqHz_x2-freqHz_x1)-(f1+200-f1)).^2));
%     rms_2 = sqrt(mean((freqHz_x2 - f1+200).^2));
    fprintf('RMS_1 value is: %f\n',rms_1);
%     fprintf('RMS_2 value is: %f\n',rms_2);
end

if(P==1)
    rms = sqrt(mean((res - f1).^2));
    fprintf('RMS value is: %f\n',rms);
    freqHz = mean(res);
end

plot(F,S,'linewidth',2)

xlabel('Hz')
ylabel('Pseudospectrum')
title 'Pseudospectrum Estimate via MUSIC', grid on