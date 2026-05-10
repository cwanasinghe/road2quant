# EE → Quant: the bridge

The transferable skills from PMSM parameter estimation are not peripheral
to quantitative finance — they are foundational. Most quant aspirants do not
have them. This document makes the mapping explicit so the rest of the repo
can lean on it.

## Concept map

| EE concept (PMSM context) | Quant analogue | Mathematical link |
|---|---|---|
| dq-axis state-space PMSM model | Heston / SABR stochastic volatility | Both are continuous-time state-space systems with partially observed latent states; both are typically discretised and filtered the same way. |
| Kalman / EKF / UKF for flux-linkage observation under saturation | UKF/EKF calibration of latent volatility from option prices and returns | Identical recursive Bayesian filtering machinery; "measurement model" swaps stator currents for option prices. |
| Recursive least squares for online R/L estimation | Time-varying-parameter regression for return forecasting; adaptive factor models | Same forgetting-factor RLS update; weights become factor exposures rather than electrical parameters. |
| Persistence of excitation | Identifiability of factor / volatility models | Both ask: does the input signal excite all the modes I want to identify? Without it, the parameter estimate is biased or unidentified. |
| Park / Clarke transforms (3-phase → dq) | Principal component / factor rotations on returns | Linear coordinate changes that decouple correlated signals into a smaller set of "modes" that are easier to model. |
| Sensor-noise filtering (low-pass, notch) on stator currents | Microstructure-noise filtering on high-frequency returns | Both separate signal from coloured measurement noise; same frequency-domain logic applies. |
| System identification (grey-box motor models) | Econometric model identification (GARCH, factor, regime) | Same workflow: choose model class, design experiment / pick sample, estimate, residual-diagnostic, validate out-of-sample. |
| Cramér-Rao bound on parameter variance | Fisher information limits on factor and vol estimates | The CRB you used to argue identification quality of L_d, L_q is the same bound that quants use to argue when a model is "estimable from this dataset". |

## Papers worth reading first (the math is already in your head)

- Christoffersen, Jacobs, Mimouni — *Volatility dynamics for the S&P 500: Evidence from realized volatility, daily returns, and option prices.* (UKF for Heston)
- Aïhara, Bagchi, Saha — *On parameter estimation of stochastic volatility models from stock data using particle filter.*
- Harvey, Ruiz, Shephard — *Multivariate stochastic variance models.* (state-space view of vol)
- Hamilton — *Time Series Analysis*, chapters on state-space and Kalman filtering. (textbook bridge)
- Cont — *Empirical properties of asset returns: stylized facts and statistical issues.* (the "what to model" before "how to model" piece)

## Project mapping

The bridge feeds into specific projects in this repo:

- `projects/00_dyno_to_markets/` — directly compares engineering sensor traces with financial return series for stationarity, autocorrelation, volatility clustering, heavy tails. Headline piece.
- `projects/05_gp_volatility/` — Gaussian processes for volatility surface interpolation; same kernel choices (Matérn, RQ, ARD) as you'd use for system identification under uncertainty.
- `src/road2quant/estimation/` — Kalman/EKF/UKF/particle filters/RLS implemented as a reusable library because they show up in *several* projects, not one.

## Notes to self

- When tempted to reach for an LSTM, first ask whether a Kalman filter or UKF
  with a properly specified measurement model would do the job with 10× less
  data and fully interpretable parameters. The answer is "yes" surprisingly often.
- A passing PMSM identification result on a dyno does not transfer to a passing
  factor identification on returns *automatically*. The data-generating process
  is non-stationary and the SNR is brutal. Stylised facts come first, models second.
