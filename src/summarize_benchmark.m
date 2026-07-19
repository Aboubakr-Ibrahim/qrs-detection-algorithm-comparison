function aggregate = summarize_benchmark(comparisons, outputDir)
%SUMMARIZE_BENCHMARK Create record-level and pooled detector summaries.
arguments
    comparisons (1,:) struct
    outputDir (1,1) string = ""
end
assert(~isempty(comparisons), 'QRS:EmptyBenchmark', ...
    'At least one comparison result is required.');

recordTable = table();
algorithms = ["Pan-Tompkins", "Wavelet"];
pooledTP = zeros(2,1); pooledFP = zeros(2,1); pooledFN = zeros(2,1);
pooledErrorsMs = {zeros(0,1); zeros(0,1)};

for recordIndex = 1:numel(comparisons)
    item = comparisons(recordIndex);
    rows = item.summary;
    rows.Record = repmat(string(item.recordId),height(rows),1);
    rows = movevars(rows,"Record","Before",1);
    recordTable = [recordTable; rows]; %#ok<AGROW>
    matchList = {item.panMatches; item.waveletMatches};
    for algorithmIndex = 1:2
        match = matchList{algorithmIndex};
        pooledTP(algorithmIndex) = pooledTP(algorithmIndex) + match.TP;
        pooledFP(algorithmIndex) = pooledFP(algorithmIndex) + match.FP;
        pooledFN(algorithmIndex) = pooledFN(algorithmIndex) + match.FN;
        pooledErrorsMs{algorithmIndex} = [pooledErrorsMs{algorithmIndex}; ...
            1000 .* abs(match.errorsSamples(:)) ./ item.fs]; %#ok<AGROW>
    end
end

pooled = table(algorithms',pooledTP,pooledFP,pooledFN,...
    safePercent(pooledTP,pooledTP+pooledFN),...
    safePercent(pooledTP,pooledTP+pooledFP),...
    safePercent(2.*pooledTP,2.*pooledTP+pooledFP+pooledFN),...
    [meanOrNaN(pooledErrorsMs{1}); meanOrNaN(pooledErrorsMs{2})],...
    'VariableNames',["Algorithm","TP","FP","FN",...
    "Sensitivity_percent","PPV_percent","F1_percent",...
    "MeanAbsTimingError_ms"]);

aggregate = struct('recordMetrics',recordTable,'pooledMetrics',pooled);
if strlength(outputDir)>0
    if ~isfolder(outputDir), mkdir(outputDir); end
    writetable(recordTable,fullfile(outputDir,"record_metrics.csv"));
    writetable(pooled,fullfile(outputDir,"pooled_metrics.csv"));
end
end

function values = safePercent(numerator,denominator)
values = 100 .* numerator ./ denominator;
values(denominator==0) = NaN;
end

function value = meanOrNaN(values)
if isempty(values), value = NaN; else, value = mean(values); end
end
