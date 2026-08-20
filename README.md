<p align="center">
  <img src="https://raw.githubusercontent.com/neveerlabs/TermOS/main/assets.jpg" alt="Preview" width="600">TermOS Preview
</p>

Script konfigurasi Zsh untuk Termux yang membuat tampilan dan fitur seperti terminal Linux. Fitur:
- Autosuggestion dari history tersimpan (ghost text)
- Syntax highlighting untuk perintah, path & opsi
- Prompt dinamis menampilkan direktori aktif & virtual env
- Blok kursor, navigasi panah kanan pintar

## Persyaratan
- Termux (install dari F-Droid)
- Termux:API (install dari F-Droid)

## Setup & Installasi
Jalankan perintah berikut di Termux:
```bash
# Clone repositori:
git clone https://github.com/neveerlabs/TermOS.git

# Masuk kedalam folder:
cd TermOS

# Beri izin eksekusi:
chmod +x config.sh

# Setup terminal:
./config.sh
```
> *Setelah semuanya selesai, keluar dari termux lalu restart*

## Catatan
- Mengubah penggunaan shell `bashrc` dengan `zshrc`.
- Semua data input perintah disimpan didalam `.zsh_history` dan data username disimpan di `.zsh_config`
- Pada saat setelah penginstalan plugin dan package yang dibutuhkan selesai, system akan meminta input username yang nantinya akan ditampilkan di input prompt terminal
- History input hanya perintah yang sukses aja yang dismpan, yang gagal dan input yang sudah ada tidak disimpan agar tidak duplikat
