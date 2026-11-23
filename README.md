## Identitas Mahasiswa

Name : I Nyoman Yadnya Suta Karmana

NPM : 2506615993

Class : PBP F

## Tentang Proyek

MyPortfolio Mobile adalah aplikasi portofolio pribadi yang saya kembangkan menggunakan Flutter dan Dart sebagai bagian dari mata kuliah Pemrograman Berbasis Platform. Aplikasi ini melanjutkan proyek Tutorial 08 dan menjadi awal pengembangan versi mobile dari portofolio pribadi saya.

Pada Tugas 7, halaman utama menampilkan identitas, bagian Tentang Saya, serta tiga kartu menu: Lihat Proyek, Tambah Proyek, dan Logout. Setiap kartu memiliki warna yang berbeda dan menampilkan pesan SnackBar ketika ditekan. Tampilan ini menjadi fondasi untuk pengembangan aplikasi pada tahap pembelajaran berikutnya.

Setelah mempelajari navigasi dan formulir pada Tutorial 09, saya menambahkan halaman Tambah Edukasi pada Tugas 8. Pengguna dapat membukanya dari beranda atau melalui menu samping, lalu melihat ringkasan pendidikan setelah isian dinyatakan valid.

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
### Tugas 8

#### Pertanyaan Reflektif

1. **Jelaskan perbedaan antara `Navigator.push()`, `Navigator.pushReplacement()`, dan `Navigator.pop()`. Metode apa yang digunakan untuk membuka formulir dari kartu aksi? Jelaskan juga bagaimana opsi Home di drawer membawa pengguna kembali ke halaman utama.**

   `Navigator` mengelola urutan halaman dan dialog yang dibuka. `push()` menambahkan rute baru di atas rute yang sedang aktif. `pushReplacement()` mengganti rute aktif dan mempertahankan rute yang ada di bawahnya. Sementara itu, `pop()` menutup rute teratas agar rute sebelumnya kembali terlihat. Salah satu contohnya adalah tombol **Tutup** pada dialog ringkasan, yang memanggil `pop()` untuk kembali ke formulir.

   Pada proyek ini, kartu **Tambah Proyek** dan **Tambah Edukasi** menggunakan `push()`. Dengan begitu, beranda masih berada di bawah formulir. Perpindahan dari drawer ke salah satu formulir memakai `pushReplacement()`, sehingga berpindah dari satu formulir ke formulir lain melalui drawer tidak terus menambah halaman ke riwayat.

   Saat **Home** dipilih, drawer ditutup lebih dulu. Jika pengguna sudah di beranda, langkahnya selesai. Dari formulir, fungsi `returnToPortfolioHome()` memeriksa posisi rute. Jika beranda masih ada di bawah formulir, fungsi tersebut memakai `pop()`. Jika formulir sudah menjadi rute pertama, misalnya setelah dibuka dari drawer beranda, fungsi tersebut mengganti formulir dengan `MyHomePage` melalui `pushReplacement()`. Tombol kembali pada AppBar kedua formulir memakai fungsi yang sama.

2. **Bagaimana susunan `Scaffold`, `AppBar`, dan `Drawer` membantu menjaga struktur halaman tetap konsisten? Berikan satu contoh penggunaan warna tema portofolio di lebih dari satu halaman.**

   `Scaffold` menjadi kerangka halaman yang menempatkan bilah judul pada `appBar`, menu samping pada `drawer`, dan isi utama pada `body`. Di beranda, bagian `body` berisi profil dan kartu menu. Di halaman Edukasi, bagian yang sama berisi formulir. Judul pada `AppBar` membantu pengguna mengenali halaman yang sedang dibuka, sementara `LeftDrawer` menyediakan pilihan **Home**, **Add Project**, dan **Add Education** pada ketiga halaman. Drawer memakai `currentPage` untuk menandai menu yang sedang aktif.

   Contoh penggunaan tema ada pada AppBar beranda dan formulir Edukasi. Keduanya mengambil warna latar dari `Theme.of(context).colorScheme.primary`. Jika warna utama di tema aplikasi diubah, kedua AppBar akan mengikuti perubahan tersebut karena membaca nilai dari sumber yang sama.

