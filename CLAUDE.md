# CLAUDE.md

Panduan untuk Claude Code saat bekerja di repo ini.

## Apa ini

Presentasi web satu berkas untuk tugas **Sejarah Kelas XII**, sub-topik
*Perundingan RI dengan Pihak Asing tentang Kedaulatan Ekonomi*. Isinya
membandingkan perundingan RI–Belanda 1945–1949 (Linggarjati, Renville,
Roem–Royen, KMB) dengan tantangan ketahanan energi Indonesia akibat
ketegangan di Selat Hormuz.

Bukan aplikasi — tidak ada build step, tidak ada dependensi, tidak ada
package manager. Cukup HTML + CSS + JavaScript vanilla dalam satu berkas.

- **Live:** https://bakpia25code.github.io/sejarah-kedaulatan-bangsa/
- **Repo:** https://github.com/Bakpia25Code/sejarah-kedaulatan-bangsa

## Struktur

```
index.html          seluruh deck — markup, CSS, dan JS jadi satu (±79 KB)
assets/img/         39 foto, peta, dan grafik
assets/video/       5 rekaman film berita arsip (webm, ±84 MB)
.autosync/sync.sh   skrip commit + push otomatis
AUTOSYNC.md         cara kerja & pemecahan masalah autosync
CARA-PAKAI.md       panduan untuk penyaji (bahasa non-teknis)
RINGKASAN-SESI.md   riwayat keputusan desain & isi
SEJARAH - ….docx    naskah tugas asli — sumber kebenaran untuk isi
```

## Aturan yang tidak boleh dilanggar

### 1. Tidak boleh ada media yang dipakai dua kali

Ini permintaan eksplisit pemilik repo. Ada **39 slot gambar dan 39 berkas
gambar** — pemetaannya satu lawan satu. Video juga: 5 berkas, masing-masing
dipakai sekali.

Kalau menambah slot gambar, **unduh berkas baru**, jangan memakai ulang yang
sudah ada. Verifikasi sebelum menyerahkan pekerjaan:

```bash
# harus tidak menghasilkan output apa pun
grep -o 'assets/img/[a-z0-9-]*\.\(jpg\|png\)' index.html | sort | uniq -c | awk '$1>1'
grep -o 'assets/video/[a-z0-9-]*\.webm'       index.html | sort | uniq -c | awk '$1>1'

# tidak boleh ada berkas menganggur
for f in assets/img/* assets/video/*; do
  grep -q "$(basename "$f")" index.html || echo "tak terpakai: $f"
done
```

Hindari juga duplikasi **informasi**: jangan mengulang argumen yang sudah
disampaikan slide lain. Slide kronologi (11) sengaja hanya berisi ringkasan
satu kalimat karena detailnya ada di slide 12–18.

### 2. Isi harus mengikuti naskah tugas

`SEJARAH - Perundingan RI ….docx` adalah sumber kebenaran. Jawaban atas
pertanyaan tugas (ancaman, aktor, strategi, risiko/peluang, tokoh, dampak,
persamaan, perbedaan, relevansi) harus tetap sesuai isinya. Boleh menambah
konteks pendukung, tetapi tandai sumbernya di slide 24–25.

Fakta tambahan yang ditambahkan di luar naskah **wajib diverifikasi** dan
dicantumkan sumbernya — jangan mengarang angka.

### 3. Semua media harus berlisensi terbuka

Hanya Domain Publik, CC0, CC BY, atau CC BY-SA — praktiknya dari Wikimedia
Commons. Setiap sumber baru harus ditambahkan ke kredit di **slide 25**.

Unduh berkasnya ke `assets/`, jangan menaut ke URL luar: deck ini harus tetap
berjalan penuh tanpa koneksi internet.

### 4. Jangan memutus jalur aset

`index.html` memanggil media lewat jalur relatif (`assets/img/…`). Berkas ini
harus tetap berada di akar repo, dan namanya harus tetap `index.html` karena
GitHub Pages memakainya sebagai halaman utama.

## Konvensi di dalam `index.html`

- **Panggung tetap 1280×720**, diperbesar/diperkecil lewat `transform: scale()`
  oleh fungsi `fit()`. Rancang tata letak dalam ukuran itu; jangan pakai satuan
  viewport di dalam slide.
- **Nomor slide dibuat otomatis** oleh JS (`slides.forEach` di awal skrip).
  Elemen `<span class="num">` sengaja dibiarkan kosong — jangan diisi manual.
- **Catatan penyaji** disimpan di atribut `data-notes` tiap `<section>`, berisi
  potongan `<li>`. Judul untuk mode ikhtisar ada di `data-title`.
- **Video** memakai `preload="metadata"` dan otomatis dijeda saat pindah slide.
  Klik pada area `.videobox` tidak memicu pindah slide.
- Kelas tata letak yang tersedia: `.cols` dengan `.c-2 / .c-2a / .c-2b / .c-3`,
  lalu `.stack`, `.card` (varian `.accent / .danger / .good / .mid`), `.fig`
  (varian `.contain` untuk peta dan grafik), `.videobox`, `.portrait`,
  `.timeline`, `.quote`, `.tbl-wrap`, `.roster`.
- Bahasa: **Indonesia**, termasuk komentar dan teks antarmuka.

## Cara memeriksa hasil secara visual

Tidak ada test suite. Untuk melihat slide tanpa membuka browser:

```bash
CHROME="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
F="file://$PWD/index.html"
for n in 5 12 18; do
  "$CHROME" --headless --disable-gpu --allow-file-access-from-files \
    --window-size=1400,800 --virtual-time-budget=3500 --hide-scrollbars \
    --screenshot="/tmp/slide-$n.png" "$F#$n"
done
```

Lalu baca berkas PNG-nya. Yang paling sering perlu diperbaiki: potongan foto
(`object-position`) dan grafik yang mengecil karena kotaknya terlalu pendek —
grafik lebar butuh kotak yang tinggi, atur lewat `flex`.

## Mengunggah perubahan

```bash
./.autosync/sync.sh      # commit + push; Pages membangun ulang otomatis (1–2 menit)
```

Deploy memakai **GitHub Pages dari branch `main`, folder root** — bukan GitHub
Actions. Token `gh` di mesin ini **tidak punya scope `workflow`**, jadi berkas
di `.github/workflows/` akan ditolak saat push. Jangan menambahkannya.

Autosync latar belakang lewat launchd **sudah aktif** — setiap penyimpanan berkas
otomatis di-commit dan di-push. Log-nya di `~/Library/Logs/sejarah-autosync.log`.

> ⚠️ Log dan berkas kunci **wajib berada di luar folder proyek**. Kalau ditulis
> di dalam folder yang dipantau `WatchPaths`, setiap penulisan log memicu agent
> jalan lagi — loop tak berujung yang menghabiskan CPU. Ini pernah terjadi dan
> sudah diperbaiki; jangan dikembalikan ke dalam repo.

Autosync bergantung pada Full Disk Access untuk `/bin/zsh`, karena macOS
memblokir proses latar belakang membaca `~/Downloads`. Lihat `AUTOSYNC.md`.

## Catatan privasi

Repo ini **publik** dan slide 2 memuat nama lengkap serta nomor presensi enam
siswa — pemilik repo sudah diberi tahu dan memilih ini secara sadar. Email
commit sengaja diset ke alamat `users.noreply.github.com`; jangan menggantinya
ke email pribadi.
