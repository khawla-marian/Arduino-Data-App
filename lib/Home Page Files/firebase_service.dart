import 'package:firebase_database/firebase_database.dart';

class FirebaseService {
  final DatabaseReference _databaseReference =
      FirebaseDatabase.instance.ref('Arduino_data');

  Stream<Map<String, dynamic>> getSensorData() {
    return _databaseReference.onValue.map((event) {
      if (event.snapshot.value != null) {
        return Map<String, dynamic>.from(
            event.snapshot.value as Map<dynamic, dynamic>);
      } else {
        return {};
      }
    });
  }
}
