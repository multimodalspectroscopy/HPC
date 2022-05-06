function [betas] = hpc_glm(hpc_foi)
%Computes beta values using the GLM for HPC method. Input HPC frequencies of
%interest 

if size(hpc_foi,1) > 1
    Y = mean(hpc_foi);
else
    Y = hpc_foi;
end

Y = Y';

hpc_rf = ones(size(Y,1),1)*-1;
cons = ones(size(Y,1),1);

X = [hpc_rf cons];

betas = pinv(X'*X)*X'*Y;



end

