import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import FirebaseAuth package

class UserInfoPage extends StatelessWidget {
  final User? user;

  const UserInfoPage({Key? key, required this.user}) : super(key: key);

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
            if (user != null &&
                user!.photoURL !=
                    null) // Check if user and photoURL are not null
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(user!
                        .photoURL!), // Safe access using null-aware operator
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            SizedBox(height: 20),
            Text(
              user?.displayName ?? 'No Name',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              user?.phoneNumber ?? 'No TP Number',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              user?.email ?? 'No Email',
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
                // Sign out the user
                await FirebaseAuth.instance.signOut();
              },
              child: Text('Sign Out'),
            ),
          ],
        ),
      ),
    );
  }
}
