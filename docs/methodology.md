# Methodology

Both algorithms receive the same validated and band-pass-filtered ECG. The Pan–Tompkins-style path uses a QRS band, derivative energy, moving integration, a robust adaptive threshold, physiological refractory period, and local peak refinement. The wavelet path combines selected detail reconstructions, applies an energy envelope and the same peak-spacing and refinement principles.

Detected peaks are matched to reference annotations using a one-to-one temporal tolerance. Each reference and detection can participate in at most one match. The framework reports TP, FP, FN, sensitivity, PPV, F1 score, and absolute timing error.

Fair comparison requires identical records, channels, durations, annotation policy, tolerance, preprocessing assumptions, and reporting rules.
