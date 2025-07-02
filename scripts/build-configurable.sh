#!/bin/bash

# Exit immediately if any command fails
set -e

# Print the current R version (useful for logging and debugging)
echo "📦 R version:"
Rscript -e 'R.version.string'

# Function to link the correct Bookdown YAML config file
# Arguments:
#   $1 - The config filename to use (e.g., _bookdown-viz.yml)
link_bookdown_config() {
  local config="$1"
  echo "🔧 Using config: $config"

  # Create or update a symbolic link named _bookdown.yml pointing to the desired config
  cp -f "$config" _bookdown.yml
}

# -------------------------------
# Statistical Analysis GitBook
# -------------------------------
if [[ "$1" == "stats-gitbook" ]]; then
  echo "📘 Building Statistical Analysis GitBook..."
  cp -f index-stats-gitbook.Rmd index.Rmd
  link_bookdown_config _bookdown-stats.yml
  mkdir -p stats-gitbook
  Rscript -e 'bookdown::render_book("index.Rmd", "bookdown::gitbook", output_dir = "docs")'
  rm index.Rmd
  echo "✅ Statistical Analysis GitBook complete → /docs"

# -------------------------------
# Statistical Analysis PDF
# -------------------------------
elif [[ "$1" == "stats-pdf" ]]; then
  echo "📘 Building Statistical Analysis PDF..."
  cp -f index-stats-pdf.Rmd index.Rmd
  link_bookdown_config _bookdown-stats.yml
  mkdir -p stats-pdf
  Rscript -e 'bookdown::render_book("index.Rmd", "bookdown::pdf_book", output_dir = "stats-pdf")'
  rm index.Rmd
  echo "✅ Statistical Analysis PDF complete → /stats-pdf"

# -------------------------------
# Help / fallback
# -------------------------------
else
  echo "❌ Unknown build option: $1"
  echo "Usage: $0 {stats-gitbook|stats-pdf}"
  exit 1
fi

echo "🧹 Cleaning up Visualization build files..."
rm -f stats-pdf/*.md stats-pdf/*.tex
rm -rf stats-pdf/_bookdown_files/
rm -f ./*.rds
echo "✅ Cleanup complete."

# Remove symlink to avoid accidental reuse
rm -f index.Rmd
rm -f _bookdown.yml