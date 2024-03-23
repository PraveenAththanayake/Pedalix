import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pedalix_app/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
  final _cvvController = TextEditingController();
  final _expireDateController = TextEditingController();
  final _cardNumberController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

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
                  width: double.infinity,
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
                              const SizedBox(width: 30),
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
                              width: double.infinity,
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
                                'assets/Minus_button.png', // Provide the path to your custom icon image
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
                                                    controller:
                                                        _cardNumberController,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    inputFormatters: [
                                                      LengthLimitingTextInputFormatter(
                                                          19), // limit to 19 characters (16 numbers + 3 spaces)
                                                      FilteringTextInputFormatter
                                                          .digitsOnly, // only allow digits
                                                      TextInputFormatter
                                                          .withFunction(
                                                              (oldValue,
                                                                  newValue) {
                                                        String newText =
                                                            newValue.text
                                                                .replaceAll(
                                                                    RegExp(
                                                                        r'\D'),
                                                                    '');
                                                        if (newText.length >=
                                                            4) {
                                                          newText = newText
                                                              .replaceAllMapped(
                                                                  RegExp(
                                                                      r'.{4}'),
                                                                  (match) =>
                                                                      '${match.group(0)} ');
                                                        }
                                                        return newValue.copyWith(
                                                            text: newText
                                                                .trimRight(),
                                                            selection: TextSelection
                                                                .collapsed(
                                                                    offset: newText
                                                                        .length));
                                                      }),
                                                    ],
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
                                                      if (value!.isEmpty ||
                                                          value.length < 19) {
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
                                                    controller:
                                                        _expireDateController,
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
                                                      var dateParts =
                                                          value.split('/');
                                                      if (dateParts.length !=
                                                          2) {
                                                        return 'Invalid format. Use MM/YY';
                                                      }
                                                      var month = int.tryParse(
                                                          dateParts[0]);
                                                      var year = int.tryParse(
                                                          '20' + dateParts[1]);
                                                      if (month == null ||
                                                          month < 1 ||
                                                          month > 12) {
                                                        return 'Month must be between 1 and 12';
                                                      }
                                                      if (year == null ||
                                                          year <= 23) {
                                                        return 'Year must be more than 2023';
                                                      }
                                                      return null;
                                                    },
                                                    inputFormatters: [
                                                      FilteringTextInputFormatter
                                                          .allow(RegExp(
                                                              r'[0-9/]')),
                                                      TextInputFormatter
                                                          .withFunction(
                                                              (oldValue,
                                                                  newValue) {
                                                        if (newValue.text
                                                                    .length ==
                                                                2 &&
                                                            oldValue.text
                                                                    .length ==
                                                                1) {
                                                          return TextEditingValue(
                                                            text:
                                                                '${newValue.text}/',
                                                            selection: TextSelection
                                                                .collapsed(
                                                                    offset: newValue
                                                                            .text
                                                                            .length +
                                                                        1),
                                                          );
                                                        }
                                                        return newValue;
                                                      }),
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  child: TextFormField(
                                                    controller:
                                                        _cvvController, // Add this line
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
                                                    }, // Add this line
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
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 20),
                                    child: ElevatedButton(
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
                                      onPressed: () async {
                                        if (_formKey.currentState!.validate()) {
                                          print('Form is valid');

                                          try {
                                            final user = _auth.currentUser;
                                            if (user != null) {
                                              // Create a DocumentReference pointing to the user's document
                                              final userRef = _firestore
                                                  .collection('users')
                                                  .doc(user.uid);

                                              await _firestore
                                                  .collection('cards')
                                                  .add({
                                                'user':
                                                    userRef, // Save the DocumentReference
                                                'cvv': _cvvController.text,
                                                'expireDate':
                                                    _expireDateController.text,
                                                'cardNumber':
                                                    _cardNumberController.text,
                                              });

                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Center(
                                                    // Wrap with Center widget
                                                    child: Text(
                                                      'Card added successfully!',
                                                    ),
                                                  ),
                                                  duration:
                                                      Duration(seconds: 3),
                                                  behavior: SnackBarBehavior
                                                      .floating, // Make the SnackBar floating
                                                  shape: RoundedRectangleBorder(
                                                    // Change the shape
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20.0),
                                                  ),
                                                  backgroundColor: Colors.green[
                                                      500], // Change the background color
                                                  margin: EdgeInsets.all(
                                                      30), // Add some margin
                                                ),
                                              );
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Center(
                                                    // Wrap with Center widget
                                                    child: Text(
                                                      'Please sign in to add card!',
                                                    ),
                                                  ),
                                                  duration:
                                                      Duration(seconds: 3),
                                                  behavior: SnackBarBehavior
                                                      .floating, // Make the SnackBar floating
                                                  shape: RoundedRectangleBorder(
                                                    // Change the shape
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20.0),
                                                  ),
                                                  backgroundColor: Colors.red[
                                                      500], // Change the background color
                                                  margin: EdgeInsets.all(
                                                      30), // Add some margin
                                                ),
                                              );
                                            }
                                          } catch (e) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Center(
                                                  // Wrap with Center widget
                                                  child: Text(
                                                    'Failed to add card! Please try again.',
                                                  ),
                                                ),
                                                duration: Duration(seconds: 3),
                                                behavior: SnackBarBehavior
                                                    .floating, // Make the SnackBar floating
                                                shape: RoundedRectangleBorder(
                                                  // Change the shape
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0),
                                                ),
                                                backgroundColor: Colors.red[
                                                    500], // Change the background color
                                                margin: EdgeInsets.all(30),
                                              ),
                                            );
                                          }
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Center(
                                                // Wrap with Center widget
                                                child: Text(
                                                  'Please enter valid card details!',
                                                ),
                                              ),
                                              duration: Duration(seconds: 3),
                                              behavior: SnackBarBehavior
                                                  .floating, // Make the SnackBar floating
                                              shape: RoundedRectangleBorder(
                                                // Change the shape
                                                borderRadius:
                                                    BorderRadius.circular(20.0),
                                              ),
                                              backgroundColor: Colors.red[
                                                  500], // Change the background color
                                              margin: EdgeInsets.all(30),
                                            ),
                                          );
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
