import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pedalix_app/screens/about.dart';
import 'package:pedalix_app/screens/help.dart';
import 'package:pedalix_app/screens/mytrip.dart';
import 'package:pedalix_app/screens/payments.dart';
import 'package:pedalix_app/screens/profile.dart';
import 'package:pedalix_app/screens/promotions.dart';

class navbar extends StatelessWidget {
  final User? user; // Define the user object in the navbar
  const navbar({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final FirebaseAuth _auth = FirebaseAuth.instance;
    return SafeArea(
      child: Drawer(
        child: ListView(
          children: [
            const UserAccountsDrawerHeader(
              accountName: Text(
                'Chamindu',
                style: TextStyle(color: Colors.black),
              ),
              accountEmail: Text('chamindu@gmail.com'),
              currentAccountPicture: CircleAvatar(
                child: ClipOval(),
                backgroundColor: Color.fromRGBO(158, 158, 158, 1),
              ),
              decoration: BoxDecoration(color: Colors.white),
            ),
            ListTile(
              leading: const Icon(Icons.payment),
              title: const Text('Payments'),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => const Payments()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.local_offer),
              title: const Text(
                'Promotions',
              ),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const promotions()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.location_on),
              title: const Text('My Trip'),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => const mytrip()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.help),
              title: const Text('Help'),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => const help()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('About'),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => const about()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('Profile'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => profile(
                          user: user)), // Pass user to the profile screen
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
