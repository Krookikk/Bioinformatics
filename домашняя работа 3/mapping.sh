#!/bin/bash

file="flagstat.txt"
mapped=$(grep "mapped (" "$file" | head -n 1 | awk '{print $1}')
total=$(grep "in total" "$file" | awk '{print $1}')

percent=$(echo "scale=2; 100 * $mapped / $total" | bc)

echo "Mapped: $mapped / $total (${percent}%)"

#! Для ONT порог ниже.
if (( $(echo "$percent > 70" | bc -l) )); then
  echo "OK"
else
  echo "Not OK"
fi
