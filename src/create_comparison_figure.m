function create_comparison_figure(comparison, outputDir)
%CREATE_COMPARISON_FIGURE Visual quality-control comparison.
t=comparison.signal.timeSec; x=comparison.signal.filtered;
safeId=regexprep(comparison.recordId,'[^a-zA-Z0-9_-]','_');
f=figure('Visible','off','Color','w','Position',[100 100 1200 750]);
subplot(2,1,1); plot(t,x,'k'); hold on
plot(comparison.panPeaks/comparison.fs,x(comparison.panPeaks),'rv');
plot(comparison.referencePeaks/comparison.fs,x(comparison.referencePeaks),'go');
title('Pan-Tompkins-style detector'); ylabel('Amplitude'); grid on
legend('ECG','Detected','Reference');
subplot(2,1,2); plot(t,x,'k'); hold on
plot(comparison.waveletPeaks/comparison.fs,x(comparison.waveletPeaks),'bv');
plot(comparison.referencePeaks/comparison.fs,x(comparison.referencePeaks),'go');
title('Wavelet detector'); xlabel('Time (s)'); ylabel('Amplitude'); grid on
legend('ECG','Detected','Reference');
exportgraphics(f,fullfile(outputDir,safeId+"_qrs_comparison.png"),'Resolution',180);
close(f)
end
