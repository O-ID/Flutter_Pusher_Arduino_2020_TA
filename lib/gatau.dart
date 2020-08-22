import 'package:flutter/material.dart';
import 'package:drop_cap_text/drop_cap_text.dart';
import 'dart:math' as math;

class Psolving extends StatefulWidget {
  @override
  _PsolvingState createState() => _PsolvingState();
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child,
  });
  final double minHeight;
  final double maxHeight;
  final Widget child;
  @override
  double get minExtent => minHeight;
  @override
  double get maxExtent => math.max(maxHeight, minHeight);
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}

class _PsolvingState extends State<Psolving> {
  SliverPersistentHeader makeHeader(String headerText, String header2) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _SliverAppBarDelegate(
        minHeight: 60.0,
        maxHeight: 100.0,
        child: Container(
            color: Colors.purple[100],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  headerText,
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                Text(
                  header2,
                  style: TextStyle(fontSize: 16.0),
                )
              ],
            )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          expandedHeight: 150,
          stretch: false,
          backgroundColor: Colors.purple[50],
          flexibleSpace: FlexibleSpaceBar(
            background:
                Image.asset('assets/images/icon.png', fit: BoxFit.contain),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(-200),
              bottomRight: Radius.circular(200),
            ),
          ),
        ),
        makeHeader('Tutorial Aplikasi', 'Tombol Kontrol'),
        SliverFixedExtentList(
          itemExtent: 110.0,
          delegate: SliverChildListDelegate(
            [
              Container(
                color: Colors.purple[50],
                padding: EdgeInsets.all(10.0),
                child: DropCapText(
                    'Menunjukkan Area atau Sensor yang ke berapa, Contoh DHT22 Ke-1 Menunjukkan Area Ke- 1',
                    textAlign: TextAlign.justify,
                    dropCap: DropCap(
                      width: 200,
                      height: 50,
                      child: Image.asset(
                        'assets/images/headerApp.png',
                        fit: BoxFit.cover,
                      ),
                    )),
              ),
              Container(
                color: Colors.purple[200],
                padding: EdgeInsets.all(10.0),
                child: DropCapText(
                    'Menunjukkan Data Suhu secara Realtime, Pengembunan akan dilakukan ketika suhu lebih besar dari 29.0, dan akan berhenti ketika mencapai 29.0. Mengalami Masalah Tentang Suhu ? Lihat Pemecahan Masalah',
                    textAlign: TextAlign.justify,
                    dropCap: DropCap(
                      width: 200,
                      height: 40,
                      child: Image.asset(
                        'assets/images/suhu.png',
                        fit: BoxFit.cover,
                      ),
                    )),
              ),
              Container(
                color: Colors.purple[50],
                padding: EdgeInsets.all(10.0),
                child: DropCapText(
                    'Menunjukkan Data Kelembaban secara Realtime, Pengembunan akan dilakukan ketika Lembab lebih kecil dari 80.0, dan akan berhenti ketika mencapai 80.0. Mengalami Masalah Tentang Lembab ? Lihat Pemecahan Masalah',
                    textAlign: TextAlign.justify,
                    dropCap: DropCap(
                      width: 200,
                      height: 40,
                      child: Image.asset(
                        'assets/images/lembab.png',
                        fit: BoxFit.cover,
                      ),
                    )),
              ),
              Container(
                color: Colors.purple[200],
                padding: EdgeInsets.all(10.0),
                child: DropCapText(
                    'Tombol dalam posisi off dan text Otomatis menunjukkan bahwa perangkat berjalan secara otomatis, jika ingin melakukan pengembunan secara manual tekan tombol untuk menyalakan.',
                    textAlign: TextAlign.justify,
                    dropCap: DropCap(
                      width: 200,
                      height: 40,
                      child: Image.asset(
                        'assets/images/ftombol.png',
                        fit: BoxFit.cover,
                      ),
                    )),
              ),
              Container(
                color: Colors.purple[50],
                padding: EdgeInsets.all(10.0),
                child: DropCapText('Menunjukkan Label ketersediaan air.',
                    textAlign: TextAlign.justify,
                    dropCap: DropCap(
                      width: 200,
                      height: 30,
                      child: Image.asset(
                        'assets/images/hair.png',
                        fit: BoxFit.cover,
                      ),
                    )),
              ),
              Container(
                color: Colors.purple[100],
                padding: EdgeInsets.all(10.0),
                child: DropCapText(
                    'Menunjukan ketersediaan air, atau persentase dari air saat ini.',
                    textAlign: TextAlign.justify,
                    dropCap: DropCap(
                      width: 150,
                      height: 50,
                      child: Image.asset(
                        'assets/images/isiair.png',
                        fit: BoxFit.cover,
                      ),
                    )),
              ),
              Container(
                color: Colors.purple[200],
                padding: EdgeInsets.all(10.0),
                child: DropCapText(
                    'Tombol dalam posisi off dan text Otomatis menunjukkan bahwa pengisian air berjalan secara otomatis, jika ingin melakukan pengisian secara manual tekan tombol untuk menyalakan.',
                    textAlign: TextAlign.justify,
                    dropCap: DropCap(
                      width: 200,
                      height: 40,
                      child: Image.asset(
                        'assets/images/ftombol.png',
                        fit: BoxFit.cover,
                      ),
                    )),
              ),
            ],
          ),
        ),
        makeHeader('Tutorial Aplikasi', 'Tombol Rekap'),
        SliverFixedExtentList(
          itemExtent: 110.0,
          delegate: SliverChildListDelegate(
            [
              Container(
                  color: Colors.purple[50],
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                      'Terdapat Tombol Lihat Data untuk melihat data pada bulan tertentu, klik dan pilih bulan untuk melihat data bulan. terdapat pesan konfirmasi persetujuan untuk melanjutkan atau batal melihat data.')),
              Container(
                color: Colors.purple[200],
                padding: EdgeInsets.all(10.0),
                child: DropCapText(
                    'Setelah pemilihan data terdapat chart atau bar, pada bagian bawah seperti gambar disamping terdapat DHT 2, 3, 4 dan seterusnya, nomor yang berbeda menandakan area tertentu.',
                    textAlign: TextAlign.justify,
                    dropCap: DropCap(
                      width: 200,
                      height: 40,
                      child: Image.asset(
                        'assets/images/dhtchart.png',
                        fit: BoxFit.cover,
                      ),
                    )),
              ),
            ],
          ),
        ),
        //chart panjang
        SliverFixedExtentList(
          itemExtent: 350.0,
          delegate: SliverChildListDelegate(
            [
              Container(
                color: Colors.purple[50],
                padding: EdgeInsets.all(10.0),
                child: DropCapText(
                    'Terdapat nomor di sebelah kiri chart atau bar Rekap, menunjukkan banyak pengembunan atau berapa kali dalam sebulan perangkat melakukan pengembunan.',
                    textAlign: TextAlign.justify,
                    dropCap: DropCap(
                      width: 100,
                      height: 300,
                      child: Image.asset(
                        'assets/images/numberchart.png',
                        fit: BoxFit.contain,
                      ),
                    )),
              ),
            ],
          ),
        ),
        SliverFixedExtentList(
          itemExtent: 110.0,
          delegate: SliverChildListDelegate(
            [
              Container(
                  color: Colors.purple[200],
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                      'Terakhir terdapat tombol Hapus Data di sebelah tombol Lihat Data, tombol tersebut berfungsi untuk menghapus data pada bulan tertentu yang akan anda pilih, untuk menghapus tap tombol Hapus Data->Pilih data bulan->tap Ok->Konfirmasi Penghapusan data->Selesai.'))
            ],
          ),
        ),
        makeHeader('Pemecahan Masalah', ''),
        // Yes, this could also be a SliverFixedExtentList. Writing
        // this way just for an example of SliverList construction.
        SliverGrid.count(
          crossAxisCount: 3,
          children: [
            Container(
              color: Colors.red,
              height: 150.0,
              child: Image.asset(
                'assets/images/dht22.png',
                fit: BoxFit.contain,
              ),
            ),
            Container(
              color: Colors.purple,
              height: 150.0,
              child: Image.asset(
                'assets/images/esp.png',
                fit: BoxFit.contain,
              ),
            ),
            Container(
              color: Colors.green,
              height: 150.0,
              child: Image.asset(
                'assets/images/pompa.png',
                fit: BoxFit.contain,
              ),
            ),
            Container(
              color: Colors.orange,
              height: 150.0,
              child: Image.asset(
                'assets/images/relaydc.png',
                fit: BoxFit.contain,
              ),
            ),
            Container(
              color: Colors.yellow,
              height: 150.0,
              child: Image.asset(
                'assets/images/ultrasonic.png',
                fit: BoxFit.contain,
              ),
            ),
            Container(
              color: Colors.blue,
              height: 150.0,
              child: Image.asset(
                'assets/images/solenoid.png',
                fit: BoxFit.contain,
              ),
            )
          ],
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              Container(
                  padding: EdgeInsets.all(10.0),
                  color: Colors.cyan,
                  height: 400.0,
                  child: Text(
                      'Masalah Tidak Melakukan Pengembunan\n\n1. Jika Suhu Dan Lembab di aplikasi berjalan atau tetap berganti seiringnya waktu namun tidak melakukan pengembunan Coba periksa kabel Modul Relay dan tekan tombol on/off di aplikasi atau tombol yang terdapat di perangkat lalu restart perangkat.\n\n2. Jika suhu dan lembab keluar angka 0 atau NaN coba periksa sensor DHT22 Lalu restart perangkat.\n\n3. Jika suhu dan lembab tetap keluar 0 atau NaN setelah perangkat di restart Periksalah Modul ESP8266 jika led biru tidak berkedip silahkan restart perangkat.\n\n4. Setelah melakukan 3 pemecahan diatas namun tetap tidak melakukan pengembunan periksalah air di tangki air.\n\n5. Jika air banyak, periksalah pompa air sambil menekan tombol on/off di aplikasi atau di perangkat.\n\n6. Jika pompa air menyala namun tetap tidak menyiram periksalah solenoid mungkin terdapat sambungan terputus lalu restart perangkat.')),
              Container(
                color: Colors.purple[50],
                padding: EdgeInsets.all(10.0),
                height: 400.0,
                child: Text(
                    'Masalah Tidak Melakukan Pengisian Air Tangki\n\n1. Jika persentase di aplikasi berjalan atau tetap berganti seiringnya waktu namun tidak melakukan pengisian air Coba periksa kabel Modul Relay dan tekan tombol on/off di aplikasi atau tombol yang terdapat di perangkat lalu restart perangkat.\n\n2. Jika persentase keluar angka 0 atau NaN coba periksa sensor Ultrasonic apakah lampu merah menyala? jika tidak, restart perangkat.\n\n3. Jika persentase tetap keluar 0 atau NaN setelah perangkat di restart Periksalah Modul ESP8266 jika led biru tidak berkedip silahkan restart perangkat.\n\n4. Jika pompa air menyala namun tetap mengisi atau tidak berhenti mengisi restart perangkat, biasanya sistem mengalami kegagalan dalam membaca data.'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
