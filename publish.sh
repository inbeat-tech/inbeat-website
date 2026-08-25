#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"

REPO="inbeat-tech/inbeat-website"
REMOTE_URL="git@github.com:${REPO}.git"
CNAME_DOMAIN="$(tr -d '[:space:]' < CNAME)"
PAGES_URL="https://${CNAME_DOMAIN}/"

if command -v gh >/dev/null 2>&1; then
  GH="$(command -v gh)"
elif [[ -x "$HOME/.local/bin/gh" ]]; then
  GH="$HOME/.local/bin/gh"
else
  GH=""
fi

if git remote get-url origin >/dev/null 2>&1; then
  git remote set-url origin "$REMOTE_URL"
else
  git remote add origin "$REMOTE_URL"
fi

git push -u origin HEAD

if [[ -n "$GH" ]] && "$GH" auth status >/dev/null 2>&1; then
  "$GH" api -X POST "repos/${REPO}/pages" \
    -f build_type=workflow \
    -f cname="$CNAME_DOMAIN" \
    2>/dev/null || \
  "$GH" api -X PUT "repos/${REPO}/pages" \
    -f build_type=workflow \
    -f cname="$CNAME_DOMAIN" \
    -F https_enforced=true \
    2>/dev/null || \
  echo "If Pages API failed, enable manually: Settings → Pages → GitHub Actions, Custom domain → ${CNAME_DOMAIN}"
else
  echo "Enable Pages manually (or after gh auth): Settings → Pages → GitHub Actions, Custom domain → ${CNAME_DOMAIN}"
fi

echo
echo "Site URL:"
echo "$PAGES_URL"
