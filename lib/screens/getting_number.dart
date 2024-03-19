import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pedalix_app/screens/onboarding.dart';

class GettingNumber extends StatefulWidget {
  const GettingNumber({Key? key}) : super(key: key);

  @override
  State<GettingNumber> createState() => _MyAppState();
}

class _MyAppState extends State<GettingNumber> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Define primary color
  final Color primaryColor = Color(0xFF127368);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  // Use Row to place image and text side by side
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context, onboarding());
                        // Handle onPressed function here
                      },
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            EdgeInsets.only(
                                left: 0,
                                right: 0) // Adjust the left padding here
                            ),
                      ),
                      child: Image.asset(
                        'assets/back_button.png',
                        height: 80,
                        width: 80,
                      ),
                    ),
                    SizedBox(width: 10), // Spacer between image and text
                    Text('Enter your number',
                        style: GoogleFonts.roboto(
                          textStyle: const TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        )),
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
                          maxLength: 10,
                          decoration: InputDecoration(
                            labelText: 'Enter number',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.grey), // Change border color
                            ),
                            prefixText: '+94',
                            labelStyle: TextStyle(fontSize: 14),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
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
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter number';
                            }
                            return null;
                          },
                        ),
                        Text('We will send you an OTP to verify',
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                fontSize: 10,
                                color: Colors.grey,
                                fontWeight: FontWeight.w400,
                              ),
                            )),
                        Text('your phone number',
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                fontSize: 10,
                                color: Colors.grey,
                                fontWeight: FontWeight.w400,
                              ),
                            )),
                        SizedBox(height: 490),
                        ElevatedButton(
                          style: ButtonStyle(
                            minimumSize:
                                MaterialStateProperty.all(Size(390, 50)),
                            padding:
                                MaterialStateProperty.all(EdgeInsets.all(15)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                            backgroundColor:
                                MaterialStateProperty.all(primaryColor),
                            // Change the text color here
                            foregroundColor:
                                MaterialStateProperty.all(Colors.white),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              print('Form is valid');
                            } else {
                              print('Form is invalid');
                            }
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
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
