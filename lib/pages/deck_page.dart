import 'package:cards/components/deck_bubble.dart';
import 'package:cards/services/local_store.dart';
import 'package:flutter/material.dart';

class DeckPage extends StatefulWidget {
  const DeckPage({super.key});

  @override
  State<DeckPage> createState() => _DeckPageState();
}

class _DeckPageState extends State<DeckPage> {
  List<DeckBubble> decks = [];

  bool equals(List<DeckBubble> left, List<DeckBubble> right) {
    if (left.length == right.length) {
      for (int i = 0; i < left.length; i++) {
        if (left[i].name != right[i].name ||
            left[i].cardCount != right[i].cardCount) {
          return false;
        }
      }
      return true;
    } else {
      return false;
    }
  }

  Future<void> generateDeckList() async {
    if (decks.isEmpty) {
      decks = [
        const DeckBubble(
          name: "First",
          description: "Just for testing",
          cardCount: 1,
        )
      ];
    }

    var intermediary = (await LocalStore.getDecks());
    print("Dekcs retrieved");
    List<DeckBubble> list = [];
    for (var meta in intermediary) {
      int count = await meta.getCount();
      print("retrived deck count for deck ${meta.name} as count = $count");
      list.add(
        DeckBubble(
          name: meta.name,
          description: meta.description,
          cardCount: count,
        ),
      );
    }
    
    if (list.isNotEmpty && !equals(list, decks)) {
      setState(() {
        decks = list;
      });
    }
    print("just to make sure");
  }

  void createDeck(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext ctx) {
          String deckName = "";
          String deckDescription = "";
          return Column(
            children: [
              const Text("Create a deck"),
              TextField(
                decoration: const InputDecoration(
                    hintText: "Choose a name for this deck",
                    labelText: "Deck name"),
                onChanged: (value) => deckName = value,
              ),
              TextField(
                decoration: const InputDecoration(
                    hintText: "Describe this deck",
                    labelText: "Deck description"),
                onChanged: (value) => deckDescription = value,
              ),
              ElevatedButton(
                  onPressed: () {
                    print(
                        "Deck named $deckName will be saved with description $deckDescription");
                    LocalStore.saveDeck(deckName,
                            deckDescription: deckDescription)
                        .then((value) {
                      generateDeckList();
                    });
                  },
                  child: const Text("Create Deck"))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...() {
          generateDeckList();
          return decks;
        }(),
        ElevatedButton(
            onPressed: () {
              createDeck(context);
            },
            child: const Padding(
              padding: EdgeInsets.all(8),
              child: Text("Add a Deck"),
            ))
      ],
    );
  }
}
