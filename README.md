# road2quant

**Engineering to quant.** A working portfolio repository documenting the
transition from electrical engineering research (autonomous parameter
estimation in permanent magnet synchronous machines) into quantitative finance.

The thesis behind the repo: the mathematical machinery used to identify
electrical parameters of a PMSM under saturation — Kalman/EKF/UKF filtering,
recursive least squares, persistence-of-excitation, system identification —
is structurally identical to the machinery used in modern quant for stochastic
volatility filtering, time-varying factor models, and online return forecasting.
This repo treats that overlap as a deliberate strength rather than a coincidence.

See [`docs/ee_to_quant_bridge.md`](docs/ee_to_quant_bridge.md) for the explicit
mapping, and [`RESEARCH_IDEAS.md`](RESEARCH_IDEAS.md) for the 13-phase roadmap.

## Repository layout

```
src/road2quant/   Reusable library (data, timeseries, estimation, portfolio,
                  backtest, derivatives, risk, viz). Anything used by more
                  than one project lives here.
projects/         Self-contained, portfolio-grade projects. One folder each,
                  numbered by intended reading order.
notebooks/        Scratch only. Promote to projects/ once a notebook stabilises.
data/             Raw / interim / processed data. raw/ is gitignored.
docs/             Theory notes, learning log, EE-to-quant bridge, references.
reports/          Non-code deliverables: investor memos, fund teardowns, decks.
journal/          Trade ideas (hypothesis -> validation -> result -> failure).
tests/            Unit tests for src/road2quant. Mirrors its structure 1:1.
```

## The placement rule

Code lives in exactly one of three places, mechanically:

1. Reusable across more than one project? -> `src/road2quant/` + tests in `tests/`.
2. Exploratory or possibly throwaway? -> `notebooks/_scratch/`.
3. Coherent enough to show someone? -> `projects/NN_name/`.

When a scratch notebook stabilises, it is promoted to `projects/`. When two
projects keep reinventing the same helper, it is lifted into `src/`.

## Setup

```bash
# clone, then from the repo root:
python -m venv .venv && source .venv/bin/activate     # or use conda/uv
pip install -e ".[dev,quant]"
pytest                                                 # smoke test
```

If using conda: `conda env create -f environment.yml && conda activate road2quant`.

## Project index

| Project | Status | One-liner |
|---|---|---|
| 00_dyno_to_markets | TODO | The bridge piece: dyno traces vs financial returns. |
| 01_return_forecasting_baselines | TODO | Naive, MA, regression, ridge/lasso, ARIMA on returns. |
| 02_portfolio_optimisation | TODO | Mean-variance, efficient frontier, Sharpe optimiser. |
| 03_backtest_engine | TODO | Reusable engine: orders, fills, costs, walk-forward. |
| 04_options_pricing_and_greeks | TODO | Black-Scholes, Greeks, MC pricing, IV inversion. |
| 05_gp_volatility | TODO | Gaussian processes for volatility surface interpolation. |
| 06_microstructure_execution | TODO | Order-book imbalance, slippage, market impact. |
| 07_advanced_strategy_research | TODO | Cointegration, stat-arb, regime-switching factors. |
