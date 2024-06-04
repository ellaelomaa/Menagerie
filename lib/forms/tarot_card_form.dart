import 'package:flutter/material.dart';
import 'package:lists/database/models/item_model.dart';
import 'package:lists/providers/tarot_hand_provider.dart';
import 'package:provider/provider.dart';
import 'package:simple_gesture_detector/simple_gesture_detector.dart';

class TarotCardForm extends StatefulWidget {
  const TarotCardForm(
      {Key? key, required this.parentId, this.item, required this.newItem})
      : super(key: key);
  final int parentId;
  final ItemModel? item;
  final bool newItem;

  @override
  State<TarotCardForm> createState() => _TarotCardFormState();
}

class _TarotCardFormState extends State<TarotCardForm> {
  final _titleController = TextEditingController();
  late int _oldJudgement;

  // DATA TO BE SAVED
  final title = "";
  late int judgement;

  @override
  void initState() {
    super.initState();
    if (widget.item != null) {
      _titleController.text = widget.item!.title;
      _oldJudgement = widget.item!.judgement!;
    }
  }

  @override
  Widget build(BuildContext context) {
    final tarotProvider =
        Provider.of<TarotHandProvider>(context, listen: false);

    void _saveCard(int judgement) async {
      if (widget.newItem == true) {
        print("is new card");
        await tarotProvider.addCard(
          ItemModel(
              title: _titleController.text,
              added: DateTime.now().toString(),
              type: "tarot",
              judgement: judgement,
              parentId: widget.parentId),
        );
      } else {
        print("edit card");
        await tarotProvider.editCard(
            ItemModel(
                id: widget.item?.id,
                title: _titleController.text,
                added: widget.item!.added,
                modified: DateTime.now().toString(),
                type: widget.item!.type,
                judgement: judgement,
                parentId: widget.parentId),
            _oldJudgement);
      }

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
