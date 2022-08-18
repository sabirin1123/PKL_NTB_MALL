import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project_pkl/pages/listumkm.dart';
import 'package:project_pkl/repositori/repositori.dart';
import 'package:search_page/search_page.dart';
import '../modal/umkm.dart';
import '../service/markers_service.dart';

class homePage extends StatefulWidget {
  @override
  homePageState createState() => homePageState();
}

class homePageState extends State<homePage> {
  GoogleMapController? mapController;
  Completer<GoogleMapController> _controller = Completer();
  MapType _mapType = MapType.normal;
  LatLng m = LatLng(-8.749366, 117.570633);

  Map<MarkerId, Marker> penanda = <MarkerId, Marker>{};
  // List<marker> markers = [];
  // List<Umkm> filtermarker = [];
  final markerService = MarkerService();
  List<Umkm> umkm = [];
  FetchUmkmList umkmList = FetchUmkmList();
  Iterable iterable = [];

  List<Umkm> umkms = [];
  String query = '';
  Timer? debouncer;

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
  }

  void animatCamera(lat, lng) {
    LatLng newlatlang = LatLng(lat, lng);
    mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: newlatlang, zoom: 17),
      ),
    );
  }

  Widget _listUmkm() => Align(
        alignment: const Alignment(0.95, -0.5),
        child: FloatingActionButton(
          // backgroundColor: Color(0xff008F8C),
          mini: true,
          heroTag: null,
          tooltip: 'Map Type',
          child: const Icon(Icons.list),
          onPressed: () => Get.to(listUmkm()),
        ),
      );

  Widget _searchUmkm() => Align(
        alignment: const Alignment(0.95, -0.7),
        child: FloatingActionButton(
          // backgroundColor: Color(0xff008F8C),
          mini: true,
          heroTag: null,
          tooltip: 'Search umkm',
          child: const Icon(Icons.search),
          onPressed: () => showSearch(
            context: context,
            delegate: SearchPage<Umkm>(
              onQueryUpdate: (s) => print(s),
              items: umkms,
              searchLabel: 'Search UMKM',
              suggestion: const Center(
                child: Text('Filter UMKM berdasarkan nama atau kabupaten'),
              ),
              failure: const Center(
                child: Text('No UMKM found :('),
              ),
              filter: (m) => [m.name, m.districts],
              builder: (m) => ListTile(
                title: Text(m.name),
                subtitle: Text(m.districts),
                trailing: IconButton(
                  icon: const Icon(Icons.directions),
                  color: Theme.of(context).primaryColor,
                  onPressed: () => setState(
                    () {
                      Get.back();
                      animatCamera(m.latitude, m.longitude);
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      );

  Widget _mapTypeSwitcher() => Align(
        alignment: const Alignment(0.95, -0.9),
        child: FloatingActionButton(
          mini: true,
          heroTag: null,
          tooltip: 'Map Type',
          child: const Icon(Icons.layers),
          onPressed: () {
            final MapType nextType =
                MapType.values[_mapType.index == 2 ? 1 : 2];
            setState(() {
              print(nextType.toString());
              _mapType = nextType;
            });
          },
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Maps"),
      ),
      body: Stack(
        children: <Widget>[
          _buildGoogleMap(context),
          _mapTypeSwitcher(),
          _searchUmkm(),
          _listUmkm(),
        ],
      ),
    );
  }

  Widget _buildGoogleMap(BuildContext context) {
    var markers =
        (umkms != null) ? markerService.getMarkers(umkms) : <Marker>[];
    return (umkms != null)
        ? Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: GoogleMap(
              mapType: _mapType,
              initialCameraPosition: CameraPosition(target: m, zoom: 7.3),
              onMapCreated: (controller) {
                setState(() {
                  mapController = controller;
                });
              },
              markers: Set<Marker>.of(markers),
            ),
          )
        : Center(child: CircularProgressIndicator());
  }
}
