function cfg = default_config()
%DEFAULT_CONFIG Reproducible QRS comparison parameters.
cfg.preprocessingBandHz = [0.5 40];
cfg.panTompkinsBandHz = [5 18];
cfg.filterOrder = 3;
cfg.integrationWindowSec = 0.15;
cfg.maxHeartRateBpm = 220;
cfg.thresholdScale = 0.45;
cfg.refinementWindowSec = 0.08;
cfg.matchToleranceSec = 0.15;
cfg.waveletName = 'db4';
cfg.waveletLevel = 4;
cfg.saveFigures = true;
end
