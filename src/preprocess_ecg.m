function signal = preprocess_ecg(ecg, fs, cfg)
%PREPROCESS_ECG Validate, center, and filter an ECG vector.
x=double(ecg(:));
if numel(x)<round(5*fs), error('QRS:ShortSignal','Five seconds required.'); end
if any(~isfinite(x)), x=fillmissing(x,'linear','EndValues','nearest'); end
x=x-median(x);
band=cfg.preprocessingBandHz; band(2)=min(band(2),0.90*fs/2);
if band(1)>=band(2), error('QRS:SamplingRate','Sampling rate too low.'); end
[b,a]=butter(cfg.filterOrder,band/(fs/2),'bandpass');
y=filtfilt(b,a,x);
signal=struct('raw',x,'filtered',y,'timeSec',(0:numel(x)-1)'/fs);
end
