import 'dart:typed_data';

import 'package:asyncstate/asyncstate.dart';
import 'package:fe_lab_clinicas_core/fe_lab_clinicas_core.dart';
import 'package:fe_lab_clinicas_self_service/src/respositories/documents/documents_repository.dart';
import 'package:signals_flutter/signals_flutter.dart';

class DocumentsScanConfirmController with MessageStateMixi {
  DocumentsScanConfirmController({
    required this.documentsRepository,
  });

  final DocumentsRepository documentsRepository;
  final pathRemoteStorage = signal<String?>(null);

  Future<void> uploadImage(Uint8List imageBytes, String filename) async {
    final result = await documentsRepository
        .uploadImage(imageBytes, filename)
        .asyncLoader();

    switch (result) {
      case Left():
        showError('Erro ao fazer uplod da imagem');
      case Right(value: final pathFile):
        pathRemoteStorage.value = pathFile;
    }
  }
}
