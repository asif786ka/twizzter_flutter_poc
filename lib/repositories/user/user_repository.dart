import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:twizzter/config/paths.dart';
import 'package:twizzter/models/models.dart';
import 'package:twizzter/repositories/repositories.dart';

class UserRepository extends BaseUserRepository {
  final FirebaseFirestore _firebaseFirestore;

  UserRepository({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Future<User?> getUserWithId({required String userId}) async {
    final doc = await _firebaseFirestore.collection(Paths.users).doc(userId).get();
    return doc.exists ? User.fromDocument(doc) : User.empty;
  }

  @override
  Future<void> updateUser({required User user}) async {
    await _firebaseFirestore.collection(Paths.users).doc(user.id).update(user.toDocument());
  }
}
