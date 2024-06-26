// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:lists/database/models/item_model.dart';
import 'package:lists/forms/tarot_card_form.dart';
import 'package:lists/providers/tarot_hand_provider.dart';
import 'package:provider/provider.dart';
import 'package:tab_container/tab_container.dart';
import 'package:lists/consts/dialog_consts.dart' as consts;

class TarotHand extends StatelessWidget {
  final int parentId;
  final String listName;
  const TarotHand({super.key, required this.parentId, required this.listName});

  @override
  Widget build(BuildContext context) {
    final handProvider = Provider.of<TarotHandProvider>(context, listen: false);
    handProvider.setParent(parentId);

    void deleteCard(BuildContext context, ItemModel item) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text(consts.DELETE_WARNING),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: () {
                  handProvider.deleteCard(item);
                  Navigator.pop(context);
                },
                child: Text("Delete"),
              ),
            ],
          );
        },
      );
    }

    PopupMenuButton menuButton(ItemModel card) {
      return PopupMenuButton(
        iconColor: Colors.white,
        itemBuilder: (context) => [
          PopupMenuItem(
            value: 1,
            child: Row(
              children: [
                Icon(Icons.edit),
                SizedBox(
                  width: 10,
                ),
                Text("Edit"),
              ],
            ),
          ),
          PopupMenuItem(
            value: 2,
            child: Row(
              children: [
                Icon(Icons.delete),
                SizedBox(
                  width: 10,
                ),
                Text("Delete"),
              ],
            ),
          ),
        ],
        onSelected: (value) {
          if (value == 1) {
            _showAlertDialog(context, false, item: card);
          }

          if (value == 2) {
            deleteCard(context, card);
          }
        },
      );
    }

    TextStyle emptyHandStyle() {
      return TextStyle(
        color: Colors.white,
        fontSize: 18,
        letterSpacing: 2.0,
        fontWeight: FontWeight.w200,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(listName),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Image.asset(
                height: 40,
                "assets/icons/crystal_moon.png"), // TODO: change to tophat
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {
              // await showDialog(
              //   context: context,
              //   builder: (context) =>
              //       TarotCardForm(parentId: parentId, newItem: true),
              // );
              _showAlertDialog(context, true);
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: Consumer<TarotHandProvider>(builder: (context, provider, child) {
        return SizedBox(
          width: double.infinity,
          child: TabContainer(
            tabs: [
              Text("Past"),
              Text("Present"),
              Text("Future"),
            ],
            tabEdge: TabEdge.top,
            borderRadius: BorderRadius.circular(10),
            tabBorderRadius: BorderRadius.circular(10),
            childPadding: const EdgeInsets.all(20.0),
            selectedTextStyle: const TextStyle(
              color: Colors.white,
              fontSize: 15.0,
            ),
            unselectedTextStyle: const TextStyle(
              color: Colors.black,
              fontSize: 13.0,
            ),
            colors: [
              Color(0xFF02315E),
              Color(0xff00457E),
              Color(0xff2F70AF),
            ],
            children: [
              provider.pastCards.isNotEmpty
                  ? ListView.builder(
                      itemCount: provider.pastCards.length,
                      itemBuilder: (context, index) {
                        var card = provider.pastCards[index];
                        return ListTile(
                          title: Text(
                            card.title,
                            style: TextStyle(color: Colors.white),
                          ),
                          trailing: menuButton(card),
                        );
                      },
                    )
                  : Center(
                      child: Text(
                        "Things to be left in memories",
                        style: emptyHandStyle(),
                      ),
                    ),
              provider.currentCards.isNotEmpty
                  ? ListView.builder(
                      itemCount: provider.currentCards.length,
                      itemBuilder: (context, index) {
                        var card = provider.currentCards[index];
                        return ListTile(
                          title: Text(
                            card.title,
                            style: TextStyle(color: Colors.white),
                          ),
                          trailing: menuButton(card),
                        );
                      },
                    )
                  : Center(
                      child: Text(
                        "Carpe diem",
                        style: emptyHandStyle(),
                      ),
                    ),
              provider.futureCards.isNotEmpty
                  ? ListView.builder(
                      itemCount: provider.futureCards.length,
                      itemBuilder: (context, index) {
                        var card = provider.futureCards[index];
                        return ListTile(
                          title: Text(
                            card.title,
                            style: TextStyle(color: Colors.white),
                          ),
                          trailing: menuButton(card),
                        );
                      },
                    )
                  : Center(
                      child: Text(
                        "Things that might come across your path, or evade it entirely",
                        style: emptyHandStyle(),
                      ),
                    ),
            ],
          ),
        );
      }),
    );
  }

  void _showAlertDialog(BuildContext context, bool newItem, {ItemModel? item}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return Container(
        //   height: 200,
        //   color: Colors.red,
        // );
        return TarotCardForm(
          parentId: parentId,
          newItem: newItem,
          item: item,
        );
      },
    );
  }
}
