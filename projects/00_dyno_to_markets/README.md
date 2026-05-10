# 00 — From Dyno to Markets

**The bridge piece.** Compare engineering sensor traces (dyno torque, current,
speed) with financial return series. The point is not to claim they are the
same — they aren't — but to identify which engineering modelling instincts
transfer to markets and which fail, with evidence.

## Hypothesis

A researcher trained on PMSM parameter estimation has well-calibrated intuition
for: state-space modelling, recursive estimation under noise, persistence of
excitation, identifiability. That same researcher has *poorly* calibrated
intuition for: heavy tails, regime shifts, non-stationarity of the
data-generating process, and the absence of repeatable experiments.

This project quantifies both sides of that statement.

## Datasets

- **Engineering side:** publicly available PMSM dyno datasets (see
  `data_refs.md`) — e.g. Paderborn / Kaggle motor temperature dataset, or
  your own anonymised thesis traces.
- **Markets side:** daily returns for SPX, US 10Y futures, and a single name
  (e.g. AAPL) over 20+ years. Plus 1-minute returns for a recent slice if
  available.

## Analyses

1. **Stationarity & autocorrelation.** ADF test, KPSS test, ACF/PACF on raw
   series and on returns / first differences.
2. **Volatility clustering.** ACF of squared / absolute returns. Compare to
   ACF of squared dyno residuals from a known good motor model (these should
   be near-zero — the contrast is the point).
3. **Heavy tails.** QQ plots vs Gaussian, Hill estimator for tail index,
   Jarque-Bera. Repeat for the engineering residuals.
4. **Regime evidence.** Rolling mean / variance / skew. Visualise how
   non-stationary the markets data is vs an experimentally controlled rig.
5. **What identification techniques transfer.** Run RLS on a stationary chunk
   of returns to fit an AR(p); discuss why this looks like online R-estimation
   on a motor and where the analogy breaks (forgetting factor selection,
   non-Gaussian innovations).

## Deliverable

A 2-3 page `report.md` (with figures from `figures/`) titled "Which engineering
modelling instincts transfer to markets, and which do not." The point is the
report, not the code. The code lives in `notebooks/` and `scripts/`.

## Why this is project 00

It is the most honest thing to lead with. It signals self-awareness about
what the EE background does and does not buy in finance. Anyone who reads
this first will read the rest of the portfolio more carefully.
