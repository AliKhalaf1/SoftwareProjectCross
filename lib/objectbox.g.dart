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

import 'models/auth.dart';
import 'models/user.dart';

export 'package:objectbox/objectbox.dart'; // so that callers only have to import this file

final _entities = <ModelEntity>[
  ModelEntity(
      id: const IdUid(1, 6324978119880890039),
      name: 'Auth',
      lastPropertyId: const IdUid(3, 7958771781219981162),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 2312945438362267445),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 3532204531777365667),
            name: 'email',
            type: 9,
            flags: 2080,
            indexId: const IdUid(1, 862770701866512243)),
        ModelProperty(
            id: const IdUid(3, 7958771781219981162),
            name: 'password',
            type: 9,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(2, 4908252787234866678),
      name: 'User',
      lastPropertyId: const IdUid(7, 7100372381637242612),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 2799260197233414138),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 590757566030278686),
            name: 'email',
            type: 9,
            flags: 2080,
            indexId: const IdUid(2, 2658527413851925650)),
        ModelProperty(
            id: const IdUid(3, 3338523289187129199),
            name: 'imageUrl',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 3562410967619780751),
            name: 'firstName',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(5, 7780287094472565681),
            name: 'lastName',
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
      lastEntityId: const IdUid(2, 4908252787234866678),
      lastIndexId: const IdUid(2, 2658527413851925650),
      lastRelationId: const IdUid(0, 0),
      lastSequenceId: const IdUid(0, 0),
      retiredEntityUids: const [],
      retiredIndexUids: const [],
      retiredPropertyUids: const [5488245486567488427, 7100372381637242612],
      retiredRelationUids: const [],
      modelVersion: 5,
      modelVersionParserMinimum: 5,
      version: 1);

  final bindings = <Type, EntityDefinition>{
    Auth: EntityDefinition<Auth>(
        model: _entities[0],
        toOneRelations: (Auth object) => [],
        toManyRelations: (Auth object) => {},
        getId: (Auth object) => object.id,
        setId: (Auth object, int id) {
          object.id = id;
        },
        objectToFB: (Auth object, fb.Builder fbb) {
          final emailOffset = fbb.writeString(object.email);
          final passwordOffset = fbb.writeString(object.password);
          fbb.startTable(4);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, emailOffset);
          fbb.addOffset(2, passwordOffset);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = Auth(
              const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 6, ''),
              const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 8, ''))
            ..id = const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0);

          return object;
        }),
    User: EntityDefinition<User>(
        model: _entities[1],
        toOneRelations: (User object) => [],
        toManyRelations: (User object) => {},
        getId: (User object) => object.id,
        setId: (User object, int id) {
          object.id = id;
        },
        objectToFB: (User object, fb.Builder fbb) {
          final emailOffset = fbb.writeString(object.email);
          final imageUrlOffset = fbb.writeString(object.imageUrl);
          final firstNameOffset = fbb.writeString(object.firstName);
          final lastNameOffset = fbb.writeString(object.lastName);
          fbb.startTable(8);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, emailOffset);
          fbb.addOffset(2, imageUrlOffset);
          fbb.addOffset(3, firstNameOffset);
          fbb.addOffset(4, lastNameOffset);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = User(
              const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 6, ''),
              const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 8, ''),
              const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 10, ''),
              const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 12, ''))
            ..id = const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0);

          return object;
        })
  };

  return ModelDefinition(model, bindings);
}

/// [Auth] entity fields to define ObjectBox queries.
class Auth_ {
  /// see [Auth.id]
  static final id = QueryIntegerProperty<Auth>(_entities[0].properties[0]);

  /// see [Auth.email]
  static final email = QueryStringProperty<Auth>(_entities[0].properties[1]);

  /// see [Auth.password]
  static final password = QueryStringProperty<Auth>(_entities[0].properties[2]);
}

/// [User] entity fields to define ObjectBox queries.
class User_ {
  /// see [User.id]
  static final id = QueryIntegerProperty<User>(_entities[1].properties[0]);

  /// see [User.email]
  static final email = QueryStringProperty<User>(_entities[1].properties[1]);

  /// see [User.imageUrl]
  static final imageUrl = QueryStringProperty<User>(_entities[1].properties[2]);

  /// see [User.firstName]
  static final firstName =
      QueryStringProperty<User>(_entities[1].properties[3]);

  /// see [User.lastName]
  static final lastName = QueryStringProperty<User>(_entities[1].properties[4]);
}