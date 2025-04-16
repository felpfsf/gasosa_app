import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gasosa_app/core/errors/failure.dart';
import 'package:gasosa_app/domain/entities/refuel.dart';
import 'package:gasosa_app/domain/usecases/refuel/add_refuel_usecase.dart';
import 'package:gasosa_app/domain/usecases/refuel/delete_refuel_usecase.dart';
import 'package:gasosa_app/domain/usecases/refuel/find_refuel_by_id_usecase.dart';
import 'package:gasosa_app/domain/usecases/refuel/update_refuel_usecase.dart';
import 'package:gasosa_app/domain/usecases/refuel/watch_all_refuels_by_vehicle_id_usecase.dart';
import 'package:gasosa_app/presentation/cubits/refuel/refuel_cubit.dart';
import 'package:gasosa_app/presentation/cubits/refuel/refuel_state.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uuid/uuid.dart';

import '../../../mocks/fallbacks_values.dart';
import '../../../mocks/mock_classes.dart';

void main() {
  late RefuelCubit refuelCubit;
  late IWatchAllRefuelsByVehicleIdUsecase watchAllRefuelsByVehicleIdUsecase;
  late IAddRefuelUsecase addRefuelUsecase;
  late IUpdateRefuelUsecase updateRefuelUsecase;
  late IDeleteRefuelUsecase deleteRefuelUsecase;
  late IFindRefuelByIdUsecase findRefuelByIdUsecase;

  final vehicleId = const Uuid().v4();
  final refuel = Refuel(
    id: const Uuid().v4(),
    vehicleId: vehicleId,
    date: DateTime.now(),
    fuelType: 'gasoline',
    odometer: 100,
    liters: 100,
    totalValue: 100,
    isSynced: false,
    createdBy: 'John Doe',
    createdAt: DateTime.now(),
  );

  setUpAll(() {
    registerFallbacks();
  });

  setUp(() {
    watchAllRefuelsByVehicleIdUsecase = MocktchAllRefuelsByVehicleIdUsecase();
    addRefuelUsecase = MockAddRefuelUsecase();
    updateRefuelUsecase = MockUpdateRefuelUsecase();
    deleteRefuelUsecase = MockDeleteRefuelUsecase();
    findRefuelByIdUsecase = MockFindRefuelByIdUsecase();

    refuelCubit = RefuelCubit(
      addRefuelUsecase,
      deleteRefuelUsecase,
      findRefuelByIdUsecase,
      updateRefuelUsecase,
      watchAllRefuelsByVehicleIdUsecase,
    );
  });

  group('RefuelCubit', () {
    blocTest<RefuelCubit, RefuelState>(
      'emits [loading, loaded] when watch stream refuels.',
      build: () {
        when(
          () => watchAllRefuelsByVehicleIdUsecase(vehicleId),
        ).thenAnswer((_) => Stream.value([refuel]));

        return refuelCubit;
      },
      act: (cubit) => cubit.watchRefuels(vehicleId),
      expect:
          () => [
            const RefuelState.loading(),
            RefuelState.loaded([refuel]),
          ],
      verify: (_) {
        verify(() => watchAllRefuelsByVehicleIdUsecase(vehicleId)).called(1);
      },
    );

    blocTest<RefuelCubit, RefuelState>(
      'emits [loading, loaded] when addRefuel is successful',
      build: () {
        when(
          () => addRefuelUsecase(refuel),
        ).thenAnswer((_) => Future.value(Right(refuel)));

        return refuelCubit;
      },
      act: (cubit) => cubit.addRefuel(refuel),
      expect:
          () => [
            const RefuelState.loading(),
            RefuelState.success('Refuel added successfully'),
          ],
      verify: (_) {
        verify(() => addRefuelUsecase(refuel)).called(1);
      },
    );

    blocTest<RefuelCubit, RefuelState>(
      'emits [loading, error] when addRefuel fails',
      build: () {
        when(
          () => addRefuelUsecase(refuel),
        ).thenAnswer((_) => Future.value(Left(DatabaseFailure('error'))));

        return refuelCubit;
      },
      act: (cubit) => cubit.addRefuel(refuel),
      expect:
          () => [
            const RefuelState.loading(),
            RefuelState.error(message: 'error'),
          ],
      verify: (_) {
        verify(() => addRefuelUsecase(refuel)).called(1);
      },
    );

    blocTest<RefuelCubit, RefuelState>(
      'emits [loading, success] when updateRefuel is successful',
      build: () {
        when(
          () => updateRefuelUsecase(refuel),
        ).thenAnswer((_) => Future.value(Right(null)));

        return refuelCubit;
      },
      act: (cubit) => cubit.updateRefuel(refuel),
      expect:
          () => [
            const RefuelState.loading(),
            RefuelState.success('Refuel updated successfully'),
          ],
      verify: (_) {
        verify(() => updateRefuelUsecase(refuel)).called(1);
      },
    );

    blocTest<RefuelCubit, RefuelState>(
      'emits [loading, error] when updateRefuel fails',
      build: () {
        when(
          () => updateRefuelUsecase(refuel),
        ).thenAnswer((_) => Future.value(Left(DatabaseFailure('error'))));

        return refuelCubit;
      },
      act: (cubit) => cubit.updateRefuel(refuel),
      expect:
          () => [
            const RefuelState.loading(),
            RefuelState.error(message: 'error'),
          ],
      verify: (_) {
        verify(() => updateRefuelUsecase(refuel)).called(1);
      },
    );

    blocTest<RefuelCubit, RefuelState>(
      'emits [loading, success] when deleteRefuel is successful',
      build: () {
        when(
          () => deleteRefuelUsecase(refuel.id),
        ).thenAnswer((_) => Future.value(Right(null)));

        return refuelCubit;
      },
      act: (bloc) => bloc.deleteRefuel(refuel),
      expect:
          () => [
            const RefuelState.loading(),
            RefuelState.success('Refuel deleted successfully'),
          ],
      verify: (_) {
        verify(() => deleteRefuelUsecase(refuel.id)).called(1);
      },
    );

    blocTest<RefuelCubit, RefuelState>(
      'emits [loading, error] when deleteRefuel is failed',
      build: () {
        when(
          () => deleteRefuelUsecase(refuel.id),
        ).thenAnswer((_) => Future.value(Left(DatabaseFailure('error'))));

        return refuelCubit;
      },
      act: (bloc) => bloc.deleteRefuel(refuel),
      expect:
          () => [
            const RefuelState.loading(),
            RefuelState.error(message: 'error'),
          ],
      verify: (_) {
        verify(() => deleteRefuelUsecase(refuel.id)).called(1);
      },
    );
  });
}
