function [hpc_signal, hpc_foi, f1, f2] = hpc(y1,y2,t,foi)

%returns hpc of y1 and y2 inputs based on the cwt using the
%Morlet wavelet. If t is input as vector computes fs based on that, if
%double %then uses value as fs
%% Check fs 
if length(t) > 1
    fs = 1/t(2)-t(1);
elseif length(t) == 1
    fs=t;
end
%% Compute HPC

y1(isnan(y1)) = 0; 
y2(isnan(y2)) = 0;
m1=mean(y1(:)); 
m2=mean(y2(:));
y1=y1-m1; %centre data
y2=y2-m2;
[c1,f1]=cwt(y1,'amor',fs); %continuous wavelet transform with morlet wavelet
[c2,f2]=cwt(y2,'amor',fs);
ctc=c1.*conj(c2);     %Cross wavelet transform
spt = atan2(imag(ctc),real(ctc)); %phase
hpc_signal=cos(spt); %HPC signal complete

%% Get fois
dp = 2; %round frequencies to decimal points
hpc_fois = find(round(f1,dp)==foi);
if isempty(hpc_fois)
    warning('Could not find frequencies of interest, trying tolerance method')
    tol = 0.001;
    hpc_fois = find(abs(f1-foi) < tol);
end
fprintf(' %d frequency band/s in FOIs.\n',size(hpc_fois,1));

for fois = 1:length(hpc_fois) 
fprintf('Frequencies: %d \n',f1(hpc_fois(fois)))
end

hpc_foi = hpc_signal(hpc_fois,:);


end

