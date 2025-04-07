import 'package:dartz/dartz.dart';
import 'package:gasosa_app/core/errors/failure.dart';
import 'package:gasosa_app/domain/entities/refuel.dart';

abstract interface class RefuelRepository {
  Future<Either<Failure, Refuel>> addRefuel(Refuel refuel);
}
