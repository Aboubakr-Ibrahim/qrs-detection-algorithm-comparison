function comparison = compare_detectors(ecg, fs, referencePeaks, cfg, recordId, outputDir)
%COMPARE_DETECTORS Run, score, and compare both QRS detectors.
arguments
    ecg {mustBeNumeric,mustBeVector}
    fs (1,1) double {mustBePositive}
    referencePeaks {mustBeNumeric,mustBeVector}
    cfg (1,1) struct
    recordId (1,1) string = "record"
    outputDir (1,1) string = ""
end
signal=preprocess_ecg(ecg,fs,cfg);
[panPeaks,panDiagnostic]=detect_qrs_pan_tompkins(signal.filtered,fs,cfg);
[waveletPeaks,waveletDiagnostic]=detect_qrs_wavelet(signal.filtered,fs,cfg);
tolerance=round(cfg.matchToleranceSec*fs);
panMatches=match_annotations(panPeaks,referencePeaks,tolerance);
waveletMatches=match_annotations(waveletPeaks,referencePeaks,tolerance);
panMetrics=compute_detection_metrics(panMatches,fs);
waveletMetrics=compute_detection_metrics(waveletMatches,fs);
summary=struct2table([add_label(panMetrics,"Pan-Tompkins");...
    add_label(waveletMetrics,"Wavelet")]);
comparison=struct('recordId',recordId,'fs',fs,'signal',signal,...
    'referencePeaks',referencePeaks(:),'panPeaks',panPeaks,...
    'waveletPeaks',waveletPeaks,'panDiagnostic',panDiagnostic,...
    'waveletDiagnostic',waveletDiagnostic,'panMatches',panMatches,...
    'waveletMatches',waveletMatches,'summary',summary);
if strlength(outputDir)>0 && cfg.saveFigures
    if ~isfolder(outputDir), mkdir(outputDir); end
    create_comparison_figure(comparison,outputDir);
    writetable(summary,fullfile(outputDir,recordId+"_metrics.csv"));
end
end

function output=add_label(metrics,label)
output=metrics; output.Algorithm=label;
end
