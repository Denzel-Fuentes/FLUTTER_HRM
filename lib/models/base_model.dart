import 'package:cloud_firestore/cloud_firestore.dart';

abstract class BaseModel<T> {
  String id = ''; 
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  String get collection;

  Map<String, dynamic> toMap();

  T fromMap(String id, Map<String, dynamic> data);

  Stream<List<T>> getAll() {
    return _db.collection(collection).snapshots().map(
      (snapshot) => snapshot.docs
          .map((doc) => fromMap(doc.id, doc.data() as Map<String, dynamic>))
          .toList(),
    );
  }

  Future<T?> getOne(String id) async {
    var doc = await _db.collection(collection).doc(id).get();
    if (!doc.exists) return null;
    return fromMap(doc.id, doc.data() as Map<String, dynamic>);
  }

  Future<void> save() async {
    var ref = _db.collection(collection);
    if (id.isEmpty) {
      var docRef = await ref.add(toMap());
      id = docRef.id;
    } else {
      await ref.doc(id).set(toMap(), SetOptions(merge: true));
    }
  }

  Future<void> delete() async {
    if (id.isNotEmpty) {
      await _db.collection(collection).doc(id).delete();
    }
  }
}
