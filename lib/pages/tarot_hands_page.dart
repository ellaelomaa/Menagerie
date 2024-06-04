// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:lists/forms/new_tarot_form.dart';
import 'package:lists/providers/children_provider.dart';
import 'package:provider/provider.dart';
import 'package:tab_container/tab_container.dart';

class TarotHand extends StatelessWidget {
  final int parentId;
  final String listName;
  const TarotHand({super.key, required this.parentId, required this.listName});

  @override
  Widget build(BuildContext context) {
    final handProvider = Provider.of<TarotHandProvider>(context, listen: false);
    handProvider.setParent(parentId);

    return Scaffold(
      appBar: AppBar(
        title: Text(listName),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.toys), // TODO: change to tophat
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {
              _showAlertDialog(context);
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: Consumer<TarotHandProvider>(
        builder: (context, provider, child) {
          if (provider.allCards.isEmpty) {
            return Center(
              child: Text(provider.allCards.length.toString()),
            );
          } else {
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
                            );
                          },
                        )
                      : Center(
                          child: Text("nothing here"),
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
                            );
                          },
                        )
                      : Center(
                          child: Text("nothing here"),
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
                            );
                          },
                        )
                      : Center(
                          child: Text("nothing here"),
                        ),
                ],
              ),
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
        return TarotForm(
          parentId: parentId,
        );
      },
    );
  }
}
