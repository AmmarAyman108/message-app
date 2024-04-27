import 'package:flutter/material.dart';
import 'package:message_app/data/models/user_model.dart';
import 'package:message_app/presentation/widgets/list_tile_item.dart';

// ignore: must_be_immutable
class ShowChatList extends StatelessWidget {
  ShowChatList({
    super.key,
    required this.itemCount,
    required this.user,
  });
  int? itemCount;
  List<UserModel> user;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 2),
      child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: itemCount,
          itemBuilder: (context, index) => ListTileItem(
                user: user[index],
              )),
    );
  }
}
