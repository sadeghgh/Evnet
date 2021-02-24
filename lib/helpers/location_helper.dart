import 'dart:convert';

import 'package:http/http.dart' as http;

const GOOGLE_API_KEY = 'AIzaSyBX0s9a2KGHJ8ZEoJ1bDuld8IAhDa63WzM';

class LocationHelper {
  // static String generateLocationPreviewImage({
  //   double latitude,
  //   double longitude,
  // }) {
  //   return 'https://maps.googleapis.com/maps/api/staticmap?center=&$latitude,$longitude&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$latitude,$longitude&key=$GOOGLE_API_KEY';
  // }

  static Future<String> getPlaceAddress(double lat, double lng) async {
    final url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$GOOGLE_API_KEY';
    final response = await http.get(url);
    return json.decode(response.body)['results'][0]['formatted_address'];
  }

  static String fetchCityFromAdress(String adress) {
    List<String> splitedAdress = adress.split(',');
    int postionOfCity = splitedAdress.length - 2;
    String unformattedCityName = splitedAdress[postionOfCity];
    List<String> splitedUnformattedCityName = unformattedCityName.split(" ");
    String city;
    for (int i = 0; i < splitedUnformattedCityName.length; i++) {
      if (RegExp(r'^[0-9]+$').hasMatch(splitedUnformattedCityName[i]) != true) {
        city = splitedUnformattedCityName[i];
        print(city);
      }
    }
    return city;
  }
}
