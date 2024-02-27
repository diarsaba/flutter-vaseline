import 'package:flutter/material.dart';

class ListDismiss extends StatelessWidget {
  final Icon rightIcon;
  final Icon leftIcon;
  //final VoidCallback Function(int index) onRight;
  //final VoidCallback Function(int index) onLeft;
  final Function(int index) onRight;
  final Function(int index) onLeft;
  final List<dynamic> list;
  final Function(int index) childIndex;
  final DismissDirection direction;
  final bool reverse;

  const ListDismiss({
    super.key,
    required this.rightIcon,
    required this.leftIcon,
    required this.onRight,
    required this.onLeft,
    required this.list, 
    required this.childIndex, required this.direction, required this.reverse,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (_, i) {
        return Dismissible(
          secondaryBackground: const Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(
                Icons.archive_outlined,
                size: 40,
                color: Colors.green,
              ),
            ],
          ),
          background: const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.delete_rounded,
                size: 40,
                color: Colors.red,
              ),
            ],
          ),
          key: UniqueKey(),
          direction: direction,
          // direction: (textController.text.isEmpty
          //     ? DismissDirection.horizontal
          //     : DismissDirection.startToEnd),
          onDismissed: (direction) {
            if (direction == DismissDirection.startToEnd) {
              onRight(i);
            } else if (direction == DismissDirection.endToStart) {
              onLeft(i);
            }
          },
          child: childIndex(i)
        );
      },
      itemCount: list.length,
      reverse: reverse,
    );
  }

}
