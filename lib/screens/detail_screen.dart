import 'package:car_predictor_front_end/models/car_prediction_model.dart';
import 'package:car_predictor_front_end/services/car_prediction_Api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:get/get.dart';
import 'package:car_predictor_front_end/constants/exports.dart';
import 'package:car_predictor_front_end/widgets/responsive_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';

class DetailsScreen extends StatefulWidget {
  final String makeText;
  final String modelText;
  final String yearText;
  final String stateText;
  final String mileageText;

  const DetailsScreen({
    Key? key,
    required this.makeText,
    required this.modelText,
    required this.yearText,
    required this.stateText,
    required this.mileageText,
  }) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  List<String> webSites = [
    'Carvana',
    'Carmax',
    'truecar.com',
    'Google',
  ];

  List<String> webUrls = [
    'https://www.carvana.com/cars/',
    'https://www.carmax.com/cars?search=',
    'https://www.truecar.com/used-cars-for-sale/listings/',
    'https://www.google.com/search?q=',
  ];

  // void _launchURL() async {
  //   const url = 'https://flutter.dev';
  //   if (await canLaunch(url)) {
  //     await launch(url);
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }

  void _launchURL(String url) async {
    String newUrl = "";
    if (url == 'https://www.truecar.com/used-cars-for-sale/listings/') {
      newUrl =
          "$url${widget.makeText.toLowerCase()}/${widget.modelText.toLowerCase()}/year-${widget.yearText}/";
    } else {
      newUrl =
          "$url${widget.makeText.toLowerCase()}%20${widget.modelText.toLowerCase()}%20${widget.yearText}";
    }
    print("Yhis is the url : $newUrl");
    if (await canLaunch(newUrl)) {
      await launch(newUrl);
    } else {
      throw 'Could not launch $newUrl';
    }
  }

// for keep the circular progressing until is query is completed
  String? carPrediction;
  String? carAnalysis;
  var isLoaded = 0;
  String? estimatedPrice = '\$55,000';
  String? carAnalysisDefault = "The analysis";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCarPrediction();
    getCarAnalysis();
  }

  getCarPrediction() async {
    carPrediction = await CarPredictionApi().getPrediction(
        widget.yearText,
        widget.mileageText,
        widget.stateText,
        widget.makeText,
        widget.modelText);
    double result =
        double.parse(carPrediction!.replaceAll(RegExp(r'[^\d.]'), ''));
    String carPredictionFormated =
        NumberFormat.currency(symbol: '\$', decimalDigits: 2).format(result);
    if (carPrediction != null) {
      setState(() {
        isLoaded += 1;
        estimatedPrice = carPredictionFormated;
      });
    }
  }

  getCarAnalysis() async {
    String prompt =
        "I would like to buy a second hand ${widget.makeText} ${widget.modelText} ${widget.yearText}, it has ${widget.mileageText} of mileage, and I will buy it in ${widget.stateText} state here in USA, Can you please tell me the pros, the cons, and What I have to be aware of before buying this car ?";
    carAnalysis = await CarPredictionApi().getCarAnalysis(prompt);
    if (carAnalysis != null) {
      setState(() {
        isLoaded += 1;
        carAnalysisDefault = carAnalysis;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        /// floating button
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.defaultDialog(
              title: '',
              content: Builder(builder: (context) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    for (int i = 0; i < 4; i++)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: TextButton(
                          onPressed: () {
                            _launchURL(webUrls[i]);
                          },
                          child: Text(
                            webSites[i].toString(),
                            style: interSemiBold.copyWith(
                              fontSize: 15,
                              color: AppColors.secondaryColor,
                            ),
                          ),
                        ),
                      ),
                  ],
                );
              }),
            );
          },
          backgroundColor: AppColors.primaryColor,
          child: const Icon(Icons.search, color: AppColors.whiteColor),
        ),

        /// appbar
        appBar: AppBar(
          backgroundColor: AppColors.secondaryColor,
          automaticallyImplyLeading: true,
        ),

        /// body
        body: Visibility(
          visible: isLoaded == 2,
          replacement: const Center(
            child: CircularProgressIndicator(),
          ),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(
              horizontal: ResponsiveWidget.isSmallScreen(context)
                  ? 20
                  : ResponsiveWidget.isMediumScreen(context)
                      ? height(context) * 0.05
                      : height(context) * 0.07,
              vertical: height(context) * 0.05,
            ),
            children: [
              pointTexts(heading: 'Make:', value: widget.makeText),
              pointTexts(heading: 'Model:', value: widget.modelText),
              pointTexts(heading: 'Year:', value: widget.yearText),
              pointTexts(heading: 'State:', value: widget.stateText),
              pointTexts(heading: 'Mileage:', value: widget.mileageText),
              pointTexts(heading: 'Estimated Price:', value: estimatedPrice!),

              /// pros
              const SizedBox(height: 16),
              Text(
                'Analysis:',
                style: interSemiBold.copyWith(
                  fontSize: 18,
                  color: AppColors.secondaryColor,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                carAnalysisDefault!,
                style: interRegular.copyWith(
                  fontSize: 16,
                  color: AppColors.secondaryColor,
                ),
              ),
            ],
          ),
        ));
  }

  Widget pointTexts({required String heading, required String value}) {
    return Padding(
      padding: EdgeInsets.only(
          bottom: 16.0,
          right: ResponsiveWidget.isSmallScreen(context)
              ? 0.0
              : height(context) * 0.2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              heading,
              style: interSemiBold.copyWith(
                fontSize: 18,
                color: AppColors.secondaryColor,
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(
              value,
              style: interMedium.copyWith(
                fontSize: 16,
                color: AppColors.secondaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
