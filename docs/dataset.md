# Dataset, annotations, and benchmark protocol

## Intended public dataset

The intended benchmark is the [MIT-BIH Arrhythmia Database](https://physionet.org/content/mitdb/) hosted by PhysioNet. The database contains ambulatory ECG recordings with expert beat annotations.

Do not redistribute database files through this repository. Download through the official source and follow its citation, licence, and attribution requirements.

## Required inputs

For each record, supply:

- One ECG channel as a numeric vector
- Sampling frequency in hertz
- Accepted reference beat locations as MATLAB 1-based integer sample indices
- An anonymized record identifier

If an annotation reader returns zero-based samples, add one before using `compare_detectors`.

## Annotation policy

Not every MIT-BIH annotation symbol represents a normal or abnormal cardiac beat. Before evaluation, define which annotation symbols count as QRS reference beats. Document:

- Accepted beat symbols
- Excluded rhythm, signal-quality, and non-beat markers
- Duplicate-removal rule
- Analyzed start/end interval
- Selected ECG channel

Do not change the annotation policy after inspecting detector errors without reporting the change.

## Matching policy

The default tolerance is 150 ms. The framework uses chronological one-to-one matching: each detection and reference annotation can contribute to at most one true positive. Unmatched detections are false positives and unmatched references are false negatives.

## Reporting policy

For every published benchmark, report:

- Exact record list
- Channel and sampling rate
- Configuration and software version
- Record-level TP, FP, FN, sensitivity, PPV, F1, and timing error
- Pooled counts and pooled metrics
- Failed or excluded records with reasons
- Runtime verification status and limitations

Record-averaged percentages and pooled-count percentages are not interchangeable and must be labelled clearly.

## Reproducibility boundary

The repository contains the analysis framework but not PhysioNet data, client data, or a claim that predecessor results were reproduced. A result becomes public evidence only when the current code, documented inputs, and annotation policy generate it successfully.
