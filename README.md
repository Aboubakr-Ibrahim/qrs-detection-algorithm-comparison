# QRS Detection Algorithm Comparison

A reproducible MATLAB framework for comparing Pan–Tompkins-style and wavelet-based QRS detectors against reference ECG annotations.

## Project purpose

This repository is based on paid biomedical MATLAB research work in which I contributed original code, signal-processing implementation, evaluation, visualization, and reporting. It is presented as an **independent technical contribution**, not as ownership of another person's academic project.

## What it demonstrates

- ECG validation and zero-phase preprocessing
- Pan–Tompkins-style derivative, energy, integration, and adaptive thresholding
- Wavelet-detail QRS enhancement and adaptive detection
- Local R-peak refinement
- One-to-one matching against expert annotations
- TP, FP, FN, sensitivity, PPV, F1 score, and timing error
- Record-level and aggregate comparison tables
- Automated quality-control figures

## Quick start

```matlab
addpath('config','src');
cfg = default_config();

% ecg: numeric vector, fs: Hz, referencePeaks: sample indices
comparison = compare_detectors(ecg, fs, referencePeaks, cfg, "record_100", "results");
disp(comparison.summary)
```

## Dataset

The intended public benchmark is the MIT-BIH Arrhythmia Database on PhysioNet. Dataset files are not redistributed here. Users must follow PhysioNet attribution, access, and licensing requirements. See [dataset instructions](docs/dataset.md).

## Results status

The framework is complete, but this public repository intentionally does not claim the predecessor report's performance values as independently reproduced results. Populate the results table only after running the current code against the documented record list and annotations.

## Verification

MATLAB unit tests are included. They were not executed in this workspace because MATLAB is unavailable.

```matlab
results = runtests('tests');
table(results)
```

## Responsible use

Research and educational software only. It is not a medical device and must not be used for diagnosis, monitoring, alarms, or treatment decisions.

## Author

**Aboubakr Ibrahim** — Biomedical Engineer and Independent Biomedical Research & MATLAB Consultant  
[GitHub profile](https://github.com/Aboubakr-Ibrahim)

## License

[MIT](LICENSE)
