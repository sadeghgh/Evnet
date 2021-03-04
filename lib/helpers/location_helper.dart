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

  static Future<Map<String, String>> getPlaceAddress(
      double lat, double lng) async {
    Map<String, String> adressInfo = {
      'adress': '',
      'postalCode': '',
      'city': '',
      'district': '',
    };
    String district = '';
    String city = '';
    String postalCode = '';
    String adress = '';

    final url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$GOOGLE_API_KEY';
    final response = await http.get(url);
    final status = json.decode(response.body)['status'];

    if (status == 'OK') {
      final relevantAdressInfo = json.decode(response.body)['results'][0];
      List<dynamic> addressComponents =
          relevantAdressInfo['address_components'];
      adress = relevantAdressInfo['formatted_address'];

      // if the street is not unnamed road
      if (addressComponents.firstWhere(
              (entry) => entry['types'].contains('route'))['long_name'] !=
          'Unnamed Road') {
        district = addressComponents[2]['long_name'];
      } else {
        district = addressComponents[1]['long_name'];
      }
      postalCode = addressComponents.firstWhere(
          (entry) => entry['types'].contains('postal_code'))['long_name'];

      if (postalCode != null) {
        city = fetchCityFromAdress(adress);
      }

      adressInfo.update('adress', (value) => adress);
      adressInfo.update('postalCode', (value) => postalCode);
      adressInfo.update('city', (value) => city);
      adressInfo.update('district', (value) => district);
    }
    print('adressInfo:');
    print(adressInfo);
    return adressInfo;
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
      }
    }
    return city;
  }
}
