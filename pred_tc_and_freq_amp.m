clear all; close all; clc;

addpath(genpath('/analyse/Project0288/LAB_CODE/packages/BVQXtools_v08b'))

DM = BVQXfile('/analyse/Project0385/data/JYN10/logFiles_h/JYN10_RUN1_DESIGN.sdm');
design_matrix = DM.SDMMatrix;
imagesc(design_matrix)

DM2 = BVQXfile('/analyse/Project0385/students/YRG04/logFiles/YRG04_RUN1_DESIGN.sdm');
design_matrix2 = DM2.SDMMatrix;
imagesc(design_matrix2)

%%

Fs = 0.5; % sampling rate Hz 1/TR
sC = 1; % scale betas (important?)
N = size(design_matrix,1)*2; % total samples in seconds
beta = [1; 1; 1; 1; 1; 1; 1; 1; 0; 0]*sC; % a modelled RH voxel responding to everything equally except target mapping (and run constant?) 
frequencies = (0:N-1)*(Fs/N);

%%
pred_tc = design_matrix*beta; % get predicted timecourse from design matrix and modelled voxel
ftDat = fft(pred_tc); % transform timecourse to frequency

% get absolute magnitude of frequencies
amplitude = abs(ftDat)/N;
amplitude = amplitude(1:(N/2));
psd = amplitude.^2;

%%
% % white noise
% alpha = 0;
% noise_w = 1./(frequencies(1:N/2).^alpha);
% 
% % pink noise
% alpha = 1;
% noise_p = 1./(frequencies(1:N/2).^alpha);

%% plot stuff

subplot(3,2,1)
plot(pred_tc)
title('Predictied Timecourse 12s + 6 ISI')
xlabel('Time')
ylabel('Amplitude')

figure(1);
subplot(3,2,3)
plot(frequencies(1:N/2), amplitude);
title('Amplitude vs. Frequency')
xlabel('Frequency (Hz)')
ylabel('Amplitude')
% plot noise
% hold on 
% plot(frequencies(1:N/2), noise_p, 'r--', 'LineWidth', 2)
% hold off

subplot(3,2,5)
plot(frequencies(1:N/2),10*log10(psd))
title('Power Spectral Density')
xlabel('Frequency (Hz)')
ylabel('Power/Frequency (dB/Hz)')

%% 
pred_tc = design_matrix2*beta; % get predicted timecourse from design matrix and modelled voxel
ftDat = fft(pred_tc); % transform timecourse to frequency

% get absolute magnitude of frequencies
amplitude = abs(ftDat)/N;
amplitude = amplitude(1:(N/2));
psd = amplitude.^2;

%% plot stuff
subplot(3,2,2)
plot(pred_tc)
title('Predictied Timecourse 6 on jittered ISI5-7')
xlabel('Time')
ylabel('Amplitude')

figure(1);
subplot(3,2,4)
plot(frequencies(1:N/2), amplitude);
title('Amplitude vs. Frequency')
xlabel('Frequency (Hz)')
ylabel('Amplitude')
% plot noise
% hold on 
% plot(frequencies(1:N/2), noise_p, 'r--', 'LineWidth', 2)
% hold off

subplot(3,2,6)
plot(frequencies(1:N/2),10*log10(psd))
title('Power Spectral Density')
xlabel('Frequency (Hz)')
ylabel('Power/Frequency (dB/Hz)')

