import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pedalix_app/main.dart';

class Payments extends StatefulWidget {
  const Payments({super.key});

  @override
  _PaymentsState createState() => _PaymentsState();
}

class _PaymentsState extends State<Payments> {
  bool isExpanded = false;
  bool _saveCard = false;
  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(); // Define _formKey

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 244, 244),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 430,
                  height: 320,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Row(
                            children: [
                              Image.asset(
                                'assets/back.png',
                                width: 28,
                                height: 28,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                'Payments',
                                style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 390,
                              height: 100,
                              decoration: BoxDecoration(
                                color: customColor, // Provide customColor
                                borderRadius: BorderRadius.circular(30),
                              ),
                              margin: const EdgeInsets.all(20),
                              child: const Padding(
                                padding: EdgeInsets.only(left: 20),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Pedalix Balance',
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                      Text(
                                        'LKR 00.00',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 24,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 35),
                                      child: Image(
                                        image: AssetImage(
                                            'assets/QuestionMark.png'),
                                        width: 24,
                                        height: 24,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Text(
                                        'What is pedalix balance?',
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5),
                                Row(
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: 35, top: 5),
                                      child: Image(
                                        image: AssetImage(
                                            'assets/Transaction.png'),
                                        width: 24,
                                        height: 24,
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: 10, top: 4),
                                      child: Text(
                                        'See pedalix balance transaction',
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ExpansionTile(
                        title: Text('Add New Card',
                            style: GoogleFonts.roboto(
                              textStyle: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            )),
                        onExpansionChanged: (expanded) {
                          setState(() {
                            isExpanded = expanded;
                          });
                        },
                        // Custom icon for the dropdown button
                        trailing: isExpanded
                            ? Image.asset(
                                'assets/add.png', // Provide the path to your custom icon image
                                width:
                                    24, // Adjust the width to your preference
                                height:
                                    24, // Adjust the height to your preference
                              )
                            : Image.asset(
                                'assets/add.png', // Provide the path to your custom icon image
                                width:
                                    24, // Adjust the width to your preference
                                height:
                                    24, // Adjust the height to your preference
                              ),
                        children: <Widget>[
                          // Container that expands to full size when ExpansionTile is expanded
                          if (isExpanded)
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                      height: 10), // Added SizedBox for spacing
                                  Container(
                                    width: double.infinity,
                                    height: 215,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey
                                              .withOpacity(0.4), // Shadow color
                                          spreadRadius: 5, // Spread radius
                                          blurRadius: 7, // Blur radius
                                          offset: const Offset(
                                              1, 5), // Offset position
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
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: TextFormField(
                                                    decoration: InputDecoration(
                                                      labelText: 'Card number',
                                                      hintText:
                                                          '8154 3265 0045 1582',
                                                      labelStyle:
                                                          const TextStyle(
                                                              fontSize: 13),
                                                      contentPadding:
                                                          const EdgeInsets
                                                              .symmetric(
                                                              vertical: 0,
                                                              horizontal: 10),
                                                      // Add suffix icon here
                                                      suffixIcon: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                right: 10),
                                                        child: Image.asset(
                                                          'assets/Visa.png', // Provide the path to your card icon image
                                                          width: 24,
                                                          height: 24,
                                                        ),
                                                      ),
                                                    ),
                                                    validator: (value) {
                                                      if (value!.isEmpty) {
                                                        return 'Please enter valid card number';
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 30),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: TextFormField(
                                                    decoration:
                                                        const InputDecoration(
                                                      labelText:
                                                          'Expire date (MM/YY)',
                                                      hintText: 'MM/YY',
                                                      labelStyle: TextStyle(
                                                          fontSize: 13),
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
                                                    decoration:
                                                        const InputDecoration(
                                                      labelText: 'CVV',
                                                      hintText: '123',
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
                                  const SizedBox(height: 30),
                                  ElevatedButton(
                                    style: ButtonStyle(
                                      minimumSize: MaterialStateProperty.all(
                                          const Size(390, 50)),
                                      padding: MaterialStateProperty.all(
                                          const EdgeInsets.all(15)),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                      ),
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              primaryColor),
                                      foregroundColor:
                                          MaterialStateProperty.all(
                                              Colors.white),
                                    ),
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        print('Form is valid');
                                      } else {
                                        print('Form is invalid');
                                      }
                                    },
                                    child: Text('Add Card',
                                        style: GoogleFonts.roboto(
                                          textStyle: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        )),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ],
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
