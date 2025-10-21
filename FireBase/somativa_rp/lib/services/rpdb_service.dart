import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class RpdbService {

  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static final FirebaseAuth _auth = FirebaseAuth.instance;


  static Future<List<Map<String, dynamic>>> fetchUserHistory() async {
    try {
      final uid = _auth.currentUser!.uid;


      final snapshot = await _firestore
          .collection("registros_ponto")
          .where("uid", isEqualTo: uid)
          .orderBy("data", descending: true)
          .get();


      return snapshot.docs.map((doc) {
        final map = doc.data();
        map["id"] = doc.id;
        return map;
      }).toList();
    } catch (e) {
      throw Exception("Falha ao buscar histórico: $e");
    }
  }

  static Future<void> addAttendance({
    required double latitude,
    required double longitude,
  }) async {
    try {
      final uid = _auth.currentUser!.uid;

      await _firestore.collection("registros_ponto").add({
        "uid": uid,
        "email": _auth.currentUser!.email,
        "data": DateTime.now().toIso8601String(),
        "latitude": latitude,
        "longitude": longitude,
      });
    } catch (e) {
      throw Exception("Falha ao registrar ponto: $e");
    }
  }
}
