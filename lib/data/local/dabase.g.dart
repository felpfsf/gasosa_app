// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dabase.dart';

// ignore_for_file: type=lint
class $RefuelsTable extends Refuels with TableInfo<$RefuelsTable, Refuel> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RefuelsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _vehicleIdMeta = const VerificationMeta(
    'vehicleId',
  );
  @override
  late final GeneratedColumn<String> vehicleId = GeneratedColumn<String>(
    'vehicle_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _odometerMeta = const VerificationMeta(
    'odometer',
  );
  @override
  late final GeneratedColumn<double> odometer = GeneratedColumn<double>(
    'odometer',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fuelTypeMeta = const VerificationMeta(
    'fuelType',
  );
  @override
  late final GeneratedColumn<String> fuelType = GeneratedColumn<String>(
    'fuel_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _litersMeta = const VerificationMeta('liters');
  @override
  late final GeneratedColumn<double> liters = GeneratedColumn<double>(
    'liters',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalValueMeta = const VerificationMeta(
    'totalValue',
  );
  @override
  late final GeneratedColumn<double> totalValue = GeneratedColumn<double>(
    'total_value',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pricePerLiterMeta = const VerificationMeta(
    'pricePerLiter',
  );
  @override
  late final GeneratedColumn<double> pricePerLiter = GeneratedColumn<double>(
    'price_per_liter',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _coldStartLittersMeta = const VerificationMeta(
    'coldStartLitters',
  );
  @override
  late final GeneratedColumn<double> coldStartLitters = GeneratedColumn<double>(
    'cold_start_litters',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _noteImageUrlMeta = const VerificationMeta(
    'noteImageUrl',
  );
  @override
  late final GeneratedColumn<String> noteImageUrl = GeneratedColumn<String>(
    'note_image_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isSyncedMeta = const VerificationMeta(
    'isSynced',
  );
  @override
  late final GeneratedColumn<bool> isSynced = GeneratedColumn<bool>(
    'is_synced',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_synced" IN (0, 1))',
    ),
    defaultValue: Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    vehicleId,
    date,
    odometer,
    fuelType,
    liters,
    totalValue,
    pricePerLiter,
    coldStartLitters,
    noteImageUrl,
    isSynced,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'refuels';
  @override
  VerificationContext validateIntegrity(
    Insertable<Refuel> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('vehicle_id')) {
      context.handle(
        _vehicleIdMeta,
        vehicleId.isAcceptableOrUnknown(data['vehicle_id']!, _vehicleIdMeta),
      );
    } else if (isInserting) {
      context.missing(_vehicleIdMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('odometer')) {
      context.handle(
        _odometerMeta,
        odometer.isAcceptableOrUnknown(data['odometer']!, _odometerMeta),
      );
    } else if (isInserting) {
      context.missing(_odometerMeta);
    }
    if (data.containsKey('fuel_type')) {
      context.handle(
        _fuelTypeMeta,
        fuelType.isAcceptableOrUnknown(data['fuel_type']!, _fuelTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_fuelTypeMeta);
    }
    if (data.containsKey('liters')) {
      context.handle(
        _litersMeta,
        liters.isAcceptableOrUnknown(data['liters']!, _litersMeta),
      );
    } else if (isInserting) {
      context.missing(_litersMeta);
    }
    if (data.containsKey('total_value')) {
      context.handle(
        _totalValueMeta,
        totalValue.isAcceptableOrUnknown(data['total_value']!, _totalValueMeta),
      );
    } else if (isInserting) {
      context.missing(_totalValueMeta);
    }
    if (data.containsKey('price_per_liter')) {
      context.handle(
        _pricePerLiterMeta,
        pricePerLiter.isAcceptableOrUnknown(
          data['price_per_liter']!,
          _pricePerLiterMeta,
        ),
      );
    }
    if (data.containsKey('cold_start_litters')) {
      context.handle(
        _coldStartLittersMeta,
        coldStartLitters.isAcceptableOrUnknown(
          data['cold_start_litters']!,
          _coldStartLittersMeta,
        ),
      );
    }
    if (data.containsKey('note_image_url')) {
      context.handle(
        _noteImageUrlMeta,
        noteImageUrl.isAcceptableOrUnknown(
          data['note_image_url']!,
          _noteImageUrlMeta,
        ),
      );
    }
    if (data.containsKey('is_synced')) {
      context.handle(
        _isSyncedMeta,
        isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Refuel map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Refuel(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}id'],
          )!,
      vehicleId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}vehicle_id'],
          )!,
      date:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}date'],
          )!,
      odometer:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}odometer'],
          )!,
      fuelType:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}fuel_type'],
          )!,
      liters:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}liters'],
          )!,
      totalValue:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}total_value'],
          )!,
      pricePerLiter: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}price_per_liter'],
      ),
      coldStartLitters: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}cold_start_litters'],
      ),
      noteImageUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note_image_url'],
      ),
      isSynced:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}is_synced'],
          )!,
      createdAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}created_at'],
          )!,
    );
  }

  @override
  $RefuelsTable createAlias(String alias) {
    return $RefuelsTable(attachedDatabase, alias);
  }
}

