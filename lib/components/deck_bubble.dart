import 'package:flutter/material.dart';

class DeckBubble extends StatelessWidget {
  const DeckBubble(
      {super.key,
      required this.name,
      required this.description,
      required this.cardCount});
  final String name;
  final String description;

  final int cardCount;

  

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: ElevatedButton(
          onPressed: () {},
          child: Padding(
            padding: const EdgeInsets.only(
                left: 5,
                right: 75,
                top: 20,
                bottom:
                    20), //EdgeInsets.symmetric(horizontal: 40, vertical: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name),
                Text(description),
                Text(
                    "${cardCount.toString()} ${cardCount == 1 ? "card" : "cards"} in this deck"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
