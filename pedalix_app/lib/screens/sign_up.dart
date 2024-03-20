import 'package:pedalix_app/widgets/custom_phone_number.dart';
import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:pedalix_app/widgets/custom_outlined_button.dart';
import 'package:flutter/material.dart';
import 'package:pedalix_app/core/app_export.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key})
      : super(
          key: key,
        );

  Country selectedCountry = CountryPickerUtils.getCountryByPhoneCode('94');

  TextEditingController phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(horizontal: 20.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 1.v),
              Text(
                "Enter your number",
                style: theme.textTheme.titleMedium,
              ),
              SizedBox(height: 19.v),
              CustomPhoneNumber(
                country: selectedCountry,
                controller: phoneNumberController,
                onTap: (Country value) {
                  selectedCountry = value;
                },
              ),
              SizedBox(height: 34.v),
              _buildOR(context),
              SizedBox(height: 36.v),
              CustomOutlinedButton(
                text: "Sign  in with Google",
                leftIcon: Container(
                  margin: EdgeInsets.only(right: 30.h),
                  child: CustomImageView(
                    imagePath: ImageConstant.imgGooglecoloricon1,
                    height: 30.v,
                    width: 32.h,
                  ),
                ),
              ),
              SizedBox(height: 14.v),
              CustomOutlinedButton(
                text: "Sign  in with Facebook",
                leftIcon: Container(
                  margin: EdgeInsets.only(right: 30.h),
                  child: CustomImageView(
                    imagePath: ImageConstant.imgFacebookroundcoloricon1,
                    height: 30.v,
                    width: 32.h,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildOR(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: 10.v,
            bottom: 9.v,
          ),
          child: SizedBox(
            width: 170.h,
            child: Divider(),
          ),
        ),
        Text(
          "OR",
          style: theme.textTheme.titleSmall,
        ),
        Padding(
          padding: EdgeInsets.only(
            top: 10.v,
            bottom: 9.v,
          ),
          child: SizedBox(
            width: 171.h,
            child: Divider(),
          ),
        ),
      ],
    );
  }
}
