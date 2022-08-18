import 'package:flutter/material.dart';

class aboutusPage extends StatelessWidget {
  const aboutusPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: const Color(0xffD8FFDB),
        title: const Text("About Us", textAlign: TextAlign.center),
      ),
      body: Stack(
        children: <Widget>[
          _background(context),
          // _nameApk(context),
        ],
      ),
    );
  }

  Widget _background(context) => Container(
        padding: const EdgeInsets.all(25),
        decoration: const BoxDecoration(
          color: Colors.white10,
        ),
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.18,
              child: const Text(
                  "\nSistem Informasi Geografis Pemetaan Usaha Masyarakat Kecil dan Menegah (UMKM) Provinsi NTB",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Color(0xff023535),
                    fontSize: 24.0,
                  ),
                  textAlign: TextAlign.center),
            ),
            const SizedBox(
              child: Text(
                "\nmerupakan sebuah aplikasi untuk membantu masyarakat mengetahui atau menemukan lokasi dan jenis barang dari UMKM yang ada di NTB. Dengan Masyarakat mengetahui lokasi dan jenis barang yang diproduksi maka ketika masyarakat berkunjung ke daerah tersebut, masyarakat dapat mengunjungi dan membeli barang produksi UMKM untuk dijadikan oleh-oleh.",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Color(0xff023535),
                  fontSize: 18.0,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
          ],
        ),
      );
// merupakan sebuah aplikasi untuk memetakan letak dari UMKM yang telah malukan kerja sama dengan NTB mall. Dengan aplikasi ini pengguna aplikasi dapat mengetahui letak UMKM yang telah bekerja sama dengan NTB mall menggunakan google maps yang telah terintegrasi dengan aplikasi. Pengguna juga da[at melakukan search UMKM berdasarkan nama UMKM dan di kabupaten mana UMKM itu berada.
  Widget _nameApk(context) => Container(
        height: MediaQuery.of(context).size.height * 0.2,
        padding: const EdgeInsets.all(25),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
          color: Color(0xffD8FFDB),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 0),
              blurRadius: 1,
              spreadRadius: 1,
              color: Colors.black26,
            ),
          ],
        ),
        child: const Text(
            "\n\nSistem Informasi Geografis Pemetaan Usaha Masyarakat Kecil dan Menegah (UMKM) Provinsi NTB",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: Color(0xff023535),
              fontSize: 18.0,
            ),
            textAlign: TextAlign.center),
      );
}
