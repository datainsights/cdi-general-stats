#!/bin/bash

# Define the list of Jupyter Notebook filenames (without extension)
NOTEBOOK_NAMES=(
    "01-0-setup-ds"
    "01-1-eda-ds"
    # "01-2-viz-ds"
    # "99-what-next"
    # "01-3-stats-ds"
    # "01-4-ml-ds"
)

# Define the output directory (use current folder)
OUTPUT_DIR="./"

# Create the output directory if it doesn't exist
mkdir -p "$OUTPUT_DIR"

# Loop through each notebook
for NOTEBOOK_NAME in "${NOTEBOOK_NAMES[@]}"; do
    if [[ ! -f "$NOTEBOOK_NAME.ipynb" ]]; then
        echo "❌ $NOTEBOOK_NAME.ipynb not found. Skipping..."
        continue
    fi

    echo "⚙️  Executing and converting: $NOTEBOOK_NAME.ipynb"

    # Step 1: Execute and convert notebook to Markdown with outputs
    jupyter nbconvert --to markdown --execute \
        --ExecutePreprocessor.timeout=300 \
        --output-dir "$OUTPUT_DIR" \
        "$NOTEBOOK_NAME.ipynb"

    # Step 2: Rename .md to .Rmd
    if [[ -f "$OUTPUT_DIR/$NOTEBOOK_NAME.md" ]]; then
        mv "$OUTPUT_DIR/$NOTEBOOK_NAME.md" "$OUTPUT_DIR/$NOTEBOOK_NAME.Rmd"
        echo "✅ Converted: $NOTEBOOK_NAME.Rmd"
    else
        echo "⚠️  Warning: $NOTEBOOK_NAME.md not found. Skipping rename."
        continue
    fi

    # Step 3: Fix image tag formatting if needed
    if [[ "$OSTYPE" == "darwin"* ]]; then
        sed -i '' 's/!\[png\]/![]/g' "$OUTPUT_DIR/$NOTEBOOK_NAME.Rmd"
    else
        sed -i 's/!\[png\]/![]/g' "$OUTPUT_DIR/$NOTEBOOK_NAME.Rmd"
    fi
done

  mkdir -p docs
  Rscript -e 'bookdown::render_book("index.Rmd", "bookdown::gitbook", output_dir = "docs")'
  echo "✅ General DS Free GitBook complete → /docs"