class Refuel extends DataClass implements Insertable<Refuel> {
  final String id;
  final String vehicleId;
  final DateTime date;
  final double odometer;
  final String fuelType;
  final double liters;
  final double totalValue;
  final double? pricePerLiter;
  final double? coldStartLitters;
  final String? noteImageUrl;
  final bool isSynced;
  final DateTime createdAt;
  const Refuel({
    required this.id,
    required this.vehicleId,
    required this.date,
    required this.odometer,
    required this.fuelType,
    required this.liters,
    required this.totalValue,
    this.pricePerLiter,
    this.coldStartLitters,
    this.noteImageUrl,
    required this.isSynced,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['vehicle_id'] = Variable<String>(vehicleId);
    map['date'] = Variable<DateTime>(date);
    map['odometer'] = Variable<double>(odometer);
    map['fuel_type'] = Variable<String>(fuelType);
    map['liters'] = Variable<double>(liters);
    map['total_value'] = Variable<double>(totalValue);
    if (!nullToAbsent || pricePerLiter != null) {
      map['price_per_liter'] = Variable<double>(pricePerLiter);
    }
    if (!nullToAbsent || coldStartLitters != null) {
      map['cold_start_litters'] = Variable<double>(coldStartLitters);
    }
    if (!nullToAbsent || noteImageUrl != null) {
      map['note_image_url'] = Variable<String>(noteImageUrl);
    }
    map['is_synced'] = Variable<bool>(isSynced);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  RefuelsCompanion toCompanion(bool nullToAbsent) {
    return RefuelsCompanion(
      id: Value(id),
      vehicleId: Value(vehicleId),
      date: Value(date),
      odometer: Value(odometer),
      fuelType: Value(fuelType),
      liters: Value(liters),
      totalValue: Value(totalValue),
      pricePerLiter:
          pricePerLiter == null && nullToAbsent
              ? const Value.absent()
              : Value(pricePerLiter),
      coldStartLitters:
          coldStartLitters == null && nullToAbsent
              ? const Value.absent()
              : Value(coldStartLitters),
      noteImageUrl:
          noteImageUrl == null && nullToAbsent
              ? const Value.absent()
              : Value(noteImageUrl),
      isSynced: Value(isSynced),
      createdAt: Value(createdAt),
    );
  }

  factory Refuel.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Refuel(
      id: serializer.fromJson<String>(json['id']),
      vehicleId: serializer.fromJson<String>(json['vehicleId']),
      date: serializer.fromJson<DateTime>(json['date']),
      odometer: serializer.fromJson<double>(json['odometer']),
      fuelType: serializer.fromJson<String>(json['fuelType']),
      liters: serializer.fromJson<double>(json['liters']),
      totalValue: serializer.fromJson<double>(json['totalValue']),
      pricePerLiter: serializer.fromJson<double?>(json['pricePerLiter']),
      coldStartLitters: serializer.fromJson<double?>(json['coldStartLitters']),
      noteImageUrl: serializer.fromJson<String?>(json['noteImageUrl']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'vehicleId': serializer.toJson<String>(vehicleId),
      'date': serializer.toJson<DateTime>(date),
      'odometer': serializer.toJson<double>(odometer),
      'fuelType': serializer.toJson<String>(fuelType),
      'liters': serializer.toJson<double>(liters),
      'totalValue': serializer.toJson<double>(totalValue),
      'pricePerLiter': serializer.toJson<double?>(pricePerLiter),
      'coldStartLitters': serializer.toJson<double?>(coldStartLitters),
      'noteImageUrl': serializer.toJson<String?>(noteImageUrl),
      'isSynced': serializer.toJson<bool>(isSynced),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Refuel copyWith({
    String? id,
    String? vehicleId,
    DateTime? date,
    double? odometer,
    String? fuelType,
    double? liters,
    double? totalValue,
    Value<double?> pricePerLiter = const Value.absent(),
    Value<double?> coldStartLitters = const Value.absent(),
    Value<String?> noteImageUrl = const Value.absent(),
    bool? isSynced,
    DateTime? createdAt,
  }) => Refuel(
    id: id ?? this.id,
    vehicleId: vehicleId ?? this.vehicleId,
    date: date ?? this.date,
    odometer: odometer ?? this.odometer,
    fuelType: fuelType ?? this.fuelType,
    liters: liters ?? this.liters,
    totalValue: totalValue ?? this.totalValue,
    pricePerLiter:
        pricePerLiter.present ? pricePerLiter.value : this.pricePerLiter,
    coldStartLitters:
        coldStartLitters.present
            ? coldStartLitters.value
            : this.coldStartLitters,
    noteImageUrl: noteImageUrl.present ? noteImageUrl.value : this.noteImageUrl,
    isSynced: isSynced ?? this.isSynced,
    createdAt: createdAt ?? this.createdAt,
  );
  Refuel copyWithCompanion(RefuelsCompanion data) {
    return Refuel(
      id: data.id.present ? data.id.value : this.id,
      vehicleId: data.vehicleId.present ? data.vehicleId.value : this.vehicleId,
      date: data.date.present ? data.date.value : this.date,
      odometer: data.odometer.present ? data.odometer.value : this.odometer,
      fuelType: data.fuelType.present ? data.fuelType.value : this.fuelType,
      liters: data.liters.present ? data.liters.value : this.liters,
      totalValue:
          data.totalValue.present ? data.totalValue.value : this.totalValue,
      pricePerLiter:
          data.pricePerLiter.present
              ? data.pricePerLiter.value
              : this.pricePerLiter,
      coldStartLitters:
          data.coldStartLitters.present
              ? data.coldStartLitters.value
              : this.coldStartLitters,
      noteImageUrl:
          data.noteImageUrl.present
              ? data.noteImageUrl.value
              : this.noteImageUrl,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Refuel(')
          ..write('id: $id, ')
          ..write('vehicleId: $vehicleId, ')
          ..write('date: $date, ')
          ..write('odometer: $odometer, ')
          ..write('fuelType: $fuelType, ')
          ..write('liters: $liters, ')
          ..write('totalValue: $totalValue, ')
          ..write('pricePerLiter: $pricePerLiter, ')
          ..write('coldStartLitters: $coldStartLitters, ')
          ..write('noteImageUrl: $noteImageUrl, ')
          ..write('isSynced: $isSynced, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    vehicleId,
    date,
    odometer,
    fuelType,
    liters,
    totalValue,
    pricePerLiter,
    coldStartLitters,
    noteImageUrl,
    isSynced,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Refuel &&
          other.id == this.id &&
          other.vehicleId == this.vehicleId &&
          other.date == this.date &&
          other.odometer == this.odometer &&
          other.fuelType == this.fuelType &&
          other.liters == this.liters &&
          other.totalValue == this.totalValue &&
          other.pricePerLiter == this.pricePerLiter &&
          other.coldStartLitters == this.coldStartLitters &&
          other.noteImageUrl == this.noteImageUrl &&
          other.isSynced == this.isSynced &&
          other.createdAt == this.createdAt);
}

class RefuelsCompanion extends UpdateCompanion<Refuel> {
  final Value<String> id;
  final Value<String> vehicleId;
  final Value<DateTime> date;
  final Value<double> odometer;
  final Value<String> fuelType;
  final Value<double> liters;
  final Value<double> totalValue;
  final Value<double?> pricePerLiter;
  final Value<double?> coldStartLitters;
  final Value<String?> noteImageUrl;
  final Value<bool> isSynced;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const RefuelsCompanion({
    this.id = const Value.absent(),
    this.vehicleId = const Value.absent(),
    this.date = const Value.absent(),
    this.odometer = const Value.absent(),
    this.fuelType = const Value.absent(),
    this.liters = const Value.absent(),
    this.totalValue = const Value.absent(),
    this.pricePerLiter = const Value.absent(),
    this.coldStartLitters = const Value.absent(),
    this.noteImageUrl = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RefuelsCompanion.insert({
    required String id,
    required String vehicleId,
    required DateTime date,
    required double odometer,
    required String fuelType,
    required double liters,
    required double totalValue,
    this.pricePerLiter = const Value.absent(),
    this.coldStartLitters = const Value.absent(),
    this.noteImageUrl = const Value.absent(),
    this.isSynced = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       vehicleId = Value(vehicleId),
       date = Value(date),
       odometer = Value(odometer),
       fuelType = Value(fuelType),
       liters = Value(liters),
       totalValue = Value(totalValue),
       createdAt = Value(createdAt);
  static Insertable<Refuel> custom({
    Expression<String>? id,
    Expression<String>? vehicleId,
    Expression<DateTime>? date,
    Expression<double>? odometer,
    Expression<String>? fuelType,
    Expression<double>? liters,
    Expression<double>? totalValue,
    Expression<double>? pricePerLiter,
    Expression<double>? coldStartLitters,
    Expression<String>? noteImageUrl,
    Expression<bool>? isSynced,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (vehicleId != null) 'vehicle_id': vehicleId,
      if (date != null) 'date': date,
      if (odometer != null) 'odometer': odometer,
      if (fuelType != null) 'fuel_type': fuelType,
      if (liters != null) 'liters': liters,
      if (totalValue != null) 'total_value': totalValue,
      if (pricePerLiter != null) 'price_per_liter': pricePerLiter,
      if (coldStartLitters != null) 'cold_start_litters': coldStartLitters,
      if (noteImageUrl != null) 'note_image_url': noteImageUrl,
      if (isSynced != null) 'is_synced': isSynced,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RefuelsCompanion copyWith({
    Value<String>? id,
    Value<String>? vehicleId,
    Value<DateTime>? date,
    Value<double>? odometer,
    Value<String>? fuelType,
    Value<double>? liters,
    Value<double>? totalValue,
    Value<double?>? pricePerLiter,
    Value<double?>? coldStartLitters,
    Value<String?>? noteImageUrl,
    Value<bool>? isSynced,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return RefuelsCompanion(
      id: id ?? this.id,
      vehicleId: vehicleId ?? this.vehicleId,
      date: date ?? this.date,
      odometer: odometer ?? this.odometer,
      fuelType: fuelType ?? this.fuelType,
      liters: liters ?? this.liters,
      totalValue: totalValue ?? this.totalValue,
      pricePerLiter: pricePerLiter ?? this.pricePerLiter,
      coldStartLitters: coldStartLitters ?? this.coldStartLitters,
      noteImageUrl: noteImageUrl ?? this.noteImageUrl,
      isSynced: isSynced ?? this.isSynced,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (vehicleId.present) {
      map['vehicle_id'] = Variable<String>(vehicleId.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (odometer.present) {
      map['odometer'] = Variable<double>(odometer.value);
    }
    if (fuelType.present) {
      map['fuel_type'] = Variable<String>(fuelType.value);
    }
    if (liters.present) {
      map['liters'] = Variable<double>(liters.value);
    }
    if (totalValue.present) {
      map['total_value'] = Variable<double>(totalValue.value);
    }
    if (pricePerLiter.present) {
      map['price_per_liter'] = Variable<double>(pricePerLiter.value);
    }
    if (coldStartLitters.present) {
      map['cold_start_litters'] = Variable<double>(coldStartLitters.value);
    }
    if (noteImageUrl.present) {
      map['note_image_url'] = Variable<String>(noteImageUrl.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RefuelsCompanion(')
          ..write('id: $id, ')
          ..write('vehicleId: $vehicleId, ')
          ..write('date: $date, ')
          ..write('odometer: $odometer, ')
          ..write('fuelType: $fuelType, ')
          ..write('liters: $liters, ')
          ..write('totalValue: $totalValue, ')
          ..write('pricePerLiter: $pricePerLiter, ')
          ..write('coldStartLitters: $coldStartLitters, ')
          ..write('noteImageUrl: $noteImageUrl, ')
          ..write('isSynced: $isSynced, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $VehiclesTable extends Vehicles with TableInfo<$VehiclesTable, Vehicle> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VehiclesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _plateMeta = const VerificationMeta('plate');
  @override
  late final GeneratedColumn<String> plate = GeneratedColumn<String>(
    'plate',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _fuelTypeMeta = const VerificationMeta(
    'fuelType',
  );
  @override
  late final GeneratedColumn<String> fuelType = GeneratedColumn<String>(
    'fuel_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, plate, fuelType, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'vehicles';
  @override
  VerificationContext validateIntegrity(
    Insertable<Vehicle> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('plate')) {
      context.handle(
        _plateMeta,
        plate.isAcceptableOrUnknown(data['plate']!, _plateMeta),
      );
    }
    if (data.containsKey('fuel_type')) {
      context.handle(
        _fuelTypeMeta,
        fuelType.isAcceptableOrUnknown(data['fuel_type']!, _fuelTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_fuelTypeMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Vehicle map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Vehicle(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}id'],
          )!,
      name:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}name'],
          )!,
      plate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}plate'],
      ),
      fuelType:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}fuel_type'],
          )!,
      createdAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}created_at'],
          )!,
    );
  }

  @override
  $VehiclesTable createAlias(String alias) {
    return $VehiclesTable(attachedDatabase, alias);
  }
}

class Vehicle extends DataClass implements Insertable<Vehicle> {
  final String id;
  final String name;
  final String? plate;
  final String fuelType;
  final DateTime createdAt;
  const Vehicle({
    required this.id,
    required this.name,
    this.plate,
    required this.fuelType,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || plate != null) {
      map['plate'] = Variable<String>(plate);
    }
    map['fuel_type'] = Variable<String>(fuelType);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  VehiclesCompanion toCompanion(bool nullToAbsent) {
    return VehiclesCompanion(
      id: Value(id),
      name: Value(name),
      plate:
          plate == null && nullToAbsent ? const Value.absent() : Value(plate),
      fuelType: Value(fuelType),
      createdAt: Value(createdAt),
    );
  }

  factory Vehicle.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Vehicle(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      plate: serializer.fromJson<String?>(json['plate']),
      fuelType: serializer.fromJson<String>(json['fuelType']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'plate': serializer.toJson<String?>(plate),
      'fuelType': serializer.toJson<String>(fuelType),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Vehicle copyWith({
    String? id,
    String? name,
    Value<String?> plate = const Value.absent(),
    String? fuelType,
    DateTime? createdAt,
  }) => Vehicle(
    id: id ?? this.id,
    name: name ?? this.name,
    plate: plate.present ? plate.value : this.plate,
    fuelType: fuelType ?? this.fuelType,
    createdAt: createdAt ?? this.createdAt,
  );
  Vehicle copyWithCompanion(VehiclesCompanion data) {
    return Vehicle(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      plate: data.plate.present ? data.plate.value : this.plate,
      fuelType: data.fuelType.present ? data.fuelType.value : this.fuelType,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Vehicle(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('plate: $plate, ')
          ..write('fuelType: $fuelType, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, plate, fuelType, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Vehicle &&
          other.id == this.id &&
          other.name == this.name &&
          other.plate == this.plate &&
          other.fuelType == this.fuelType &&
          other.createdAt == this.createdAt);
}

class VehiclesCompanion extends UpdateCompanion<Vehicle> {
  final Value<String> id;
  final Value<String> name;
  final Value<String?> plate;
  final Value<String> fuelType;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const VehiclesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.plate = const Value.absent(),
    this.fuelType = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  VehiclesCompanion.insert({
    required String id,
    required String name,
    this.plate = const Value.absent(),
    required String fuelType,
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       fuelType = Value(fuelType),
       createdAt = Value(createdAt);
  static Insertable<Vehicle> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? plate,
    Expression<String>? fuelType,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (plate != null) 'plate': plate,
      if (fuelType != null) 'fuel_type': fuelType,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  VehiclesCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String?>? plate,
    Value<String>? fuelType,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return VehiclesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      plate: plate ?? this.plate,
      fuelType: fuelType ?? this.fuelType,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (plate.present) {
      map['plate'] = Variable<String>(plate.value);
    }
    if (fuelType.present) {
      map['fuel_type'] = Variable<String>(fuelType.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VehiclesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('plate: $plate, ')
          ..write('fuelType: $fuelType, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$GasosaDatabase extends GeneratedDatabase {
  _$GasosaDatabase(QueryExecutor e) : super(e);
  $GasosaDatabaseManager get managers => $GasosaDatabaseManager(this);
  late final $RefuelsTable refuels = $RefuelsTable(this);
  late final $VehiclesTable vehicles = $VehiclesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [refuels, vehicles];
}

typedef $$RefuelsTableCreateCompanionBuilder =
    RefuelsCompanion Function({
      required String id,
      required String vehicleId,
      required DateTime date,
      required double odometer,
      required String fuelType,
      required double liters,
      required double totalValue,
      Value<double?> pricePerLiter,
      Value<double?> coldStartLitters,
      Value<String?> noteImageUrl,
      Value<bool> isSynced,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$RefuelsTableUpdateCompanionBuilder =
    RefuelsCompanion Function({
      Value<String> id,
      Value<String> vehicleId,
      Value<DateTime> date,
      Value<double> odometer,
      Value<String> fuelType,
      Value<double> liters,
      Value<double> totalValue,
      Value<double?> pricePerLiter,
      Value<double?> coldStartLitters,
      Value<String?> noteImageUrl,
      Value<bool> isSynced,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$RefuelsTableFilterComposer
    extends Composer<_$GasosaDatabase, $RefuelsTable> {
  $$RefuelsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get vehicleId => $composableBuilder(
    column: $table.vehicleId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get odometer => $composableBuilder(
    column: $table.odometer,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fuelType => $composableBuilder(
    column: $table.fuelType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get liters => $composableBuilder(
    column: $table.liters,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get totalValue => $composableBuilder(
    column: $table.totalValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get pricePerLiter => $composableBuilder(
    column: $table.pricePerLiter,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get coldStartLitters => $composableBuilder(
    column: $table.coldStartLitters,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get noteImageUrl => $composableBuilder(
    column: $table.noteImageUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$RefuelsTableOrderingComposer
    extends Composer<_$GasosaDatabase, $RefuelsTable> {
  $$RefuelsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get vehicleId => $composableBuilder(
    column: $table.vehicleId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get odometer => $composableBuilder(
    column: $table.odometer,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fuelType => $composableBuilder(
    column: $table.fuelType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get liters => $composableBuilder(
    column: $table.liters,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get totalValue => $composableBuilder(
    column: $table.totalValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get pricePerLiter => $composableBuilder(
    column: $table.pricePerLiter,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get coldStartLitters => $composableBuilder(
    column: $table.coldStartLitters,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get noteImageUrl => $composableBuilder(
    column: $table.noteImageUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$RefuelsTableAnnotationComposer
    extends Composer<_$GasosaDatabase, $RefuelsTable> {
  $$RefuelsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get vehicleId =>
      $composableBuilder(column: $table.vehicleId, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<double> get odometer =>
      $composableBuilder(column: $table.odometer, builder: (column) => column);

  GeneratedColumn<String> get fuelType =>
      $composableBuilder(column: $table.fuelType, builder: (column) => column);

  GeneratedColumn<double> get liters =>
      $composableBuilder(column: $table.liters, builder: (column) => column);

  GeneratedColumn<double> get totalValue => $composableBuilder(
    column: $table.totalValue,
    builder: (column) => column,
  );

  GeneratedColumn<double> get pricePerLiter => $composableBuilder(
    column: $table.pricePerLiter,
    builder: (column) => column,
  );

  GeneratedColumn<double> get coldStartLitters => $composableBuilder(
    column: $table.coldStartLitters,
    builder: (column) => column,
  );

  GeneratedColumn<String> get noteImageUrl => $composableBuilder(
    column: $table.noteImageUrl,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$RefuelsTableTableManager
    extends
        RootTableManager<
          _$GasosaDatabase,
          $RefuelsTable,
          Refuel,
          $$RefuelsTableFilterComposer,
          $$RefuelsTableOrderingComposer,
          $$RefuelsTableAnnotationComposer,
          $$RefuelsTableCreateCompanionBuilder,
          $$RefuelsTableUpdateCompanionBuilder,
          (Refuel, BaseReferences<_$GasosaDatabase, $RefuelsTable, Refuel>),
          Refuel,
          PrefetchHooks Function()
        > {
  $$RefuelsTableTableManager(_$GasosaDatabase db, $RefuelsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$RefuelsTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$RefuelsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$RefuelsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> vehicleId = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<double> odometer = const Value.absent(),
                Value<String> fuelType = const Value.absent(),
                Value<double> liters = const Value.absent(),
                Value<double> totalValue = const Value.absent(),
                Value<double?> pricePerLiter = const Value.absent(),
                Value<double?> coldStartLitters = const Value.absent(),
                Value<String?> noteImageUrl = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RefuelsCompanion(
                id: id,
                vehicleId: vehicleId,
                date: date,
                odometer: odometer,
                fuelType: fuelType,
                liters: liters,
                totalValue: totalValue,
                pricePerLiter: pricePerLiter,
                coldStartLitters: coldStartLitters,
                noteImageUrl: noteImageUrl,
                isSynced: isSynced,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String vehicleId,
                required DateTime date,
                required double odometer,
                required String fuelType,
                required double liters,
                required double totalValue,
                Value<double?> pricePerLiter = const Value.absent(),
                Value<double?> coldStartLitters = const Value.absent(),
                Value<String?> noteImageUrl = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => RefuelsCompanion.insert(
                id: id,
                vehicleId: vehicleId,
                date: date,
                odometer: odometer,
                fuelType: fuelType,
                liters: liters,
                totalValue: totalValue,
                pricePerLiter: pricePerLiter,
                coldStartLitters: coldStartLitters,
                noteImageUrl: noteImageUrl,
                isSynced: isSynced,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$RefuelsTableProcessedTableManager =
    ProcessedTableManager<
      _$GasosaDatabase,
      $RefuelsTable,
      Refuel,
      $$RefuelsTableFilterComposer,
      $$RefuelsTableOrderingComposer,
      $$RefuelsTableAnnotationComposer,
      $$RefuelsTableCreateCompanionBuilder,
      $$RefuelsTableUpdateCompanionBuilder,
      (Refuel, BaseReferences<_$GasosaDatabase, $RefuelsTable, Refuel>),
      Refuel,
      PrefetchHooks Function()
    >;
typedef $$VehiclesTableCreateCompanionBuilder =
    VehiclesCompanion Function({
      required String id,
      required String name,
      Value<String?> plate,
      required String fuelType,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$VehiclesTableUpdateCompanionBuilder =
    VehiclesCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String?> plate,
      Value<String> fuelType,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$VehiclesTableFilterComposer
    extends Composer<_$GasosaDatabase, $VehiclesTable> {
  $$VehiclesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get plate => $composableBuilder(
    column: $table.plate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fuelType => $composableBuilder(
    column: $table.fuelType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$VehiclesTableOrderingComposer
    extends Composer<_$GasosaDatabase, $VehiclesTable> {
  $$VehiclesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get plate => $composableBuilder(
    column: $table.plate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fuelType => $composableBuilder(
    column: $table.fuelType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$VehiclesTableAnnotationComposer
    extends Composer<_$GasosaDatabase, $VehiclesTable> {
  $$VehiclesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get plate =>
      $composableBuilder(column: $table.plate, builder: (column) => column);

  GeneratedColumn<String> get fuelType =>
      $composableBuilder(column: $table.fuelType, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$VehiclesTableTableManager
    extends
        RootTableManager<
          _$GasosaDatabase,
          $VehiclesTable,
          Vehicle,
          $$VehiclesTableFilterComposer,
          $$VehiclesTableOrderingComposer,
          $$VehiclesTableAnnotationComposer,
          $$VehiclesTableCreateCompanionBuilder,
          $$VehiclesTableUpdateCompanionBuilder,
          (Vehicle, BaseReferences<_$GasosaDatabase, $VehiclesTable, Vehicle>),
          Vehicle,
          PrefetchHooks Function()
        > {
  $$VehiclesTableTableManager(_$GasosaDatabase db, $VehiclesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$VehiclesTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$VehiclesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$VehiclesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> plate = const Value.absent(),
                Value<String> fuelType = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => VehiclesCompanion(
                id: id,
                name: name,
                plate: plate,
                fuelType: fuelType,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                Value<String?> plate = const Value.absent(),
                required String fuelType,
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => VehiclesCompanion.insert(
                id: id,
                name: name,
                plate: plate,
                fuelType: fuelType,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$VehiclesTableProcessedTableManager =
    ProcessedTableManager<
      _$GasosaDatabase,
      $VehiclesTable,
      Vehicle,
      $$VehiclesTableFilterComposer,
      $$VehiclesTableOrderingComposer,
      $$VehiclesTableAnnotationComposer,
      $$VehiclesTableCreateCompanionBuilder,
      $$VehiclesTableUpdateCompanionBuilder,
      (Vehicle, BaseReferences<_$GasosaDatabase, $VehiclesTable, Vehicle>),
      Vehicle,
      PrefetchHooks Function()
    >;

class $GasosaDatabaseManager {
  final _$GasosaDatabase _db;
  $GasosaDatabaseManager(this._db);
  $$RefuelsTableTableManager get refuels =>
      $$RefuelsTableTableManager(_db, _db.refuels);
  $$VehiclesTableTableManager get vehicles =>
      $$VehiclesTableTableManager(_db, _db.vehicles);
}
