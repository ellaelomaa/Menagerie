import 'package:flutter/material.dart';
import 'package:lists/vanhat/database/db_service.dart';
import 'package:lists/vanhat/database/models/folder.dart';

class FolderForm extends StatefulWidget {
  const FolderForm({super.key});

  @override
  State<FolderForm> createState() => _FolderFormState();
}

class _FolderFormState extends State<FolderForm> {
  final TextEditingController _titleContoller = TextEditingController();
  final _databaseService = DatabaseService();

  Future<void> _onSave() async {
    final title = _titleContoller.text;
    await _databaseService.insertFolder(
      FolderVanha(
        title: title,
        added: DateTime.now().toString(),
      ),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
