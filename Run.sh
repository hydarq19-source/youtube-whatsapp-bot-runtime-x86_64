#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
cd "$ROOT"

if [[ "$(uname -s)" != Linux || "$(uname -m)" != x86_64 ]]; then
  echo "هذه الحزمة مخصصة لـ Linux x86_64 فقط." >&2
  exit 1
fi
if [[ ! -x "$ROOT/whatsapp-rust-bot" || ! -x "$ROOT/libraries/deno" ]]; then
  echo "ملفات runtime ناقصة؛ تأكد من فك ضغط الحزمة كاملةً." >&2
  exit 1
fi

if [[ ! -x "$ROOT/libraries/yt-dlp" ]]; then
  YTDLP_SOURCE="${YTDLP_BINARY:-$(command -v yt-dlp || true)}"
  if [[ -z "$YTDLP_SOURCE" || ! -x "$YTDLP_SOURCE" ]]; then
    echo "لم يتم العثور على yt-dlp. ضعه في libraries/yt-dlp أو شغّل: YTDLP_BINARY=/مسار/yt-dlp ./Run.sh" >&2
    exit 1
  fi
  mkdir -p "$ROOT/libraries"
  cp "$YTDLP_SOURCE" "$ROOT/libraries/yt-dlp"
  chmod 755 "$ROOT/libraries/yt-dlp"
fi

if [[ ! -f "$ROOT/.env" ]]; then cp "$ROOT/.env.example" "$ROOT/.env"; fi
if ! grep -q '^WHATSAPP_PHONE_NUMBER=..*' "$ROOT/.env"; then
  if [[ ! -t 0 ]]; then
    echo "عدّل .env وضع WHATSAPP_PHONE_NUMBER بصيغة دولية ثم أعد التشغيل." >&2
    exit 1
  fi
  read -r -p "رقم WhatsApp بصيغة دولية من دون + أو مسافات: " PHONE
  if [[ -z "$PHONE" ]]; then echo "رقم الهاتف مطلوب؛ عدّل .env وأعد التشغيل." >&2; exit 1; fi
  PHONE_VALUE="$PHONE" python3 - "$ROOT/.env" <<'PY'
import os, pathlib, sys
p=pathlib.Path(sys.argv[1]); lines=p.read_text().splitlines()
for i, line in enumerate(lines):
    if line.startswith('WHATSAPP_PHONE_NUMBER='):
        lines[i]='WHATSAPP_PHONE_NUMBER='+os.environ['PHONE_VALUE']; break
else: lines.insert(0,'WHATSAPP_PHONE_NUMBER='+os.environ['PHONE_VALUE'])
p.write_text('\n'.join(lines)+'\n')
PY
fi
export PATH="$ROOT/libraries:$PATH"
exec "$ROOT/whatsapp-rust-bot" "$@"
