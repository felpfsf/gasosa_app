import 'package:drift/drift.dart' as drift;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gasosa_app/data/local/dabase.dart';
import 'package:gasosa_app/data/mappers/user_mapper.dart';
import 'package:gasosa_app/domain/entities/user.dart' as domain;
import 'package:uuid/uuid.dart';

void main() {
  late GasosaDatabase db;

  setUp(() async {
    db = GasosaDatabase.forTesting(NativeDatabase.memory());
    await db.customStatement('PRAGMA foreign_keys = ON');
  });

  tearDown(() async {
    await db.close();
  });

  test('should insert and update user correctly', () async {
    final now = DateTime.now();
    final updated = DateTime.now().toUtc().copyWith(
      millisecond: 0,
      microsecond: 0,
    );

    final user = domain.User(
      id: const Uuid().v4(),
      name: 'Jon Snow',
      email: 'email@email.com',
      photoUrl: 'https://example.com/image.png',
      createdAt: now,
    );

    await db.userDao.insertOrReplaceUser(
      UsersCompanion.insert(
        id: user.id,
        name: user.name,
        email: user.email,
        photoUrl: drift.Value(user.photoUrl),
        createdAt: user.createdAt,
      ),
    );

    final loaded = await db.userDao.findUserById(user.id);

    expect(loaded, isNotNull);
    expect(loaded!.name, 'Jon Snow');
    expect(loaded.updatedAt, isNull);

    final updatedUser = user.copyWith(
      name: 'Jon Snow Updated',
      photoUrl: 'https://example.com/image-updated.png',
      updatedAt: updated,
    );

    await db.userDao.updateUser(updatedUser.toCompanion());

    final reloaded = await db.userDao.findUserById(user.id);

    expect(reloaded, isNotNull);
    expect(reloaded!.name, 'Jon Snow Updated');
    expect(reloaded.updatedAt?.millisecondsSinceEpoch, updated.millisecondsSinceEpoch);
  });
}
