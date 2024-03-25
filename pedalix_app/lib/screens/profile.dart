import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pedalix_app/screens/getting_user_details.dart';
import 'package:pedalix_app/screens/user_info_edit.dart';
import 'package:pedalix_app/utils/loader.dart';
import 'package:pedalix_app/utils/transitions.dart';

class profile extends StatefulWidget {
  final User? user;
  const profile({Key? key, required this.user}) : super(key: key);

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  bool isObscurePassword = true;
  String? email;
  String? phoneNumber;
  String? firstName;
  String? lastName;
  String? nicNo;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUserInfo();
  }

  fetchUserInfo() async {
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.user?.uid)
        .get();
    if (doc.exists) {
      setState(() {
        email = doc.get('email');
        phoneNumber = doc.get('phoneNumber');
        firstName = doc.get('firstName');
        lastName = doc.get('lastName');
        nicNo = doc.get('nicNo');
        _isLoading = false;
      });
    } else {
      // Handle the case where the document does not exist
      print('Document does not exist');
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isLoading) {
      fetchUserInfo();
    }
  }

  final Color primaryColor = const Color(0xFF127368);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          toolbarHeight: 80,
          titleSpacing: 20,
        ),
      ),
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Image.asset('assets/back_button.png'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            title: Text(
              'Profile',
              style: GoogleFonts.montserrat(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(slideTransitionAnimation(
                      UserInfoEdit(user: widget.user)));
                },
                child: Text(
                  'Edit Profile',
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: primaryColor,
                  ),
                ),
              ),
            ],
          ),
          backgroundColor: const Color(0xFFF6F6F6),
          body: _isLoading
              ? Center(
                  child: OverlayLoaderWithAppIcon(
                    isLoading:
                        _isLoading, // Add the required argument for 'isLoading'
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Stack(
                            children: [
                              Container(
                                height: 300,
                                width: double.infinity,
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(20),
                                  ),
                                  color: Colors.white,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(
                                      50.0), // Add padding around the profile image
                                  child: Align(
                                    alignment: Alignment.topCenter,
                                    child: CircleAvatar(
                                      radius: 50, // adjust the size as needed
                                      backgroundImage:
                                          NetworkImage(widget.user!.photoURL!),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    appIconPath:
                        'path/to/app_icon.png', // Add the required argument for 'appIconPath'
                  ), // Show loading indicator while fetching data
                )
              : SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Stack(
                        children: [
                          Container(
                            height: 300,
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(20),
                              ),
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(
                                  50.0), // Add padding around the profile image
                              child: Align(
                                alignment: Alignment.topCenter,
                                child: CircleAvatar(
                                  radius: 50, // adjust the size as needed
                                  backgroundImage:
                                      NetworkImage(widget.user!.photoURL!),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 160,
                            left: 0,
                            right: 0,
                            child: Center(
                              child: Text(
                                '$firstName $lastName', // Display first name and last name
                                style: GoogleFonts.montserrat(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 140,
                            left: 0,
                            right: 0,
                            child: Center(
                              child: Text(
                                phoneNumber ?? 'No TP Number',
                                style: GoogleFonts.montserrat(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 70,
                            left: 15,
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.email,
                                  color: Colors.grey,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  email ?? 'No Email',
                                  style: GoogleFonts.montserrat(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            bottom: 40,
                            left: 15,
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.email,
                                  color: Colors.grey,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  nicNo ?? 'No NIC',
                                  style: GoogleFonts.montserrat(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        height: 200,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 15.0,
                            top: 20.0,
                          ),
                          child: Text(
                            'Saved places',
                            style: GoogleFonts.montserrat(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        height: 120,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),
                          color: Colors.white,
                        ),
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () async {
                                await FirebaseAuth.instance.signOut();
                                // Navigate back to the previous screen
                                Navigator.popUntil(
                                    context, (route) => route.isFirst);
                              },
                              child: Container(
                                height: 60,
                                width: double.infinity,
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(20),
                                  ),
                                  color: Colors.white,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.logout,
                                        size: 22, color: primaryColor),
                                    const SizedBox(width: 20),
                                    Text(
                                      'Logout',
                                      style: GoogleFonts.montserrat(
                                        color: primaryColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (_) => UserDetails()),
                                );
                              },
                              child: Container(
                                height: 60,
                                width: double.infinity,
                                color: Colors.white,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.delete,
                                        size: 22, color: Colors.red),
                                    const SizedBox(width: 20),
                                    Text(
                                      'Delete Account',
                                      style: GoogleFonts.montserrat(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
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
