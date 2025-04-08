import 'package:drift/drift.dart';
import 'package:gasosa_app/data/local/dabase.dart';

import 'tables/users.dart';

part 'user_dao.g.dart';

@DriftAccessor(tables: [Users])
class UserDao extends DatabaseAccessor<GasosaDatabase> with _$UserDaoMixin {
  UserDao(super.db);

  Future<void> insertOrReplaceUser(UsersCompanion user) async {
    await into(users).insertOnConflictUpdate(user);
  }

  Future<User?> findUserById(String id) async {
    final query =
        await (select(users)
          ..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
    if (query == null) return null;

    return User(
      id: query.id,
      name: query.name,
      email: query.email,
      createdAt: query.createdAt,
      updatedAt: query.updatedAt,
    );
  }

  Future<void> updateUser(UsersCompanion entry) async {
    await update(users).replace(entry);
  }
}
