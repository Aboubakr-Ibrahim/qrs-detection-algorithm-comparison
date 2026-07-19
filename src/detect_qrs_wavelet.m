function [peaks, diagnostic] = detect_qrs_wavelet(ecg, fs, cfg)
%DETECT_QRS_WAVELET Wavelet-detail energy detector.
x=double(ecg(:));
[coefficients,lengths]=wavedec(x,cfg.waveletLevel,cfg.waveletName);
enhanced=zeros(size(x));
for level=1:cfg.waveletLevel
    detail=wrcoef('d',coefficients,lengths,cfg.waveletName,level);
    nominalHz=fs/(2^(level+1));
    if nominalHz>=4 && nominalHz<=40, enhanced=enhanced+detail; end
end
score=movmean(enhanced.^2,max(3,round(0.10*fs)));
spread=1.4826*median(abs(score-median(score)));
threshold=median(score)+cfg.thresholdScale*spread;
distance=max(1,floor(60*fs/cfg.maxHeartRateBpm));
[~,candidates]=findpeaks(score,'MinPeakHeight',threshold,...
    'MinPeakDistance',distance);
peaks=refine_r_peaks(x,candidates,fs,cfg);
diagnostic=struct('enhanced',enhanced,'score',score,'threshold',threshold,...
    'candidateCount',numel(candidates));
end