3. **Mengapa tata letak tersebut dipilih untuk formulir? Jelaskan peran widget pengatur jarak dan widget penggulir ketika ruang layar terbatas.**

   Saya memakai `Column` karena urutan isiannya dapat diikuti dari atas ke bawah, mulai dari Institusi dan Program Studi, lalu Tahun Mulai, Tahun Selesai, dan tombol **Simpan**. Properti `padding` pada `SingleChildScrollView` memberi ruang di sekeliling formulir. `SizedBox` memberi jarak antarisian supaya label dan pesan validasi lebih mudah dibaca. Pada layar lebar, `Center` dan `ConstrainedBox` menempatkan formulir di tengah dengan lebar maksimum 600 piksel logis.

   Saat keyboard muncul, ruang yang tersedia untuk isi halaman berkurang. Pesan kesalahan juga bisa membuat formulir bertambah tinggi. Karena `Column` berada di dalam `SingleChildScrollView`, pengguna dapat menggulir sampai isian bawah dan tombol **Simpan**. Isi dialog ringkasan juga dapat digulir jika ruangnya terbatas.

4. **Apa peran `GlobalKey<FormState>`, `validator`, dan `validate()` saat tombol Simpan ditekan? Berikan satu contoh nilai yang ditolak oleh validasi dan jelaskan mengapa memilih jenis input atau papan ketik saja belum cukup.**

   `GlobalKey<FormState>` dipasang pada `Form` agar fungsi yang menangani tombol **Simpan** dapat mengambil `FormState` melalui `_formKey.currentState`. Ketika tombol ditekan, `validate()` menjalankan `validator` pada setiap `TextFormField`. Setiap validator mengembalikan pesan jika isian bermasalah atau `null` jika isian diterima. Jika ada yang gagal, pesan muncul pada kolom yang bersangkutan dan dialog belum dibuka.

   Sebagai contoh, Tahun Selesai `2024` ditolak jika Tahun Mulai adalah `2025`. Keduanya bisa diketik dengan papan ketik angka dan sama-sama terdiri dari empat digit, tetapi urutannya tidak sesuai. Karena itu, formulir memeriksa format tahun sekaligus membandingkan kedua nilai. Tahun Selesai boleh kosong, sedangkan Institusi, Program Studi, dan Tahun Mulai wajib diisi. Isian wajib yang berisi spasi saja juga ditolak setelah diperiksa dengan `trim()`.

   Setelah semua kolom lolos, `form.save()` menjalankan `onSaved` untuk mengambil Institusi dan Program Studi. Nilai tahun dibaca dari `TextEditingController`. Aplikasi kemudian menyusun isian tersebut dan menampilkannya dalam dialog **Ringkasan Edukasi**. Pada tahap ini, nilai yang dikumpulkan digunakan untuk ringkasan di aplikasi.

## Harap Dibaca (Tugas 8)

Tutorial 09 sudah menghasilkan drawer, formulir Tambah Proyek, dan dialog hasil pengisian. Saya memakai alur itu sebagai dasar untuk menambahkan **Tambah Edukasi**, karena riwayat pendidikan merupakan bagian dari portofolio saya. Berikut perubahan yang bisa dilihat saat mencoba versi Tugas 8.

- **Formulir Tambah Edukasi** dapat dibuka dari kartu beranda dan menu **Add Education** di drawer. Pengguna dapat mengisi institusi, program studi, tahun mulai, serta tahun selesai jika sudah diketahui. Isian yang valid ditampilkan di dialog ringkasan.
- **Pratinjau durasi pendidikan** langsung mengikuti perubahan pada kedua kolom tahun. Misalnya, tahun mulai `2025` dan tahun selesai `2029` menampilkan perkiraan empat tahun, yang juga ditampilkan di ringkasan. Durasi tersebut berupa perkiraan karena formulir hanya meminta tahun.
- **Tombol kembali pada kedua formulir** memberi akses langsung ke beranda dari AppBar Tambah Edukasi dan Tambah Proyek. Drawer tetap dapat dibuka dari ikon di sisi kanan AppBar, dan pilihan yang aktif ditandai sesuai dengan halaman yang sedang tampil.

Untuk mengatur tujuan kartu, `ItemHomepage` menyimpan informasi halaman yang dituju, lalu `ItemCard` menggunakannya saat kartu ditekan. Alur kembali ke beranda juga ditempatkan dalam satu fungsi yang digunakan oleh drawer dan kedua formulir.

## DOKUMENTASI AI Tugas 8

### AI Disclosure

Dalam mengerjakan Tugas 8, saya menggunakan Gemini dengan model Hydrogen untuk membantu mempelajari konsep Flutter. Saya juga menggunakan ChatGPT/Codex dengan model GPT-6.2 Sol untuk membahas checklist tugas, memahami alur navigasi dan validasi, serta meninjau proyek yang sudah dibuat pada Tutorial 09. Saya memilih Edukasi sebagai bagian yang ingin saya tambahkan dan membagi pengerjaan menjadi beberapa tahap agar saya bisa menelusuri perubahan sebelum melakukan commit.

