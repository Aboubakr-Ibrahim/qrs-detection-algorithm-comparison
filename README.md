# QRS Detection Algorithm Comparison

A reproducible MATLAB framework for comparing Pan-Tompkins-style and wavelet-based QRS detectors against expert ECG reference annotations.

## Project purpose and ownership

This repository is based on paid biomedical MATLAB research work in which I contributed original code, signal-processing implementation, evaluation, visualization, and reporting. It is presented as an **independent technical contribution**, not as ownership of another person's academic project.

Only material I am permitted to publish should be included. Client data, identities, reports, and restricted files remain excluded.

## What it demonstrates

- ECG validation and zero-phase preprocessing
- Pan-Tompkins-style derivative, energy, integration, and adaptive thresholding
- Wavelet-detail QRS enhancement and adaptive detection
- Local R-peak refinement
- Chronological one-to-one matching against expert annotations
- TP, FP, FN, sensitivity, PPV, F1 score, and timing error
- Record-level and pooled multi-record comparison tables
- Automated quality-control figures

## Quick start

```matlab
addpath('config','src');
cfg = default_config();

% ecg: numeric vector, fs: Hz
% referencePeaks: MATLAB 1-based integer sample indices
comparison = compare_detectors(ecg, fs, referencePeaks, cfg, ...
    "record_100", "results");
disp(comparison.summary)
```

To summarize several completed records:

```matlab
aggregate = summarize_benchmark([comparison1 comparison2], "results");
disp(aggregate.pooledMetrics)
```

## Annotation policy

Reference annotations must be filtered to the accepted beat symbols before calling the framework and converted to MATLAB 1-based sample indices. Every published result must state:

- Record list and ECG channel
- Record duration or analyzed interval
- Accepted and excluded annotation symbols
- Sampling frequency
- Matching tolerance
- Detector configuration
- Whether metrics are record-averaged or pooled from TP/FP/FN counts

See [dataset and benchmark guidance](docs/dataset.md).

## Dataset

The intended public benchmark is the MIT-BIH Arrhythmia Database on PhysioNet. Dataset files are not redistributed here. Users must follow PhysioNet attribution, access, citation, and licensing requirements.

## Results and verification

The framework and expanded tests are included, but the public repository does not claim the predecessor report's performance as independently reproduced results. Populate the results section only after running the current code against a documented record list and annotation policy.

```matlab
results = runtests('tests');
table(results)
```

## Responsible use

Research and educational software only. It is not a medical device and must not be used for diagnosis, monitoring, alarms, or treatment decisions.

## Author

**Aboubakr Ibrahim** — Biomedical Engineer and Independent Biomedical Research & MATLAB Consultant  
[GitHub profile](https://github.com/Aboubakr-Ibrahim) · [LinkedIn](https://www.linkedin.com/in/aboubakr-ibrahim-45435a246)

## License

[MIT](LICENSE)
