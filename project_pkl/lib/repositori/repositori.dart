import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:project_pkl/modal/umkm.dart';

// class Repository {
//   final _baseUrl = 'http://10.0.2.2:8000/api/umkm';

//   Future getData() async {
//     try {
//       final response = await http.get(Uri.parse(_baseUrl));

//       if (response.statusCode == 200) {
//         final umkm = jsonDecode(response.body)['data'];
//         // List<Umkm> umkm = it.map((e) => Umkm.fromJson(e)).toList();
//         return umkm;
//       } else {
//         print("error status " + response.statusCode.toString());
//         return null;
//       }
//     } catch (e) {
//       print(e.toString());
//     }
//   }
// }

class FetchUmkmList {
  static Future<List<Umkm>> getUmkms(String query) async {
    final url = Uri.parse('https://gisntbmall.000webhostapp.com/api/umkm');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List umkms = json.decode(response.body)['data'];

      return umkms.map((json) => Umkm.fromJson(json)).where((umkm) {
        // final titleLower = umkm.name.toLowerCase();
        final authorLower = umkm.districts.toLowerCase();
        final searchLower = query.toLowerCase();

        return authorLower.contains(searchLower);
        // ||
        //     authorLower.contains(searchLower);
      }).toList();
    } else {
      throw Exception();
    }
  }
}
