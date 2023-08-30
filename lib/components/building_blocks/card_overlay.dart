import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';

class CardOverlay extends StatelessWidget {
  const CardOverlay(
      {super.key,
      this.onCardDelete,
      this.onCardEdit,
      required this.onOverlayClose});
  final void Function()? onCardEdit;
  final void Function()? onCardDelete;
  final void Function() onOverlayClose;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all()),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GFButton(
              onPressed: onCardEdit,
              text: "Edit",
            ),
            GFButton(
              onPressed: onOverlayClose,
              text: "Close",
            ),
            GFButton(
              onPressed: onCardDelete,
              text: "Delete",
            )
          ],
        ),
      ),
    );
  }
}
