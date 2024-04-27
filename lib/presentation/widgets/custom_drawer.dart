import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:message_app/business_logic/cubits/layout_cubit/layout_cubit.dart';
import 'package:message_app/business_logic/cubits/theme_cubit/theme_cubit.dart';
import 'package:message_app/constants/constant.dart';
import 'package:message_app/data/models/list_tile_model.dart';
import 'package:message_app/presentation/screens/login_screen.dart';
import 'package:message_app/presentation/widgets/custom_list_tile.dart';
import 'package:message_app/presentation/widgets/custom_text.dart';

// ignore: must_be_immutable
class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
  });
  
  @override
  Widget build(BuildContext context) {
    List<ListTileModel> listTileData = [
      ListTileModel(
        title: 'Dark Mode',
        trailing: Switch(
          value: !BlocProvider.of<ThemeCubit>(context).lightTheme,
          onChanged: (value) {
            BlocProvider.of<ThemeCubit>(context).theme(context);
          },
        ),
      ),
      ListTileModel(
        title: 'Log Out',
        trailing: IconButton(
          onPressed: () {
            FirebaseAuth.instance.signOut();
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
                (route) => false);
          },
          icon: const Icon(Icons.logout_rounded),
        ),
      )
    ];
    return BlocProvider(
      create: (context) => LayoutCubit()..getMyData(),
      child: BlocBuilder<LayoutCubit, LayoutState>(
        builder: (context, state) {
          if (state is GetMyDataSuccess) {
            return Drawer(
              child: Column(
                children: [
                  UserAccountsDrawerHeader(
                    decoration:
                        const BoxDecoration(color: CustomColor.kPrimaryColor),
                    currentAccountPicture: const Padding(
                      padding: EdgeInsets.only(bottom: 5, right: 5),
                      child: CircleAvatar(
                        radius: 20,
                        backgroundImage: AssetImage(
                          'assets/images/xm.jpg',
                        ),
                      ),
                    ),
                    accountName: CustomText(
                      title: state.myData.name,
                      fontSize: 16,
                    ),
                    accountEmail: CustomText(
                      title: state.myData.email,
                      fontSize: 16,
                    ),
                  ),
                  Expanded(
                    child: ListView.separated(
                        itemBuilder: (context, index) => CustomListTile(
                              listTileData: listTileData[index],
                            ),
                        separatorBuilder: (context, index) => Divider(
                              color: Colors.grey.withOpacity(.5),
                              endIndent: 30,
                              indent: 30,
                              height: 1,
                            ),
                        itemCount: listTileData.length),
                  ),
                ],
              ),
            );
          } else if (state is GetMyDataFailure) {
            return Center(
              child: CustomText(
                title: state.errorMessage,
                color: const Color.fromARGB(255, 249, 17, 0),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
