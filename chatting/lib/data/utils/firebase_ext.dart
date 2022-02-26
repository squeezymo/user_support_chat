import 'package:cloud_firestore/cloud_firestore.dart';

extension QuerySnapshotExt on QuerySnapshot {

  Iterable<T> extract<T>(T Function(DocumentSnapshot) toElement) {
    final result = <T>[];

    for (final DocumentSnapshot docSnapshot in docs) {
      try {
        result.add(toElement(docSnapshot));
      } catch (e) {
        /* do nothing */
      }
    }

    return result;
  }

}
