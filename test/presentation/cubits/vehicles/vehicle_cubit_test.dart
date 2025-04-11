import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gasosa_app/core/errors/failure.dart';
import 'package:gasosa_app/domain/entities/vehicle.dart';
import 'package:gasosa_app/domain/usecases/vehicle/add_vehicle_usecase.dart';
import 'package:gasosa_app/domain/usecases/vehicle/delete_vehicle_usecase.dart';
import 'package:gasosa_app/domain/usecases/vehicle/update_vehicle_usecase.dart';
import 'package:gasosa_app/domain/usecases/vehicle/watch_all_vehicles_by_user_id_usecase.dart';
import 'package:gasosa_app/presentation/cubits/vehicle/vehicle_cubit.dart';
import 'package:gasosa_app/presentation/cubits/vehicle/vehicle_state.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks/fallbacks_values.dart';
import '../../../mocks/mock_classes.dart';

void main() {
  late VehicleCubit vehicleCubit;
  late IWatchAllVehiclesByUserIdUsecase watchAllVehiclesByUserIdUsecase;
  late IAddVehicleUsecase addVehicleUsecase;
  late IUpdateVehicleUsecase updateVehicleUsecase;
  late IDeleteVehicleUsecase deleteVehicleUsecase;

  const userId = 'userId';
  final vehicle = Vehicle(
    id: 'id',
    userId: userId,
    name: 'name',
    plate: 'ABC1234',
    fuelType: 'gasoline',
    createdAt: DateTime.now(),
  );

  setUpAll(() {
    registerFallbacks();
  });

  setUp(() {
    watchAllVehiclesByUserIdUsecase = MockWaWatchAllVehiclesByUserIdUsecase();
    addVehicleUsecase = MockWaAddVehicleUsecase();
    updateVehicleUsecase = MockWaUpdateVehicleUsecase();
    deleteVehicleUsecase = MockWaDeleteVehicleUsecase();

    vehicleCubit = VehicleCubit(
      watchAllVehiclesByUserIdUsecase,
      addVehicleUsecase,
      updateVehicleUsecase,
      deleteVehicleUsecase,
    );
  });

  blocTest<VehicleCubit, VehicleState>(
    'emit [loading, loaded] when watch stream emits vehicles',
    build: () {
      when(
        () => watchAllVehiclesByUserIdUsecase(userId),
      ).thenAnswer((_) => Stream.value([vehicle]));

      return vehicleCubit;
    },
    act: (cubit) => cubit.fetchVehicles(userId),
    expect:
        () => [
          const VehicleState.loading(),
          VehicleState.loaded([vehicle]),
        ],
    verify: (_) {
      verify(() => watchAllVehiclesByUserIdUsecase(userId)).called(1);
    },
  );

  blocTest<VehicleCubit, VehicleState>(
    'emits [loading, loaded] when addVehicle is successful',
    build: () {
      when(
        () => addVehicleUsecase(vehicle),
      ).thenAnswer((_) => Future.value(Right(vehicle)));

      return vehicleCubit;
    },
    act: (bloc) => bloc.addVehicle(vehicle),
    expect: () => [
      const VehicleState.loading(),
      VehicleState.success('Vehicle added successfully'),
    ],
    verify: (_) {
      verify(() => addVehicleUsecase(vehicle)).called(1);
    },
  );

  blocTest<VehicleCubit, VehicleState>(
    'emits [loading, error] when addVehicle fails',
    build: () {
      when(
        () => addVehicleUsecase(vehicle),
      ).thenAnswer((_) => Future.value(Left(DatabaseFailure('error'))));

      return vehicleCubit;
    },
    act: (bloc) => bloc.addVehicle(vehicle),
    expect: () => [
      const VehicleState.loading(),
      VehicleState.error(message: 'error'),
    ],
    verify: (_) {
      verify(() => addVehicleUsecase(vehicle)).called(1);
    },
  );

  blocTest<VehicleCubit, VehicleState>(
    'emits [loading, success] when updateVehicle is successful',
    build: () {
      when(
        () => updateVehicleUsecase(vehicle),
      ).thenAnswer((_) => Future.value(Right(null)));

      return vehicleCubit;
    },
    act: (bloc) => bloc.updateVehicle(vehicle),
    expect: () => [
      const VehicleState.loading(),
      VehicleState.success('Vehicle updated successfully'),
    ],
    verify: (_) {
      verify(() => updateVehicleUsecase(vehicle)).called(1);
    },
  );

  blocTest<VehicleCubit, VehicleState>(
    'emits [loading, error] when updateVehicle fails',
    build: () {
      when(
        () => updateVehicleUsecase(vehicle),
      ).thenAnswer((_) => Future.value(Left(DatabaseFailure('error'))));

      return vehicleCubit;
    },
    act: (bloc) => bloc.updateVehicle(vehicle),
    expect: () => [
      const VehicleState.loading(),
      VehicleState.error(message: 'error'),
    ],
    verify: (_) {
      verify(() => updateVehicleUsecase(vehicle)).called(1);
    },
  );

  blocTest<VehicleCubit, VehicleState>(
    'emits [loading, success] when deleteVehicle is successful',
    build: () {
      when(
        () => deleteVehicleUsecase(vehicle.id),
      ).thenAnswer((_) => Future.value(Right(null)));

      return vehicleCubit;
    },
    act: (bloc) => bloc.deleteVehicle(vehicle),
    expect: () => [
      const VehicleState.loading(),
      VehicleState.success('Vehicle deleted successfully'),
    ],
    verify: (_) {
      verify(() => deleteVehicleUsecase(vehicle.id)).called(1);
    },
  );

  blocTest<VehicleCubit, VehicleState>(
    'emits [loading, error] when deleteVehicle is failed',
    build: () {
      when(
        () => deleteVehicleUsecase(vehicle.id),
      ).thenAnswer((_) => Future.value(Left(DatabaseFailure('error'))));

      return vehicleCubit;
    },
    act: (bloc) => bloc.deleteVehicle(vehicle),
    expect: () => [
      const VehicleState.loading(),
      VehicleState.error(message: 'error'),
    ],
    verify: (_) {
      verify(() => deleteVehicleUsecase(vehicle.id)).called(1);
    },
  );
}
