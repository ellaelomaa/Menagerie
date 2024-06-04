// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:flutter/material.dart';
import 'package:lists/database/models/item_model.dart';
import 'package:lists/providers/tarot_hand_provider.dart';
import 'package:provider/provider.dart';
import 'package:lists/consts/color_consts.dart' as color_consts;

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
  late int _oldJudgement; // Used to update Listview.builder

  // DATA TO BE SAVED
  final title = "";
  //late int judgement;

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
    final AppinioSwiperController swipeController = AppinioSwiperController();

    void saveCard(int judgement) async {
      if (_titleController.text.isNotEmpty) {
        if (widget.newItem == true) {
          await tarotProvider
              .addCard(
                ItemModel(
                    title: _titleController.text,
                    added: DateTime.now().toString(),
                    type: "tarot",
                    judgement: judgement,
                    parentId: widget.parentId),
              )
              .then((_) => Navigator.pop(context));
        } else {
          await tarotProvider
              .editCard(
                  ItemModel(
                      id: widget.item?.id,
                      title: _titleController.text,
                      added: widget.item!.added,
                      modified: DateTime.now().toString(),
                      type: widget.item!.type,
                      judgement: judgement,
                      parentId: widget.parentId),
                  _oldJudgement)
              .then((_) => Navigator.pop(context));
        }
      } else {
        Navigator.pop(context);
      }
    }

    void swipeEnd(int previousIndex, int targetIndex, SwiperActivity activity) {
      if (activity.direction == AxisDirection.left) {
        saveCard(0);
      }
      if (activity.direction == AxisDirection.down) {
        saveCard(1);
      }
      if (activity.direction == AxisDirection.right) {
        saveCard(2);
      }
    }

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: color_consts.cardColor,
        title: Text("Cast your vote"),
      ),
      body: SizedBox(
        child: AppinioSwiper(
          invertAngleOnBottomDrag: false,
          backgroundCardCount: 0,
          swipeOptions:
              SwipeOptions.only(down: true, up: false, right: true, left: true),
          controller: swipeController,
          onSwipeEnd: swipeEnd,

          // onEnd: _onEnd,
          cardBuilder: (BuildContext context, int index) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: color_consts.cardColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 3,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  )
                ],
              ),
              alignment: Alignment.center,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    decoration: BoxDecoration(
                      color: color_consts.cardColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    child: TextField(
                      controller: _titleController,
                      decoration: InputDecoration(
                          icon: Image.asset(
                              height: 40, "assets/icons/feather-pen.png")),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Flexible(
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 2)),
                      child: Image.asset(
                        "assets/images/rider-waite/Cups02.jpg",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                ],
              ),
            );
          },
          cardCount: 1,
        ),
      ),
    );
  }
}
