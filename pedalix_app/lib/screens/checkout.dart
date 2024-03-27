import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Checkout extends StatefulWidget {
  final String scanResult;
  const Checkout({Key? key, required this.scanResult}) : super(key: key);

  @override
  State<Checkout> createState() => _MyAppState(scanResult: scanResult);
}

class _MyAppState extends State<Checkout> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final String scanResult;

  _MyAppState({required this.scanResult});

  final Color primaryColor = const Color(0xFF127368); // Define primary color

  bool _saveCard = false; // Track whether the card should be saved or not

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
                              // Handle onPressed function here
                            },
                            style: ButtonStyle(
                              padding: MaterialStateProperty.all<EdgeInsets>(
                                const EdgeInsets.only(
                                  left: 0,
                                  right: 0,
                                ), // Adjust the left padding here
                              ),
                            ),
                            child: Image.asset(
                              'assets/back_button.png',
                              height: 80,
                              width: 80,
                            ),
                          ),
                          const SizedBox(
                              width: 10), // Spacer between image and text
                          Text('Checkout',
                              style: GoogleFonts.roboto(
                                textStyle: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              )),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Center(
                        child: Text(scanResult,
                            style: GoogleFonts.montserrat(
                              textStyle: const TextStyle(
                                fontSize: 40,
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                              ),
                            )),
                      ),
                      const SizedBox(
                        height: 45,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                                height: 10), // Added SizedBox for spacing
                            Container(
                              width: double.infinity,
                              height: 200,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey
                                        .withOpacity(0.4), // Shadow color
                                    spreadRadius: 5, // Spread radius
                                    blurRadius: 7, // Blur radius
                                    offset:
                                        const Offset(1, 5), // Offset position
                                  ),
                                ],
                              ),
                              child: Form(
                                key: _formKey,
                                child: Container(
                                  margin: const EdgeInsets.all(20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      TextFormField(
                                        decoration: const InputDecoration(
                                          labelText: 'Card number',
                                          hintText: '8154 3265 0045 1582',
                                          labelStyle: TextStyle(fontSize: 13),
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 0, horizontal: 0),
                                        ),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Please enter valid card number';
                                          }
                                          return null;
                                        },
                                      ),
                                      const SizedBox(height: 30),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: TextFormField(
                                              decoration: const InputDecoration(
                                                labelText:
                                                    'Expire date (MM/YY)',
                                                hintText: 'MM/YY',
                                                labelStyle:
                                                    TextStyle(fontSize: 13),
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        vertical: 0,
                                                        horizontal: 0),
                                              ),
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return 'Please enter valid expiration date';
                                                }
                                                return null;
                                              },
                                            ),
                                          ),
                                          const SizedBox(width: 20),
                                          Expanded(
                                            child: TextFormField(
                                              decoration: const InputDecoration(
                                                labelText: 'CVV',
                                                hintText: 'CVV',
                                                labelStyle:
                                                    TextStyle(fontSize: 13),
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        vertical: 0,
                                                        horizontal: 0),
                                              ),
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return 'Please enter valid CVV';
                                                }
                                                return null;
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 40),
                            Row(
                              children: [
                                Checkbox(
                                  value: _saveCard,
                                  onChanged: (value) {
                                    setState(() {
                                      _saveCard = value!;
                                    });
                                  },
                                ),
                                const Text(
                                  'Save this card',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Center(
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 0),
                                child: const Text(
                                  'Your card information will be saved for \nfuture payments',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: Container(
          width: double.infinity,
          margin: const EdgeInsets.all(20),
          child: ElevatedButton(
            style: ButtonStyle(
              minimumSize: MaterialStateProperty.all(const Size(390, 50)),
              padding: MaterialStateProperty.all(const EdgeInsets.all(15)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              backgroundColor: MaterialStateProperty.all(primaryColor),
              foregroundColor: MaterialStateProperty.all(Colors.white),
            ),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                print('Form is valid');
              } else {
                print('Form is invalid');
              }
            },
            child: Text('Confirm Payment',
                style: GoogleFonts.roboto(
                  textStyle: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                )),
          ),
        ),
      ),
    );
  }
}
