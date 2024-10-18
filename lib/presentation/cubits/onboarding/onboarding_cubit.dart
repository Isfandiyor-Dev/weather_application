import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';

class OnboardingCubit extends Cubit<bool> {
  OnboardingCubit() : super(false);

  void loadOnboardingStatus()  {
    final box = Hive.box("onboardingBox");
    final isOnboardingPassed = box.get("onboardingPassed") ?? false;
    emit(isOnboardingPassed);
  }

  Future<void> saveOnboardingStatus(bool status) async {
    final box = Hive.box("onboardingBox");
    await box.put("onboardingPassed", status);
    emit(status);
  }
}
