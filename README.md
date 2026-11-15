## Identitas Mahasiswa

Name : I Nyoman Yadnya Suta Karmana

NPM : 2506615993

Class : PBP F

## Tentang Proyek

MyPortfolio Mobile adalah aplikasi portofolio pribadi yang saya kembangkan menggunakan Flutter dan Dart sebagai bagian dari mata kuliah Pemrograman Berbasis Platform. Aplikasi ini melanjutkan proyek Tutorial 08 dan menjadi awal pengembangan versi mobile dari portofolio pribadi saya.

Pada Tugas 7, halaman utama menampilkan identitas, bagian Tentang Saya, serta tiga kartu menu: Lihat Proyek, Tambah Proyek, dan Logout. Setiap kartu memiliki warna yang berbeda dan menampilkan pesan SnackBar ketika ditekan. Tampilan ini menjadi fondasi untuk pengembangan aplikasi pada tahap pembelajaran berikutnya.

### Tugas 7

#### Pertanyaan Reflektif

1. **Jelaskan apa yang dimaksud dengan widget tree pada Flutter dan bagaimana hubungan induk-anak (parent-child) bekerja antar-widget!**

   Widget tree adalah susunan widget secara bertingkat yang membentuk antarmuka aplikasi Flutter. Dalam susunan ini, widget yang membungkus atau menempatkan widget lain disebut *parent*, sedangkan widget di dalamnya disebut *child*. Sebuah parent dapat menerima satu child melalui properti `child`, beberapa child melalui `children`, atau menempatkan child pada properti khusus seperti `body` pada `Scaffold`.

   Pada proyek saya, `MyApp` membangun `MaterialApp`, kemudian `MaterialApp` menampilkan `MyHomePage` melalui properti `home`. Halaman utama menggunakan `Scaffold` dengan `AppBar` dan `SingleChildScrollView` sebagai body. Di dalam body, `Column` menyusun panel sambutan, kartu profil, menu, serta bagian Tentang Saya secara vertikal. Masing-masing `InfoCard` dan `ItemCard` juga memiliki susunan widget sendiri untuk membentuk isi kartu.

   Hubungan parent-child juga memengaruhi tata letak. Parent memberikan batas ukuran kepada child, kemudian child menentukan ukurannya dalam batas tersebut dan parent menempatkannya. Contohnya, `ConstrainedBox` membatasi lebar konten maksimal 960 piksel logis. Di dalamnya, `LayoutBuilder` membaca lebar yang tersedia untuk menentukan lebar `SizedBox` yang membungkus setiap `InfoCard`. Dengan demikian, susunan kartu dapat menyesuaikan ruang yang tersedia.

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

   Sebagai contoh penggunaan widget tersebut, data setiap menu disimpan dalam objek `ItemHomepage`, kemudian digunakan untuk membuat `ItemCard`. Di dalam kartu, `Material` memberikan warna dan `InkWell` menangani sentuhan. Ketika kartu ditekan, `SnackBar` menampilkan pesan sesuai nama menu.

   `ItemHomepage` bukan widget, melainkan model data yang menyimpan `name`, `icon`, dan `color`. Begitu juga `ThemeData`, `ColorScheme`, `TextStyle`, `BoxDecoration`, dan `EdgeInsets`: semuanya merupakan konfigurasi tampilan, bukan widget yang saya susun langsung pada halaman. Sementara itu, `ScaffoldMessenger.of(context)` digunakan untuk memperoleh pengelola SnackBar dari leluhur widget.

