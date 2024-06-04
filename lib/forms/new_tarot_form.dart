import 'package:flutter/material.dart';
import 'package:lists/database/models/item_model.dart';
import 'package:lists/providers/children_provider.dart';
import 'package:provider/provider.dart';
import 'package:simple_gesture_detector/simple_gesture_detector.dart';

class TarotForm extends StatefulWidget {
  const TarotForm({Key? key, required this.parentId}) : super(key: key);
  final int parentId;

  @override
  State<TarotForm> createState() => _TarotFormState();
}

class _TarotFormState extends State<TarotForm> {
  final _titleController = TextEditingController();

  // DATA TO BE SAVED
  final title = "";
  int judgement = 1;

  @override
  Widget build(BuildContext context) {
    final tarotProvider =
        Provider.of<TarotHandProvider>(context, listen: false);

    void _saveCard(int judgement) async {
      await tarotProvider.addCard(
        ItemModel(
            title: _titleController.text,
            added: DateTime.now().toString(),
            type: "tarot",
            judgement: judgement,
            parentId: widget.parentId),
      );
      Navigator.pop(context);
    }

    void _onSwipe(SwipeDirection direction) {
      setState(
        () {
          if (direction == SwipeDirection.left) {
            judgement = 0;
          }
          if (direction == SwipeDirection.down) {
            judgement = 1;
          }
          if (direction == SwipeDirection.right) {
            judgement = 2;
          }
        },
      );
      _saveCard(judgement);
    }

    return SimpleGestureDetector(
      child: AlertDialog(
        title: Text("Cast your vote"),
        actions: [
          IconButton(
            onPressed: () {
              _saveCard(0);
            },
            icon: Icon(Icons.cancel),
          ),
          IconButton(
            onPressed: () {
              _saveCard(1);
            },
            icon: Icon(Icons.circle),
          ),
          IconButton(
            onPressed: () {
              _saveCard(2);
            },
            icon: Icon(Icons.favorite),
          ),
        ],
        content: TextField(
          controller: _titleController,
          decoration:
              InputDecoration(hintText: "Write item title", labelText: "Title"),
        ),
      ),
    );
  }
}
