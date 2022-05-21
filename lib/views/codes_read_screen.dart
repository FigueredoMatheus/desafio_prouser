import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desafio_prouser/controllers/app_state_controller.dart';
import 'package:desafio_prouser/data/codes_read_list.dart';
import 'package:desafio_prouser/models/code_model.dart';
import 'package:desafio_prouser/widgets/codesReadScreen/body.dart';
import 'package:flutter/material.dart';

class CodesReadScreen extends StatelessWidget {
  const CodesReadScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appStateController = AppStateController();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        backgroundColor: const Color(0xFF0082E0),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: appStateController.codesReadListLoaded
              ? const Body()
              : FutureBuilder<QuerySnapshot>(
                  future: FirebaseFirestore.instance.collection('codes').get(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      );
                    }

                    if (snapshot.connectionState == ConnectionState.none) {
                      return const Center(
                        child: Text(
                          'Algo deu errado.',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      );
                    }
                    codesReadList.clear();
                    for (DocumentSnapshot doc in snapshot.data!.docs) {
                      codesReadList.add(
                        CodeModel.fromMap(doc.data() as Map<String, dynamic>),
                      );
                    }

                    appStateController.codesReadListLoaded = true;

                    return const Body();
                  },
                ),
        ),
      ),
    );
  }
}