3. **Apa fungsi dari widget MaterialApp? Jelaskan mengapa widget ini umumnya digunakan sebagai root widget pada aplikasi Flutter!**

   `MaterialApp` menyediakan konfigurasi dan layanan umum untuk aplikasi yang menggunakan Material Design, seperti tema, halaman awal, dan pengaturan navigasi. Widget ini memudahkan halaman-halaman di bawahnya menggunakan konfigurasi yang konsisten. Pada proyek saya, `title` diisi MyPortfolio, `theme` menggunakan `ThemeData` dengan `ColorScheme.fromSeed`, dan `home` diisi `const MyHomePage()`.

   `MaterialApp` umumnya ditempatkan dekat akar widget tree agar konfigurasi tersebut tersedia bagi bagian aplikasi di bawahnya. Sebagai contoh, AppBar pada halaman utama mengambil warna utama melalui `Theme.of(context).colorScheme.primary`. Dengan cara ini, tema dapat diatur pada tingkat aplikasi dan digunakan kembali oleh widget yang memerlukannya.

   Dalam kode saya, widget yang langsung diberikan kepada `runApp` adalah `MyApp`. Metode `build` pada MyApp kemudian mengembalikan `MaterialApp`. Dengan demikian, MyApp merupakan root widget yang saya berikan kepada `runApp`, sedangkan MaterialApp menyediakan konfigurasi aplikasi di bawahnya. Sementara itu, `Scaffold` digunakan untuk menyusun struktur halaman, seperti AppBar dan body.

4. **Jelaskan perbedaan antara StatelessWidget dan StatefulWidget! Kapan kita sebaiknya memilih StatelessWidget dan kapan harus menggunakan StatefulWidget?**

   `StatelessWidget` tidak memiliki objek `State` untuk mengelola perubahan data lokal. Tampilannya dibangun berdasarkan konfigurasi yang diterima dan informasi dari lingkungannya. Meskipun demikian, metode `build` tetap dapat dipanggil kembali, misalnya ketika konfigurasi dari parent atau tema yang digunakannya berubah. Jadi, stateless tidak berarti widget hanya dibangun satu kali.

   `StatefulWidget` memiliki objek `State` terpisah yang dapat menyimpan data yang berubah selama widget masih berada dalam tree. Objek widget-nya sendiri tetap immutable; data lokal yang berubah dikelola oleh State. Ketika perubahan lokal perlu ditampilkan, metode `setState` dapat digunakan untuk memberi tahu Flutter agar menjadwalkan pembangunan ulang tampilan. Contohnya adalah penghitung, pilihan yang sedang aktif, atau form dengan tampilan yang berubah mengikuti input.

   Pada proyek ini, saya menggunakan StatelessWidget untuk MyApp, MyHomePage, InfoCard, dan ItemCard karena keempat widget tersebut belum perlu menyimpan perubahan state lokal. Ketika kartu ditekan, ItemCard memanggil ScaffoldMessenger untuk menampilkan SnackBar. Karena pesan tersebut dikelola oleh ScaffoldMessenger, ItemCard tidak memerlukan objek State sendiri hanya untuk merespons sentuhan.

   Jika nanti halaman perlu menyimpan perubahan lokal, seperti pilihan filter proyek yang sedang aktif, StatefulWidget dapat digunakan pada bagian yang memerlukannya. Saya memilih jenis widget berdasarkan kebutuhan pengelolaan state, bukan sekadar ada atau tidaknya tombol.

5. **Apa itu BuildContext dan mengapa penting di Flutter? Bagaimana penggunaannya di dalam metode build?**

   `BuildContext` adalah antarmuka yang mewakili posisi suatu widget di dalam widget tree. Melalui context, widget dapat mencari konfigurasi atau layanan yang tersedia pada widget leluhurnya. Karena pencarian bergantung pada posisi tersebut, context tidak dapat dianggap sebagai variabel global yang selalu mewakili seluruh aplikasi.

   Metode `build(BuildContext context)` menerima context untuk menyusun tampilan sesuai lingkungan widget. Pada MyHomePage, saya menggunakan `Theme.of(context)` untuk mengambil tema dari atas halaman. Pada ItemCard, `ScaffoldMessenger.of(context)` digunakan untuk memperoleh pengelola SnackBar. Setelah itu, `hideCurrentSnackBar()` menutup pesan yang sedang tampil dan `showSnackBar()` menampilkan pesan untuk tombol yang ditekan.

   Posisi context menentukan hasil pencarian tersebut. Jika layanan yang dicari tidak tersedia sebagai leluhur, pemanggilan dapat gagal atau memperoleh layanan yang berbeda dari yang dimaksud. Context dalam metode build juga merupakan context milik widget yang sedang dibangun, bukan milik child yang baru dikembalikannya. Pada proyek ini, ItemCard berada di bawah MaterialApp sehingga dapat mengakses ScaffoldMessenger yang disediakan aplikasi.

