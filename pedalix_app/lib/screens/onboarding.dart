import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pedalix_app/screens/getting_number.dart';
import 'package:pedalix_app/screens/sign_up.dart';

class onboarding extends StatelessWidget {
  const onboarding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const myBackgroundColor = Color(0xFF127369); // Define custom color
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              Column(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: myBackgroundColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(100),
                      ),
                    ),
                    height: 640,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 50, left: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            'assets/1.png',
                            width: 45,
                          ),
                          const SizedBox(height: 5),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Revolutionize",
                              style: GoogleFonts.roboto(
                                textStyle: const TextStyle(
                                  fontSize: 30,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Your Ride:",
                              style: GoogleFonts.roboto(
                                textStyle: const TextStyle(
                                  fontSize: 30,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Easy, Eco-Friendly,",
                              style: GoogleFonts.roboto(
                                textStyle: const TextStyle(
                                  fontSize: 30,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Effortless !",
                              style: GoogleFonts.roboto(
                                textStyle: const TextStyle(
                                  fontSize: 30,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Image.asset(
                            'assets/Slider_Position.png',
                          ),
                          const SizedBox(height: 10),
                          Image.asset('assets/Logo.png', height: 80, width: 80),
                          const SizedBox(height: 105),
                          Center(
                            child: Image.asset(
                              'assets/Onboarding_Image.png',
                              height: 170,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: -2,
                right: 0,
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => SignUpScreen()));
                    // Handle onPressed function here
                  },
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsets>(
                      EdgeInsets.only(left: 0), // Adjust the left padding here
                    ),
                  ),
                  child: Image.asset(
                    'assets/next_button.png',
                    height: 80,
                    width: 80,
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
