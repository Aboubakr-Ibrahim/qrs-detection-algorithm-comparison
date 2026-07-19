# Dataset and access

The intended benchmark is the MIT-BIH Arrhythmia Database hosted by PhysioNet:

https://physionet.org/content/mitdb/

The database contains ambulatory ECG recordings with expert beat annotations. Do not redistribute database files through this repository. Download through the official source and follow its citation, license, and attribution requirements.

For this framework, supply:

- one ECG channel as a numeric vector
- sampling frequency in hertz
- accepted reference beat locations as sample indices
- an anonymized record identifier

Document the exact record list, channel choice, excluded annotation symbols, duration, and matching tolerance with every published result.
