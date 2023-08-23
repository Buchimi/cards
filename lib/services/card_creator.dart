import 'package:flutter/material.dart';
import 'package:cards/models/card.dart' as card_model;

class CardCreator extends StatelessWidget {
  CardCreator({super.key, required this.oncardCreate});

  final Function(card_model.Card) oncardCreate;
  static const String title = "title";
  static const String description = "description";
  final Map<String, String> map = {title: "", description: ""};
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (ctx) {
                return Column(
                  children: [
                    TextField(
                      decoration:
                          const InputDecoration(label: Text("Card Title")),
                      onChanged: (value) {
                        map.addAll({title: value});
                      },
                    ),
                    TextField(
                      decoration: const InputDecoration(
                          label: Text("Card Description")),
                      onChanged: (value) {
                        map.addAll({description: value});
                      },
                    ),
                    Row(
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              oncardCreate(card_model.Card(
                                  title: map[title] ?? "",
                                  description: map[description] ?? ""));
                            },
                            child: const Text("Save your Card"))
                      ],
                    )
                  ],
                );
              });
        },
        child: const Text("Add a card"));
  }
}
