function metrics = compute_detection_metrics(matches, fs)
%COMPUTE_DETECTION_METRICS Sensitivity, PPV, F1, and timing error.
tp=matches.TP; fp=matches.FP; fn=matches.FN;
metrics=struct('TP',tp,'FP',fp,'FN',fn,...
    'Sensitivity_percent',safe_percent(tp,tp+fn),...
    'PPV_percent',safe_percent(tp,tp+fp),...
    'F1_percent',safe_percent(2*tp,2*tp+fp+fn),...
    'MeanAbsTimingError_ms',mean(abs(matches.errorsSamples))/fs*1000);
if isempty(matches.errorsSamples), metrics.MeanAbsTimingError_ms=NaN; end
end

function value=safe_percent(numerator,denominator)
if denominator==0, value=NaN; else, value=100*numerator/denominator; end
end