6. **Jelaskan konsep hot reload di Flutter dan apa perbedaannya dengan hot restart! Kapan kita tidak bisa hanya mengandalkan hot reload dan harus melakukan hot restart atau full restart?**

   Hot reload memasukkan perubahan kode yang didukung ke aplikasi dalam mode debug dan membangun ulang widget tree sambil mempertahankan state yang sedang berjalan. Pada proyek ini, hot reload berguna ketika saya mengubah warna kartu, jarak, atau teks Tentang Saya. Saat hot reload didukung oleh target dan konfigurasi yang digunakan, saya dapat menekan `r` di terminal `flutter run` untuk menjalankannya.

   Hot restart memulai ulang aplikasi Flutter dan menghilangkan state yang tersimpan dalam memori. Perbedaannya penting karena hot reload tidak menjalankan ulang `main()` atau `initState()`. Jika perubahan perlu mengeksekusi ulang inisialisasi tersebut, saya membutuhkan hot restart. Sebagai contoh, perubahan nilai awal variabel global atau field `static final` yang sudah diinisialisasi mungkin belum terlihat setelah hot reload. Perubahan tertentu pada struktur kelas juga dapat ditolak oleh hot reload. Pada terminal `flutter run`, hot restart dapat dijalankan dengan `R` huruf kapital.

   Full restart dilakukan dengan menghentikan dan menjalankan ulang aplikasi. Ini diperlukan untuk perubahan native, misalnya kode Kotlin/Java atau Swift/Objective-C, dan penambahan plugin yang memerlukan build native. Full restart membutuhkan waktu lebih lama karena melibatkan proses build dan peluncuran ulang yang lebih luas.


## Harap dibaca (Tugas 7)

Pada Tutorial 08, saya membangun dasar aplikasi Flutter dengan memisahkan `main.dart` dan `menu.dart`, menggunakan `StatelessWidget`, serta membuat `InfoCard` dan `ItemCard`. Identitas pribadi dan label menu sudah saya sesuaikan pada hasil tutorial tersebut. Pada Tugas 7, saya melanjutkan proyek yang sama dengan menambahkan warna berbeda pada setiap kartu aksi, merapikan struktur kode, dan mengembangkan tampilan portofolio.

Beberapa penyesuaian dan tambahan yang saya buat pada Tugas 7:

- **Bagian Tentang Saya** untuk memperkenalkan latar pendidikan dan minat saya dalam pengembangan bisnis serta data science.
- **Panel sambutan dan ikon pada kartu identitas** untuk memperjelas informasi yang ditampilkan.
- **Kartu menu dengan warna berbeda** untuk Lihat Proyek, Tambah Proyek, dan Logout. Saat ditekan, setiap kartu menampilkan SnackBar dengan nama serta warna yang sesuai.
- **Tata letak yang menyesuaikan lebar layar.** Saat lebar konten kurang dari 500 piksel logis, kartu identitas disusun dalam satu kolom dan menu dalam dua kolom. Pada ruang yang lebih lebar, keduanya disusun dalam tiga kolom. Halaman juga dapat digulir dan memiliki batas lebar konten agar tetap nyaman dibaca.

Untuk menjaga kode tetap rapi, data nama, ikon, dan warna setiap menu disimpan dalam `ItemHomepage`, lalu digunakan oleh `ItemCard` tanpa percabangan warna berdasarkan nama tombol. `InfoCard` dan `ItemCard` juga saya pisahkan ke file tersendiri agar dapat digunakan kembali. `MyHomePage` tetap berupa `StatelessWidget` karena halaman ini belum mengelola perubahan state lokal.

### Menjalankan Proyek

Untuk menjalankan aplikasi, pastikan Flutter SDK dan Google Chrome sudah terpasang. Kondisi instalasi dan perangkat yang tersedia dapat diperiksa melalui terminal:

```bash
flutter doctor
flutter devices
```

Clone repositori, masuk ke folder proyek, lalu pindah ke branch Tugas 7:

```bash
git clone https://github.com/SutaKarmana/myportofolio_mobile.git
cd myportofolio_mobile
git switch Tugas07Mobile
```

Setelah itu, unduh dependensi dan jalankan aplikasi di Chrome:

```bash
flutter pub get
flutter run -d chrome
```

### Progres Pengerjaan

