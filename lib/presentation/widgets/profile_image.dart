import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:message_app/business_logic/cubits/auth_cubit/auth_cubit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

// ignore: must_be_immutable
class ProfileImage extends StatelessWidget {
  ProfileImage({
    super.key,
  });
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is ProfileImageSelectedLoading) {
          loading = true;
        } else {
          loading = false;
        }
      },
      builder: (context, state) {
        if (state is ProfileImageSelectedSuccess) {
          return Center(
            child: Container(
              height: 120,
              width: 120,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5000),
                  image: DecorationImage(
                      image: FileImage(state.profileImage!), fit: BoxFit.fill)),
            ),
          );
        } else {
          return Center(
            child: ModalProgressHUD(
              inAsyncCall: loading,
              child: Container(
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5000),
                    image: const DecorationImage(
                        image: AssetImage('assets/images/xm.jpg'),
                        fit: BoxFit.fill)),
              ),
            ),
          );
        }
      },
    );
  }
}
