import 'package:drift/drift.dart';
import 'package:gasosa_app/data/local/dabase.dart';
import 'package:gasosa_app/domain/entities/user.dart' as domain;

extension UserMapper on domain.User {
  UsersCompanion toCompanion() {
    return UsersCompanion(
      id: Value(id),
      name: Value(name),
      email: Value(email),
      photoUrl: Value(photoUrl),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }
}

extension UserDataTodomain on User {
  domain.User toDomain() {
    return domain.User(
      id: id,
      name: name,
      email: email,
      photoUrl: photoUrl,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
  