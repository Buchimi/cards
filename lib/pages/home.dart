import 'package:cards/components/card_view.dart';
import 'package:cards/services/card_creator.dart';
import 'package:cards/services/local_store.dart';
import 'package:cards/services/randomizer.dart';
import 'package:flutter/material.dart';
import 'package:cards/models/card.dart' as card_model;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<card_model.Card> cards = [];
  int cardIndex = 0;
  @override
  Widget build(BuildContext context) {
    if (cards.isEmpty) {
      //get cards from the store
      LocalStore.create().then((value) {
        List<card_model.Card> temp = value.getCards();

        if (temp.isNotEmpty) {
          cards = temp;
          setState(() {
            Randomizer().randomizeList(cards);
          });
        }
      });
    }
    void incrementIndex() {
      setState(() {
        cardIndex = (cardIndex + 1) % cards.length;
      });
    }

    void decrementIndex() {
      setState(() {
        cardIndex = (cards.length + cardIndex - 1) % cards.length;
      });
    }

    List<Widget> generatePage() {
      List<Widget> widgets = [const Text("Homepage")];
      if (cards.isEmpty) {
        widgets.add(const Text(
            """Seems like you're missing some cards bud, how about adding a new card?
"""));
      } else {
        widgets.addAll(
          [
            CardView(card: cards[cardIndex]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
              ElevatedButton(
                onPressed: () {
                  decrementIndex();
                },
                child: const Text("Left"),
              ),
              ElevatedButton(
                onPressed: incrementIndex,
                child: const Text("Right"),
              )
            ],)
          ],
        );
      }

      widgets.add(CardCreator(
        oncardCreate: (card) {
          LocalStore.saveCard(card).then(
            (value) {
              setState(() {
                cards.add(card);
              });
            },
          );
        },
      ));

      widgets.add(ElevatedButton(
          onPressed: () {
            setState(() {
              LocalStore.create().then((value) {
                value.deleteAllCards();
                cards = [];
                cardIndex = 0;
              });
            });
          },
          child: const Text("Delete everything")));

      return widgets;
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: generatePage(),
      ),
    );
  }
}
