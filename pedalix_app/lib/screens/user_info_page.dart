import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import FirebaseAuth package
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Cloud Firestore package

class UserInfoPage extends StatefulWidget {
  final User? user;

  const UserInfoPage({Key? key, required this.user}) : super(key: key);

  @override
  _UserInfoPageState createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  String? email;
  String? phoneNumber;

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
    setState(() {
      email = doc.get('email');
      phoneNumber = doc.get('phoneNumber');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Information'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (widget.user != null &&
                widget.user!.photoURL !=
                    null) // Check if user and photoURL are not null
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(widget.user!
                        .photoURL!), // Safe access using null-aware operator
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            SizedBox(height: 20),
            Text(
              widget.user?.displayName ?? 'No Name',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              phoneNumber ?? 'No TP Number',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              email ?? 'No Email',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate back to the previous screen
                Navigator.pop(context);
              },
              child: Text('Back'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // Sign out the user and clear all sessions
                await FirebaseAuth.instance.signOut();
                // Navigate back to the previous screen
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              child: Text('Sign Out'),
            ),
          ],
        ),
      ),
    );
  }
}
