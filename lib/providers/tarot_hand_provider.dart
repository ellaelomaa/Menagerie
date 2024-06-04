// Provider for tarot cards/checklists

import 'package:flutter/foundation.dart';
import 'package:lists/database/db_helper.dart';
import 'package:lists/database/models/item_model.dart';

class TarotHandProvider extends ChangeNotifier {
  late DatabaseHelper _databaseHelper;
  late int _parentId;

  List<ItemModel> _allCards = [];
  List<ItemModel> _pastCards = [];
  List<ItemModel> _currentCards = [];
  List<ItemModel> _futureCards = [];

  List<ItemModel> get allCards => _allCards;
  List<ItemModel> get pastCards => _pastCards;
  List<ItemModel> get currentCards => _currentCards;
  List<ItemModel> get futureCards => _futureCards;

  TarotHandProvider() {
    _databaseHelper = DatabaseHelper();
  }

  setParent(int id) async {
    _parentId = id;
    _initData();
  }

  void _initData() async {
    _allCards = await _databaseHelper.getChildren(_parentId);
    _pastCards = await _databaseHelper.getJudgementItems(_parentId, 0);
    _currentCards = await _databaseHelper.getJudgementItems(_parentId, 1);
    _futureCards = await _databaseHelper.getJudgementItems(_parentId, 2);
    notifyListeners();
  }

  void _getAllCards() async {
    _allCards = await _databaseHelper.getChildren(_parentId);
    notifyListeners();
  }

  void _getPastCards() async {
    _pastCards = await _databaseHelper.getJudgementItems(_parentId, 0);
    notifyListeners();
  }

  void _getCurrentCards() async {
    _currentCards = await _databaseHelper.getJudgementItems(_parentId, 1);
    notifyListeners();
  }

  void _getFutureCards() async {
    _futureCards = await _databaseHelper.getJudgementItems(_parentId, 2);
    notifyListeners();
  }

  Future<void> addCard(ItemModel item) async {
    await _databaseHelper.addItem(item);
    fetchCards(item.judgement!);
  }

  Future<void> editCard(ItemModel item, int oldJudgement) async {
    await _databaseHelper.updateItem(item);
    fetchCards(item.judgement!);
    if (item.judgement != oldJudgement) {
      fetchCards(oldJudgement);
    }
  }

  Future<void> fetchCards(int judgement) async {
    if (judgement == 0) {
      _getPastCards();
    }
    if (judgement == 1) {
      _getCurrentCards();
    } else {
      _getFutureCards();
    }
    _getAllCards();
  }

  Future<void> deleteCard(ItemModel item) async {
    int judgement = item.judgement!;
    //_allCards.removeWhere((element) => element.id == item.id!);
    await _databaseHelper.deleteItem(item.id!);
    fetchCards(judgement);
  }
}
