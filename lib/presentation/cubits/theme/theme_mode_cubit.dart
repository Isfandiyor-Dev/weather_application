import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

class ThemeModeCubit extends Cubit<bool> {
  late Box _myBox;

  ThemeModeCubit() : super(false) {
    _myBox = Hive.box("themeBox"); 
    final bool isDarkMode = _myBox.get("isDarkMode") ?? false; 
    emit(isDarkMode);
  }

  void toggleThemeMode() async {
    final bool isDarkMode = _myBox.get("isDarkMode", defaultValue: false);
    _myBox.put("isDarkMode", !isDarkMode);
    emit(!state);
  }
}
