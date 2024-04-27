import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:message_app/business_logic/cubits/layout_cubit/layout_cubit.dart';
import 'package:message_app/data/models/user_model.dart';
import 'package:message_app/presentation/widgets/chat_list.dart';
import 'package:message_app/presentation/widgets/custom_text.dart';

class CustomDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(
            Icons.close,
            size: 25,
            color: Colors.black,
          ))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(
          Icons.arrow_back_ios_new,
          size: 23,
          color: Colors.black,
        ));
  }

  @override
  Widget buildResults(BuildContext context) {
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<UserModel> users = BlocProvider.of<LayoutCubit>(context).users;

    if (query == '') {
      return Padding(
          padding: const EdgeInsets.fromLTRB(2, 0, 2, 7),
          child: ShowChatList(
            itemCount: users.length,
            user: users,
          ));
    } else {
      users = users
          .where((element) => element.name.toLowerCase().startsWith(query))
          .toList();
      if (users.isEmpty) {
        return const Center(
          child: CustomText(
            title: 'Not Found !',
          ),
        );
      } else {
        return Padding(
            padding: const EdgeInsets.fromLTRB(15, 10, 15, 7),
            child: ShowChatList(
              itemCount: users.length,
              user: users,
            ));
      }
    }
  }
}
