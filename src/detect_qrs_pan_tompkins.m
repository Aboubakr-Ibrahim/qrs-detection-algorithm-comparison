function [peaks, diagnostic] = detect_qrs_pan_tompkins(ecg, fs, cfg)
%DETECT_QRS_PAN_TOMPKINS Pan-Tompkins-style energy-envelope detector.
x = double(ecg(:));
band = cfg.panTompkinsBandHz;
band(2) = min(band(2),0.90*fs/2);
if band(1) >= band(2)
    error('QRS:SamplingRate', ...
        'Sampling rate is too low for the configured QRS passband.');
end
[b,a] = butter(2,band/(fs/2),'bandpass');
z = filtfilt(b,a,x);
energy = [0;diff(z)].^2;
window = max(3,round(cfg.integrationWindowSec*fs));
integrated = movmean(energy,window);
robustSpread = 1.4826*median(abs(integrated-median(integrated)));
threshold = median(integrated)+cfg.thresholdScale*robustSpread;
distance = max(1,floor(60*fs/cfg.maxHeartRateBpm));
[~,candidates] = findpeaks(integrated,'MinPeakHeight',threshold,...
    'MinPeakDistance',distance);
peaks = refine_r_peaks(x,candidates,fs,cfg);
diagnostic = struct('enhanced',z,'score',integrated,...
    'threshold',threshold,'candidateCount',numel(candidates));
end
