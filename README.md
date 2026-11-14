## Identitas Mahasiswa

Name : I Nyoman Yadnya Suta Karmana

NPM : 2506615993

Class : PBP F

## Tentang Proyek

MyPortfolio Mobile adalah aplikasi portofolio pribadi yang saya kembangkan secara bertahap pada mata kuliah Pemrograman Berbasis Platform. Proyek ini melanjutkan hasil Tutorial 08 menggunakan Flutter dan Dart, dalam repositori yang terpisah dari website Django saya.

Pada Tugas 7, aplikasi menampilkan identitas, menu Lihat Proyek, Tambah Proyek, dan Logout, serta bagian Tentang Saya. Ketiga menu memberikan respons berupa SnackBar sesuai tombol yang ditekan. Pada tahap ini, aplikasi belum terhubung dengan API Django dan belum menjalankan navigasi daftar proyek, penyimpanan proyek, maupun autentikasi.

### Tugas 7

#### Pertanyaan Reflektif

1. **Jelaskan apa yang dimaksud dengan widget tree pada Flutter dan bagaimana hubungan induk-anak (parent-child) bekerja antar-widget!**

   Widget tree adalah susunan hierarkis widget yang membentuk antarmuka Flutter. Sebuah widget dapat membungkus widget lain melalui properti seperti `child`, menerima beberapa widget melalui `children`, atau menyediakan tempat khusus seperti `body` pada `Scaffold`. Widget pembungkus menjadi parent, sedangkan widget di dalamnya menjadi child. Susunan ini menjelaskan bagaimana komponen tampilan saling berhubungan.

   Pada proyek saya, `MyApp` membangun `MaterialApp`, yang menampilkan `MyHomePage` melalui properti `home`. Halaman tersebut membangun `Scaffold` dengan `AppBar` dan `SingleChildScrollView` sebagai body. Di dalam body, `Column` menyusun panel sambutan, kartu profil, menu, serta bagian Tentang Saya secara vertikal. `InfoCard` dan `ItemCard` memiliki susunan widget masing-masing, sehingga tidak perlu menuliskan ulang seluruh isi kartu pada halaman utama.

   Hubungan parent-child juga memengaruhi tata letak. Parent memberikan batas ukuran kepada child, child menentukan ukuran dalam batas tersebut, lalu parent menempatkannya. Contohnya, `ConstrainedBox` membatasi lebar konten maksimal 960 piksel logis, sedangkan `SizedBox` memberi lebar tertentu kepada setiap `InfoCard`. Karena itu, perubahan pada widget pembungkus dapat memengaruhi tampilan anak-anaknya.

2. **Sebutkan semua widget yang kamu gunakan dalam proyek ini dan jelaskan fungsinya masing-masing!**

   Berikut widget yang saya tulis secara langsung dalam kode aplikasi:

   | Widget | Fungsi dalam proyek |
   | --- | --- |
   | `MyApp` | Widget buatan sendiri yang menyiapkan konfigurasi aplikasi. |
   | `MaterialApp` | Mengatur judul aplikasi, tema Material, dan halaman awal. |
   | `MyHomePage` | Widget halaman utama yang menyusun profil dan menu portofolio. |
   | `Scaffold` | Menyediakan struktur halaman berupa AppBar dan body. |
   | `AppBar` | Menampilkan judul MyPortfolio di bagian atas halaman. |
   | `SingleChildScrollView` | Memungkinkan isi halaman digulir ketika melebihi tinggi layar. |
   | `Center` | Menempatkan konten di tengah secara horizontal. |
   | `ConstrainedBox` | Membatasi lebar konten agar tidak terlalu melebar di layar besar. |
   | `Column` | Menyusun elemen secara vertikal, misalnya isi halaman dan isi kartu. |
   | `Container` | Membentuk panel sambutan serta latar ikon dengan padding dan dekorasi. |
   | `Text` | Menampilkan judul, identitas, pengantar, label tombol, dan pesan. |
   | `SizedBox` | Memberikan jarak antarelemen dan mengatur lebar kartu profil. |
   | `LayoutBuilder` | Membaca batas ukuran dari parent untuk menentukan lebar kartu dan jumlah kolom menu. |
   | `Wrap` | Menyusun kartu profil dan memungkinkan perpindahan ke baris berikutnya. |
   | `InfoCard` | Widget buatan sendiri untuk menampilkan satu informasi identitas beserta ikon. |
   | `Card` | Memberi tampilan kartu pada identitas dan bagian Tentang Saya. |
   | `Padding` | Memberikan ruang antara konten dan batas pembungkusnya. |
   | `Icon` | Menampilkan simbol pada profil, menu, dan bagian Tentang Saya. |
   | `GridView.count` | Menata menu dalam dua atau tiga kolom sesuai lebar yang tersedia. |
   | `ItemCard` | Widget buatan sendiri untuk menampilkan satu kartu menu dan respons sentuhannya. |
   | `Material` | Menjadi permukaan kartu aksi yang memiliki warna, sudut membulat, dan elevasi. |
   | `InkWell` | Mendeteksi sentuhan serta memberi efek visual pada kartu aksi. |
   | `SnackBar` | Menampilkan pesan sementara sesuai menu yang ditekan. |
   | `Row` | Menyusun ikon dan isi bagian Tentang Saya secara horizontal. |
   | `Expanded` | Memberi teks Tentang Saya sisa lebar di dalam Row agar dapat membungkus baris. |

   `ItemHomepage` bukan widget, melainkan model data yang menyimpan `name`, `icon`, dan `color` untuk setiap menu. `ThemeData`, `ColorScheme`, `TextStyle`, `BoxDecoration`, dan `EdgeInsets` juga bukan widget; semuanya dipakai sebagai konfigurasi tampilan. Pemanggilan `ScaffoldMessenger.of(context)` digunakan untuk memperoleh pengelola SnackBar dari leluhur widget.

