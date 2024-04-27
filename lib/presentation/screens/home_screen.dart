import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:message_app/business_logic/cubits/layout_cubit/layout_cubit.dart';
import 'package:message_app/constants/constant.dart';
import 'package:message_app/presentation/widgets/chat_list.dart';
import 'package:message_app/presentation/widgets/custom_delegate.dart';
import 'package:message_app/presentation/widgets/custom_drawer.dart';
import 'package:message_app/presentation/widgets/custom_text.dart';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 8),
              child: IconButton(
                onPressed: () {
                  showSearch(context: context, delegate: CustomDelegate());
                },
                icon: const Icon(
                  Icons.search,
                  color: Colors.white,
                ),
              )),
          //  Padding(
          //   padding: const EdgeInsets.only(right: 8),
          //   child: BlocBuilder<ThemeCubit, ThemeState>(
          //     builder: (context, state) {
          //       if (state is InitialState || state is LightThemeState) {
          //         return IconButton(
          //           onPressed: () {
          //             BlocProvider.of<ThemeCubit>(context).theme(context);
          //           },
          //           icon: const Icon(
          //             Icons.dark_mode,
          //             color: Colors.white,
          //           ),
          //         );
          //       } else {
          //         return IconButton(
          //           onPressed: () {
          //             BlocProvider.of<ThemeCubit>(context).theme(context);
          //           },
          //           icon: const Icon(
          //             Icons.light_mode,
          //             color: Colors.white,
          //           ),
          //         );
          //       }
          //     },
          //   ),
          //
        ],
        automaticallyImplyLeading: false,
        title: GestureDetector(
          onTap: () => scaffoldKey.currentState!.openDrawer(),
          child: const CustomText(
              title: 'Scholar Chat',
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 23),
        ),
        backgroundColor: CustomColor.kColor,
      ),
      drawer: const CustomDrawer(),
      body: BlocBuilder<LayoutCubit, LayoutState>(
        builder: (context, state) {
          if (state is GetAllChatSuccess) {
            return ShowChatList(
              itemCount: state.users.length,
              user: state.users,
            );
          } else if (state is GetAllChatFailure) {
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