Codex membantu menerapkan rancangan formulir dan validator, menghubungkan kartu dan drawer, menyiapkan pengujian widget, serta menyusun draf jawaban reflektif. Saya mengarahkan urutan pengerjaan, menanyakan jalur navigasi yang belum tersedia, dan mengusulkan tombol kembali di kedua formulir. Commit saya lakukan sendiri setelah meninjau tiap kelompok perubahan.

### Contoh Prompt yang Saya Gunakan

Contoh berikut diringkas dari arahan dan pertanyaan saya selama pengerjaan.

1. > Bantu saya memahami checklist Tugas 8 dan jelaskan alur pengerjaannya secara bertahap. Berikan saran kode untuk tiap tahap, lalu terapkan setelah saya konfirmasi.
2. > Mulai dari formulir Edukasi dulu. Setelah isi dan validasinya jelas, lanjutkan sampai formulir bisa dibuka dari beranda supaya saya bisa meninjau satu alur lengkap sebelum commit.
3. > Cek lagi hasilnya terhadap checklist dan rubrik nilai 4. Jelaskan bagian yang termasuk hasil tutorial dan bagian yang menjadi tambahan di Tugas 8.
4. > Tambahkan tombol kembali di AppBar formulir Edukasi agar pengguna bisa kembali ke beranda tanpa membuka drawer. Terapkan alur yang sama di formulir Tambah Proyek.
5. > Aku cukup kebingungan dengan flow program , coba jelaskan ke aku dan berikan potongan code yang mengarah ke alur tersebut.
6. > Aku penasaran, disini project flutter apakah dia seperti django yang menyediakan form bawaan gitu? atau buat sendiri. 

### Verifikasi dan Debugging

Saya meminta Codex memeriksa proyek setelah formulir Edukasi terhubung ke beranda dan drawer. Pemeriksaan diulang setelah tombol kembali dan pratinjau durasi ditambahkan. Pada pemeriksaan akhir, `flutter analyze --no-pub` menghasilkan `No issues found` dan `flutter test --no-pub` meluluskan 15 pengujian widget.

Saya memeriksa dua jalur masuk karena keduanya menghasilkan riwayat navigasi yang berbeda. Pengujian membuka formulir dari kartu dan dari drawer, lalu memeriksa apakah pengguna dapat kembali ke beranda. Jika formulir dibuka dari drawer beranda, rute beranda sudah tergantikan. Kasus ini perlu diuji karena memanggil `pop()` saja tidak akan mengembalikan pengguna ke beranda.

Untuk formulir Edukasi, pengujian juga mencakup isian wajib yang kosong, urutan tahun yang salah, perubahan pratinjau durasi, serta dialog ringkasan. Satu pengujian menyimulasikan layar sempit dengan keyboard terbuka untuk memeriksa apakah tombol **Simpan** masih dapat dijangkau dengan menggulir.

### Refleksi Penggunaan AI

Perubahan pada formulir, navigasi, dan tampilan akan sulit saya ikuti jika dibahas sekaligus. Karena itu, saya memberi batas yang lebih jelas pada tiap tahap. Saya mulai dari isian yang dibutuhkan, lalu menelusuri bagaimana pengguna membuka formulir dari beranda dan bagaimana tombol **Simpan** menampilkan dialog ringkasan.

Pertanyaan tentang tombol kembali membantu saya memahami kenapa cara membuka halaman berpengaruh saat pengguna ingin kembali ke beranda. Setelah membandingkan jalur kartu dan drawer, saya meminta tombol tersebut tersedia juga pada formulir Proyek agar kedua halaman bisa digunakan dengan cara yang sama. Saat meninjau rubrik, saya juga mempertimbangkan manfaat setiap tambahan. Pratinjau durasi membantu pengguna mengetahui hasil dari isian tahunnya sebelum membuka ringkasan.

Rancangan isian tahun mulai dan tahun selesai tetap perlu dicocokkan dengan model Edukasi di proyek Django, yang saat itu belum tersedia untuk diperiksa. Dari sini saya belajar membedakan asumsi dalam rancangan dari perilaku yang sudah diuji. Widget test dapat memeriksa cara formulir memvalidasi dan menampilkan data, sedangkan kesesuaian nama dan tipe field perlu ditinjau dari model Django ketika integrasi dilakukan.

### Link Percakapan AI Tugas 8

