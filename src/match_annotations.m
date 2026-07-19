function matches = match_annotations(detected, reference, toleranceSamples)
%MATCH_ANNOTATIONS Greedy one-to-one temporal matching.
detected=sort(round(double(detected(:))));
reference=sort(round(double(reference(:))));
used=false(size(reference)); pairs=zeros(0,2); errors=zeros(0,1);
for i=1:numel(detected)
    available=find(~used);
    if isempty(available), break; end
    [distance,j]=min(abs(reference(available)-detected(i)));
    if distance<=toleranceSamples
        index=available(j); used(index)=true;
        pairs(end+1,:)=[detected(i),reference(index)]; %#ok<AGROW>
        errors(end+1,1)=detected(i)-reference(index); %#ok<AGROW>
    end
end
matches=struct('pairs',pairs,'errorsSamples',errors,'TP',size(pairs,1),...
    'FP',numel(detected)-size(pairs,1),'FN',numel(reference)-size(pairs,1));
end
