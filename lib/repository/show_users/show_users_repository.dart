import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:harrowsithivinayagar/models/user_model.dart';

class UserRepository {
  final FirebaseFirestore _firestore;

  UserRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  Stream<List<UserModel>> getUsersByRole(String role) {
    print("Role: $role");
    final usersStream = _firestore
        .collection('users')
        .where('role', isEqualTo: role)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return UserModel.fromFirestore(doc.data(), doc.id);
      }).toList();
    });
    return usersStream;
  }

  Future<void> updateUserRole(String userId, String newRole) async {
    try {
      await _firestore
          .collection('users')
          .doc(userId)
          .update({'role': newRole});
    } catch (e) {
      throw Exception('Failed to update user role: $e');
    }
  }
}
