import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pedalix_app/main.dart';

class Contact_US extends StatefulWidget {
  Contact_US({Key? key}) : super(key: key);

  @override
  _Contact_USState createState() => _Contact_USState();
}

class _Contact_USState extends State<Contact_US> {
  List<bool> checkboxValues = List.filled(5, false);
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Image.asset('assets/back_button.png'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'Contact Us',
          style: GoogleFonts.montserrat(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 50.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 15.0),
              child: Text(
                'Message:',
                style: GoogleFonts.montserrat(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
            TextFormField(
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'Enter your message here',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20.0),
            Row(
              children: [
                Checkbox(
                  value: _isChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      _isChecked = value!;
                    });
                  },
                ),
                Text('I agree to the terms and conditions.'),
              ],
            ),
            SizedBox(height: 20.0),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: ElevatedButton(
              onPressed: () {
                // Add your submit functionality here
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    const Color(0xFF127368)), // Set the background color here
              ),
              child: Text(
                'Submit',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              )),
        ),
      ),
    );
  }
}
