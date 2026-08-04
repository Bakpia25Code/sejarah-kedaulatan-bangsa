# Autosync ke GitHub

Setiap kali berkas di folder ini diubah dan disimpan, perubahannya otomatis
di-*commit* dan di-*push* ke GitHub, lalu situsnya ikut ter-update.

- **Repo:** https://github.com/Bakpia25Code/sejarah-kedaulatan-bangsa
- **Situs:** https://bakpia25code.github.io/sejarah-kedaulatan-bangsa/

---

## Cek status sekarang

Tempel perintah ini di Terminal — hasilnya langsung memberi tahu autosync sudah
aktif atau belum:

```bash
cd ~/Downloads/"SEJARAH TUGAS 1 KELAS XII" && : > .autosync/sync.log && \
launchctl kickstart -p gui/$UID/com.bakpia25.sejarah-autosync >/dev/null 2>&1 && \
sleep 12 && cat .autosync/sync.log
```

| Yang muncul | Artinya |
|---|---|
| `cek : tidak ada perubahan` | ✅ **Aktif** — autosync sudah jalan |
| `commit : …` lalu `push : berhasil` | ✅ **Aktif** — perubahan sudah terunggah |
| `can't open input file` | ❌ Full Disk Access belum aktif — ikuti langkah di bawah |
| `GAGAL : folder tidak terbaca` | ❌ Full Disk Access belum aktif |

---

## ⚠️ Satu langkah manual yang wajib

macOS memproteksi folder **Downloads**, **Documents**, dan **Desktop**. Proses
latar belakang seperti launchd tidak diizinkan membacanya — dibuktikan lewat uji
langsung:

```
ls: /Users/…/Downloads/SEJARAH TUGAS 1 KELAS XII: Operation not permitted
```

Jadi autosync **belum akan jalan** sampai `/bin/zsh` diberi izin
**Full Disk Access**. Izin ini hanya bisa diberikan lewat System Settings —
tidak bisa dilakukan lewat perintah.

### Langkahnya

**1.** Buka panel izinnya:

```bash
open "x-apple.systempreferences:com.apple.preference.security?Privacy_AllFiles"
```

Atau manual: **System Settings → Privacy & Security → Full Disk Access**.

**2.** Klik tombol **+** di daftar aplikasi. Kalau diminta, masukkan kata sandi
Mac Anda.

**3.** Di jendela pemilih berkas, tekan **⇧⌘G** (Shift-Command-G), lalu ketik:

```
/bin/zsh
```

Tekan **Enter**, lalu klik **Open**.

> Folder `/bin` tersembunyi di Finder — itulah sebabnya harus lewat ⇧⌘G,
> tidak bisa diklik biasa.

**4.** Pastikan sakelar di sebelah **zsh** dalam posisi **menyala (biru)**.

**5.** Muat ulang autosync:

```bash
launchctl bootout gui/$UID/com.bakpia25.sejarah-autosync 2>/dev/null
launchctl bootstrap gui/$UID ~/Library/LaunchAgents/com.bakpia25.sejarah-autosync.plist
```

**6.** Jalankan **Cek status** di bagian atas berkas ini untuk memastikan.

> Kalau setelah itu masih gagal, tambahkan juga `/opt/homebrew/bin/git` ke
> daftar Full Disk Access dengan cara yang sama (langkah 2–4).

---

## Sync manual — selalu bisa dipakai

Cara ini **berfungsi sekarang juga**, tanpa izin apa pun, karena dijalankan
langsung dari Terminal:

```bash
~/Downloads/"SEJARAH TUGAS 1 KELAS XII"/.autosync/sync.sh
```

Supaya lebih singkat, buat alias sekali saja:

```bash
echo 'alias sync-sejarah='\''~/Downloads/"SEJARAH TUGAS 1 KELAS XII"/.autosync/sync.sh'\''' >> ~/.zshrc
```

Buka Terminal baru, lalu cukup ketik **`sync-sejarah`**.

---

## Cara kerjanya

| Komponen | Lokasi |
|---|---|
| Skrip sync | `.autosync/sync.sh` |
| Konfigurasi launchd | `~/Library/LaunchAgents/com.bakpia25.sejarah-autosync.plist` |
| Log | `.autosync/sync.log` — diabaikan git, tidak ikut terunggah |

Pemicunya dua lapis:

- **Saat berkas berubah** — `WatchPaths` memantau folder proyek, `assets/`,
  `assets/img/`, dan `assets/video/`.
- **Tiap 10 menit** — `StartInterval` sebagai pengaman kalau ada perubahan yang
  terlewat pantauan.

Skrip menunggu **6 detik** sebelum bekerja supaya perubahan beruntun menyatu jadi
satu commit, dan memakai kunci direktori supaya tidak ada dua proses sync
berbarengan. Berkas `.DS_Store` dibuang otomatis sebelum staging, dan log
dipangkas sendiri kalau sudah lewat 500 baris.

Setelah push, GitHub Pages membangun ulang situs otomatis — biasanya selesai
dalam **1–2 menit**.

---

## Menyalakan dan mematikan

```bash
# matikan
launchctl bootout gui/$UID/com.bakpia25.sejarah-autosync

# nyalakan lagi
launchctl bootstrap gui/$UID ~/Library/LaunchAgents/com.bakpia25.sejarah-autosync.plist

# lihat apakah sedang termuat
launchctl list | grep sejarah
```

## Kalau push gagal

```bash
gh auth status          # pastikan masih login sebagai Bakpia25Code
git -C ~/Downloads/"SEJARAH TUGAS 1 KELAS XII" status
```

Log kesalahan push ikut tercatat di `.autosync/sync.log`.
