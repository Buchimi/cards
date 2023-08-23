import 'package:flutter/material.dart';
import 'package:cards/models/card.dart' as card_model;

class CardView extends StatelessWidget {
  const CardView({super.key, required this.card, this.color});

  final card_model.Card card;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      height: 400,
      child: Card(
        elevation: 2.0,
        color: color ?? Colors.amber,
        child: Column(
          children: [Text(card.title), Text(card.description)],
        ),
      ),
    );
  }
}
