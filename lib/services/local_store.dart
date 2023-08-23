import 'dart:io';
import 'package:cards/models/card.dart';
import 'package:cards/models/deck_model.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:cards/objectbox.g.dart';

class LocalStore {
  late final Store store;

  static const defaultStorePath = "Home";
  static String? appDir;
  static final Map<String, Store> _stores = {};

  LocalStore._create(this.store) {
    // Add any additional setup code, e.g. build queries.
  }

  /// Creates a Deck and a store for that deck
  /// The base path id appdocdir/Store
  /// This is where the metadata is stored.
  /// Decks are stored in sub directories to appdocdir/Store
  /// The default is appdocdir/Store/Home
  /// Passing in Home is the same as not passing in a dir
  static Future<LocalStore> create(
      {String? dir, bool forMetaData = false}) async {
    final docsDir = await getApplicationDocumentsDirectory();
    // Future<Store> openStore() {...} is defined in the generated objectbox.g.dart

    appDir ??= p.join(docsDir.path, "Store");

    String storePath;

    // Create directory if needed
    if (forMetaData) {
      storePath = appDir!;
    } else {
      storePath = p.join(appDir!, dir ?? defaultStorePath);
    }
    await Directory(appDir!).create(recursive: true);
    print("1");
    //Create a store
    if (_stores.containsKey(storePath)) {
      return LocalStore._create(_stores[storePath]!);
    } else {
      _stores[storePath] = await openStore(directory: storePath);

      final store = _stores[storePath]!;

      return LocalStore._create(store);
    }
  }

  static String _getRelativeFromAbsolute(String absolutePath) {
    int start = absolutePath.lastIndexOf("/") + 1;
    if (start == 0) {
      throw Error();
    }
    print("2");
    return absolutePath.substring(start);
  }

  static Future saveCard(Card card, {String? deckname}) async {
    //int result = store.box<Card>().put(card, mode: PutMode.insert);

    //String deckName = _getRelativeFromAbsolute(store.directoryPath);
    deckname ??= defaultStorePath;
    var meta = await findDeckData(deckname);
    if (meta == null) {
      saveDeck(deckname, deckDescription: "This deck was created on card creation");
    }
    // Passing in dir == Home is the same as not passing in a dir
    var box = (await LocalStore.create(dir: deckname)).store.box<Card>();
    box.put(card);
  }

  static Future<int> getDeckItemCount(String deckName) async {
    var store = await LocalStore.create(dir: deckName);
    print("3");
    return store.store.box<Card>().count();
  }

  List<Card> getCards() {
    print("4");
    return store.box<Card>().getAll();
  }

  int deleteAllCards() {
    return store.box<Card>().removeAll();
  }

  int numCards() {
    return store.box<Card>().count();
  }

  /// This function get's the box that stores all the metadata
  /// It is a utility function
  static Future<Box<DeckMetaData>> _getMetadataBox() async {
    LocalStore store = await LocalStore.create(forMetaData: true);
    return store.store.box<DeckMetaData>();
  }

  /// The purpose of this function is to get the deck
  /// names from the metadata box
  static Future<List<DeckMetaData>> getDecks() async {
    //return tree.getAllDecks(appDir!);
    var box = await _getMetadataBox();
    return box.getAll();
  }

  /// Creates a deck
  /// This is done by creating a deck folder and
  /// Saving the deck metadata in the "Store" folder
  static Future<LocalStore> saveDeck(String deckName,
      {String? deckDescription}) async {
    // Save the metadata of this deck in root
    saveDeckMetaData(deckName, deckDescription ?? "");

    // Create deck folder
    return create(dir: deckName);
  }

  /// This Document creates meta data for a deck
  static void saveDeckMetaData(String deckName, String deckDescription) async {
    //LocalStore store = await LocalStore.create(forMetaData: true);
    var box = await _getMetadataBox();
    if (box.query(DeckMetaData_.name.equals(deckName)).build().findFirst() ==
        null) {
      //no decks that fit this description. make a new one
      DeckMetaData metaData =
          DeckMetaData(description: deckDescription, name: deckName);

      box.put(metaData);
    }
  }

  /// This function tries to find the metadata of a deck
  /// This is done by querying by name
  static Future<DeckMetaData?> findDeckData(String deckName) async {
    var box = await _getMetadataBox();
    var condition = DeckMetaData_.name.equals(deckName);
    return box.query(condition).build().findFirst();
  }

  /// This function returns the cards in an existing deck
  Future<List<Card>> traverseDeck(String deckName) async {
    // This function must check if the deck already exists

    // if it does, good. open the deck. if not, throw and error
    throw UnimplementedError();
    //LocalStore store = await create(dir: deckName);
    // return store.getCards();
  }

  // This function deletes a deck by deckname
  static Future<bool> deleteDeck(String deckName) async {
    // Deleting a deck can be accomplished
    // By deleting the directory

    String dirName = p.join(appDir!, deckName);

    Directory dir = Directory(dirName);

    try {
      dir.deleteSync(recursive: true);
      // delete deck metadata
      DeckMetaData? data = await LocalStore.findDeckData(deckName);

      if (data != null) {
        // delete the data
        var box = await _getMetadataBox();
        box.remove(data.id);
      }
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static String getAppDir() {
    return appDir!;
  }

  /// This function is the nuclear bomb
  static void cleanAll() async {
    // loop through every directory in dir/store
    String path =
        p.join((await getApplicationDocumentsDirectory()).path, "Store");

    var dir = Directory(path);
    await dir.delete(recursive: true);

    if (await dir.exists()) {
      print("directory not deleted");
    } else {
      print("Directory was deleted. Making a new one");
      dir.create();
    }
  }
}
