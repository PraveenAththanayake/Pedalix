import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pedalix_app/screens/onboarding.dart';
import 'package:pedalix_app/screens/sign_up.dart';

class TermsAndCondition extends StatelessWidget {
  final Color primaryColor = const Color(0xFF127368);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          // Your theme data
          ),
      home: AgreementScreen(primaryColor: primaryColor),
    );
  }
}

class AgreementScreen extends StatelessWidget {
  final Color primaryColor;

  AgreementScreen({Key? key, required this.primaryColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ScrollController _scrollController = ScrollController();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pedalix ',
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              color: Colors.black,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Terms and Conditions',
              style: GoogleFonts.roboto(
                textStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            child: Scrollbar(
              controller: _scrollController,
              thickness: 8.0,
              radius: const Radius.circular(10.0),

              // Adjust the thickness of the scrollbar
              child: ListView(
                controller: _scrollController,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: RichText(
                      text: TextSpan(
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        children: const [
                          TextSpan(
                            text: '1. Introduction : ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text:
                                'These Terms and Conditions ("Terms") govern your use of the Smart Bike Rental App ("App") and the rental of e-bikes through the App. By creating an account and using the App, you agree to be bound by these Terms.',
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: RichText(
                      text: TextSpan(
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        children: const [
                          TextSpan(
                            text: '2. Rental Period and Return : ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                              text:
                                  'The maximum rental period for an e-bike is 24 hours from the time of unlocking.You are responsible for returning the e-bike to a designated location within the 24-hour period.Late returns will incur a penalty fee of [amount] per hour (or a prorated amount based on your specific delay).'
                              // Add the rest of your paragraph 2 here
                              ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: RichText(
                      text: TextSpan(
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        children: const [
                          TextSpan(
                            text: '3. User Responsibility and Damage : ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                              text:
                                  'You are solely responsible for the e-bike from the moment you unlock it until you return it.You are responsible for any damage caused to the e-bike during the rental period, including vandalism and theft.In case of damage, you will be charged a repair or replacement fee based on the extent of the damage. You are also responsible for any fines or penalties incurred due to traffic violations or improper use of the e-bike during the rental period.'
                              // Add the rest of your paragraph 2 here
                              ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: RichText(
                      text: TextSpan(
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        children: const [
                          TextSpan(
                            text: '4. Payment : ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                              text:
                                  'You agree to pay all rental fees, penalties, and damage charges associated with your e-bike rental.You authorize us to charge your payment method for any outstanding fees upon return of the e-bike.'
                              // Add the rest of your paragraph 2 here
                              ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: RichText(
                      text: TextSpan(
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        children: const [
                          TextSpan(
                            text: '5. User Conduct : ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                              text:
                                  'You agree to use the e-bike in a safe and responsible manner, complying with all traffic laws and regulations.You are prohibited from using the e-bike under the influence of alcohol or drugs.You are limited to carrying one passenger on the e-bike (unless the specific e-bike model allows for more).You agree to treat the e-bike with care and avoid any misuse that could cause damage.'
                              // Add the rest of your paragraph 2 here
                              ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: RichText(
                      text: TextSpan(
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        children: const [
                          TextSpan(
                            text: '6. Termination : ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                              text:
                                  'We reserve the right to terminate your account and deny you access to the App for any violation of these Terms.'
                              // Add the rest of your paragraph 2 here
                              ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: RichText(
                      text: TextSpan(
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        children: const [
                          TextSpan(
                            text: '7. Disclaimer of Warranties : ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                              text:
                                  'The e-bikes are provided "as is" and without warranties of any kind, express or implied. We disclaim any warranty of merchantability or fitness for a particular purpose.'
                              // Add the rest of your paragraph 2 here
                              ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: RichText(
                      text: TextSpan(
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        children: const [
                          TextSpan(
                            text: '8. Limitation of Liability : ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                              text:
                                  'We shall not be liable for any damages arising out of your use of the App or the e-bike, including but not limited to personal injury, property damage, or incidental and consequential damages.'
                              // Add the rest of your paragraph 2 here
                              ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: RichText(
                      text: TextSpan(
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        children: const [
                          TextSpan(
                            text: '9. Governing Law : ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                              text:
                                  'These Terms shall be governed by and construed in accordance with the laws of Sri Lanka.'
                              // Add the rest of your paragraph 2 here
                              ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: RichText(
                      text: TextSpan(
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        children: const [
                          TextSpan(
                            text: '10. Dispute Resolution : ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                              text:
                                  'Any disputes arising out of or relating to these Terms shall be resolved through binding arbitration in accordance with the Sri Lanka Arbitration Act No. 11 of 1996.'
                              // Add the rest of your paragraph 2 here
                              ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: RichText(
                      text: TextSpan(
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        children: const [
                          TextSpan(
                            text: '11. Entire Agreement : ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                              text:
                                  'These Terms constitute the entire agreement between you and us regarding the use of the App and the rental of e-bikes.'
                              // Add the rest of your paragraph 2 here
                              ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: RichText(
                      text: TextSpan(
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        children: const [
                          TextSpan(
                            text: '12. Updates to Terms : ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                              text:
                                  'We may update these Terms from time to time. We will notify you of any changes by posting the new Terms on the App.'
                              // Add the rest of your paragraph 2 here
                              ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: RichText(
                      text: TextSpan(
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        children: const [
                          TextSpan(
                            text: 'Bicycle Safety Inspection : ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                              text:
                                  'Before each use of a Bicycle, You must conduct a safety inspection of the Bicycle, which you acknowledge you are competent to do, and which includes inspecting for all of the following: (i) proper tire pressure; (ii) trueness of the wheels; (iii) safe operation of all brakes and lights; (iv) proper attachment of the seat, pedals, and basket; (v) alignment of the fender and the metal rods that hold the fender in place; (vi) good condition of the frame; and (vii) no sign of damage, unusual or excessive wear, or other mechanical problem or maintenance need. If the Bicycle You are using is an electric pedal-assist bicycle, You should also confirm that the battery is locked securely in place in the frame of the Bicycle. You may not ride the Bicycle if You notice any mechanical or other problem or safety issue; and, in such case, You must promptly notify NYCBS or JCBS, as applicable, of all problems and issues and use a different Bicycle. You agree to press the “Faulty Bike” button within 1 minute after docking or locking any Bicycle that You notice has any mechanical or other problem or safety issue. For a Bicycle that is equipped with an on-board lock, you agree to press the “Faulty Bike” button in the Mobile Application within 1 minute after locking any Bicycle that You notice has any mechanical or other problem or safety issue. You must not attempt to repair any Bicycle.'
                              // Add the rest of your paragraph 2 here
                              ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: RichText(
                      text: TextSpan(
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        children: const [
                          TextSpan(
                            text: 'Returning Bicycle : ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                              text:
                                  'To return a Bicycle that is not equipped with an on-board lock, You must secure it into an available Bike Dock. When the Bicycle is correctly docked, a sound signal will be emitted, and the signal light will turn yellow and then green, to confirm that the Bicycle has been properly secured to the Bike Dock. If the Bicycle is not properly secured to the Bike Dock, then the signal light will turn red, and a longer signal sound will be emitted. If the signal light turns red, then You must repeat the operation until the signal light turns green and the Bicycle is properly secured in the Bike Dock. If after several attempts the signal light does not turn green, then You must return the Bicycle to another available Bike Dock. '
                              // Add the rest of your paragraph 2 here
                              ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor, // background color
                    ),
                    child: const Text(
                      'Accept',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => onboarding()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shadowColor: Colors.black // background color
                        ),
                    child: Text(
                      'Decline',
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
