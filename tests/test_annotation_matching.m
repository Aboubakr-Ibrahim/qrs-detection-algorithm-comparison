classdef test_annotation_matching < matlab.unittest.TestCase
    methods (Test)
        function perfectMatch(testCase)
            addpath('src');
            match=match_annotations([100 200 300],[100 200 300],5);
            testCase.verifyEqual([match.TP match.FP match.FN],[3 0 0])
        end
        function oneToOnePreventsDoubleMatch(testCase)
            addpath('src');
            match=match_annotations([98 102],[100],5);
            testCase.verifyEqual([match.TP match.FP match.FN],[1 1 0])
        end
        function chronologicalMatchPreservesCardinality(testCase)
            addpath('src');
            % Nearest-neighbour matching can consume reference 104 for
            % detection 103 and incorrectly leave detection 105 unmatched.
            match=match_annotations([103 105],[100 104],3);
            testCase.verifyEqual([match.TP match.FP match.FN],[2 0 0])
            testCase.verifyEqual(match.pairs,[103 100;105 104])
        end
        function emptyDetectionIsHandled(testCase)
            addpath('src');
            match=match_annotations([], [100 200], 5);
            testCase.verifyEqual([match.TP match.FP match.FN],[0 0 2])
        end
        function metricsAreCorrect(testCase)
            addpath('src');
            match=struct('TP',8,'FP',2,'FN',2,'errorsSamples',[1;-1]);
            m=compute_detection_metrics(match,100);
            testCase.verifyEqual(m.Sensitivity_percent,80,'AbsTol',1e-12)
            testCase.verifyEqual(m.PPV_percent,80,'AbsTol',1e-12)
            testCase.verifyEqual(m.F1_percent,80,'AbsTol',1e-12)
            testCase.verifyEqual(m.MeanAbsTimingError_ms,10,'AbsTol',1e-12)
        end
    end
end
