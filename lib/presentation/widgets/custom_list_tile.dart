import 'package:flutter/material.dart';
import 'package:message_app/data/models/list_tile_model.dart';
import 'package:message_app/presentation/widgets/custom_text.dart';

// ignore: must_be_immutable
class CustomListTile extends StatelessWidget {
  CustomListTile({
    super.key,
    required this.listTileData,
  });
  ListTileModel listTileData;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: CustomText(
          title: listTileData.title,
        ),
        trailing: listTileData.trailing);
  }
}
