

//model class for place search
class PlaceSearch{
  final String description;
  final String placeId;

  PlaceSearch({this.description,this.placeId});

  factory PlaceSearch.fromJson(Map<String,dynamic> json){
    return PlaceSearch(
      description: json['description'],
      placeId:json['place_id']
    );
  }
}

//
//
// import 'package:http/http.dart' as http;
// import 'dart:convert' as convert;
//
//
// class PlacesService {
//   final key = 'YOUR_KEY';
//
//   Future<List<PlaceSearch>> getAutocomplete(String search) async {
//     var url =
//         'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$search&types=(cities)&key=$key';
//     var response = await http.get(url);
//     var json = convert.jsonDecode(response.body);
//     var jsonResults = json['predictions'] as List;
//     return jsonResults.map((place) => PlaceSearch.fromJson(place)).toList();
//   }
//
//   Future<Place> getPlace(String placeId) async {
//     var url =
//         'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$key';
//     var response = await http.get(url);
//     var json = convert.jsonDecode(response.body);
//     var jsonResult = json['result'] as Map<String,dynamic>;
//     return Place.fromJson(jsonResult);
//   }
//
//   Future<List<Place>> getPlaces(double lat, double lng,String placeType) async {
//     var url = 'https://maps.googleapis.com/maps/api/place/textsearch/json?location=$lat,$lng&type=$placeType&rankby=distance&key=$key';
//     var response = await http.get(url);
//     var json = convert.jsonDecode(response.body);
//     var jsonResults = json['results'] as List;
//     return jsonResults.map((place) => Place.fromJson(place)).toList();
//   }
// }