**Tutorial 08 — Dasar aplikasi Flutter**

Pada tahap ini, saya menyiapkan proyek Flutter dan mempelajari struktur direktori serta peran `main.dart` sebagai titik awal aplikasi. Halaman utama kemudian dipisahkan ke `menu.dart` dan diubah menjadi `StatelessWidget` karena belum memerlukan pengelolaan state lokal.

Saya juga menyusun halaman menggunakan widget seperti `Scaffold`, `Column`, dan `GridView`, serta membuat `InfoCard` untuk identitas dan `ItemCard` untuk menu. Ketika kartu menu ditekan, aplikasi menampilkan pesan melalui SnackBar.

**Tugas 7 — Penyesuaian portofolio pribadi**

Saya melanjutkan proyek Tutorial 08 dengan memberikan warna yang berbeda pada setiap kartu menu melalui model `ItemHomepage`. Struktur kode juga dirapikan dengan memisahkan model, `InfoCard`, dan `ItemCard` ke file tersendiri.

Pada bagian tampilan, saya menambahkan panel sambutan, ikon identitas, dan bagian Tentang Saya. Susunan kartu disesuaikan dengan lebar layar agar lebih nyaman dibaca. Setelah perubahan selesai, saya memeriksa kode menggunakan `flutter analyze` dan menjalankan pengujian widget untuk identitas serta pesan SnackBar.

## DOKUMENTASI AI Tugas 7

### AI Disclosure

Dalam mengerjakan Tugas 7, saya menggunakan Gemini dengan model Hydrogen dan ChatGPT/Codex dari OpenAI sebagai alat bantu belajar dan pengembangan. Gemini saya gunakan untuk membantu mempelajari dan memahami konsep dasar Flutter. Sementara itu, Codex yang terhubung dengan proyek lokal membantu membaca PDF Tutorial 08 dan soal Tugas 7, memeriksa file kode, menjelaskan perubahan, menyesuaikan implementasi, menjalankan pemeriksaan, serta menyusun dokumentasi.

Dalam mengembangkan proyek ini, saya menentukan cakupan pengerjaan berdasarkan materi tutorial dan instruksi tugas, meninjau hasil setiap tahap, serta memberikan arahan untuk struktur dan tampilan yang saya inginkan. Codex membantu menjelaskan dan menyesuaikan implementasi, termasuk warna pada ItemHomepage, pemisahan InfoCard dan ItemCard, tata letak, pengujian profil dan SnackBar, serta draf jawaban reflektif. Saya mempelajari perubahan tersebut secara bertahap agar memahami alurnya, lalu melakukan commit dan push sendiri.

### Contoh Prompt yang Saya Gunakan

Berikut contoh arahan yang saya gunakan selama pengerjaan, ditulis kembali agar lebih ringkas:

1. > Baca Tutorial 08 sebagai konteks untuk Tugas 7, lalu bantu saya mengikuti alur dan cakupan materi yang sudah dipelajari.

2. > Bantu saya membuat tugas sambil menjelaskan setiap perubahan. Kerjakan secara bertahap berdasarkan kelompok pekerjaan agar saya bisa memahami prosesnya dan melakukan commit sendiri.

3. > Jelaskan apakah widget test yang ditambahkan memang wajib pada tugas ini, serta apa hubungannya dengan aplikasi yang saya buat.

4. > Sesuaikan peningkatan tampilan dengan materi tutorial. Saya ingin desain yang lebih rapi, tetapi tetap sederhana dan bisa saya pahami.

5. > Periksa kembali kode, checklist, dan rubrik Tugas 7 agar saya bisa memahami bagian yang sudah terpenuhi dan bagian yang masih perlu diperiksa.

6. > Coba bantu aku untuk melakukan crosscheck ulang full dari Tugas7 ini pada file pdf yang aku kirimkan, aku takut ada yang terlewat dan kurang sesuai checklist dari tugas ini.

7. > Sepertinya bantuan perubahan yang kamu lakukan menurutku terlalu advance, dan diluar materi perkuliahan saat ini. Perbaiki lagi , karena beberapa bagian membuat aku bingung mengikuti flow penjelasannya.

### Verifikasi dan Debugging

