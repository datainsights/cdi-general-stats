# 📘 Domain-Specific R Packages for General Data Science

# Ensure BiocManager is available (if needed)
if (!requireNamespace("BiocManager", quietly = TRUE)) install.packages("BiocManager")
library(BiocManager)

# List of core packages for foundational DS work
domain_pkgs <- c(
  "tidyverse",       # includes ggplot2, dplyr, readr, tidyr, forcats, etc.
  "scales",          # for axis scaling and formatting
  "GGally",          # for pair plots and extended ggplot2 features
  "ggcorrplot",      # for correlation heatmaps
  "treemap",         # for hierarchical visualizations
  "palmerpenguins",  # for clean example datasets
  "broom",           # for tidying model outputs
  "car",             # for ANOVA and regression diagnostics
  "emmeans",         # for estimated marginal means
  "caret",           # for machine learning workflows
  "viridis",          # for colorblind-friendly palettes (used in ggplot2)
  "Rtsne",
  "uwot"
)

for (pkg in domain_pkgs) {
  if (!requireNamespace(pkg, quietly = TRUE)) {
    renv::install(pkg, repos = BiocManager::repositories())
  }
}

# Install additional ML packages commonly used in general DS workflows
ml_pkgs <- c("randomForest", "e1071", "nnet", "xgboost", "rpart", "rpart.plot", "glmnet", "caret")

for (pkg in ml_pkgs) {
  if (!requireNamespace(pkg, quietly = TRUE)) {
    renv::install(pkg, repos = BiocManager::repositories())
  }
}

# Install GitHub package: mikropml
if (!requireNamespace("mikropml", quietly = TRUE)) {
  renv::install("SchlossLab/mikropml")
}

message("✅ general-ds domain-specific setup complete.")