#!/bin/zsh
# Autosync: commit + push perubahan folder presentasi ke GitHub.
# Dipicu oleh launchd (~/Library/LaunchAgents/com.bakpia25.sejarah-autosync.plist)
# setiap kali ada file berubah, dan sebagai pengaman tiap 10 menit.
#
# Jalankan manual:      ~/Downloads/"SEJARAH TUGAS 1 KELAS XII"/.autosync/sync.sh
# Lihat log:            tail -f ~/Downloads/"SEJARAH TUGAS 1 KELAS XII"/.autosync/sync.log

export PATH="/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"

REPO="/Users/arlensanjaya/Downloads/SEJARAH TUGAS 1 KELAS XII"
LOG="$REPO/.autosync/sync.log"
LOCK="$REPO/.autosync/.lock"

cd "$REPO" || exit 1

log() { print -r -- "[$(date '+%Y-%m-%d %H:%M:%S')] $*" >> "$LOG"; }

# Satu proses saja dalam satu waktu. mkdir bersifat atomik.
if ! mkdir "$LOCK" 2>/dev/null; then
  exit 0
fi
trap 'rmdir "$LOCK" 2>/dev/null' EXIT INT TERM

# Debounce: tunggu sebentar supaya editor selesai menulis file,
# lalu serap letupan perubahan beruntun jadi satu commit.
sleep 6

# Buang berkas sampah macOS sebelum staging.
find . -name '.DS_Store' -not -path './.git/*' -delete 2>/dev/null

if [[ -z "$(git status --porcelain)" ]]; then
  exit 0
fi

CHANGED=$(git status --porcelain | wc -l | tr -d ' ')
git add -A

# Ringkas nama file yang berubah untuk judul commit.
FILES=$(git diff --cached --name-only | head -3 | xargs -n1 basename 2>/dev/null | paste -sd ', ' -)
[[ $CHANGED -gt 3 ]] && FILES="$FILES, +$((CHANGED - 3)) lainnya"

if git commit -q -m "Autosync: $FILES" -m "Diperbarui otomatis pada $(date '+%d %B %Y, %H:%M WIB')."; then
  log "commit  : $CHANGED berkas — $FILES"
else
  log "GAGAL   : commit tidak berhasil"
  exit 1
fi

if git push -q origin main 2>>"$LOG"; then
  log "push    : berhasil → github.com/Bakpia25Code/sejarah-kedaulatan-bangsa"
  log "          situs akan ter-update dalam ~1-2 menit"
else
  log "GAGAL   : push ditolak — cek koneksi atau jalankan 'gh auth status'"
  exit 1
fi

# Jaga ukuran log tetap wajar.
if [[ $(wc -l < "$LOG") -gt 500 ]]; then
  tail -200 "$LOG" > "$LOG.tmp" && mv "$LOG.tmp" "$LOG"
fi
