import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pedalix_app/screens/getting_number.dart';

class NumberVerification extends StatefulWidget {
  const NumberVerification({Key? key}) : super(key: key);

  @override
  State<NumberVerification> createState() => _MyAppState();
}

class _MyAppState extends State<NumberVerification> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Define primary color
  final Color primaryColor = Color(0xFF127368);
  @override
  Widget build(BuildContext context) {
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
                                maxLength: 4,
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
                                  onPressed: () {
                                    // Dummy onPressed function
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
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    print('Form is valid');
                  } else {
                    print('Form is invalid');
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
