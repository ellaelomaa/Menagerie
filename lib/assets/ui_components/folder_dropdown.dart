import 'package:flutter/material.dart';
import 'package:lists/database/db_helper.dart';
import 'package:lists/database/models/folder_model.dart';

class FoldersDropdown extends StatefulWidget {
  const FoldersDropdown({super.key, required this.onClicked});

  method() => createState().updateDropdownmenu();
  final Function onClicked;

  @override
  _FoldersDropdownState createState() => _FoldersDropdownState();
}

class _FoldersDropdownState extends State<FoldersDropdown> {
  late List<DropdownMenuItem<String>> list;
  int? currentFolderId = 1;
  String? dropdownValue;

  updateDropdownmenu() {
    list = [];
    DatabaseHelper.instance.getFolders().then(
      (value) {
        value.map((map) {
          return getDropdownWidget(map);
        }).forEach(
          (element) {
            list.add(element);
          },
        );
        setState(() {});
      },
    );
  }

  DropdownMenuItem<String> getDropdownWidget(Folder folder) {
    return DropdownMenuItem<String>(
      value: folder.id.toString(),
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Text(folder.name),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    updateDropdownmenu();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(flex: 1, child: Text("Select folder:")),
        Expanded(
          flex: 2,
          child: DropdownButtonFormField<String>(
            hint: const Text("Select folder"),
            onChanged: (value) {
              widget.onClicked(
                int.parse(value!),
              );
              updateDropdownmenu();
            },
            items: list,
            isExpanded: true,
            itemHeight: null,
          ),
        ),
      ],
    );
  }
}
