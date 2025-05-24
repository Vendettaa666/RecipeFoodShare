# RecipeFoodShare

Aplikasi berbagi resep makanan dengan sistem autentikasi dan role-based access menggunakan Flutter dan Supabase.

## Fitur

- Autentikasi user (login/register)
- Role-based access (admin dan user biasa)
- Dashboard admin
- Halaman user

## Setup Database

Untuk setup database dan sistem autentikasi, ikuti langkah-langkah di [README_MANUAL_ADMIN.md](README_MANUAL_ADMIN.md).

## Cara Menjalankan Aplikasi

1. Clone repository ini
2. Jalankan `flutter pub get` untuk menginstall dependencies
3. Setup database Supabase sesuai petunjuk di README_MANUAL_ADMIN.md
4. Jalankan aplikasi dengan `flutter run`

## Login Admin

Sistem menggunakan pendekatan manual untuk login admin:

1. Daftar user baru melalui aplikasi dengan email pilihan Anda
2. Jalankan query SQL berikut di Supabase untuk mengubah role menjadi 'admin':
   ```sql
   UPDATE public.profiles SET role = 'admin' WHERE email = 'email_anda@example.com';
   ```
3. Login kembali dengan email dan password yang sama
4. Sistem akan otomatis mengarahkan ke Dashboard Admin

Tidak ada password default khusus untuk admin. Password adalah yang Anda tentukan saat pendaftaran.

## Struktur Aplikasi

- `lib/core/services`: Service untuk autentikasi dan API
- `lib/feature/auth`: Halaman login dan register
- `lib/feature/admin`: Halaman dashboard admin
- `lib/feature/user`: Halaman user biasa
- `lib/models`: Model data
- `lib/widgets`: Widget yang dapat digunakan kembali
