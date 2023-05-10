import 'package:car_predictor_front_end/widgets/custom_button.dart';
import 'package:car_predictor_front_end/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:car_predictor_front_end/constants/exports.dart';
import 'package:car_predictor_front_end/widgets/responsive_widget.dart';

import 'detail_screen.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({Key? key}) : super(key: key);

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final makeController = TextEditingController();
  final modelController = TextEditingController();
  final yearController = TextEditingController();
  final mileageController = TextEditingController();

  String dropdownValue = 'Florida';
  List<String> state_list = [
    'Alaska',
    'Alabama',
    'Arkansas',
    'Arizona',
    'California',
    'Colorado',
    'Connecticut',
    'District of Columbia',
    'Delaware',
    'Florida',
    'Georgia',
    'Hawaii',
    'Iowa',
    'Idaho',
    'Illinois',
    'Indiana',
    'Kansas',
    'Kentucky',
    'Louisiana',
    'Massachusetts',
    'Maryland',
    'Maine',
    'Michigan',
    'Minnesota',
    'Missouri',
    'Mississippi',
    'Montana',
    'North Carolina',
    'North Dakota',
    'Nebraska',
    'New Hampshire',
    'New Jersey',
    'New Mexico',
    'Nevada',
    'New York',
    'Ohio',
    'Oklahoma',
    'Oregon',
    'Pennsylvania',
    'Rhode Island',
    'South Carolina',
    'South Dakota',
    'Tennessee',
    'Texas',
    'Utah',
    'Virginia',
    'Vermont',
    'Washington',
    'Wisconsin',
    'West Virginia',
    'Wyoming'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// body
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(
          horizontal: ResponsiveWidget.isSmallScreen(context)
              ? 20
              : ResponsiveWidget.isMediumScreen(context)
                  ? height(context) * 0.16
                  : height(context) * 0.5,
          vertical: height(context) * 0.1,
        ),
        children: [
          CustomTextField(
            titleText: 'Make',
            hintText: 'Make',
            controller: makeController,
          ),
          CustomTextField(
            titleText: 'Model',
            hintText: 'Model',
            controller: modelController,
          ),
          Text(
            'State',
            style: interMedium.copyWith(
              fontSize: 16,
              color: AppColors.secondaryColor,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            height: height(context) * 0.065,
            width: width(context),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              border: Border.all(
                color: AppColors.secondaryColor,
                width: 1.0,
              ),
            ),
            child: DropdownButton<String>(
              value: dropdownValue,
              isExpanded: true,
              hint: Text(
                'Select Option',
                style: interRegular.copyWith(
                  color: AppColors.blackColor.withOpacity(0.5),
                  fontSize: 14.0,
                ),
              ),
              focusColor: Colors.transparent,
              underline: const SizedBox(),
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValue = newValue!;
                });
              },
              items: state_list.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: interMedium.copyWith(
                      fontSize: 16,
                      color: AppColors.secondaryColor,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 16),
          CustomTextField(
            titleText: 'Year',
            hintText: 'Year',
            controller: yearController,
            keyboardType: TextInputType.number,
          ),
          CustomTextField(
            titleText: 'Mileage',
            hintText: 'Mileage',
            controller: mileageController,
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: height(context) * 0.15),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: CustomButton(
                  onTap: () {
                    makeController.clear();
                    modelController.clear();
                    yearController.clear();
                    mileageController.clear();
                  },
                  height: 60,
                  btnText: 'Clear',
                  btnColor: AppColors.secondaryColor,
                  btnTextColor: AppColors.whiteColor,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: CustomButton(
                  onTap: () {
                    Get.to(
                      DetailsScreen(
                        makeText: makeController.text.toString(),
                        modelText: modelController.text.toString(),
                        yearText: yearController.text.toString(),
                        stateText: dropdownValue.toString(),
                        mileageText: mileageController.text.toString(),
                      ),
                    );
                  },
                  height: 60,
                  btnText: 'Predict',
                  btnTextColor: AppColors.whiteColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
