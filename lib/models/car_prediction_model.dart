import 'dart:convert';

// To get the prediction from json to string
CarPrediction carPredictionFromJson(String str) => CarPrediction.fromJson(json.decode(str));


class CarPrediction {
  CarPrediction({
    required this.price,
  });

  final String price;

  factory CarPrediction.fromJson(Map<String, dynamic> json) =>
      CarPrediction(price: json['result']);

  //This will be used just in case i would like to do a post or update
  Map<String, dynamic> toJson() => {
        "price": price,
      };

// Trick to not crush
  @override
  String toString() {
    String result = price;
    return result;
  }
}
