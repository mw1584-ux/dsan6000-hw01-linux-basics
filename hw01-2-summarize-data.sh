#!/bin/bash

# Define the final output file in the repository root
OUTPUT_FILE="wikimedia_data_summary.csv"

# 1. Create the header row (overwrites the file if it already exists)
echo "filename,size,num_lines" > "$OUTPUT_FILE"

# 2. Loop through all .csv files inside the data folder
for filepath in data/*.csv; do
    # Skip the loop if no matching files are found
    [ -e "$filepath" ] || continue

    # Extract just the filename without the "data/" path prefix
    filename=$(basename "$filepath")

    # Get human-readable size (awk grabs the 5th column from standard ls -h output)
    size=$(ls -lh "$filepath" | awk '{print $5}')

    # Count the lines (awk grabs the number block and ignores the path suffix)
    num_lines=$(wc -l < "$filepath")

    # Append the row data into the summary CSV file
    echo "$filename,$size,$num_lines" >> "$OUTPUT_FILE"
done
