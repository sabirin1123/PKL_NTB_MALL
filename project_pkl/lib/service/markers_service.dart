import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project_pkl/modal/umkm.dart';

class MarkerService {
  List<Marker> getMarkers(List<Umkm> umkm) {
    List<Marker> markers = [];

    umkm.forEach((umkm) {
      Marker marker = Marker(
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        markerId: MarkerId(umkm.id.toString()),
        draggable: false,
        infoWindow: InfoWindow(title: umkm.name),
        position: LatLng(umkm.latitude, umkm.longitude),
      );

      markers.add(marker);
    });

    return markers;
  }
}
