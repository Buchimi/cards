import 'package:cards/components/building_blocks/text_box.dart';
import 'package:cards/services/local_store.dart';
import 'package:flutter/material.dart';
import 'package:cards/models/card.dart' as card_model;

class CardView extends StatefulWidget {
  const CardView(
      {super.key,
      required this.card,
      this.color,
      this.width,
      this.height,
      this.deckName});

  final card_model.Card card;
  final Color? color;
  final double? width;
  final double? height;
  final String? deckName;
  @override
  State<CardView> createState() => _CardViewState();
}

class _CardViewState extends State<CardView> {
  _CardViewState();
  bool _showOverlay = false;
  bool _editMode = true;

  late card_model.Card card;

  @override
  void initState() {
    super.initState();
    card = widget.card;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width ?? 400,
      height: widget.height ?? 400,
      child: Card(
        elevation: 2.0,
        color: widget.color,
        child: Container(
          decoration: BoxDecoration(border: Border.all()),
          child: Column(
            children: (!_editMode)
                ? ([
                    Text(widget.card.title),
                    Text(widget.card.description),
                    ...(_showOverlay ? [Container()] : []),
                  ])
                : [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3.0),
                            color: Colors.grey),
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextBox(
                              initText: "Hello",
                              onChange: (val) {
                                setState(() {
                                  card.title = val;
                                });
                              },
                            )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3.0),
                            color: Colors.grey),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            decoration:
                                const InputDecoration(label: Text("Hello")),
                            onChanged: (val) {
                              setState(() {
                                card.description = val;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
          ),
        ),
      ),
    );
  }

  void toggleOverlay() {
    setState(() {
      _showOverlay = !_showOverlay;
    });
  }

  void toggleEditMode() {
    setState(() {
      _editMode = !_editMode;
      LocalStore.saveCard(card, deckname: widget.deckName);
    });
  }
}
