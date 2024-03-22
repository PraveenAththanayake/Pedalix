import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pedalix_app/core/app_export.dart';
import 'package:pedalix_app/screens/number_verification.dart';

class GettingNumber extends StatefulWidget {
  const GettingNumber({Key? key}) : super(key: key);

  static String verify = "";

  @override
  State<GettingNumber> createState() => _MyAppState();
}

class _MyAppState extends State<GettingNumber> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  var phone = "";

  // Define primary color
  final Color primaryColor = Color(0xFF127368);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                // Use Row to place image and text side by side
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsets>(
                        EdgeInsets.only(left: 0, right: 0),
                      ),
                    ),
                    child: Image.asset(
                      'assets/back_button.png',
                      height: 80,
                      width: 80,
                    ),
                  ),
                  SizedBox(width: 10), // Spacer between image and text
                  Text(
                    'Enter your number',
                    style: GoogleFonts.roboto(
                      textStyle: const TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Container(
                      margin: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            keyboardType: TextInputType.phone,
                            onChanged: (value) {
                              phone = value;
                            },
                            maxLength: 10,
                            decoration: InputDecoration(
                              labelText: 'Enter number',
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                ),
                              ),
                              prefixText: '+94',
                              labelStyle: TextStyle(fontSize: 14),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: primaryColor,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: primaryColor,
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter number';
                              }
                              return null;
                            },
                          ),
                          Text(
                            'We will send you an OTP to verify your phone number',
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                fontSize: 10,
                                color: Colors.grey,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          SizedBox(height: 20), // Adjusted height
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                        EdgeInsets.all(15),
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all(primaryColor),
                      // Change the text color here
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                    ),
                    onPressed: () async {
                      await FirebaseAuth.instance.verifyPhoneNumber(
                        phoneNumber: '{+94$phone}',
                        verificationCompleted:
                            (PhoneAuthCredential credential) async {
                          // This callback will be called when the verification is done automatically
                          await FirebaseAuth.instance
                              .signInWithCredential(credential);
                        },
                        verificationFailed: (FirebaseAuthException e) {
                          // This callback will be called when the verification has failed
                          print(e);
                        },
                        codeSent: (String verificationId, int? resendToken) {
                          GettingNumber.verify = verificationId;
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => NumberVerification(),
                            ),
                          );
                          // This callback will be called when the code is sent
                          // You can use this verificationId to create PhoneAuthCredential and signInWithCredential
                        },
                        codeAutoRetrievalTimeout: (String verificationId) {
                          // This callback will be called when the auto-retrieval timeout is exceeded
                        },
                      );
                    },
                    child: Text(
                      'Continue',
                      style: GoogleFonts.roboto(
                        textStyle: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
