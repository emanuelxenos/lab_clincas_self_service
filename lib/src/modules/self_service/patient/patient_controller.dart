import 'package:fe_lab_clinicas_core/fe_lab_clinicas_core.dart';
import 'package:fe_lab_clinicas_self_service/src/model/patient_model.dart';
import 'package:fe_lab_clinicas_self_service/src/respositories/patients/patients_repository.dart';
import 'package:signals_flutter/signals_flutter.dart';

class PatientController with MessageStateMixi {
  PatientController({
    required PatientsRepository repository,
  }) : _repository = repository;

  final PatientsRepository _repository;
  PatientModel? patient;
  final _nextStep = signal<bool>(false);
  bool get nextStep => _nextStep();

  void goNextStep() {
    _nextStep.value = true;
  }

  void upDateAndNext(PatientModel model) async {
    final updateResult = await _repository.update(model);

    switch (updateResult) {
      case Left():
        showError('Erro ao atualizar dados do paciente , chame o atendente');
      case Right():
        showInfo('Paciente atualizado com sucessso');
        patient = model;
        goNextStep();
    }
  }

  Future<void> saveAndNext(RegisterPatientModel regestirPatientModel) async {
    final result = await _repository.register(regestirPatientModel);
    switch (result) {
      case Left():
        showError('Error ao cadastrar paciente, chame o atendent');
      case Right(value: final patient):
        showInfo('Paciente cadastrado com sucesso');
        this.patient = patient;
        goNextStep();
    }
  }
}
