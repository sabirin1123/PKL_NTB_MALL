import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_pkl/pages/aboutusPage.dart';
import 'package:project_pkl/pages/homePage.dart';
import 'package:project_pkl/pages/listumkm.dart';

class firstPage extends StatefulWidget {
  const firstPage({Key? key}) : super(key: key);

  @override
  _firstPageState createState() => _firstPageState();
}

class _firstPageState extends State<firstPage> {
  @override
  Widget build(BuildContext context) {
    final buttonMaps = Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(10),
      color: const Color(0xffD8FFDB),
      child: MaterialButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () => Get.to(homePage()),
          child: const Text(
            "Maps",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20,
                color: Color(0xff023535),
                fontWeight: FontWeight.w600),
          )),
    );

    final buttonAboutus = Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(10),
      color: const Color(0xffD8FFDB),
      child: MaterialButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () => Get.to(aboutusPage()),
          child: const Text(
            "About Us",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20,
                color: Color(0xff023535),
                fontWeight: FontWeight.w600),
          )),
    );

    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: Color(0xff008F8C),
        ),
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: ListView(
              padding: EdgeInsets.all(32),
              children: <Widget>[
                const SizedBox(
                  height: 80,
                ),
                const SizedBox(
                  width: 200,
                  height: 200,
                  child: Image(
                      image: AssetImage('assets/images/icon1.png'),
                      fit: BoxFit.cover),
                ),

                // SizedBox(
                //   height: 100,
                //   child: Column(
                //     children: const [
                //       Text("Telusuri UMKM di dekat anda\n",
                //           style: TextStyle(
                //               fontWeight: FontWeight.w700, color: Colors.white),
                //           textAlign: TextAlign.center),
                //       Text(
                //         "Beli barang yang anda butuhkan di UMKM terdekat anda",
                //         maxLines: 2,
                //         textAlign: TextAlign.center,
                //       ),
                //     ],
                //   ),
                // ),
                const SizedBox(
                  height: 130,
                ),
                buttonMaps,
                const SizedBox(
                  height: 30,
                ),
                buttonAboutus,
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
