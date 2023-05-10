import 'package:flutter/material.dart';

import '../constants/exports.dart';

class CustomButton extends StatelessWidget {
  final double? width;
  final double? height;
  final double? radius;
  final double? fontSize;
  final double? elevation;
  final String? btnText;
  final Color? btnColor;
  final Color? btnTextColor;
  final VoidCallback? onTap;
  final bool? loading;

  const CustomButton({
    Key? key,
    this.width,
    this.height = 55.0,
    this.radius,
    this.elevation = 0.0,
    this.fontSize = 22.0,
    this.btnText = 'Button Text',
    this.btnColor = AppColors.primaryColor,
    this.btnTextColor = AppColors.whiteColor,
    required this.onTap,
    this.loading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(width ?? MediaQuery.of(context).size.width, height!),
        primary: btnColor,
        elevation: elevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius ?? 8.0),
        ),
      ),
      onPressed: onTap,
      child: loading == true
          ? const CircularProgressIndicator(
              strokeWidth: 4, color: AppColors.whiteColor)
          : Center(
              child: Text(
                btnText!,
                style: interMedium.copyWith(
                  color: btnTextColor,
                  fontSize: fontSize,
                ),
              ),
            ),
    );
  }
}
