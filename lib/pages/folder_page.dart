// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:menagerie_provider/assets/ui_components/app_bar.dart';
import 'package:menagerie_provider/assets/ui_components/fab.dart';
import 'package:menagerie_provider/assets/ui_components/folder_dropdown.dart';
import 'package:menagerie_provider/assets/ui_components/folder_row.dart';
import 'package:menagerie_provider/database/models/folder_model.dart';
import 'package:menagerie_provider/providers/folder_provider.dart';
import 'package:provider/provider.dart';

class FolderPage extends StatelessWidget {
  const FolderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar("Folders"),
      floatingActionButton: FAB(),
      body: Consumer<FolderProvider>(
        builder: (context, provider, child) {
          var folders = provider.folders;
          return Column(
            children: <Widget>[
              FoldersDropdown(),
              Expanded(
                child: ListView.builder(
                  itemCount: folders.length,
                  itemBuilder: (context, index) {
                    var folder = folders[index];
                    return FolderRow(folder: folder);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

// class FoldersPage extends StatefulWidget {
//   const FoldersPage({super.key});

//   @override
//   State<FoldersPage> createState() => _FoldersPageState();
// }

// class _FoldersPageState extends State<FoldersPage> {
//   @override
//   void initState() {
//     super.initState();
//   }

//   getFolders() async {
//     var folders = Provider.of<FolderProvider>(context, listen: false).folders;
//     return folders;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppBar("Folders"),
//       body: buildFolderColumn(),
//       floatingActionButton: FAB(),
//     );
//   }

//   Padding buildFolderColumn() {
//     return Padding(
//       padding: const EdgeInsets.all(8),
//       child: Consumer<FolderProvider>(
//         builder: (context, provider, child) => FutureBuilder(
//           future: getFolders(),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return CircularProgressIndicator();
//             }
//             if (!snapshot.hasData) {
//               return Center(
//                 child: Text("No folders yet!"),
//               );
//             }
//             if (snapshot.hasData) {
//               return Column(
//                 children: [
//                   Text(provider.folders.length.toString()),
//                   FoldersDropdown(),
//                   Expanded(
//                     child: ListView.separated(
//                         itemBuilder: (context, index) {
//                           final item = provider.folders[index];
//                           return FolderRow(id: item.id);
//                         },
//                         separatorBuilder: (BuildContext context, int index) =>
//                             Divider(
//                               thickness: 2,
//                               indent: 20,
//                               endIndent: 20,
//                             ),
//                         physics: BouncingScrollPhysics(),
//                         itemCount: provider.folders.length),
//                   ),
//                 ],
//               );
//             } else {
//               return Text("Error :(");
//             }
//           },
//         ),
//       ),
//     );
//   }
// }

// class ListViewItemWidget extends StatelessWidget {
//   const ListViewItemWidget({
//     super.key,
//     required this.item,
//   });

//   final FolderModel item;

//   @override
//   Widget build(BuildContext context) {
//     final width = MediaQuery.of(context).size.width;
//     final height = MediaQuery.of(context).size.height;
//     return Card(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(width * 0.03),
//       ),
//       color: Colors.white,
//       margin: EdgeInsets.symmetric(
//         horizontal: width * 0.03,
//         vertical: height * 0.01,
//       ),
//       elevation: 3,
//       child: ListTile(
//         style: ListTileStyle.drawer,
//         title: Text(item.title),
//         subtitle: Text(
//           item.title,
//           style: TextStyle(
//             color: Colors.grey[600],
//           ),
//         ),
//         trailing: Text(
//           item.added,
//           style: const TextStyle(fontWeight: FontWeight.bold),
//         ),
//       ),
//     );
//   }
// }

// class DismissBackGround extends StatelessWidget {
//   final Color color;
//   final Alignment alignment;
//   final IconData iconData;

//   const DismissBackGround({
//     super.key,
//     required this.color,
//     required this.alignment,
//     required this.iconData,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final width = MediaQuery.of(context).size.width;
//     final height = MediaQuery.of(context).size.height;
//     return Container(
//       margin: EdgeInsets.all(width * 0.02),
//       padding: EdgeInsets.all(width * 0.03),
//       decoration: BoxDecoration(
//         color: color,
//         borderRadius: BorderRadius.circular(width * 0.03),
//       ),
//       alignment: alignment,
//       height: height * 0.02,
//       width: width,
//       child: Icon(
//         iconData,
//         color: Colors.white,
//       ),
//     );
//   }
// }

// class DeleteDialog extends StatelessWidget {
//   const DeleteDialog({
//     super.key,
//     required this.helperValue,
//   });

//   final FolderModel helperValue;

//   @override
//   Widget build(BuildContext context) {
//     final todoProvider = Provider.of<FolderProvider>(context, listen: false);
//     final width = MediaQuery.of(context).size.width;
//     final height = MediaQuery.of(context).size.height;
//     return AlertDialog(
//       scrollable: true,
//       title: const Text('Delete'),
//       content: const Text('Do you want to delete it?'),
//       actions: [
//         Row(
//           children: [
//             Expanded(
//               child: Padding(
//                 padding: EdgeInsets.all(width * 0.02),
//                 child: ElevatedButton(
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                   child: const Text('Yes'),
//                 ),
//               ),
//             ),
//             Expanded(
//               child: Padding(
//                 padding: EdgeInsets.all(width * 0.02),
//                 child: ElevatedButton(
//                   style:
//                       ElevatedButton.styleFrom(backgroundColor: Colors.white),
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                   child: Text(
//                     'No',
//                     style: TextStyle(
//                       color: Theme.of(context).primaryColor,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         )
//       ],
//     );
//   }
// }

// class DeleteTableDialog extends StatelessWidget {
//   const DeleteTableDialog({
//     super.key,
//     required this.todoP,
//   });

//   final FolderProvider todoP;

//   @override
//   Widget build(BuildContext context) {
//     final width = MediaQuery.of(context).size.width;
//     final height = MediaQuery.of(context).size.height;
//     return AlertDialog(
//       scrollable: true,
//       title: const Text('Delete All'),
//       content: const Text('Do you want to delete all data?'),
//       actions: [
//         Row(
//           children: [
//             Expanded(
//               child: Padding(
//                 padding: EdgeInsets.all(width * 0.02),
//                 child: ElevatedButton(
//                   onPressed: () async {
//                     Navigator.pop(context);
//                   },
//                   child: const Text('Yes'),
//                 ),
//               ),
//             ),
//             Expanded(
//               child: Padding(
//                 padding: EdgeInsets.all(width * 0.02),
//                 child: ElevatedButton(
//                   style:
//                       ElevatedButton.styleFrom(backgroundColor: Colors.white),
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                   child: Text(
//                     'No',
//                     style: TextStyle(
//                       color: Theme.of(context).primaryColor,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }
