import 'package:objectbox/objectbox.dart';

@Entity()
class Card {
  @Id()
  int id = 0;

  String title;
  String description;

  Card({required this.title, required this.description});
}
