// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:lists/forms/hand_form.dart';
import 'package:lists/pages/tarot_hands_page.dart';
import 'package:lists/providers/parent_provider.dart';
import 'package:lists/ui_components/drawer.dart';
import 'package:lists/ui_components/list_card.dart';
import 'package:provider/provider.dart';

class TarotDecksPage extends StatelessWidget {
  const TarotDecksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tarot decks"),
        actions: [
          IconButton(
              onPressed: () {
                _showAlertDialog(context);
              },
              icon: Icon(Icons.add))
        ],
      ),
      drawer: DrawerNav(),
      body: Consumer<ParentProvider>(
        builder: (context, provider, child) {
          var tarotHands = provider.tarotHands;
          if (tarotHands.isEmpty) {
            return Center(
              child: Text(
                  "Insert here tarot deck, hand, and Go ahead, create your first deck"),
            );
          } else {
            return Column(
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                    itemCount: tarotHands.length,
                    itemBuilder: (context, index) {
                      var hand = tarotHands[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                // builder: (context) => TarotHandsPage(
                                //     parentId: hand.id!, listName: hand.title),
                                builder: (context) => TarotHand(
                                      parentId: hand.id!,
                                      listName: hand.title,
                                    )),
                          );
                        },
                        child: ListCard(
                          parent: hand,
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  void _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DeckForm();
      },
    );
  }
}
