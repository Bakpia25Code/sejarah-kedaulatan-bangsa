# Ringkasan Sesi — Riwayat Pembuatan Proyek

Catatan apa yang dikerjakan, apa yang diputuskan, dan alasannya. Berguna kalau
proyek ini dilanjutkan lain waktu.

---

## 1. Titik awal

Folder hanya berisi satu berkas:
`SEJARAH - Perundingan RI dengan Pihak Asing tentang Kedaulatan Ekonomi.docx`

Isinya jawaban tugas kelompok dengan tiga bagian:

| Bagian | Isi |
|---|---|
| Kasus Masa Kini | Ketegangan Selat Hormuz — ancaman, aktor, strategi, risiko & peluang |
| Kasus Sejarah 1945–1949 | Linggarjati, Renville, Roem–Royen — latar belakang, tokoh, dampak |
| Sintesis Perbandingan | Persamaan, perbedaan, dan nilai yang masih relevan |

**Permintaan:** buatkan presentasi versi web yang sesuai, lengkap dengan foto
dan video dari internet.

## 2. Pencarian dan pengunduhan media

Seluruh media diambil dari **Wikimedia Commons** melalui API-nya, lalu
**diunduh ke folder `assets/`** — bukan ditaut dari internet — supaya
presentasi tetap berjalan penuh saat ditayangkan di kelas tanpa wifi.

Temuan penting: Commons menyimpan **rekaman film berita asli Polygoon dan Open
Beelden tahun 1946–1950**, jadi videonya benar-benar arsip sezaman, bukan video
penjelasan buatan orang lain. Diambil versi transcode 480p VP9 agar ukurannya
wajar.

Lima video yang dipakai:

| Berkas | Isi | Slide |
|---|---|---|
| `linggarjati.webm` | Penandatanganan Perjanjian Linggarjati | 12 |
| `agresi.webm` | "Politionele Akties" — aksi militer Belanda | 13 |
| `renville.webm` | Penandatanganan gencatan senjata di kapal *Renville* | 14 |
| `kmb.webm` | Suasana Konferensi Meja Bundar | 18 |
| `kedaulatan.webm` | Penyerahan kedaulatan & kedatangan Soekarno di Jakarta | 18 |

Beberapa berkas diolah lagi: peta wilayah RI 1948 dipotong agar fokus ke
Indonesia (aslinya terlalu banyak ruang kosong), dan foto `agresi-3` dibuang
karena negatifnya rusak.

## 3. Deck versi pertama — 23 slide

Tema gelap dengan aksen emas dan merah, panggung tetap 1280×720 yang diperbesar
mengikuti layar. Fitur: navigasi papan ketik, mode ikhtisar, **catatan penyaji
per slide** (tombol `N`), layar penuh, dan video yang otomatis berhenti saat
pindah slide.

Data tambahan di luar naskah tugas — ±20 juta barel/hari melintasi Selat Hormuz
pada 2024, setara ±20% konsumsi minyak dunia — diverifikasi ke **U.S. Energy
Information Administration** dan dicantumkan sumbernya.

Setiap slide diperiksa visualnya dengan tangkapan layar headless Chrome, lalu
diperbaiki: garis timeline yang tidak sejajar dengan titiknya, latar pembatas
bab yang terlalu gelap, dan beberapa slide yang menyisakan ruang kosong besar.

## 4. Permintaan lanjutan: sumber + anggota kelompok

Ditambahkan empat sumber. Metadatanya diverifikasi langsung ke penerbit supaya
penulisannya benar:

1. Safitry, Utami & Ilyas (2021), *Sejarah untuk SMA/SMK Kelas XI*, Kemendikbudristek
2. Suparjan, Edy & Khaldun (2021), *SOSIOHUMANIORA* 7(1), 122–131
3. Budiman (2017), *Jurnal Wahana Pendidikan* 4(1), Universitas Galuh
4. Kementerian Keuangan RI (2026), *APBN KITA*, edisi Februari 2026

> Domain `buku.kemdikbud.go.id` dan `media.kemenkeu.go.id` tidak dapat diakses
> dari lingkungan kerja, jadi dua entri itu ditulis berdasarkan judul katalog
> dan nama berkas yang diberikan. Dua jurnal lainnya terverifikasi langsung.

Ditambahkan pula **slide 2: Anggota Kelompok** berisi enam nama dengan nomor
presensi.

## 5. Pembersihan duplikasi

Permintaan: *"jangan sampai ada yang keduplikat apalagi pada bagian informasi
dan juga video"*.

Hasil audit:

