#! /bin/bash

tmpfile=$(mktemp)
trap 'rm -f "$tmpfile"' EXIT

one_year_ago=$(date -d '1 year ago' +%s 2>/dev/null || date -v-1y +%s 2>/dev/null)
find ~/.local/share/astronvim/lazy -type d -name '.git' -print | while read -r git_dir; do
	repo_dir="$(dirname "$git_dir")"
	repo_name="$(basename "$repo_dir")"

	cd "$repo_dir" || continue

	current_sha=$(git rev-parse --short HEAD)
	current_date=$(git log -1 --format=%ci HEAD | cut -d' ' -f1)
	current_epoch=$(git log -1 --format=%ct HEAD)

	origin_sha=$(git rev-parse --short origin/HEAD 2>/dev/null || echo "N/A")
	if [ "$origin_sha" != "N/A" ]; then
		origin_date=$(git log -1 --format=%ci origin/HEAD 2>/dev/null | cut -d' ' -f1 || echo "N/A")
	else
		origin_date="N/A"
	fi

	printf '%s\t%s\t%s\t%s\t%s\t%s\n' "$current_date" "$repo_name" "$current_sha" "$origin_sha" "$origin_date" "$current_epoch"
done >"$tmpfile"

sort -r "$tmpfile" | while IFS=$'\t' read -r current_date repo current_sha origin_sha origin_date current_epoch; do

	label="updated"
	style=""

	if [ "$current_epoch" -lt "$one_year_ago" ] 2>/dev/null; then
		label="stale"
		style="\033[0;31m"
	elif [ "$current_date" != "$origin_date" ] && [ "$origin_date" != "N/A" ]; then
		label="outdated"
		style="\033[0;33m"
	fi
	no_color='\033[0m' # No Color
	echo -e -n "${style}[$label]${no_color} $repo"
	echo -n ", current: $current_sha ($current_date)"
	if [ "$origin_sha" != "N/A" ]; then
		echo -n ", origin: $origin_sha ($origin_date)"
	else
		echo -n ", origin: N/A"
	fi
	echo ""
done
