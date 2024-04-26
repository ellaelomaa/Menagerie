import 'package:flutter/material.dart';
import 'package:lists/vanhat/database/db_service.dart';
import 'package:lists/vanhat/database/models/folder.dart';
import 'dart:math' as math;

class Notes extends StatefulWidget {
  const Notes({super.key});

  @override
  State<Notes> createState() => _NotesState();

  void setCurrentFolderId(int parse) {}
}

class _NotesState extends State<Notes> {
  var _folderNameController = TextEditingController();
  final DatabaseService _databaseService = DatabaseService();

  Future<List<FolderVanha>> _getFolders() async {
    return await _databaseService.folders();
  }

  _newFolderForm(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (param) {
        return AlertDialog(
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                _onSave();
              },
              child: Text("Save"),
            ),
          ],
          title: Text("Create a new folder"),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextField(
                  controller: _folderNameController,
                  decoration: InputDecoration(
                      hintText: "Enter folder name", labelText: "Title"),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _onSave() async {
    final title = _folderNameController.text;

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
    return Scaffold(
      appBar: AppBar(
        title: Text("Notes"),
      ),
      body: Container(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [Text("Folders")],
        ),
      ),
      floatingActionButton: ExpandableFab(
        distance: 112,
        children: [
          ActionButton(
            text: "Note",
            icon: Icon(Icons.edit_note),
            onPressed: () {},
          ),
          ActionButton(
            text: "Folder",
            icon: Icon(Icons.folder),
            onPressed: () {
              _newFolderForm(context);
            },
          ),
        ],
      ),
    );
  }
}

@immutable
class ExpandableFab extends StatefulWidget {
  const ExpandableFab({
    super.key,
    this.initialOpen,
    required this.distance,
    required this.children,
  });

  final bool? initialOpen;
  final double distance;
  final List<Widget> children;

  @override
  State<ExpandableFab> createState() => _ExpandableFabState();
}

class _ExpandableFabState extends State<ExpandableFab>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _expandAnimation;
  bool _open = false;

  @override
  void initState() {
    super.initState();
    _open = widget.initialOpen ?? false;
    _controller = AnimationController(
      value: _open ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
    _expandAnimation = CurvedAnimation(
      curve: Curves.fastOutSlowIn,
      reverseCurve: Curves.easeOutQuad,
      parent: _controller,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _open = !_open;
      if (_open) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        alignment: Alignment.bottomRight,
        clipBehavior: Clip.none,
        children: [
          _buildTapToCloseFab(),
          ..._buildExpandingActionButtons(),
          _buildTapToOpenFab(),
        ],
      ),
    );
  }

  Widget _buildTapToCloseFab() {
    return SizedBox(
      width: 56,
      height: 56,
      child: Center(
        child: Material(
          shape: const CircleBorder(),
          clipBehavior: Clip.antiAlias,
          elevation: 4,
          child: InkWell(
            onTap: _toggle,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Icon(
                Icons.close,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildExpandingActionButtons() {
    final children = <Widget>[];
    final count = widget.children.length;
    final step = 90.0 / (count - 1);
    for (var i = 0, angleInDegrees = 0.0;
        i < count;
        i++, angleInDegrees += step) {
      children.add(
        _ExpandingActionButton(
          directionInDegrees: angleInDegrees,
          maxDistance: widget.distance,
          progress: _expandAnimation,
          child: widget.children[i],
        ),
      );
    }
    return children;
  }

  Widget _buildTapToOpenFab() {
    return IgnorePointer(
      ignoring: _open,
      child: AnimatedContainer(
        transformAlignment: Alignment.center,
        transform: Matrix4.diagonal3Values(
          _open ? 0.7 : 1.0,
          _open ? 0.7 : 1.0,
          1.0,
        ),
        duration: const Duration(milliseconds: 250),
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
        child: AnimatedOpacity(
          opacity: _open ? 0.0 : 1.0,
          curve: const Interval(0.25, 1.0, curve: Curves.easeInOut),
          duration: const Duration(milliseconds: 250),
          child: FloatingActionButton(
            onPressed: _toggle,
            child: const Icon(Icons.create),
          ),
        ),
      ),
    );
  }
}

@immutable
class _ExpandingActionButton extends StatelessWidget {
  const _ExpandingActionButton({
    required this.directionInDegrees,
    required this.maxDistance,
    required this.progress,
    required this.child,
  });

  final double directionInDegrees;
  final double maxDistance;
  final Animation<double> progress;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: progress,
      builder: (context, child) {
        final offset = Offset.fromDirection(
          directionInDegrees * (math.pi / 180.0),
          progress.value * maxDistance,
        );
        return Positioned(
          right: 4.0 + offset.dx,
          bottom: 4.0 + offset.dy,
          child: Transform.rotate(
            angle: (1.0 - progress.value) * math.pi / 2,
            child: child!,
          ),
        );
      },
      child: FadeTransition(
        opacity: progress,
        child: child,
      ),
    );
  }
}

@immutable
class ActionButton extends StatelessWidget {
  const ActionButton({
    super.key,
    this.onPressed,
    required this.text,
    required this.icon,
  });

  final VoidCallback? onPressed;
  final Widget icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Container(padding: EdgeInsets.all(8), child: Text(text)),
        Material(
          shape: const CircleBorder(),
          clipBehavior: Clip.antiAlias,
          color: theme.colorScheme.secondary,
          elevation: 4,
          child: IconButton(
            onPressed: onPressed,
            icon: icon,
            color: theme.colorScheme.onSecondary,
          ),
        ),
      ],
    );
  }
}

// @immutable
// class FakeItem extends StatelessWidget {
//   const FakeItem({
//     super.key,
//     required this.isBig,
//   });

//   final bool isBig;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
//       height: isBig ? 128 : 36,
//       decoration: BoxDecoration(
//         borderRadius: const BorderRadius.all(Radius.circular(8)),
//         color: Colors.grey.shade300,
//       ),
//     );
//   }
// }
