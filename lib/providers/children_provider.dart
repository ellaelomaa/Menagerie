// Provider for tarot cards/checklists

import 'package:flutter/foundation.dart';
import 'package:lists/database/db_helper.dart';
import 'package:lists/database/models/item_model.dart';

// class TarotProvider extends ChangeNotifier {
//   late DatabaseHelper _databaseHelper;

//   late int _parentId;
//   int get parentId => _parentId;

//   set parentId(int id) {
//     _parentId = id;
//     notifyListeners();
//   }

//   void setParentid(int id) {
//     _parentId = id;
//     notifyListeners();
//   }

//   List<ItemModel> _children = [];
//   List<ItemModel> get children => _children;

//   List<ItemModel> _pastItems = [];
//   List<ItemModel> get pastItems => _pastItems;

//   List<ItemModel> _currentItems = [];
//   List<ItemModel> get currentItems => _currentItems;

//   List<ItemModel> _futureItems = [];
//   List<ItemModel> get futureItems => _futureItems;

//   TarotProvider([int id = 0]) {
//     _databaseHelper = DatabaseHelper();
//     fetchData();
//   }

//   Future<void> fetchData() async {
//     _getChildren();
//     _getJudgementItems();
//   }

//   // GETTERS

//   Future<void> _getChildren() async {
//     ///  Function to check if any items have been added to a tarot deck.
//     _children = await _databaseHelper.getChildren(_parentId);
//     notifyListeners();
//   }

//   Future<void> _getPastItems() async {
//     _pastItems = await _databaseHelper.getJudgementItems(_parentId, 0);
//     notifyListeners();
//   }

//   Future<void> _getCurrentItems() async {
//     _currentItems = await _databaseHelper.getJudgementItems(parentId, 1);
//     notifyListeners();
//   }

//   Future<void> _getFutureItems() async {
//     _futureItems = await _databaseHelper.getJudgementItems(_parentId, 2);
//     notifyListeners();
//   }

//   Future<void> _getJudgementItems() async {
//     _getPastItems();
//     _getCurrentItems();
//     _getFutureItems();
//     notifyListeners();
//   }

//   Future<void> addItem(ItemModel item) async {
//     print("judgement: ${item.judgement}");
//     await _databaseHelper.addItem(item).then(
//       (_) {
//         if (item.judgement == 0) {
//           _getPastItems();
//         }
//         if (item.judgement == 1) {
//           _getCurrentItems();
//         } else {
//           _getFutureItems();
//         }
//       },
//     );
//   }
// }

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
    if (item.judgement == 0) {
      _getPastCards();
    }
    if (item.judgement == 1) {
      _getCurrentCards();
    } else {
      _getFutureCards();
    }
  }
}
