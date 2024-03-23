import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pedalix_app/screens/create_account.dart';
import 'package:pedalix_app/screens/getting_number.dart';
import 'package:pedalix_app/screens/sign_up.dart';
import 'package:pedalix_app/screens/user_info_edit.dart';

class NumberVerification extends StatefulWidget {
  const NumberVerification({Key? key}) : super(key: key);

  @override
  State<NumberVerification> createState() => _MyAppState();
}

class _MyAppState extends State<NumberVerification> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final FirebaseAuth auth = FirebaseAuth.instance;

  // Define primary color
  final Color primaryColor = Color(0xFF127368);
  @override
  Widget build(BuildContext context) {
    var code = "";
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        // Use Row to place image and text side by side
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context, GettingNumber());
                              // Handle onPressed function here
                            },
                            style: ButtonStyle(
                              padding: MaterialStateProperty.all<EdgeInsets>(
                                EdgeInsets.only(
                                    left: 0), // Adjust the left padding here
                              ),
                            ),
                            child: Image.asset(
                              'assets/back_button.png',
                              height: 80,
                              width: 80,
                            ),
                          ),
                          SizedBox(width: 10), // Spacer between image and text
                          Text('Enter code',
                              style: GoogleFonts.roboto(
                                textStyle: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              )),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                              left: 20,
                              top: 10,
                              bottom: 4,
                            ),
                            child: Text(
                              'A code was sent to',
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                  fontSize: 10,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                              left: 20,
                              bottom: 4,
                            ),
                            child: Text(
                              '+94 _________',
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                  fontSize: 10,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                              left: 20,
                              bottom: 10,
                            ),
                            child: Text(
                              'Edit phone number',
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                  fontSize: 10,
                                  color: Color(0xFF127368),
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Form(
                        key: _formKey,
                        child: Container(
                          margin: EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextFormField(
                                onChanged: (value) {
                                  code = value;
                                },
                                maxLength: 6,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                        color:
                                            Colors.grey), // Change border color
                                  ),
                                  labelStyle: TextStyle(fontSize: 14),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            primaryColor), // Change border color when focused
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                        color:
                                            primaryColor), // Change border color when enabled
                                  ),
                                ),
                              ),
                              Center(
                                child: TextButton(
                                  onPressed: () async {
                                    try {
                                      PhoneAuthCredential credential =
                                          PhoneAuthProvider.credential(
                                              verificationId:
                                                  GettingNumber.verify,
                                              smsCode: code);
                                      UserCredential userCredential = await auth
                                          .signInWithCredential(credential);
                                      User? user = userCredential.user;
                                    } catch (error) {
                                      print("object");
                                    }
                                  },
                                  child: Text(
                                    'Resend code in 00:30',
                                    style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                        fontSize: 12,
                                        color: Colors
                                            .grey, // Change the text color here
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(20),
              child: ElevatedButton(
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(Size(390, 50)),
                  padding: MaterialStateProperty.all(EdgeInsets.all(15)),
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
                  try {
                    PhoneAuthCredential credential =
                        PhoneAuthProvider.credential(
                            verificationId: GettingNumber.verify,
                            smsCode: code);
                    UserCredential userCredential =
                        await auth.signInWithCredential(credential);
                    User? user = userCredential.user;

                    if (user != null) {
                      // Check if the user's email is null or empty
                      if (user.email == null || user.email!.isEmpty) {
                        // If it is, navigate to the create account page
                        String? phoneNumber = user.phoneNumber;
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) =>
                                CreateAccount(phoneNumber: phoneNumber ?? ""),
                          ),
                        );
                      } else {
                        // If the user's email is not null or empty, navigate to the sign up screen
                        await FirebaseFirestore.instance
                            .collection('users')
                            .doc(user.uid)
                            .set({
                          'phoneNumber': user.phoneNumber,
                          'displayName': user.displayName,
                          'email': user.email,
                          'photoURL': user.photoURL,
                          'timestamp': FieldValue.serverTimestamp(),
                        });
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => UserInfoEdit(
                              user: user,
                            ),
                          ),
                        );
                      }

                      // Update the phone number in Firebase Authentication
                      await user.updatePhoneNumber(credential);
                    }
                  } catch (error) {
                    print('Error occurred: $error');
                  }
                },
                child: Text('Verify number',
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
