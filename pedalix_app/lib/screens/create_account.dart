import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pedalix_app/core/app_export.dart';
import 'package:pedalix_app/widgets/custom_outlined_button.dart';

class CreateAccount extends StatefulWidget {
  late final String phoneNumber;

  CreateAccount({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final firestoreInstance = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    String phoneNumber = widget.phoneNumber;
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
                    'Create Account',
                    style: theme.textTheme.titleMedium,
                  ),
                  SizedBox(height: 1.v),
                  Text(
                    "Save time by linking your social account. We will never share any personal data",
                    style: theme.textTheme.titleSmall,
                  ),
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
                  SizedBox(height: 34.v),
                  _buildOR(context),
                  SizedBox(height: 36.v),
                  CustomOutlinedButton(
                    text: "Continue with Email",
                    onPressed: _handleGoogleSignIn,
                    buttonStyle: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        theme.colorScheme.secondary,
                      ),
                    ),
                  ),
                ],
              ))),
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
      String phoneNumber = widget.phoneNumber;

      if (user != null) {
        // Save the user data in Firestore
        await firestoreInstance.collection('users').doc(user.uid).set({
          'phoneNumber': phoneNumber,
          'displayName': user.displayName,
          'email': user.email,
          'photoURL': user.photoURL,
          'timestamp': FieldValue.serverTimestamp(),
        });
      }
    } catch (error) {
      print(error);
    }
  }
}
