for f in staging-*; do mv "$f" $(echo "$f" | sed 's/^staging-//g'); done
