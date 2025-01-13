import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'firebase_service.dart';
import 'gauge_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late FirebaseService _firebaseService;
  Map<String, dynamic> sensorData = {};

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _firebaseService = FirebaseService();
    _firebaseService.getSensorData().listen((data) {
      setState(() {
        sensorData = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Arduino Cloud Data"),
        centerTitle: true,
      ),
      body: sensorData.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      children: [
                        buildGaugeCard(
                          title: "Temperature",
                          value: sensorData['temperature']?.toDouble() ?? 0.0,
                          min: 0,
                          max: 100,
                          unit: "°C",
                          initialValue: 0,
                          finalValue: 100,
                        ),
                        buildGaugeCard(
                          title: "Humidity",
                          value: sensorData['humidity']?.toDouble() ?? 0.0,
                          min: 0,
                          max: 100,
                          unit: "%",
                          initialValue: 0,
                          finalValue: 100,
                        ),
                        buildGaugeCard(
                          title: "Soil Moisture",
                          value: sensorData['soil_misture']?.toDouble() ?? 0.0,
                          min: -400,
                          max: 50,
                          unit: "",
                          initialValue: -400,
                          finalValue: 50,
                        ),
                        buildGaugeCard(
                          title: "Air Quality",
                          value: sensorData['air_quality']?.toDouble() ?? 0.0,
                          min: 0,
                          max: 1000,
                          unit: "",
                          initialValue: 0,
                          finalValue: 1000,
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _showSignOutDialog(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: const Text(
                      "Sign Out",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  void _showSignOutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Are you sure you want to sign out?'),
        content: const Text('This account is signing out.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('No, Back'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _signOut(context);
            },
            child: const Text(
              'Sign out',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  void _signOut(BuildContext context) async {
    try {
      await _auth.signOut();
      Navigator.pushReplacementNamed(context, '/login');
    } catch (e) {
      print('Error signing out: $e');
    }
  }
}
