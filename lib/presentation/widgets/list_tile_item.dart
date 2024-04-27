import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:message_app/business_logic/cubits/message_cubit/message_cubit.dart';
import 'package:message_app/data/models/user_model.dart';
import 'package:message_app/presentation/screens/chat_view.dart';
import 'package:message_app/presentation/widgets/custom_text.dart';

// ignore: must_be_immutable
class ListTileItem extends StatelessWidget {
  ListTileItem({super.key, required this.user});
  UserModel user;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
      width: double.infinity,
      child: ListTile(
        onTap: () {
          BlocProvider.of<MessageCubit>(context).getAllMessage(receiver: user);
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) {
              return ChatView(
                user: user,
              );
            },
          ));
        },
        leading: Container(
          height: 44,
          width: 44,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5000),
            image: const DecorationImage(
              image: AssetImage('assets/images/xm.jpg'),
              fit: BoxFit.fill,
            ),
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 8,
        ),
        title: CustomText(
          title: user.name,
          fontSize: 19,
        ),
      ),
    );
  }
}
