import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:message_app/business_logic/cubits/auth_cubit/auth_cubit.dart';
import 'package:message_app/business_logic/cubits/layout_cubit/layout_cubit.dart';
import 'package:message_app/business_logic/cubits/theme_cubit/theme_cubit.dart';
import 'package:message_app/business_logic/cubits/theme_cubit/theme_state.dart';
import 'package:message_app/presentation/screens/home_screen.dart';
import 'package:message_app/presentation/widgets/center_text.dart';
import 'package:message_app/presentation/widgets/custom_button.dart';
import 'package:message_app/presentation/widgets/custom_text.dart';
import 'package:message_app/presentation/widgets/custom_text_field.dart';
import 'package:message_app/presentation/widgets/profile_image.dart';
import 'package:message_app/presentation/widgets/password_felid.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

// ignore: must_be_immutable
class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  bool obscureText = true;
  bool loading = false;
  TextEditingController email = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController password = TextEditingController();

  GlobalKey<FormState> key = GlobalKey();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is RegisterLoadingState) {
            loading = true;
          } else if (state is RegisterSuccessState) {
            loading = false;

            customSnackBar(const Text('Register Success.'),
                const Color.fromARGB(255, 58, 58, 58));
          } else if (state is RegisterFailureState) {
            loading = false;
            customSnackBar(Text(state.errorMessage),
                const Color.fromARGB(255, 255, 17, 0));
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: ModalProgressHUD(
              inAsyncCall: loading,
              child: Form(
                autovalidateMode: autoValidateMode,
                key: key,
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  physics: const BouncingScrollPhysics(),
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 40),
                          child: BlocBuilder<ThemeCubit, ThemeState>(
                            builder: (context, state) {
                              if (state is InitialState ||
                                  state is LightThemeState) {
                                return IconButton(
                                    highlightColor: Colors.transparent,
                                    splashColor: Colors.transparent,
                                    onPressed: () {
                                      BlocProvider.of<ThemeCubit>(context)
                                          .theme(context);
                                    },
                                    icon: const Icon(Icons.dark_mode));
                              } else {
                                return IconButton(
                                    highlightColor: Colors.transparent,
                                    splashColor: Colors.transparent,
                                    onPressed: () {
                                      BlocProvider.of<ThemeCubit>(context)
                                          .theme(context);
                                    },
                                    icon: const Icon(Icons.light_mode));
                              }
                            },
                          ),
                        )
                      ],
                    ),
                    GestureDetector(
                        onTap: () {
                          BlocProvider.of<AuthCubit>(context).pickImage();
                        },
                        child: ProfileImage()),
                    const SizedBox(
                      height: 10,
                    ),
                    const CustomText(
                      title: 'Register',
                      textAlign: TextAlign.center,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const CustomText(
                      title: 'Register to continue using the app',
                      fontSize: 18,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const CustomText(
                      title: 'Name',
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    CustomTextField(
                      hint: 'Enter your Name',
                      controller: name,
                      icon: (Icons.person),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const CustomText(
                      title: 'Email',
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    CustomTextField(
                        controller: email,
                        hint: 'Enter your Email',
                        icon: (Icons.email_outlined),
                        keyboardType: TextInputType.emailAddress),
                    const SizedBox(
                      height: 15,
                    ),
                    const CustomText(
                      title: 'Password',
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    PasswordFelid(
                      controller: password,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    BlocListener<AuthCubit, AuthState>(
                      listener: (context, state) async {
                        if (state is RegisterSuccessState) {
                          await BlocProvider.of<LayoutCubit>(context)
                              .getAllChat();

                          Navigator.pushAndRemoveUntil(
                            // ignore: use_build_context_synchronously
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomeScreen()),
                            (route) => false,
                          );
                        }
                      },
                      child: CustomButton(
                          title: 'Register',
                          onTap: () async {
                            if (key.currentState!.validate()) {
                              await BlocProvider.of<AuthCubit>(context)
                                  .registerByEmailAndPassword(
                                      email: email.text,
                                      name: name.text,
                                      password: password.text);
                            } else {
                              autoValidateMode = AutovalidateMode.always;
                              setState(() {});
                            }
                          }),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    CenterText(
                      textHint: 'Don\'t have an account ? ',
                      textButton: ' Login',
                      onTap: () => Navigator.pop(context),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // ignore: non_constant_identifier_names
  void customSnackBar(content, Color? color) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: content,
      backgroundColor: color,
    ));
  }
}
