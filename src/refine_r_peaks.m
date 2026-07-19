function peaks = refine_r_peaks(ecg, candidates, fs, cfg)
%REFINE_R_PEAKS Move candidates to the largest local absolute deflection.
x=double(ecg(:)); radius=max(1,round(cfg.refinementWindowSec*fs));
peaks=zeros(size(candidates));
for i=1:numel(candidates)
    left=max(1,candidates(i)-radius); right=min(numel(x),candidates(i)+radius);
    [~,j]=max(abs(x(left:right))); peaks(i)=left+j-1;
end
peaks=unique(peaks(:));
end
