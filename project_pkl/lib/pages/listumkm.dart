import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project_pkl/modal/umkm.dart';
import 'package:project_pkl/pages/detail.dart';
import 'package:project_pkl/repositori/repositori.dart';

import '../Widget/search_widget.dart';

class listUmkm extends StatefulWidget {
  @override
  listUmkmState createState() => listUmkmState();
}

class listUmkmState extends State<listUmkm> {
  detailPageState detailumkm = detailPageState();
  List<Umkm> umkms = [];
  String query = '';
  Timer? debouncer;
  List<Marker> _markers = <Marker>[];

  @override
  void initState() {
    super.initState();

    init();
  }

  @override
  void dispose() {
    debouncer?.cancel();
    super.dispose();
  }

  void debounce(
    VoidCallback callback, {
    Duration duration = const Duration(milliseconds: 1000),
  }) {
    if (debouncer != null) {
      debouncer!.cancel();
    }

    debouncer = Timer(duration, callback);
  }

  Future init() async {
    final umkms = await FetchUmkmList.getUmkms(query);

    setState(() => this.umkms = umkms);
    print(umkms);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('List UMKM'),
          centerTitle: true,
        ),
        body: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              buildSearch(),
              allData(),
              Expanded(
                child: ListView.builder(
                  itemCount: umkms.length,
                  itemBuilder: (context, index) {
                    final umkm = umkms[index];
                    print(umkm.name);

                    return buildUmkm(umkm);
                  },
                ),
              ),
            ],
          ),
        ),
      );

  Widget buildSearch() => SearchWidget(
        text: query,
        hintText: 'Search berdasarkan kabupaten',
        onChanged: searchUmkm,
      );

  Widget allData() => SizedBox(
        height: 20,
        child: Row(
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.all(5.0),
            ),
            Text(
              '${umkms.length.toString()} UMKM tersedia',
              style: const TextStyle(
                fontSize: 16.0,
                color: Colors.black54,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      );

  Future searchUmkm(String query) async => debounce(() async {
        final umkms = await FetchUmkmList.getUmkms(query);

        if (!mounted) return;

        setState(() {
          this.query = query;
          this.umkms = umkms;
        });
      });

  Widget buildUmkm(Umkm umkm) => Container(
        margin: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 243, 242, 241),
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0.0, 0.1), //(x,y)
              blurRadius: 2.0,
            ),
          ],
        ),
        child: ListTile(
            title: Text(umkm.name),
            subtitle: Text(umkm.districts),
            trailing: IconButton(
              icon: const Icon(Icons.description_sharp),
              color: Theme.of(context).primaryColor,
              onPressed: () => setState(
                () {
                  // Get.to(descripsiUMKM.descriptionUmkm(
                  //     umkm.name,
                  //     umkm.address,
                  //     umkm.districts,
                  //     umkm.subdistricts,
                  //     umkm.type_business,
                  //     umkm.type));
                  _markers.clear();
                  _markers.add(Marker(
                      icon: BitmapDescriptor.defaultMarkerWithHue(
                          BitmapDescriptor.hueGreen),
                      markerId: MarkerId(umkm.id.toString()),
                      position: LatLng(umkm.latitude, umkm.longitude),
                      infoWindow: InfoWindow(title: umkm.name)));
                  Get.to(Scaffold(
                    appBar: AppBar(
                      title: const Text("Detail"),
                    ),
                    body: Container(
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.35,
                            width: MediaQuery.of(context).size.width,
                            child: GoogleMap(
                              mapType: MapType.normal,
                              zoomControlsEnabled: false,
                              initialCameraPosition: CameraPosition(
                                  target: LatLng(umkm.latitude, umkm.longitude),
                                  zoom: 15),
                              onMapCreated: (controller) {
                                controller;
                              },
                              markers: Set<Marker>.of(_markers),
                            ),
                          ),

                          Container(
                            padding: const EdgeInsets.all(25),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(umkm.name,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xff023535),
                                      fontSize: 20.0,
                                    ),
                                    textAlign: TextAlign.left),
                                Text(umkm.address,
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 101, 111, 112),
                                      fontSize: 15.0,
                                    ),
                                    textAlign: TextAlign.left),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                    "UMKM ${umkm.name} merupakan umkm milik ${umkm.owner} yang menjual barang berjenis ${umkm.type} dan umkm ${umkm.name} berlokasi di Kabupaten ${umkm.districts} kecamatan ${umkm.subdistricts}",
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 47, 50, 51),
                                      fontSize: 18.0,
                                    ),
                                    textAlign: TextAlign.left),
                              ],
                            ),
                          ),
                          // Container(
                          //   padding: const EdgeInsets.all(25),
                          //   child: Material(
                          //     elevation: 2,
                          //     borderRadius: BorderRadius.circular(10),
                          //     color: Color.fromARGB(255, 153, 248, 161),
                          //     child: MaterialButton(
                          //         shape: RoundedRectangleBorder(
                          //           borderRadius: BorderRadius.circular(10),
                          //         ),
                          //         padding:
                          //             const EdgeInsets.fromLTRB(20, 15, 20, 15),
                          //         minWidth: MediaQuery.of(context).size.width,
                          //         onPressed: () => Get.back(),
                          //         child: const Text(
                          //           "Close",
                          //           textAlign: TextAlign.center,
                          //           style: TextStyle(
                          //               fontSize: 20,
                          //               color: Color(0xff023535),
                          //               fontWeight: FontWeight.w600),
                          //         )),
                          //   ),
                          // )
                        ],
                      ),
                    ),
                  ));
                },
              ),
            )),
      );

  Widget buttonAboutus(BuildContext context) => Material(
        elevation: 2,
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).primaryColor,
        child: MaterialButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
            minWidth: MediaQuery.of(context).size.width,
            onPressed: () => Get.back(),
            child: const Text(
              "About Us",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20,
                  color: Color(0xff023535),
                  fontWeight: FontWeight.w600),
            )),
      );
}
