import 'package:cards/services/local_store.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class DeckMetaData {
  DeckMetaData({required this.description, required this.name});
  @Id()
  int id = 0;
  String name;
  String description;

  Future<int> getCount() async {
    return LocalStore.getDeckItemCount(name);
  }
}
