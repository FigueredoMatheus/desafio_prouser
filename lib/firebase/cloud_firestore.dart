import 'package:cloud_firestore/cloud_firestore.dart';

class CloudFirestore {
  Future<Map<String, dynamic>> saveFile(Map<String, dynamic> codeModel) async {
    Map<String, dynamic> result = {};

    await FirebaseFirestore.instance
        .collection('codes')
        .add(codeModel)
        .then((doc) async {
      await FirebaseFirestore.instance
          .collection('codes')
          .doc(doc.id)
          .update({'id': doc.id});

      result = {
        'success': true,
        'docId': doc.id,
      };
    }).catchError((_) {
      result = {
        'success': false,
      };
    });

    return result;
  }

  Future<Map<String, dynamic>> deleteFile(String codeId) async {
    Map<String, dynamic> result = {'success': true};

    await FirebaseFirestore.instance
        .collection('codes')
        .doc(codeId)
        .delete()
        .catchError((_) {
      result = {'success': false};
    });

    return result;
  }
}
