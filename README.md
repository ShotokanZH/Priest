# Priest
Automatically checks if (OSx) daemons are editable somehow, automatically logs the (positive) output.

# How to make it work:
- `chmod +x priest.sh`
- now you can run:
  - `./priest.sh` (verbose)
  - `./priest.sh 2>/dev/null` (not verbose)

Note: STDOUT is automatically logged in `$(basename "$0").log` aka "priest.sh.log"
