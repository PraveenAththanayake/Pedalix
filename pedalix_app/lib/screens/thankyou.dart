import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThankYou extends StatefulWidget {
  const ThankYou({Key? key}) : super(key: key);

  @override
  State<ThankYou> createState() => _MyAppState();
}

class _MyAppState extends State<ThankYou> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Color primaryColor = const Color(0xFF127368);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color(0xFF127368),
        body: SafeArea(
          child: Stack(
            children: [
              Positioned(
                top: 80,
                left: 0,
                right: 0,
                child: Text(
                  'Thank you! ',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                    textStyle: const TextStyle(
                      fontSize: 40,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  width: double.infinity,
                  height: 450,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      Image.asset(
                        'assets/confirm.png',
                        height: 150,
                        width: 150,
                      ),
                      Text(
                        'Your payment was successful!',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.montserrat(
                          textStyle: const TextStyle(
                            fontSize: 17,
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        ' your ride is ready to roll. \nEnjoy the journey!'
                        ' Thank you for choosing us.',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.montserrat(
                          textStyle: const TextStyle(
                            fontSize: 13,
                            color: Colors.grey,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      minimumSize:
                          MaterialStateProperty.all(const Size(390, 50)),
                      padding:
                          MaterialStateProperty.all(const EdgeInsets.all(15)),
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
                    child: Text(
                      'Ready to go!',
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
