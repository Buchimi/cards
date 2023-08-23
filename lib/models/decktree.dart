// Deprecated

// There is only one deck tree.
import 'dart:io';

class DeckTree {
  static final List<String> _decks = [];

  List<String> getAllDecks(String path) {
    if (_decks.isEmpty) {
      //retrieve from memory
      
      Directory dir = Directory(path);  //Root of the tree
      int firstIndex = path.length + 1; //After index of last slash


      for (var subDir in dir.listSync()) {
        // Grabs the substring
        // from after the first slash to the end
        String name = subDir.path.substring(firstIndex);
        _decks.add(name);
      }

    }
    return _decks;
  }

  void saveDeck(String deckName) {
    _decks.add(deckName); // Add it to the cache
    
  }

  
}
