import 'package:cards/models/deck_model.dart';
import 'package:flutter/material.dart';
import 'package:cards/models/card.dart' as card_model;

class DeckView extends StatefulWidget {
  const DeckView({super.key, required this.metaData});
  final DeckMetaData metaData;
  @override
  State<DeckView> createState() => _DeckViewState();
}

class _DeckViewState extends State<DeckView> {
  List<card_model.Card> cards = [];
  Set<int> cardsBeingEdited = {};
  
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