`https://share.gemini.google/nuAKZKC2omn9

### Sumber Penjelasan

- PDF Tutorial 09 dan PDF Tugas 8 yang digunakan selama pengerjaan.
- [Flutter API: Navigator](https://api.flutter.dev/flutter/widgets/Navigator-class.html)
- [Flutter: Add a drawer to a screen](https://docs.flutter.dev/cookbook/design/drawer)
- [Flutter: Build a form with validation](https://docs.flutter.dev/cookbook/forms/validation)
- [Flutter: Understanding constraints](https://docs.flutter.dev/ui/layout/constraints)

## Proses Pengerjaan

### Tutorial 08 — Dasar aplikasi Flutter

Pada tahap ini, saya menyiapkan proyek Flutter dan mempelajari struktur direktori serta peran `main.dart` sebagai titik awal aplikasi. Halaman utama kemudian dipisahkan ke `menu.dart` dan diubah menjadi `StatelessWidget` karena belum memerlukan pengelolaan state lokal.

Saya juga menyusun halaman menggunakan widget seperti `Scaffold`, `Column`, dan `GridView`, serta membuat `InfoCard` untuk identitas dan `ItemCard` untuk menu. Ketika kartu menu ditekan, aplikasi menampilkan pesan melalui SnackBar.

### Tugas 7 — Penyesuaian portofolio pribadi

Saya melanjutkan proyek Tutorial 08 dengan memberikan warna yang berbeda pada setiap kartu menu melalui model `ItemHomepage`. Struktur kode juga dirapikan dengan memisahkan model, `InfoCard`, dan `ItemCard` ke file tersendiri.

Pada bagian tampilan, saya menambahkan panel sambutan, ikon identitas, dan bagian Tentang Saya. Susunan kartu disesuaikan dengan lebar layar agar lebih nyaman dibaca. Setelah perubahan selesai, saya memeriksa kode menggunakan `flutter analyze` dan menjalankan pengujian widget untuk identitas serta pesan SnackBar.

### Tutorial 09 — Navigasi dan formulir proyek

Saya memisahkan halaman dan widget ke direktori masing-masing, lalu menyiapkan drawer untuk berpindah antara beranda dan formulir Tambah Proyek. Saya mempelajari cara menghubungkan `Form` dengan validator dan menampilkan hasil pengisian dalam dialog. Pada tahap ini, kartu Tambah Proyek di beranda juga mulai membuka formulir.

### Tugas 8 — Formulir edukasi dan penyempurnaan navigasi

Saya mulai dengan menyusun isian dan validasi formulir Edukasi. Setelah formulir dapat menghasilkan ringkasan, saya menghubungkannya ke kartu beranda dan menambahkan pilihan **Add Education** pada drawer. Saya kemudian meninjau perpindahan antara beranda, formulir Proyek, dan formulir Edukasi, termasuk penanda pilihan yang sedang aktif.

Pada tahap berikutnya, saya menambahkan pratinjau durasi dari dua tahun yang diisi dan tombol kembali pada kedua formulir. Saya membagi commit berdasarkan alur yang selesai, mulai dari formulir dan navigasinya, lalu pratinjau dan akses kembali ke beranda. Setelah itu, saya memeriksa ulang hasilnya dan melengkapi penjelasan di README.

## Menjalankan Proyek

Siapkan Git, Flutter SDK, dan Google Chrome. Gunakan Flutter yang menyertakan Dart sesuai persyaratan di `pubspec.yaml` pada branch yang akan dijalankan. Periksa instalasi Flutter dan pastikan Chrome muncul pada daftar perangkat.

```bash
flutter doctor
flutter devices
```

Clone repositori, masuk ke direktori proyek, lalu pilih branch Tugas 8. Untuk membuka versi Tugas 7, gunakan `git switch Tugas07Mobile` pada langkah yang sama.

```bash
git clone https://github.com/SutaKarmana/myportofolio_mobile.git
cd myportofolio_mobile
git switch Tugas08Mobile
flutter pub get
flutter run -d chrome
```

Untuk mencoba alur Tugas 8, buka **Tambah Edukasi** dari beranda dan tekan **Simpan** saat isian masih kosong. Isi Institusi dan Program Studi, lalu masukkan `2025` dan `2029` untuk melihat perkiraan durasi. Tekan **Simpan** lagi untuk membuka dialog ringkasan. Coba kembali melalui tombol panah pada AppBar, lalu buka lagi formulir dari **Add Education** di drawer dan pilih **Home** untuk membandingkan kedua jalur.

Setelah dependensi tersedia, jalankan pemeriksaan berikut dari direktori proyek.

```bash
flutter analyze --no-pub
flutter test --no-pub
```