- **Video** — ternyata tidak pernah duplikat, 5 berkas masing-masing sekali.
- **Gambar** — banyak duplikat: `kmb-hatta` 6×, `hormuz-satelit` 5×,
  `linggarjati-sign` 4×, `proklamasi` 3×.

Penyelesaian: **20 foto baru diunduh**, lalu seluruh slot dipetakan ulang
sehingga **39 slot = 39 foto berbeda**. Strip foto yang sifatnya sekadar
mengulang tampilan slide lain (di slide persamaan dan penutup) diganti kalimat
sintesis.

Tiga tambahan yang justru memperkuat isi:

- **Grafik neraca minyak Indonesia** — memperlihatkan Indonesia berbalik dari
  pengekspor menjadi pengimpor neto sekitar 2003, jadi klaim "importir neto"
  ada buktinya
- **Ratu Juliana menandatangani akta penyerahan kedaulatan** — berpasangan
  dengan foto Hatta menandatangani di Ridderzaal
- **Meja delegasi RI di KMB** lengkap dengan papan nama Sumitro, Sukiman,
  Roem, dan Hatta

Duplikasi **informasi** juga dibereskan: kartu yang mengulang argumen slide
relevansi diganti, dan slide Agresi Militer I yang tadinya mengulang "PBB
membentuk KTN" diisi informasi baru — anggota KTN adalah Australia (pilihan
Indonesia), Belgia (pilihan Belanda), dan Amerika Serikat (pilihan keduanya).

Nomor slide diubah jadi dibuat otomatis oleh JavaScript supaya tidak meleset
saat slide ditambah. **Hasil akhir: 25 slide.**

## 6. Unggah ke GitHub + Pages

Repo dibuat **publik** — pemilik memilih ini setelah diberi tahu bahwa nama
lengkap dan nomor presensi keenam siswa akan bisa diakses siapa saja dan
terindeks mesin pencari. GitHub Pages di akun gratis memang hanya bisa aktif
untuk repo publik.

Penyesuaian teknis:

- `presentasi.html` diganti nama menjadi **`index.html`** agar URL-nya bersih
- Ditambahkan `README.md`, `.nojekyll`, dan `.gitignore`
- Email commit diset ke alamat `users.noreply.github.com` supaya email pribadi
  tidak ikut terekspos di repo publik
- Deploy memakai **Pages dari branch `main` folder root**, bukan GitHub Actions,
  karena token `gh` di mesin ini tidak punya scope `workflow`

Terverifikasi live: beranda HTTP 200, foto dan video terlayani dengan
`content-type` yang benar.

## 7. Autosync — terhalang proteksi macOS

Pilihan pemilik: commit + push otomatis setiap kali berkas berubah.

Dipasang **launchd agent** (`com.bakpia25.sejarah-autosync`) dengan pemicu
`WatchPaths` pada folder proyek dan `assets/`, ditambah pengaman `StartInterval`
tiap 10 menit. Skripnya memakai debounce 6 detik dan kunci direktori agar tidak
ada dua proses berbarengan.

**Masalahnya:** agent gagal dengan *exit code 127*. Diagnosis dengan menjalankan
`ls` lewat launchd membuktikan penyebabnya **TCC macOS** — proses latar belakang
tidak diizinkan membaca `~/Downloads`, `~/Documents`, dan `~/Desktop`:

```
ls: /Users/…/Downloads/SEJARAH TUGAS 1 KELAS XII: Operation not permitted
```

Tiga jalan keluar ditawarkan; pemilik memilih **tetap di Downloads dan memberi
Full Disk Access ke `/bin/zsh` secara manual**. Konfigurasi `ProgramArguments`
diubah memanggil `/bin/zsh` secara eksplisit supaya proses yang bertanggung
jawab di mata TCC jelas binari itu.

**Status: menunggu izin diberikan.** Langkahnya ada di `AUTOSYNC.md`.
Sementara itu sync manual (`./.autosync/sync.sh`) sudah berfungsi normal.

---

## Keputusan yang sebaiknya tidak diubah tanpa alasan

| Keputusan | Alasan |
|---|---|
| Media diunduh lokal, bukan ditaut | Presentasi harus jalan tanpa internet di kelas |
| Satu slot = satu foto | Permintaan eksplisit pemilik |
| Nomor slide dibuat JavaScript | Agar tidak meleset saat slide ditambah |
| Pages dari branch, bukan Actions | Token `gh` tidak punya scope `workflow` |
| Email commit `users.noreply` | Repo publik, hindari bocornya email pribadi |
| Isi mengikuti naskah `.docx` | Itu jawaban tugas yang dinilai |
