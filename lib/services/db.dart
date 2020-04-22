import 'package:Conversat/services/model.dart';
import 'package:Conversat/shared/shared.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class Document<T> {
  final Firestore db = Firestore.instance;
  final String path;
  DocumentReference ref;

  Document({this.path}) {
    ref = db.document(path);
  }

  Future<T> getData() {
    return ref.get().then((v) => Global.models[T](v.data) as T);
  }

  Stream<T> streamData() {
    return ref.snapshots().map((v) => Global.models[T](v.data) as T);
  }

  Future<void> upsert(Map data) {
    return ref.setData(Map<String, dynamic>.from(data), merge: true);
  }
}

class Collection<T> {
  final Firestore _db = Firestore.instance;
  final String path;
  CollectionReference ref;

  Collection({this.path}) {
    ref = _db.collection(path);
  }

  Future<List<T>> getData() async {
    var snapshots = await ref.getDocuments();
    return snapshots.documents
        .map((doc) => Global.models[T](doc.data) as T)
        .toList();
  }

  Stream<Iterable<T>> streamData() {
    return ref.snapshots().map(
            (list) => list.documents.map((doc) => Global.models[T](doc.data) as T));
  }
}

/// Methods to access various types of user data
class UserData<T> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore db = Firestore.instance;
  static const String collection = 'users';
=
  UserData();

  get user async {
    return await _auth.currentUser();
  }

  /// Gets a stream of data from Firebase at [document]/userId
  ///
  /// Returns a [Stream] of the data in that document
  /// Returns a Stream of [null] if the document isn't found.
  Stream<T> documentStream({String document: UserData.collection}) {
    return (_auth.onAuthStateChanged).switchMap((user) {
      if (user != null) {
        Document<T> doc = Document<T>(path: '$collection/${user.uid}');
        return doc.streamData();
      } else {
        return Stream<T>.value(null);
      }
    });
  }

  ///Get the feed of the current logged in user
  ///
  /// Returns a [Stream] of the users public facing data
  /// If error, returns a [Stream] of null
  Stream<UserPublic> getFeed() {
    return (_auth.onAuthStateChanged).switchMap((user) {
      if (user != null) {
        return db.collection('user-public')
            .where('followers', arrayContains: user.uid)
            .snapshots()
            .map((list) => _querySnapshotToUserPublic(list))
            .map((list) => list[0]);
      } else {
        return Stream.value(null);
      }
    });
  }

  /// Turns a query snapshot and turns it into a [List[ of [UserPublic] classes
  List<UserPublic> _querySnapshotToUserPublic(QuerySnapshot list) {
    return list.documents.map((doc) {
      return UserPublic.fromMap(doc.data);
    });
  }

  /// Gets a Future of data from Firebase at [document]/userId
  ///
  /// Returns [T] if the document is found and the user is logged in
  /// Returns [null] on error
  Future<T> getDocument({String document: UserData.collection}) async {
    FirebaseUser user = await _auth.currentUser();

    if (user != null) {
      Document doc = Document<T>(path: '$collection/${user.uid}');
      return doc.getData();
    } else {
      return null;
    }
  }

  /// Upserts a user document with [data]
  Future<void> upsertUser(Map data) async {
    Document<T> ref = Document(path: '$collection/${this.user.uid}');
    return ref.upsert(data);
  }
}