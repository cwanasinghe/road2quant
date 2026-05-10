#!/usr/bin/env bash
# setup_scaffold.sh — recreate the road2quant repository scaffold
# Usage:  bash setup_scaffold.sh [target_dir]   (default: ./road2quant)
set -euo pipefail
ROOT="${1:-road2quant}"
echo "Creating scaffold in: $ROOT"
mkdir -p "$ROOT"
cd "$ROOT"

# ---------- .github ----------
mkdir -p .github/workflows .github/ISSUE_TEMPLATE
touch .github/workflows/ci.yml .github/workflows/lint.yml
touch .github/ISSUE_TEMPLATE/.gitkeep

# ---------- src/road2quant ----------
PKG=src/road2quant
mkdir -p "$PKG"
touch "$PKG/__init__.py"

# data
mkdir -p "$PKG/data/loaders" "$PKG/data/cleaning" "$PKG/data/schemas"
touch "$PKG/data/__init__.py" "$PKG/data/loaders/__init__.py" \
      "$PKG/data/cleaning/__init__.py" "$PKG/data/schemas/__init__.py"
touch "$PKG/data/loaders/tiingo.py" "$PKG/data/loaders/fred.py" \
      "$PKG/data/loaders/alpaca.py" "$PKG/data/loaders/edgar.py" \
      "$PKG/data/loaders/yfinance.py"

# timeseries
mkdir -p "$PKG/timeseries"/{stationarity,autocorrelation,arima,garch,stylised_facts}
touch "$PKG/timeseries/__init__.py"
for d in stationarity autocorrelation arima garch stylised_facts; do
  touch "$PKG/timeseries/$d/__init__.py"
done

# estimation (the EE-bridge submodule)
mkdir -p "$PKG/estimation"/{kalman,particle_filter,recursive_least_squares,mle,bayesian,system_identification}
touch "$PKG/estimation/__init__.py"
touch "$PKG/estimation/kalman/__init__.py"
touch "$PKG/estimation/kalman/linear_kf.py" "$PKG/estimation/kalman/ekf.py" "$PKG/estimation/kalman/ukf.py"
for d in particle_filter recursive_least_squares mle bayesian system_identification; do
  touch "$PKG/estimation/$d/__init__.py"
done

# portfolio
mkdir -p "$PKG/portfolio"/{mean_variance,risk_parity,black_litterman,kelly,convex_optimisation}
touch "$PKG/portfolio/__init__.py"
for d in mean_variance risk_parity black_litterman kelly convex_optimisation; do
  touch "$PKG/portfolio/$d/__init__.py"
done

# backtest
mkdir -p "$PKG/backtest"/{engine,costs,validation,metrics}
touch "$PKG/backtest/__init__.py"
touch "$PKG/backtest/engine/__init__.py"
touch "$PKG/backtest/engine/orders.py" "$PKG/backtest/engine/fills.py" "$PKG/backtest/engine/portfolio_state.py"
touch "$PKG/backtest/costs/__init__.py"
touch "$PKG/backtest/costs/transaction_costs.py" "$PKG/backtest/costs/slippage.py"
touch "$PKG/backtest/validation/__init__.py"
touch "$PKG/backtest/validation/walk_forward.py" "$PKG/backtest/validation/cross_validation.py"
touch "$PKG/backtest/metrics/__init__.py"
touch "$PKG/backtest/metrics/sharpe.py" "$PKG/backtest/metrics/drawdown.py" "$PKG/backtest/metrics/turnover.py"

# derivatives
mkdir -p "$PKG/derivatives"/{black_scholes,greeks,monte_carlo,implied_vol,hedging}
touch "$PKG/derivatives/__init__.py"
for d in black_scholes greeks monte_carlo implied_vol hedging; do
  touch "$PKG/derivatives/$d/__init__.py"
done

# risk
mkdir -p "$PKG/risk"/{var_es,factor_models,pca,stress_testing}
touch "$PKG/risk/__init__.py"
for d in var_es factor_models pca stress_testing; do
  touch "$PKG/risk/$d/__init__.py"
done

# viz
mkdir -p "$PKG/viz"
touch "$PKG/viz/__init__.py"
touch "$PKG/viz/style.py" "$PKG/viz/timeseries_plots.py" \
      "$PKG/viz/portfolio_plots.py" "$PKG/viz/risk_plots.py"

# ---------- projects/ ----------
PROJECTS=(
  "00_dyno_to_markets"
  "01_return_forecasting_baselines"
  "02_portfolio_optimisation"
  "03_backtest_engine"
  "04_options_pricing_and_greeks"
  "05_gp_volatility"
  "06_microstructure_execution"
  "07_advanced_strategy_research"
)
for p in "${PROJECTS[@]}"; do
  mkdir -p "projects/$p"/{notebooks,scripts,figures}
  touch "projects/$p/notebooks/.gitkeep" "projects/$p/scripts/.gitkeep" "projects/$p/figures/.gitkeep"
  touch "projects/$p/data_refs.md" "projects/$p/report.md"
done

# ---------- notebooks/_scratch ----------
mkdir -p notebooks/_scratch/{2026_01,2026_02,2026_03}
for q in 2026_01 2026_02 2026_03; do
  touch "notebooks/_scratch/$q/.gitkeep"
done

# ---------- data/ ----------
mkdir -p data/raw/{equities,rates,fx,options,alternative} data/interim data/processed
for d in equities rates fx options alternative; do
  touch "data/raw/$d/.gitkeep"
done
touch data/interim/.gitkeep data/processed/.gitkeep

# ---------- docs/ ----------
mkdir -p docs/theory/{linear_algebra,probability_statistics,stochastic_calculus}
touch docs/theory/linear_algebra/.gitkeep \
      docs/theory/probability_statistics/.gitkeep \
      docs/theory/stochastic_calculus/.gitkeep
touch docs/theory/kalman_for_finance.md \
      docs/theory/black_scholes_derivation.md \
      docs/theory/garch_and_volatility_clustering.md \
      docs/theory/factor_models.md \
      docs/theory/microstructure.md
mkdir -p docs/learning_log/{2026_Q1,2026_Q2}
touch docs/learning_log/2026_Q1/.gitkeep docs/learning_log/2026_Q2/.gitkeep
mkdir -p docs/references
touch docs/references/books.md docs/references/papers.md docs/references/courses.md

# ---------- reports/ ----------
mkdir -p reports/{investor_memos,fund_teardowns,comparable_decks,deal_sourcing_maps}
for d in investor_memos fund_teardowns comparable_decks deal_sourcing_maps; do
  touch "reports/$d/.gitkeep"
done

# ---------- journal/ ----------
mkdir -p journal/{trade_ideas,post_mortems}
touch journal/trade_ideas/.gitkeep journal/post_mortems/.gitkeep

# ---------- tests/ ----------
mkdir -p tests/{data,timeseries,estimation,portfolio,backtest,derivatives,risk,viz}
touch tests/__init__.py
for d in data timeseries estimation portfolio backtest derivatives risk viz; do
  touch "tests/$d/__init__.py"
done
touch tests/estimation/test_kalman.py \
      tests/estimation/test_particle_filter.py \
      tests/estimation/test_rls.py

echo "Done. Tree created at: $(pwd)"
