import 'package:pedalix_app/screens/getting_number.dart';
import 'package:pedalix_app/screens/map_page.dart';
import 'package:pedalix_app/widgets/custom_phone_number.dart';
import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:pedalix_app/widgets/custom_outlined_button.dart';
import 'package:flutter/material.dart';
import 'package:pedalix_app/core/app_export.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({
    Key? key,
  }) : super(
          key: key,
        );

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  Country selectedCountry = CountryPickerUtils.getCountryByPhoneCode('94');

  TextEditingController phoneNumberController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final firestoreInstance = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  User? _user;

  @override
  void initState() {
    super.initState();
    _auth.authStateChanges().listen((event) {
      setState(() {
        _user = event;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _user != null ? map() : _signInScreen(),
    );
  }

  Widget map() {
    return MapPage();
  }

  Widget _signInScreen() {
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
                text: "Sign in with Google",
                onPressed: _handleGoogleSignIn,
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
                text: "Sign in with Facebook",
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

  void _handleGoogleSignIn() async {
    try {
      GoogleAuthProvider _googleAuthProvider = GoogleAuthProvider();
      UserCredential userCredential =
          await _auth.signInWithProvider(_googleAuthProvider);
      User? user = userCredential.user;

      if (user != null) {
        // Save the user data in Firestore
        await firestoreInstance.collection('users').doc(user.uid).set({
          'firstName': "",
          'lastName': "",
          'nicNO': "",
          'email': user.email,
          'photoURL': user.photoURL,
          'phoneNumber': "",
          'timestamp': FieldValue.serverTimestamp(),
        });

        if (user.phoneNumber == null || user.phoneNumber!.isEmpty) {
          // Navigate to number page
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => GettingNumber()),
          );
        }
      }
    } catch (error) {
      print(error);
    }
  }
}
