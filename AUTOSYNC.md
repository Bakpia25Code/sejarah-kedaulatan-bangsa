# Autosync ke GitHub

Setiap kali file di folder ini diubah dan disimpan, perubahannya otomatis
di-*commit* dan di-*push* ke GitHub, dan situsnya ikut ter-update.

- **Repo:** https://github.com/Bakpia25Code/sejarah-kedaulatan-bangsa
- **Situs:** https://bakpia25code.github.io/sejarah-kedaulatan-bangsa/

---

## ⚠️ Satu langkah manual yang wajib dilakukan dulu

macOS memproteksi folder **Downloads**, **Documents**, dan **Desktop**. Proses
latar belakang (launchd) tidak diizinkan membacanya, jadi autosync **belum akan
jalan** sampai Anda memberi izin **Full Disk Access** ke `/bin/zsh`.

### Cara memberi izin

1. Buka panel izinnya — tempel perintah ini di Terminal:

   ```
   open "x-apple.systempreferences:com.apple.preference.security?Privacy_AllFiles"
   ```

   Atau manual: **System Settings → Privacy & Security → Full Disk Access**.

2. Klik tombol **+** di daftar aplikasi.

3. Di jendela pemilih file, tekan **⇧⌘G** (Shift-Command-G), lalu ketik:

   ```
   /bin/zsh
   ```

   Tekan Enter, lalu klik **Open**.

4. Pastikan sakelar di sebelah **zsh** dalam posisi **menyala (biru)**.

5. Muat ulang autosync-nya:

   ```
   launchctl bootout gui/$UID/com.bakpia25.sejarah-autosync 2>/dev/null
   launchctl bootstrap gui/$UID ~/Library/LaunchAgents/com.bakpia25.sejarah-autosync.plist
   ```

### Cara memastikan sudah berhasil

```
launchctl kickstart -p gui/$UID/com.bakpia25.sejarah-autosync
sleep 12
cat ~/Downloads/"SEJARAH TUGAS 1 KELAS XII"/.autosync/sync.log
```

| Isi log | Artinya |
|---|---|
| `cek : tidak ada perubahan` | ✅ **Berhasil** — autosync sudah aktif |
| `commit : …` lalu `push : berhasil` | ✅ **Berhasil** — perubahan sudah terunggah |
| `can't open input file` atau `Operation not permitted` | ❌ Full Disk Access belum aktif |
| `GAGAL : folder tidak terbaca` | ❌ Full Disk Access belum aktif |

> Kalau setelah memberi izin ke `/bin/zsh` masih gagal, tambahkan juga
> `/opt/homebrew/bin/git` ke daftar Full Disk Access dengan cara yang sama.

---

## Sync manual (selalu bisa dipakai)

Cara ini **jalan sekarang juga**, tanpa perlu izin apa pun, karena dijalankan
langsung dari Terminal:

```
~/Downloads/"SEJARAH TUGAS 1 KELAS XII"/.autosync/sync.sh
```

Supaya lebih singkat, tambahkan alias ke `~/.zshrc`:

```
echo 'alias sync-sejarah='\''~/Downloads/"SEJARAH TUGAS 1 KELAS XII"/.autosync/sync.sh'\''' >> ~/.zshrc
```

Setelah membuka Terminal baru, cukup ketik **`sync-sejarah`**.

---

## Cara kerjanya

| Komponen | Lokasi |
|---|---|
| Skrip sync | `.autosync/sync.sh` |
| Konfigurasi launchd | `~/Library/LaunchAgents/com.bakpia25.sejarah-autosync.plist` |
| Log | `.autosync/sync.log` (tidak ikut diunggah ke GitHub) |

Pemicunya ada dua:

- **Saat file berubah** — launchd memantau folder proyek, `assets/`, `assets/img/`,
  dan `assets/video/`.
- **Tiap 10 menit** — pengaman kalau ada perubahan yang terlewat.

Skrip menunggu 6 detik sebelum bekerja supaya perubahan beruntun jadi satu commit,
dan memakai kunci direktori agar tidak ada dua proses sync berbarengan.

Setelah push, GitHub Pages membangun ulang situs secara otomatis — biasanya
selesai dalam **1–2 menit**.

## Mematikan autosync

```
launchctl bootout gui/$UID/com.bakpia25.sejarah-autosync
```

Menyalakan lagi:

```
launchctl bootstrap gui/$UID ~/Library/LaunchAgents/com.bakpia25.sejarah-autosync.plist
```
