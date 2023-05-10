import 'dart:convert';
import 'package:car_predictor_front_end/constants/api_keys.dart';
import 'package:car_predictor_front_end/models/car_prediction_model.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

//   class CarPredictionApi {
//   Future<CarPrediction?> getPrediction(String year, String mileage,
//       String state, String make, String model) async {
//     var client = http.Client();
//     print('hero 2');
//     var uri = Uri.parse(
//         "http://127.0.0.1:5000/predict/?YEAR=$year&MILEAGE=$mileage&STATE=$state&MAKE=$make&MODEL=$model");
//     print('hero 3');
//     var response = await client.get(uri);
//     print('hero 4');
//     if (response.statusCode == 200) {
//       var json = response.body;
//       return carPredictionFromJson(json);
//     } else {
//       print('hero 5');
//       throw Exception('Failed to get All Users');
//     }
//   }
// }

import 'package:dio/dio.dart';

// class CarPredictionApi {
//   Future<CarPrediction?> getPrediction(String year, String mileage,
//       String state, String make, String model) async {
//     try {
//       var dio = Dio();
//       var response = await dio.get(
//           "http://127.0.0.1:5000/predict/?YEAR=$year&MILEAGE=$mileage&STATE=$state&MAKE=$make&MODEL=$model");
//       if (response.statusCode == 200) {
//         var json = response.data;
//         return carPredictionFromJson(json);
//       } else {
//         throw Exception('Failed to get Car Prediction');
//       }
//     } catch (e) {
//       print(e.toString());
//       throw Exception('Failed to get Car Prediction');
//     }
//   }
// }

class CarPredictionApi {
  Future<String> getPrediction(String year, String mileage, String state,
      String make, String model) async {
    var client = http.Client();
    var uri = Uri.parse(
        "http://127.0.0.1:5000/predict/?YEAR=$year&MILEAGE=$mileage&STATE=$state&MAKE=$make&MODEL=$model");

    // var url = Uri.https(
    //     "http:/127.0.0.1:5000/predict/?YEAR=$year&MILEAGE=$mileage&STATE=$state&MAKE=$make&MODEL=$model");
    var response = await client.get(uri);

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to get Car Prediction');
    }
  }

  /// generate response from bot
  Future<String> getCarAnalysis(String prompt) async {
    const apiKey = apiSecretKey;
    var url = Uri.https("api.openai.com", "/v1/completions");
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        "Authorization": "Bearer $apiKey"
      },
      body: json.encode({
        "model": "text-davinci-003",
        "prompt": prompt,
        'temperature': 0,
        'max_tokens': 2000,
        'top_p': 1,
        'frequency_penalty': 0.0,
        'presence_penalty': 0.0,
      }),
    );

    // Do something with the response
    Map<String, dynamic> newResponse = jsonDecode(response.body);

    return newResponse['choices'][0]['text'];
  }
}
