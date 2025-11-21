# kasir

1. Perbedaan Cubit dan BLoC: Cubit lebih sederhana dan langsung mengubah state dengan emit(), cocok untuk kasus ringan, sedangkan BLoC lebih formal menggunakan alur Event → State, cocok untuk aplikasi kompleks dengan banyak event.

2. Pemisahan model, logika bisnis, dan UI penting agar kode lebih terstruktur, mudah diuji, mudah dirawat, dan logika bisa digunakan ulang tanpa tergantung UI.

3. Contoh state pada CartCubit:
CartInitial → keranjang kosong atau belum dimuat.
CartLoading → menandakan proses update atau load data sedang berjalan.
CartLoaded → data keranjang berhasil dimuat, menampilkan item dan total harga.
