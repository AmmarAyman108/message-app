import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:message_app/business_logic/cubits/theme_cubit/theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(InitialState());
  bool lightTheme = true;
  theme(BuildContext context) {
    emit(LightThemeState());
    lightTheme = !lightTheme;
    if (lightTheme) {
      AdaptiveTheme.of(context).setLight();
      emit(LightThemeState());
    } else {
      AdaptiveTheme.of(context).setDark();
      emit(DarkThemeState());
    }
  }
}
