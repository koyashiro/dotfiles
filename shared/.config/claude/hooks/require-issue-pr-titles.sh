#!/bin/sh
# Stop hook: keep Claude going when its last response mentions an issue or pull
# request number without the title, e.g. `#1234` instead of `#1234 (Title)`.

set -eu

input=$(cat)

# Block only once per turn so an unsatisfiable block cannot loop until Claude
# Code's continuation cap.
if [ "$(printf '%s' "$input" | jq -r '.stop_hook_active')" = true ]; then
  exit 0
fi

# Code blocks, inline code, URLs, and HTML entities are skipped because `#123`
# there is not a reference. They are removed up front rather than by checking
# the character before `#`, which in a UTF-8 locale would also reject
# references right after Japanese text or `PR`.
# A fence closes only on the same character repeated at least as many times,
# so fences nested in longer fences and inline ```code``` do not toggle it.
# shellcheck disable=SC2016 # the backticks are Markdown, not command substitution
refs=$(printf '%s' "$input" | jq -r '.last_assistant_message // empty' \
  | awk '
    {
      line = $0
      sub(/^[[:space:]]*/, "", line)
    }
    fence == "" {
      if (match(line, /^(```+|~~~+)/)) {
        marker = substr(line, 1, RLENGTH)
        if (!(marker ~ /^`/ && index(substr(line, RLENGTH + 1), "`"))) {
          fence = marker
          next
        }
      }
      print
      next
    }
    {
      if (match(line, /^(`+|~+)/) && substr(line, 1, 1) == substr(fence, 1, 1) && RLENGTH >= length(fence) && substr(line, RLENGTH + 1) ~ /^[[:space:]]*$/) {
        fence = ""
      }
    }' \
  | sed -e 's/`[^`]*`//g' -e 's/https*:\/\/[^[:space:]]*//g' -e 's/&#[0-9]*;//g' \
  | grep -oE '#[0-9]+( \()?' \
  | grep -v ' ($' \
  | sort -u \
  | tr '\n' ' ')

if [ -z "$refs" ]; then
  exit 0
fi

jq -n --arg refs "${refs% }" '{
  decision: "block",
  reason: "Issue/PR numbers without titles: \($refs). Restate them with their titles in the form `#1234 (Title)`, looking titles up with gh if needed."
}'
