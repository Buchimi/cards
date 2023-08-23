// GENERATED CODE - DO NOT MODIFY BY HAND
// This code was generated by ObjectBox. To update it run the generator again:
// With a Flutter package, run `flutter pub run build_runner build`.
// With a Dart package, run `dart run build_runner build`.
// See also https://docs.objectbox.io/getting-started#generate-objectbox-code

// ignore_for_file: camel_case_types, depend_on_referenced_packages
// coverage:ignore-file

import 'dart:typed_data';

import 'package:flat_buffers/flat_buffers.dart' as fb;
import 'package:objectbox/internal.dart'; // generated code can access "internal" functionality
import 'package:objectbox/objectbox.dart';
import 'package:objectbox_flutter_libs/objectbox_flutter_libs.dart';

import 'models/card.dart';
import 'models/deck_model.dart';

export 'package:objectbox/objectbox.dart'; // so that callers only have to import this file

final _entities = <ModelEntity>[
  ModelEntity(
      id: const IdUid(1, 8471217862712841454),
      name: 'Card',
      lastPropertyId: const IdUid(3, 1945038107016449165),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 2860687899224406723),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 3990337872619158245),
            name: 'title',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 1945038107016449165),
            name: 'description',
            type: 9,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(2, 9004859245211294043),
      name: 'DeckMetaData',
      lastPropertyId: const IdUid(3, 474452037626592917),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 7710191612193441944),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 7003323922430928201),
            name: 'name',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 474452037626592917),
            name: 'description',
            type: 9,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[])
];

/// Open an ObjectBox store with the model declared in this file.
Future<Store> openStore(
        {String? directory,
        int? maxDBSizeInKB,
        int? fileMode,
        int? maxReaders,
        bool queriesCaseSensitiveDefault = true,
        String? macosApplicationGroup}) async =>
    Store(getObjectBoxModel(),
        directory: directory ?? (await defaultStoreDirectory()).path,
        maxDBSizeInKB: maxDBSizeInKB,
        fileMode: fileMode,
        maxReaders: maxReaders,
        queriesCaseSensitiveDefault: queriesCaseSensitiveDefault,
        macosApplicationGroup: macosApplicationGroup);

/// ObjectBox model definition, pass it to [Store] - Store(getObjectBoxModel())
ModelDefinition getObjectBoxModel() {
  final model = ModelInfo(
      entities: _entities,
      lastEntityId: const IdUid(2, 9004859245211294043),
      lastIndexId: const IdUid(0, 0),
      lastRelationId: const IdUid(0, 0),
      lastSequenceId: const IdUid(0, 0),
      retiredEntityUids: const [],
      retiredIndexUids: const [],
      retiredPropertyUids: const [],
      retiredRelationUids: const [],
      modelVersion: 5,
      modelVersionParserMinimum: 5,
      version: 1);

  final bindings = <Type, EntityDefinition>{
    Card: EntityDefinition<Card>(
        model: _entities[0],
        toOneRelations: (Card object) => [],
        toManyRelations: (Card object) => {},
        getId: (Card object) => object.id,
        setId: (Card object, int id) {
          object.id = id;
        },
        objectToFB: (Card object, fb.Builder fbb) {
          final titleOffset = fbb.writeString(object.title);
          final descriptionOffset = fbb.writeString(object.description);
          fbb.startTable(4);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, titleOffset);
          fbb.addOffset(2, descriptionOffset);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = Card(
              title: const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 6, ''),
              description: const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 8, ''))
            ..id = const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0);

          return object;
        }),
    DeckMetaData: EntityDefinition<DeckMetaData>(
        model: _entities[1],
        toOneRelations: (DeckMetaData object) => [],
        toManyRelations: (DeckMetaData object) => {},
        getId: (DeckMetaData object) => object.id,
        setId: (DeckMetaData object, int id) {
          object.id = id;
        },
        objectToFB: (DeckMetaData object, fb.Builder fbb) {
          final nameOffset = fbb.writeString(object.name);
          final descriptionOffset = fbb.writeString(object.description);
          fbb.startTable(4);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, nameOffset);
          fbb.addOffset(2, descriptionOffset);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = DeckMetaData(
              description: const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 8, ''),
              name: const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 6, ''))
            ..id = const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0);

          return object;
        })
  };

  return ModelDefinition(model, bindings);
}

/// [Card] entity fields to define ObjectBox queries.
class Card_ {
  /// see [Card.id]
  static final id = QueryIntegerProperty<Card>(_entities[0].properties[0]);

  /// see [Card.title]
  static final title = QueryStringProperty<Card>(_entities[0].properties[1]);

  /// see [Card.description]
  static final description =
      QueryStringProperty<Card>(_entities[0].properties[2]);
}

/// [DeckMetaData] entity fields to define ObjectBox queries.
class DeckMetaData_ {
  /// see [DeckMetaData.id]
  static final id =
      QueryIntegerProperty<DeckMetaData>(_entities[1].properties[0]);

  /// see [DeckMetaData.name]
  static final name =
      QueryStringProperty<DeckMetaData>(_entities[1].properties[1]);

  /// see [DeckMetaData.description]
  static final description =
      QueryStringProperty<DeckMetaData>(_entities[1].properties[2]);
}