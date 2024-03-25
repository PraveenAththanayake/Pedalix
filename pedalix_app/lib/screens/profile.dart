import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

class profile extends StatefulWidget {
  const profile({super.key});

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
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
                onPressed: () {},
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
          body: SingleChildScrollView(
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
                          child: Image.asset(
                            'assets/profile_icon.png',
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
                          'Chamindu Gamage',
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
                          '+94 772901677',
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
                            'chamindulgamage@gmail.com',
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
                        onTap: () {
                          // Add your logout functionality here
                          // For example, you can call a function to handle logout
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
                              Icon(Icons.logout, size: 22, color: primaryColor),
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
                          // Add your logout functionality here
                          // For example, you can call a function to handle logout
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
