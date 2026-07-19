function matches = match_annotations(detected, reference, toleranceSamples)
%MATCH_ANNOTATIONS Chronological one-to-one beat matching.
%
% The two-pointer algorithm preserves temporal order and maximizes feasible
% one-to-one matches inside the tolerance window. It avoids the failure mode
% of nearest-neighbour matching where an early detection consumes the only
% reference annotation available to a later detection.

arguments
    detected {mustBeNumeric,mustBeVector}
    reference {mustBeNumeric,mustBeVector}
    toleranceSamples (1,1) double {mustBeInteger,mustBeNonnegative}
end

detected = sort(unique(round(double(detected(:)))));
reference = sort(unique(round(double(reference(:)))));
assert(all(isfinite(detected)) && all(isfinite(reference)), ...
    'QRS:NonfiniteAnnotation', 'Peak indices must be finite.');

i = 1; j = 1;
pairs = zeros(0,2); errors = zeros(0,1);
while i <= numel(detected) && j <= numel(reference)
    delta = detected(i) - reference(j);
    if abs(delta) <= toleranceSamples
        pairs(end+1,:) = [detected(i), reference(j)]; %#ok<AGROW>
        errors(end+1,1) = delta; %#ok<AGROW>
        i = i + 1; j = j + 1;
    elseif detected(i) < reference(j) - toleranceSamples
        i = i + 1;
    else
        j = j + 1;
    end
end

tp = size(pairs,1);
matches = struct('pairs',pairs,'errorsSamples',errors,'TP',tp,...
    'FP',numel(detected)-tp,'FN',numel(reference)-tp);
end