3. **Apa fungsi dari widget MaterialApp? Jelaskan mengapa widget ini umumnya digunakan sebagai root widget pada aplikasi Flutter!**

   `MaterialApp` menyediakan konfigurasi dan layanan umum untuk aplikasi yang menggunakan Material Design, seperti tema, halaman awal, dan pengaturan navigasi. Widget ini memudahkan halaman-halaman di bawahnya menggunakan konfigurasi yang konsisten. Pada proyek saya, `title` diisi MyPortfolio, `theme` menggunakan `ThemeData` dengan `ColorScheme.fromSeed`, dan `home` diisi `const MyHomePage()`.

   `MaterialApp` biasanya ditempatkan dekat akar widget tree agar konfigurasi tersebut tersedia bagi seluruh halaman aplikasi. Misalnya, AppBar pada halaman utama dapat mengambil warna utama dari `Theme.of(context).colorScheme.primary`. Saya tidak perlu membuat konfigurasi tema terpisah untuk setiap komponen.

   Dalam kode saya, widget yang langsung diberikan kepada `runApp` adalah `MyApp`. Metode `build` pada MyApp kemudian mengembalikan `MaterialApp`. Jadi, root widget proyek ini secara langsung adalah MyApp, dengan MaterialApp sebagai pembungkus konfigurasi aplikasi. MaterialApp bukan pengganti Scaffold: Scaffold tetap digunakan untuk menyusun struktur setiap halaman. Penjelasan ini mengacu pada [dokumentasi MaterialApp](https://api.flutter.dev/flutter/material/MaterialApp-class.html).

4. **Jelaskan perbedaan antara StatelessWidget dan StatefulWidget! Kapan kita sebaiknya memilih StatelessWidget dan kapan harus menggunakan StatefulWidget?**

   `StatelessWidget` tidak memiliki objek State untuk mengelola perubahan data lokal. Tampilannya ditentukan oleh konfigurasi yang diterima dan informasi dari lingkungannya. Meskipun disebut stateless, metode build tetap dapat dipanggil kembali, misalnya ketika konfigurasi dari parent atau tema yang digunakan berubah. StatelessWidget tidak berarti widget hanya pernah digambar satu kali.

   `StatefulWidget` memiliki objek `State` terpisah yang dapat menyimpan data yang berubah selama widget masih berada dalam tree. Ketika perubahan lokal perlu ditampilkan, metode `setState` dapat digunakan untuk memberi tahu Flutter agar menjadwalkan pembangunan ulang tampilan. Contohnya adalah penghitung, pilihan yang sedang aktif, atau form dengan tampilan yang berubah mengikuti input.

   Saya memakai StatelessWidget untuk MyApp, MyHomePage, InfoCard, dan ItemCard karena belum ada data lokal yang perlu diubah oleh widget-widget tersebut. Menekan kartu cukup memanggil ScaffoldMessenger untuk menampilkan SnackBar. ItemCard sendiri tidak menyimpan status tombol atau isi pesan yang berubah, sehingga keberadaan interaksi onTap tidak otomatis mengharuskan StatefulWidget.

   Jika nanti halaman perlu menyimpan perubahan lokal, seperti pilihan filter proyek yang sedang aktif, StatefulWidget dapat digunakan pada bagian yang memerlukannya. Saya memilih jenis widget berdasarkan kebutuhan pengelolaan state, bukan sekadar ada atau tidaknya tombol. Penjelasan ini mengacu pada dokumentasi [StatelessWidget](https://api.flutter.dev/flutter/widgets/StatelessWidget-class.html) dan [StatefulWidget](https://api.flutter.dev/flutter/widgets/StatefulWidget-class.html).

5. **Apa itu BuildContext dan mengapa penting di Flutter? Bagaimana penggunaannya di dalam metode build?**

   `BuildContext` adalah antarmuka yang mewakili posisi widget di dalam widget tree. Konteks memungkinkan widget mencari konfigurasi atau layanan pada leluhurnya. Karena pencarian mengikuti posisi dalam tree, context tidak dapat dianggap sebagai variabel global yang selalu mewakili seluruh aplikasi.

   Metode `build(BuildContext context)` menerima konteks untuk menyusun tampilan sesuai lingkungan widget tersebut. Pada MyHomePage, `Theme.of(context)` mengambil tema yang disediakan di atas halaman. Pada ItemCard, `ScaffoldMessenger.of(context)` mencari pengelola SnackBar, kemudian memanggil `hideCurrentSnackBar()` dan `showSnackBar()`.

   Posisi context penting: jika layanan yang dicari belum menjadi leluhurnya, pencarian dapat gagal atau memperoleh layanan yang berbeda dari maksud saya. Context milik suatu metode build juga bukan context milik anak yang baru dikembalikan metode tersebut. Karena ItemCard berada di bawah MaterialApp, konteksnya dapat mengakses ScaffoldMessenger yang disediakan untuk aplikasi. Penjelasan ini mengacu pada [dokumentasi BuildContext](https://api.flutter.dev/flutter/widgets/BuildContext-class.html).

6. **Jelaskan konsep hot reload di Flutter dan apa perbedaannya dengan hot restart! Kapan kita tidak bisa hanya mengandalkan hot reload dan harus melakukan hot restart atau full restart?**

   Hot reload memasukkan perubahan kode yang didukung ke aplikasi dalam mode debug dan membangun ulang widget tree sambil mempertahankan state yang sedang berjalan. Pada proyek ini, hot reload berguna ketika saya mengubah warna kartu, jarak, atau teks Tentang Saya. Dari terminal flutter run, saya dapat menekan `r` untuk meminta hot reload.

   Hot restart memulai ulang aplikasi Flutter dan menghilangkan state yang tersimpan dalam memori. Perbedaannya penting karena hot reload tidak menjalankan ulang `main()` atau `initState()`. Jika perubahan perlu mengeksekusi ulang inisialisasi tersebut, saya membutuhkan hot restart. Perubahan tertentu pada struktur kelas juga dapat ditolak oleh hot reload.

   Full restart dilakukan dengan menghentikan dan menjalankan ulang aplikasi. Ini diperlukan untuk perubahan native, misalnya kode Kotlin/Java atau Swift/Objective-C, dan penambahan plugin yang memerlukan build native. Full restart membutuhkan waktu lebih lama karena melibatkan proses build dan peluncuran ulang yang lebih luas.

   Jadi, saya memakai hot reload untuk penyesuaian UI, hot restart untuk memulai kembali state dan inisialisasi aplikasi Dart, serta full restart ketika perubahan melibatkan bagian native. Penjelasan ini mengacu pada [dokumentasi Hot reload](https://docs.flutter.dev/tools/hot-reload).

## Harap dibaca (Tugas 7)

Pada Tutorial 08, saya membangun dasar aplikasi Flutter dengan pemisahan main.dart dan menu.dart, halaman StatelessWidget, serta widget InfoCard dan ItemCard. Sebagian penyesuaian identitas dan label menu sudah ada pada hasil tutorial saya. Pada Tugas 7, saya melanjutkan fondasi tersebut dengan warna berbeda untuk setiap kartu aksi, perapian struktur kode, dan penyesuaian tampilan portofolio.

Tampilan tambahan mencakup panel sambutan, ikon pada kartu identitas, bagian Tentang Saya, serta SnackBar yang warnanya mengikuti tombol. Pada lebar konten di bawah 500 piksel logis, kartu profil disusun satu kolom dan menu menjadi dua kolom. Pada ruang yang lebih lebar, profil dan menu masing-masing memakai tiga kolom. Halaman dapat digulir, sedangkan lebar kontennya dibatasi maksimal 960 piksel logis.

Pewarnaan mengikuti petunjuk tugas: setiap ItemHomepage memiliki atribut Color, lalu ItemCard menggunakan item.color. Tidak ada percabangan warna berdasarkan nama tombol. MyHomePage tetap StatelessWidget karena halaman ini belum mengelola perubahan state lokal.

### Struktur Proyek

```text
lib/
├── main.dart                   # Entry point dan konfigurasi MaterialApp
├── menu.dart                   # Susunan halaman utama
├── models/
│   └── item_homepage.dart       # Data nama, ikon, dan warna menu
└── widgets/
    ├── info_card.dart           # Kartu identitas yang dapat dipakai ulang
    └── item_card.dart           # Kartu aksi dan respons SnackBar
test/
└── widget_test.dart             # Pemeriksaan profil dan ketiga menu
```

### Menjalankan Proyek

Pastikan Flutter SDK sudah terpasang dan periksa lingkungan dengan `flutter doctor`. Untuk menjalankan melalui web, Google Chrome perlu terdeteksi pada `flutter devices`.

Clone repositori dan masuk ke folder proyek:

```bash
git clone https://github.com/SutaKarmana/myportofolio_mobile.git
cd myportofolio_mobile
```

Pengerjaan Tugas 7 berada pada branch `Tugas07Mobile`:

```bash
git switch Tugas07Mobile
flutter pub get
flutter run -d chrome
```

Untuk pemeriksaan kode dan pengujian:

```bash
flutter analyze
flutter test
```

### Progres Pengerjaan

| Tahap | Perubahan |
| --- | --- |
| Tutorial 08 | Membuat fondasi aplikasi Flutter, memisahkan halaman utama, dan menyusun kartu identitas serta menu. |
| Tugas 7: warna | Menambahkan atribut color pada model menu dan memakai warna berbeda untuk ketiga tombol. |
| Tugas 7: struktur dan tampilan | Memisahkan model dan widget ke file khusus, menyesuaikan tata letak, serta memperbarui pengujian bawaan. |
| Tugas 7: personalisasi | Menambahkan bagian Tentang Saya dengan latar pendidikan dan minat pribadi. |
| Tugas 7: dokumentasi | Menuliskan cara menjalankan proyek, jawaban reflektif, dan dokumentasi penggunaan AI. |

Commit dilakukan bertahap dengan pesan conventional commit pada branch Tugas07Mobile. Proyek ini menggunakan repositori publik yang sama dengan Tutorial 08.

## DOKUMENTASI AI Tugas 7

### AI Disclosure

Dalam mengerjakan Tugas 7, saya menggunakan ChatGPT/Codex dari OpenAI sebagai alat bantu belajar dan pengembangan. Codex membantu membaca PDF Tutorial 08 dan soal Tugas 7, memeriksa file lokal, menjelaskan perubahan, menyesuaikan kode, menjalankan pemeriksaan, serta menyusun dokumentasi.

Bagian yang dibantu meliputi model warna ItemHomepage, pemisahan InfoCard dan ItemCard, tata letak yang menyesuaikan lebar layar, pengujian profil dan SnackBar, serta draf jawaban reflektif. Saya memberikan materi dan instruksi tugas sebagai konteks, meminta pengerjaan per kelompok perubahan, serta mengarahkan agar perubahan tetap dapat dipahami berdasarkan tutorial. Commit dan push saya lakukan sendiri.

### Contoh Prompt yang Saya Gunakan

Berikut cuplikan prompt asli dari sesi pengerjaan ini:

1. > Oke sekarang crosscheck ulang apakah sudah memenuhi nilai pada file pdf dari rubrik penilaian (Asumsi dulu readme udah lengkap ya). Serta Checklistnya

2. > Eh menurutku untuk step di tugas07 terlalu advance perubahannya, sampai tampilannya gitu. Sebenernya aku suka, tapi kek ngerasa masih AI SLop dan terlalu advance perubahan desainnya gitu

3. > jujur sekarang malah kurang banget rasanya, jadi agak polosan. Maksudku jangan terlalu advance tadi tapi juga ga sepolosan ini juga

4. > Keknya yang sebatas tampilan aja ga sih, karena kan tutorialnya belom sejauh itu

5. > Tentang portofolio keknya lebih cocok kek tentang saya gitu deh, kek saya adalah mahasiswa S1 Sistem informasi Universitas Indonesia yang tertarik dengan pengembangan bisnis dan data science gitu

Cuplikan tersebut menjadi log prompting untuk mendokumentasikan arahan saya dalam sesi ini. Saya tidak mencantumkan tautan percakapan publik karena tautan tersebut belum tersedia.

### Verifikasi dan Debugging

Pemeriksaan dilakukan dengan bantuan Codex menggunakan `flutter analyze --no-pub` dan `flutter test --no-pub`. Opsi --no-pub digunakan karena dependensi proyek sudah tersedia. Analisis menghasilkan No issues found. Empat pengujian memeriksa kemunculan identitas serta pesan SnackBar pada masing-masing tombol Lihat Proyek, Tambah Proyek, dan Logout.

Pengujian bawaan Flutter sebelumnya masih menguji counter yang sudah tidak ada. Test tersebut diganti agar sesuai dengan halaman portofolio. Saat tampilan menjadi dapat digulir, tes tombol juga disesuaikan dengan memastikan tombol berada di area layar sebelum ditekan melalui ensureVisible.

Pengujian ini memeriksa sebagian perilaku widget, bukan seluruh kualitas visual atau semua ukuran layar. Upaya Codex memeriksa tampilan langsung melalui browser juga sempat terhambat oleh akses Computer Use. Karena itu, hasil analisis dan test tidak saya anggap sebagai jaminan bahwa seluruh tampilan pasti benar pada semua perangkat.

### Refleksi Penggunaan AI

AI pada awalnya terlalu berfokus pada checklist minimal dan mengarahkan pengerjaan ke README sebelum membahas target rubrik nilai 4 dengan cukup jelas. Saya meminta pemeriksaan ulang dan penjelasan hubungan antara perubahan kode, peningkatan UI/UX, serta rubrik. Dari proses ini, saya perlu membedakan kewajiban minimal tugas dengan tambahan yang relevan, sekaligus tidak menganggap banyaknya baris kode sebagai ukuran utama kualitas.

Usulan desain AI juga sempat terlalu rumit, lalu menjadi terlalu sederhana setelah saya meminta penyederhanaan. Saya mengarahkan revisi menuju tampilan yang lebih seimbang: panel sambutan, ikon profil, menu berwarna, dan bagian Tentang Saya. Fitur Salin NPM sempat ditambahkan, tetapi saya meminta agar tambahan tetap sebatas tampilan sesuai tahap pembelajaran. Kode clipboard dan pengujiannya kemudian dihapus.

Perbaikan saya dalam sesi ini terutama berupa arahan, evaluasi cakupan, pilihan desain, dan isi profil, yang kemudian diterapkan dengan bantuan Codex. Saya tidak mengklaim seluruh perubahan kode ditulis manual. Saya tetap perlu membaca hasilnya dan memahami hubungan antarwidget agar dapat menjelaskan proyek dengan bahasa sendiri. Bagian Tentang Saya juga disesuaikan dengan pendidikan dan minat yang saya berikan.

### Sumber Penjelasan

- PDF Tutorial 08: Basic Flutter dan Individual Assignment 7: Basic Flutter yang diberikan pada sesi pengerjaan.
- [Tutorial 08](https://pbp.cs.ui.ac.id/en/tutorial/tutorial-8.html)
- [Flutter: Building user interfaces](https://docs.flutter.dev/ui)
- [Flutter API: MaterialApp](https://api.flutter.dev/flutter/material/MaterialApp-class.html)
- [Flutter API: BuildContext](https://api.flutter.dev/flutter/widgets/BuildContext-class.html)
- [Flutter: Hot reload](https://docs.flutter.dev/tools/hot-reload)
