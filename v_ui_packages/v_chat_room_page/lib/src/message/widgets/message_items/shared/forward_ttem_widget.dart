import 'package:flutter/material.dart';
import 'package:textless/textless.dart';

class ForwardItemWidget extends StatelessWidget {
  final bool isFroward;

  const ForwardItemWidget({
    Key? key,
    required this.isFroward,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!isFroward) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(bottom: 3),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Icon(
            Icons.forward,
            color: Colors.grey,
            size: 18,
          ),
          const SizedBox(
            width: 6,
          ),
          "Forwarded".cap.color(Colors.grey)
        ],
      ),
    );
  }
}
