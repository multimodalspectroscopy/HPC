# Haemodynamic Phase Correlation Signal (HPC)
# The code here computes the HPC signal for fNIRS data, plots the output in a spectrogram, and computes beta values from the resultant hpc data. See here for the publication detailing the method and results. Requires standard MATLAB toolboxes, wavelet toolbox, redblue colormap and InterX functions are required for hpcplot and rev_artifact_detect functions. 

# hpc.m 

# Computes HPC signal. Inputs required are HbO and HHb data, t as vector or integer (uses time vector to compute fs, or you can give it fs directly), desired frequencies of interest. Outputs full spectrogram, frequencies of interest from HPC, and frequencies of input data. 

# hpcplot.m
# Plots hpc spectrogram using redblue colormap. Takes either HPC signal as input or HPC and time vector. 

# hpc_glm.m
# Computes beta values from the HPC signal using the GLM. Takes hpc frequencies of interest as output from hpc function.

# rev_artifact_detect.m 

# Method to detect specific cases where the hbo and hhb signals are artifactually inverted. First input must be HbO and second must be HHb from one channel. Other inputs are task frequency (same as for hpc function) and sample frequency the hbo and hhb were acquired at. Outputs array with blocks that are not artifacts as NaN. 


