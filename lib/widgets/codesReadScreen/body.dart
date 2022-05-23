import 'package:desafio_prouser/controllers/app_state_controller.dart';
import 'package:desafio_prouser/controllers/storage_controller.dart';
import 'package:desafio_prouser/data/codes_read_list.dart';
import 'package:desafio_prouser/utils/dialogs/code_tile_on_tap.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appStateController = AppStateController();
    return ValueListenableBuilder(
      valueListenable: appStateController.attCodesReadScreen,
      builder: (context, _, __) {
        return codesReadList.isEmpty
            ? const Center(
                child: Text(
                  'Nenhum código armazendo',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              )
            : Column(
                children: codesReadList.map((codeModel) {
                  final String date = DateFormat('dd/MM/yyyy, kk:mm').format(
                    codeModel.date,
                  );
                  return Container(
                    margin: const EdgeInsets.only(bottom: 15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10,
                          offset: Offset(0, 6),
                        ),
                      ],
                    ),
                    child: ListTile(
                      title:
                          Text(codeModel.code, overflow: TextOverflow.ellipsis),
                      subtitle: Text(date),
                      onTap: () {
                        codeTileOnTap(
                          context: context,
                          codeModel: codeModel,
                          formatedDate: date,
                        );
                      },
                      trailing: IconButton(
                        onPressed: () {
                          final storageController = StorageController();

                          storageController.deleteFile(
                            context: context,
                            codeId: codeModel.id,
                          );
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              );
      },
    );
  }
}
