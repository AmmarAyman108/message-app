import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:message_app/business_logic/cubits/auth_cubit/auth_cubit.dart';
import 'package:message_app/business_logic/cubits/layout_cubit/layout_cubit.dart';
import 'package:message_app/business_logic/cubits/message_cubit/message_cubit.dart';
import 'package:message_app/business_logic/cubits/theme_cubit/theme_cubit.dart';
import 'package:message_app/firebase_options.dart';
import 'package:message_app/presentation/screens/home_screen.dart';
import 'package:message_app/presentation/screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  WidgetsFlutterBinding.ensureInitialized();
  final savedThemeMode = await AdaptiveTheme.getThemeMode();
  runApp(MyApp(savedThemeMode: savedThemeMode));
}

class MyApp extends StatelessWidget {
  final AdaptiveThemeMode? savedThemeMode;

  const MyApp({super.key, this.savedThemeMode});

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorSchemeSeed: Colors.blue,
      ),
      dark: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorSchemeSeed: Colors.blue,
      ),
      initial: AdaptiveThemeMode.light,
      builder: (theme, darkTheme) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ThemeCubit(),
          ),
          BlocProvider(
            create: (context) => AuthCubit(),
          ),
          BlocProvider(
            create: (context) => LayoutCubit()..getAllChat(),
          ),
          BlocProvider(
            create: (context) => MessageCubit(),
          ),
        ],
        child: MaterialApp(
          theme: theme,
          darkTheme: darkTheme,
          home: FirebaseAuth.instance.currentUser?.uid == null
              ? const LoginScreen()
              : const HomeScreen(),
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