Saya dibantu Codex untuk memeriksa kembali kualitas kode dan kesesuaiannya dengan checklist serta rubrik Tugas 7. Saya meminta pemeriksaan ulang agar hasil implementasi tidak hanya dinilai dari satu kali pengecekan. Pemeriksaan kode dilakukan dengan `flutter analyze --no-pub` dan pengujian widget dengan `flutter test --no-pub`. Analisis menghasilkan **No issues found**, dan keempat pengujian berhasil. Pengujian tersebut memeriksa informasi identitas serta pesan SnackBar pada tombol Lihat Proyek, Tambah Proyek, dan Logout.

Saya juga memeriksa tampilan pada ukuran layar yang berbeda untuk melihat susunan kartu profil dan menu. Pemeriksaan ini membantu menemukan masalah tata letak, meskipun belum mencakup seluruh ukuran layar dan perangkat.

### Refleksi Penggunaan AI

Saya menggunakan Tutorial 08 sebagai titik awal agar dapat menghubungkan konsep yang dipelajari dengan Tugas 7. Saya meminta bantuan secara bertahap dan penjelasan untuk setiap kelompok perubahan supaya saya bisa mengikuti alur pengerjaan, memahami fungsi kode, serta melakukan commit sendiri.

Saya menyadari bahwa AI terkadang menambahkan perubahan yang lebih luas atau lebih rumit daripada kebutuhan tugas dan materi yang sudah saya pelajari. Hal itu membuat saya bingung mengikuti alurnya, sehingga saya perlu memberi batasan dan arahan yang jelas. Misalnya, saya meminta desain disederhanakan agar tetap rapi dan dapat saya pahami. Fitur Salin NPM juga sempat ditambahkan, tetapi saya meminta tambahan difokuskan pada tampilan sesuai tahap pembelajaran; kode clipboard dan pengujiannya kemudian dihapus.

Ketika widget test ditambahkan, saya menanyakan apakah pengujian tersebut wajib. Saya memahami bahwa soal mewajibkan `flutter analyze`, sedangkan widget test menjadi pemeriksaan tambahan untuk memastikan identitas dan SnackBar tetap berfungsi. Dengan begitu, saya bisa membedakan instruksi tugas dari pilihan pemeriksaan yang membantu memverifikasi hasil.

Saya juga meminta Codex memeriksa ulang kode terhadap checklist dan rubrik karena pemeriksaan awal terlalu berfokus pada kebutuhan minimal. Dari situ, saya membandingkan hasil implementasi dengan materi dan kriteria penilaian, termasuk tambahan UI/UX yang relevan. Analisis dan pengujian membantu pemeriksaan tersebut, tetapi tidak menggantikan peninjauan hasil maupun menjamin nilai tertentu.

Kontribusi saya dalam proses ini terutama berupa arahan, evaluasi cakupan, pilihan desain, isi profil, dan commit, sedangkan perubahan kode diterapkan dengan bantuan Codex. Saya tetap perlu membaca hasilnya dan memahami hubungan antarwidget agar dapat menjelaskan proyek dengan bahasa sendiri.

### Link Percakapan AI Tugas 7

Link percakapan Gemini yang saya gunakan untuk mempelajari konsep dasar Flutter dari Tutorial 8 dan Tugas 7:

`https://share.gemini.google/LWHm65Ujk1EL`

### Sumber Penjelasan

- PDF Tutorial 08: Basic Flutter dan Individual Assignment 7: Basic Flutter yang diberikan pada sesi pengerjaan.
- [Tutorial 08](https://pbp.cs.ui.ac.id/en/tutorial/tutorial-8.html)
- [Flutter: Building user interfaces](https://docs.flutter.dev/ui)
- [Flutter: Understanding constraints](https://docs.flutter.dev/ui/layout/constraints)
- [Flutter API: MaterialApp](https://api.flutter.dev/flutter/material/MaterialApp-class.html)
- [Flutter API: StatelessWidget](https://api.flutter.dev/flutter/widgets/StatelessWidget-class.html) dan [StatefulWidget](https://api.flutter.dev/flutter/widgets/StatefulWidget-class.html)
- [Flutter API: BuildContext](https://api.flutter.dev/flutter/widgets/BuildContext-class.html)
- [Flutter: Hot reload](https://docs.flutter.dev/tools/hot-reload)
