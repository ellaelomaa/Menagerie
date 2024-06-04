import 'package:flutter/material.dart';
import 'package:lists/database/models/parent_model.dart';
import 'package:lists/providers/parent_provider.dart';
import 'package:provider/provider.dart';

class DeckForm extends StatelessWidget {
  DeckForm({super.key});
  final _handNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final parentProvider = Provider.of<ParentProvider>(context, listen: false);
    return AlertDialog(
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text("Cancel"),
        ),
        TextButton(
          onPressed: () async {
            await parentProvider.addItem(
              ParentModel(
                  title: _handNameController.text,
                  added: DateTime.now().toString(),
                  type: "tarot",
                  folderId: 1),
            );
            _handNameController.clear();
            Navigator.pop(context);
          },
          child: Text("Save"),
        ),
      ],
      title: Text("Start your deck"),
      content: TextField(
        controller: _handNameController,
        decoration:
            InputDecoration(hintText: "Name your deck", labelText: "Title"),
      ),
    );
  }
}
