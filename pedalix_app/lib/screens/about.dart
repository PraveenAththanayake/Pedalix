import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pedalix_app/components/navbar.dart';
import 'package:pedalix_app/main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pedalix_app/utils/transitions.dart';

class about extends StatelessWidget {
  const about({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Image.asset('assets/back_button.png'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Text(
            'About',
            style: GoogleFonts.montserrat(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
          actions: [],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20), // Add SizedBox with desired height
              Image.asset('assets/Mask_group.png'),
              const SizedBox(height: 60),
              const Column(
                children: [
                  ExpansionTile(
                    title: Text(
                      'About Pedalix',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: ListTile(
                          subtitle: Text(
                            'All day, every day, all around Sri Lanka, you can use our bikes using the Pedalix app. This app is tailor-made for Mobile devices, so using it will be a breeze. To find out where our bikes are, download the app. See the steps below to see how simple it is.',
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  ExpansionTile(
                    title: Text('Terms and Conditions',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14)),
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              title: Text('Bicycle Safety Inspection'),
                              subtitle: Text(
                                'Before each use of a Bicycle, You must conduct a safety inspection of the Bicycle, which you acknowledge you are competent to do, and which includes inspecting for all of the following: (i) proper tire pressure; (ii) trueness of the wheels; (iii) safe operation of all brakes and lights; (iv) proper attachment of the seat, pedals, and basket; (v) alignment of the fender and the metal rods that hold the fender in place; (vi) good condition of the frame; and (vii) no sign of damage, unusual or excessive wear, or other mechanical problem or maintenance need. If the Bicycle You are using is an electric pedal-assist bicycle, You should also confirm that the battery is locked securely in place in the frame of the Bicycle. You may not ride the Bicycle if You notice any mechanical or other problem or safety issue; and, in such case, You must promptly notify NYCBS or JCBS, as applicable, of all problems and issues and use a different Bicycle. You agree to press the “Faulty Bike” button within 1 minute after docking or locking any Bicycle that You notice has any mechanical or other problem or safety issue. For a Bicycle that is equipped with an on-board lock, you agree to press the “Faulty Bike” button in the Mobile Application within 1 minute after locking any Bicycle that You notice has any mechanical or other problem or safety issue. You must not attempt to repair any Bicycle.',
                                textAlign: TextAlign.justify,
                              ),
                            ),
                            ListTile(
                              title: Text('Returning Bicycle'),
                              subtitle: Text(
                                'To return a Bicycle that is not equipped with an on-board lock, You must secure it into an available Bike Dock. When the Bicycle is correctly docked, a sound signal will be emitted, and the signal light will turn yellow and then green, to confirm that the Bicycle has been properly secured to the Bike Dock. If the Bicycle is not properly secured to the Bike Dock, then the signal light will turn red, and a longer signal sound will be emitted. If the signal light turns red, then You must repeat the operation until the signal light turns green and the Bicycle is properly secured in the Bike Dock. If after several attempts the signal light does not turn green, then You must return the Bicycle to another available Bike Dock. ',
                                textAlign: TextAlign.justify,
                              ),
                            ),
                            ListTile(
                              title: Text('Helmets; Safety'),
                              subtitle: Text(
                                'Bike Share strongly recommends that all users of the Services wear a Snell, CPSC, ANSI, or ASTM approved helmet that has been properly sized, fitted, and fastened, according to the manufacturer’s instructions. Wearing a Snell, CPSC, ANSI, or ASTM approved helmet, properly sized, fitted, and fastened, while cycling may protect against an injury or may lessen the severity of an injury caused by an impact to the head; however, bicycle helmets are not 100% effective, do not protect against all head injuries, and do not protect against other injuries.',
                                textAlign: TextAlign.justify,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  ExpansionTile(
                    title: Text(
                      'Privacy Policy',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              title: Text('1. Information We Collect'),
                              subtitle: Text(
                                'We collect the following types of information from users of the App:\n\n'
                                '- Account Information: When you create an account with the App, we may collect your name, location (city, region), and contact information (email address, phone number).\n'
                                '- GPS Tracking Data: We may collect anonymized GPS data about your bike rental trips, including origin, destination, and duration.\n'
                                '- User Feedback: We may collect your feedback and responses to surveys within the App related to your experience with the e-bikes, routes, and overall satisfaction.',
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                            ListTile(
                              title: Text('2. How We Use Your Information'),
                              subtitle: Text(
                                'We use the information we collect for the following purposes:\n\n'
                                '- To provide and operate the App and its functionalities.\n'
                                '- To improve the App\'s functionality and user experience.\n'
                                '- To analyze user behavior patterns to optimize bike placement and availability.\n'
                                '- To send you targeted promotions or updates about the App (with your consent).\n'
                                '- To respond to your inquiries and requests.',
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                            ListTile(
                              title: Text('3. Data Sharing'),
                              subtitle: Text(
                                'We may share your information with third-party service providers who help us operate the App, such as data storage providers and analytics companies. We will only share your information with these providers for specific purposes and under strict contractual obligations to protect your privacy.\n\n'
                                'We will not share your personal information with any other third parties without your consent, except as required by law or to protect the rights, property, or safety of ourselves or others.',
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                            ListTile(
                              title: Text('4. User Access and Control'),
                              subtitle: Text(
                                'You have the right to access and update your account information at any time. You can also request to delete your account and data by contacting us through the App or at [email protected]',
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                            ListTile(
                              title: Text('5. Security Measures'),
                              subtitle: Text(
                                'We take reasonable security measures to protect your information from unauthorized access, disclosure, alteration, or destruction. However, no internet transmission or electronic storage method is completely secure. Therefore, we cannot guarantee absolute security.',
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                            ListTile(
                              title: Text('6. Compliance with Sri Lankan Law'),
                              subtitle: Text(
                                'This Privacy Policy is designed to comply with the Data Protection Act, No. 13 of 2013, of Sri Lanka. We have appointed a Data Protection Officer within our organization who is responsible for overseeing compliance with this Policy and Sri Lankan data protection laws.',
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                            ListTile(
                              title: Text('7. Changes to this Privacy Policy'),
                              subtitle: Text(
                                'We may update this Privacy Policy from time to time. We will notify you of any changes by posting the new Privacy Policy on the App.',
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                            ListTile(
                              title: Text('8. Contact Us'),
                              subtitle: Text(
                                'If you have any questions about this Privacy Policy, please contact us through the App or at [pedalix@gmail.com]',
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                            ListTile(
                              title: Text(
                                'This Privacy Policy is available in English, Sinhala, and Tamil. In the event of any inconsistencies between the versions, the Sinhala version shall prevail.',
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
