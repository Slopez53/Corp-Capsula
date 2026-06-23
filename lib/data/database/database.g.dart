// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $CategoriasTable extends Categorias
    with TableInfo<$CategoriasTable, Categoria> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CategoriasTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nombreMeta = const VerificationMeta('nombre');
  @override
  late final GeneratedColumn<String> nombre = GeneratedColumn<String>(
    'nombre',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 80,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ordenMeta = const VerificationMeta('orden');
  @override
  late final GeneratedColumn<int> orden = GeneratedColumn<int>(
    'orden',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _activoMeta = const VerificationMeta('activo');
  @override
  late final GeneratedColumn<bool> activo = GeneratedColumn<bool>(
    'activo',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("activo" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [
    createdAt,
    updatedAt,
    deletedAt,
    id,
    nombre,
    orden,
    activo,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'categorias';
  @override
  VerificationContext validateIntegrity(
    Insertable<Categoria> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nombre')) {
      context.handle(
        _nombreMeta,
        nombre.isAcceptableOrUnknown(data['nombre']!, _nombreMeta),
      );
    } else if (isInserting) {
      context.missing(_nombreMeta);
    }
    if (data.containsKey('orden')) {
      context.handle(
        _ordenMeta,
        orden.isAcceptableOrUnknown(data['orden']!, _ordenMeta),
      );
    }
    if (data.containsKey('activo')) {
      context.handle(
        _activoMeta,
        activo.isAcceptableOrUnknown(data['activo']!, _activoMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Categoria map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Categoria(
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      nombre: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nombre'],
      )!,
      orden: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}orden'],
      )!,
      activo: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}activo'],
      )!,
    );
  }

  @override
  $CategoriasTable createAlias(String alias) {
    return $CategoriasTable(attachedDatabase, alias);
  }
}

class Categoria extends DataClass implements Insertable<Categoria> {
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final int id;
  final String nombre;
  final int orden;
  final bool activo;
  const Categoria({
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.id,
    required this.nombre,
    required this.orden,
    required this.activo,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['id'] = Variable<int>(id);
    map['nombre'] = Variable<String>(nombre);
    map['orden'] = Variable<int>(orden);
    map['activo'] = Variable<bool>(activo);
    return map;
  }

  CategoriasCompanion toCompanion(bool nullToAbsent) {
    return CategoriasCompanion(
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      id: Value(id),
      nombre: Value(nombre),
      orden: Value(orden),
      activo: Value(activo),
    );
  }

  factory Categoria.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Categoria(
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      id: serializer.fromJson<int>(json['id']),
      nombre: serializer.fromJson<String>(json['nombre']),
      orden: serializer.fromJson<int>(json['orden']),
      activo: serializer.fromJson<bool>(json['activo']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'id': serializer.toJson<int>(id),
      'nombre': serializer.toJson<String>(nombre),
      'orden': serializer.toJson<int>(orden),
      'activo': serializer.toJson<bool>(activo),
    };
  }

  Categoria copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    int? id,
    String? nombre,
    int? orden,
    bool? activo,
  }) => Categoria(
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    id: id ?? this.id,
    nombre: nombre ?? this.nombre,
    orden: orden ?? this.orden,
    activo: activo ?? this.activo,
  );
  Categoria copyWithCompanion(CategoriasCompanion data) {
    return Categoria(
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      id: data.id.present ? data.id.value : this.id,
      nombre: data.nombre.present ? data.nombre.value : this.nombre,
      orden: data.orden.present ? data.orden.value : this.orden,
      activo: data.activo.present ? data.activo.value : this.activo,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Categoria(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('orden: $orden, ')
          ..write('activo: $activo')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(createdAt, updatedAt, deletedAt, id, nombre, orden, activo);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Categoria &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.id == this.id &&
          other.nombre == this.nombre &&
          other.orden == this.orden &&
          other.activo == this.activo);
}

class CategoriasCompanion extends UpdateCompanion<Categoria> {
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<int> id;
  final Value<String> nombre;
  final Value<int> orden;
  final Value<bool> activo;
  const CategoriasCompanion({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.nombre = const Value.absent(),
    this.orden = const Value.absent(),
    this.activo = const Value.absent(),
  });
  CategoriasCompanion.insert({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.id = const Value.absent(),
    required String nombre,
    this.orden = const Value.absent(),
    this.activo = const Value.absent(),
  }) : nombre = Value(nombre);
  static Insertable<Categoria> custom({
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<int>? id,
    Expression<String>? nombre,
    Expression<int>? orden,
    Expression<bool>? activo,
  }) {
    return RawValuesInsertable({
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (id != null) 'id': id,
      if (nombre != null) 'nombre': nombre,
      if (orden != null) 'orden': orden,
      if (activo != null) 'activo': activo,
    });
  }

  CategoriasCompanion copyWith({
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<int>? id,
    Value<String>? nombre,
    Value<int>? orden,
    Value<bool>? activo,
  }) {
    return CategoriasCompanion(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      orden: orden ?? this.orden,
      activo: activo ?? this.activo,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nombre.present) {
      map['nombre'] = Variable<String>(nombre.value);
    }
    if (orden.present) {
      map['orden'] = Variable<int>(orden.value);
    }
    if (activo.present) {
      map['activo'] = Variable<bool>(activo.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoriasCompanion(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('orden: $orden, ')
          ..write('activo: $activo')
          ..write(')'))
        .toString();
  }
}

class $ProductosTable extends Productos
    with TableInfo<$ProductosTable, Producto> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nombreMeta = const VerificationMeta('nombre');
  @override
  late final GeneratedColumn<String> nombre = GeneratedColumn<String>(
    'nombre',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 120,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoriaIdMeta = const VerificationMeta(
    'categoriaId',
  );
  @override
  late final GeneratedColumn<int> categoriaId = GeneratedColumn<int>(
    'categoria_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _unidadVentaMeta = const VerificationMeta(
    'unidadVenta',
  );
  @override
  late final GeneratedColumn<String> unidadVenta = GeneratedColumn<String>(
    'unidad_venta',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pieza'),
  );
  static const VerificationMeta _precioVendedorMeta = const VerificationMeta(
    'precioVendedor',
  );
  @override
  late final GeneratedColumn<int> precioVendedor = GeneratedColumn<int>(
    'precio_vendedor',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _precioPublicoMeta = const VerificationMeta(
    'precioPublico',
  );
  @override
  late final GeneratedColumn<int> precioPublico = GeneratedColumn<int>(
    'precio_publico',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _costoProduccionMeta = const VerificationMeta(
    'costoProduccion',
  );
  @override
  late final GeneratedColumn<int> costoProduccion = GeneratedColumn<int>(
    'costo_produccion',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _stockActualMeta = const VerificationMeta(
    'stockActual',
  );
  @override
  late final GeneratedColumn<double> stockActual = GeneratedColumn<double>(
    'stock_actual',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _stockMinimoMeta = const VerificationMeta(
    'stockMinimo',
  );
  @override
  late final GeneratedColumn<double> stockMinimo = GeneratedColumn<double>(
    'stock_minimo',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _estadoMeta = const VerificationMeta('estado');
  @override
  late final GeneratedColumn<String> estado = GeneratedColumn<String>(
    'estado',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('activo'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    createdAt,
    updatedAt,
    deletedAt,
    id,
    nombre,
    categoriaId,
    unidadVenta,
    precioVendedor,
    precioPublico,
    costoProduccion,
    stockActual,
    stockMinimo,
    estado,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'productos';
  @override
  VerificationContext validateIntegrity(
    Insertable<Producto> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nombre')) {
      context.handle(
        _nombreMeta,
        nombre.isAcceptableOrUnknown(data['nombre']!, _nombreMeta),
      );
    } else if (isInserting) {
      context.missing(_nombreMeta);
    }
    if (data.containsKey('categoria_id')) {
      context.handle(
        _categoriaIdMeta,
        categoriaId.isAcceptableOrUnknown(
          data['categoria_id']!,
          _categoriaIdMeta,
        ),
      );
    }
    if (data.containsKey('unidad_venta')) {
      context.handle(
        _unidadVentaMeta,
        unidadVenta.isAcceptableOrUnknown(
          data['unidad_venta']!,
          _unidadVentaMeta,
        ),
      );
    }
    if (data.containsKey('precio_vendedor')) {
      context.handle(
        _precioVendedorMeta,
        precioVendedor.isAcceptableOrUnknown(
          data['precio_vendedor']!,
          _precioVendedorMeta,
        ),
      );
    }
    if (data.containsKey('precio_publico')) {
      context.handle(
        _precioPublicoMeta,
        precioPublico.isAcceptableOrUnknown(
          data['precio_publico']!,
          _precioPublicoMeta,
        ),
      );
    }
    if (data.containsKey('costo_produccion')) {
      context.handle(
        _costoProduccionMeta,
        costoProduccion.isAcceptableOrUnknown(
          data['costo_produccion']!,
          _costoProduccionMeta,
        ),
      );
    }
    if (data.containsKey('stock_actual')) {
      context.handle(
        _stockActualMeta,
        stockActual.isAcceptableOrUnknown(
          data['stock_actual']!,
          _stockActualMeta,
        ),
      );
    }
    if (data.containsKey('stock_minimo')) {
      context.handle(
        _stockMinimoMeta,
        stockMinimo.isAcceptableOrUnknown(
          data['stock_minimo']!,
          _stockMinimoMeta,
        ),
      );
    }
    if (data.containsKey('estado')) {
      context.handle(
        _estadoMeta,
        estado.isAcceptableOrUnknown(data['estado']!, _estadoMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Producto map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Producto(
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      nombre: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nombre'],
      )!,
      categoriaId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}categoria_id'],
      ),
      unidadVenta: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}unidad_venta'],
      )!,
      precioVendedor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}precio_vendedor'],
      )!,
      precioPublico: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}precio_publico'],
      )!,
      costoProduccion: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}costo_produccion'],
      ),
      stockActual: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}stock_actual'],
      )!,
      stockMinimo: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}stock_minimo'],
      )!,
      estado: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}estado'],
      )!,
    );
  }

  @override
  $ProductosTable createAlias(String alias) {
    return $ProductosTable(attachedDatabase, alias);
  }
}

class Producto extends DataClass implements Insertable<Producto> {
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final int id;
  final String nombre;
  final int? categoriaId;
  final String unidadVenta;
  final int precioVendedor;
  final int precioPublico;
  final int? costoProduccion;
  final double stockActual;
  final double stockMinimo;
  final String estado;
  const Producto({
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.id,
    required this.nombre,
    this.categoriaId,
    required this.unidadVenta,
    required this.precioVendedor,
    required this.precioPublico,
    this.costoProduccion,
    required this.stockActual,
    required this.stockMinimo,
    required this.estado,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['id'] = Variable<int>(id);
    map['nombre'] = Variable<String>(nombre);
    if (!nullToAbsent || categoriaId != null) {
      map['categoria_id'] = Variable<int>(categoriaId);
    }
    map['unidad_venta'] = Variable<String>(unidadVenta);
    map['precio_vendedor'] = Variable<int>(precioVendedor);
    map['precio_publico'] = Variable<int>(precioPublico);
    if (!nullToAbsent || costoProduccion != null) {
      map['costo_produccion'] = Variable<int>(costoProduccion);
    }
    map['stock_actual'] = Variable<double>(stockActual);
    map['stock_minimo'] = Variable<double>(stockMinimo);
    map['estado'] = Variable<String>(estado);
    return map;
  }

  ProductosCompanion toCompanion(bool nullToAbsent) {
    return ProductosCompanion(
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      id: Value(id),
      nombre: Value(nombre),
      categoriaId: categoriaId == null && nullToAbsent
          ? const Value.absent()
          : Value(categoriaId),
      unidadVenta: Value(unidadVenta),
      precioVendedor: Value(precioVendedor),
      precioPublico: Value(precioPublico),
      costoProduccion: costoProduccion == null && nullToAbsent
          ? const Value.absent()
          : Value(costoProduccion),
      stockActual: Value(stockActual),
      stockMinimo: Value(stockMinimo),
      estado: Value(estado),
    );
  }

  factory Producto.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Producto(
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      id: serializer.fromJson<int>(json['id']),
      nombre: serializer.fromJson<String>(json['nombre']),
      categoriaId: serializer.fromJson<int?>(json['categoriaId']),
      unidadVenta: serializer.fromJson<String>(json['unidadVenta']),
      precioVendedor: serializer.fromJson<int>(json['precioVendedor']),
      precioPublico: serializer.fromJson<int>(json['precioPublico']),
      costoProduccion: serializer.fromJson<int?>(json['costoProduccion']),
      stockActual: serializer.fromJson<double>(json['stockActual']),
      stockMinimo: serializer.fromJson<double>(json['stockMinimo']),
      estado: serializer.fromJson<String>(json['estado']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'id': serializer.toJson<int>(id),
      'nombre': serializer.toJson<String>(nombre),
      'categoriaId': serializer.toJson<int?>(categoriaId),
      'unidadVenta': serializer.toJson<String>(unidadVenta),
      'precioVendedor': serializer.toJson<int>(precioVendedor),
      'precioPublico': serializer.toJson<int>(precioPublico),
      'costoProduccion': serializer.toJson<int?>(costoProduccion),
      'stockActual': serializer.toJson<double>(stockActual),
      'stockMinimo': serializer.toJson<double>(stockMinimo),
      'estado': serializer.toJson<String>(estado),
    };
  }

  Producto copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    int? id,
    String? nombre,
    Value<int?> categoriaId = const Value.absent(),
    String? unidadVenta,
    int? precioVendedor,
    int? precioPublico,
    Value<int?> costoProduccion = const Value.absent(),
    double? stockActual,
    double? stockMinimo,
    String? estado,
  }) => Producto(
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    id: id ?? this.id,
    nombre: nombre ?? this.nombre,
    categoriaId: categoriaId.present ? categoriaId.value : this.categoriaId,
    unidadVenta: unidadVenta ?? this.unidadVenta,
    precioVendedor: precioVendedor ?? this.precioVendedor,
    precioPublico: precioPublico ?? this.precioPublico,
    costoProduccion: costoProduccion.present
        ? costoProduccion.value
        : this.costoProduccion,
    stockActual: stockActual ?? this.stockActual,
    stockMinimo: stockMinimo ?? this.stockMinimo,
    estado: estado ?? this.estado,
  );
  Producto copyWithCompanion(ProductosCompanion data) {
    return Producto(
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      id: data.id.present ? data.id.value : this.id,
      nombre: data.nombre.present ? data.nombre.value : this.nombre,
      categoriaId: data.categoriaId.present
          ? data.categoriaId.value
          : this.categoriaId,
      unidadVenta: data.unidadVenta.present
          ? data.unidadVenta.value
          : this.unidadVenta,
      precioVendedor: data.precioVendedor.present
          ? data.precioVendedor.value
          : this.precioVendedor,
      precioPublico: data.precioPublico.present
          ? data.precioPublico.value
          : this.precioPublico,
      costoProduccion: data.costoProduccion.present
          ? data.costoProduccion.value
          : this.costoProduccion,
      stockActual: data.stockActual.present
          ? data.stockActual.value
          : this.stockActual,
      stockMinimo: data.stockMinimo.present
          ? data.stockMinimo.value
          : this.stockMinimo,
      estado: data.estado.present ? data.estado.value : this.estado,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Producto(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('categoriaId: $categoriaId, ')
          ..write('unidadVenta: $unidadVenta, ')
          ..write('precioVendedor: $precioVendedor, ')
          ..write('precioPublico: $precioPublico, ')
          ..write('costoProduccion: $costoProduccion, ')
          ..write('stockActual: $stockActual, ')
          ..write('stockMinimo: $stockMinimo, ')
          ..write('estado: $estado')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    createdAt,
    updatedAt,
    deletedAt,
    id,
    nombre,
    categoriaId,
    unidadVenta,
    precioVendedor,
    precioPublico,
    costoProduccion,
    stockActual,
    stockMinimo,
    estado,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Producto &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.id == this.id &&
          other.nombre == this.nombre &&
          other.categoriaId == this.categoriaId &&
          other.unidadVenta == this.unidadVenta &&
          other.precioVendedor == this.precioVendedor &&
          other.precioPublico == this.precioPublico &&
          other.costoProduccion == this.costoProduccion &&
          other.stockActual == this.stockActual &&
          other.stockMinimo == this.stockMinimo &&
          other.estado == this.estado);
}

class ProductosCompanion extends UpdateCompanion<Producto> {
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<int> id;
  final Value<String> nombre;
  final Value<int?> categoriaId;
  final Value<String> unidadVenta;
  final Value<int> precioVendedor;
  final Value<int> precioPublico;
  final Value<int?> costoProduccion;
  final Value<double> stockActual;
  final Value<double> stockMinimo;
  final Value<String> estado;
  const ProductosCompanion({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.nombre = const Value.absent(),
    this.categoriaId = const Value.absent(),
    this.unidadVenta = const Value.absent(),
    this.precioVendedor = const Value.absent(),
    this.precioPublico = const Value.absent(),
    this.costoProduccion = const Value.absent(),
    this.stockActual = const Value.absent(),
    this.stockMinimo = const Value.absent(),
    this.estado = const Value.absent(),
  });
  ProductosCompanion.insert({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.id = const Value.absent(),
    required String nombre,
    this.categoriaId = const Value.absent(),
    this.unidadVenta = const Value.absent(),
    this.precioVendedor = const Value.absent(),
    this.precioPublico = const Value.absent(),
    this.costoProduccion = const Value.absent(),
    this.stockActual = const Value.absent(),
    this.stockMinimo = const Value.absent(),
    this.estado = const Value.absent(),
  }) : nombre = Value(nombre);
  static Insertable<Producto> custom({
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<int>? id,
    Expression<String>? nombre,
    Expression<int>? categoriaId,
    Expression<String>? unidadVenta,
    Expression<int>? precioVendedor,
    Expression<int>? precioPublico,
    Expression<int>? costoProduccion,
    Expression<double>? stockActual,
    Expression<double>? stockMinimo,
    Expression<String>? estado,
  }) {
    return RawValuesInsertable({
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (id != null) 'id': id,
      if (nombre != null) 'nombre': nombre,
      if (categoriaId != null) 'categoria_id': categoriaId,
      if (unidadVenta != null) 'unidad_venta': unidadVenta,
      if (precioVendedor != null) 'precio_vendedor': precioVendedor,
      if (precioPublico != null) 'precio_publico': precioPublico,
      if (costoProduccion != null) 'costo_produccion': costoProduccion,
      if (stockActual != null) 'stock_actual': stockActual,
      if (stockMinimo != null) 'stock_minimo': stockMinimo,
      if (estado != null) 'estado': estado,
    });
  }

  ProductosCompanion copyWith({
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<int>? id,
    Value<String>? nombre,
    Value<int?>? categoriaId,
    Value<String>? unidadVenta,
    Value<int>? precioVendedor,
    Value<int>? precioPublico,
    Value<int?>? costoProduccion,
    Value<double>? stockActual,
    Value<double>? stockMinimo,
    Value<String>? estado,
  }) {
    return ProductosCompanion(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      categoriaId: categoriaId ?? this.categoriaId,
      unidadVenta: unidadVenta ?? this.unidadVenta,
      precioVendedor: precioVendedor ?? this.precioVendedor,
      precioPublico: precioPublico ?? this.precioPublico,
      costoProduccion: costoProduccion ?? this.costoProduccion,
      stockActual: stockActual ?? this.stockActual,
      stockMinimo: stockMinimo ?? this.stockMinimo,
      estado: estado ?? this.estado,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nombre.present) {
      map['nombre'] = Variable<String>(nombre.value);
    }
    if (categoriaId.present) {
      map['categoria_id'] = Variable<int>(categoriaId.value);
    }
    if (unidadVenta.present) {
      map['unidad_venta'] = Variable<String>(unidadVenta.value);
    }
    if (precioVendedor.present) {
      map['precio_vendedor'] = Variable<int>(precioVendedor.value);
    }
    if (precioPublico.present) {
      map['precio_publico'] = Variable<int>(precioPublico.value);
    }
    if (costoProduccion.present) {
      map['costo_produccion'] = Variable<int>(costoProduccion.value);
    }
    if (stockActual.present) {
      map['stock_actual'] = Variable<double>(stockActual.value);
    }
    if (stockMinimo.present) {
      map['stock_minimo'] = Variable<double>(stockMinimo.value);
    }
    if (estado.present) {
      map['estado'] = Variable<String>(estado.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductosCompanion(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('categoriaId: $categoriaId, ')
          ..write('unidadVenta: $unidadVenta, ')
          ..write('precioVendedor: $precioVendedor, ')
          ..write('precioPublico: $precioPublico, ')
          ..write('costoProduccion: $costoProduccion, ')
          ..write('stockActual: $stockActual, ')
          ..write('stockMinimo: $stockMinimo, ')
          ..write('estado: $estado')
          ..write(')'))
        .toString();
  }
}

class $HistorialPreciosTable extends HistorialPrecios
    with TableInfo<$HistorialPreciosTable, HistorialPrecio> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HistorialPreciosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _productoIdMeta = const VerificationMeta(
    'productoId',
  );
  @override
  late final GeneratedColumn<int> productoId = GeneratedColumn<int>(
    'producto_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tipoPrecioMeta = const VerificationMeta(
    'tipoPrecio',
  );
  @override
  late final GeneratedColumn<String> tipoPrecio = GeneratedColumn<String>(
    'tipo_precio',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _precioAnteriorMeta = const VerificationMeta(
    'precioAnterior',
  );
  @override
  late final GeneratedColumn<int> precioAnterior = GeneratedColumn<int>(
    'precio_anterior',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _precioNuevoMeta = const VerificationMeta(
    'precioNuevo',
  );
  @override
  late final GeneratedColumn<int> precioNuevo = GeneratedColumn<int>(
    'precio_nuevo',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _motivoMeta = const VerificationMeta('motivo');
  @override
  late final GeneratedColumn<String> motivo = GeneratedColumn<String>(
    'motivo',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _usuarioIdMeta = const VerificationMeta(
    'usuarioId',
  );
  @override
  late final GeneratedColumn<int> usuarioId = GeneratedColumn<int>(
    'usuario_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
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
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    productoId,
    tipoPrecio,
    precioAnterior,
    precioNuevo,
    motivo,
    usuarioId,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'historial_precios';
  @override
  VerificationContext validateIntegrity(
    Insertable<HistorialPrecio> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('producto_id')) {
      context.handle(
        _productoIdMeta,
        productoId.isAcceptableOrUnknown(data['producto_id']!, _productoIdMeta),
      );
    } else if (isInserting) {
      context.missing(_productoIdMeta);
    }
    if (data.containsKey('tipo_precio')) {
      context.handle(
        _tipoPrecioMeta,
        tipoPrecio.isAcceptableOrUnknown(data['tipo_precio']!, _tipoPrecioMeta),
      );
    } else if (isInserting) {
      context.missing(_tipoPrecioMeta);
    }
    if (data.containsKey('precio_anterior')) {
      context.handle(
        _precioAnteriorMeta,
        precioAnterior.isAcceptableOrUnknown(
          data['precio_anterior']!,
          _precioAnteriorMeta,
        ),
      );
    }
    if (data.containsKey('precio_nuevo')) {
      context.handle(
        _precioNuevoMeta,
        precioNuevo.isAcceptableOrUnknown(
          data['precio_nuevo']!,
          _precioNuevoMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_precioNuevoMeta);
    }
    if (data.containsKey('motivo')) {
      context.handle(
        _motivoMeta,
        motivo.isAcceptableOrUnknown(data['motivo']!, _motivoMeta),
      );
    }
    if (data.containsKey('usuario_id')) {
      context.handle(
        _usuarioIdMeta,
        usuarioId.isAcceptableOrUnknown(data['usuario_id']!, _usuarioIdMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  HistorialPrecio map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HistorialPrecio(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      productoId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}producto_id'],
      )!,
      tipoPrecio: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tipo_precio'],
      )!,
      precioAnterior: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}precio_anterior'],
      ),
      precioNuevo: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}precio_nuevo'],
      )!,
      motivo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}motivo'],
      ),
      usuarioId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}usuario_id'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $HistorialPreciosTable createAlias(String alias) {
    return $HistorialPreciosTable(attachedDatabase, alias);
  }
}

class HistorialPrecio extends DataClass implements Insertable<HistorialPrecio> {
  final int id;
  final int productoId;
  final String tipoPrecio;
  final int? precioAnterior;
  final int precioNuevo;
  final String? motivo;
  final int? usuarioId;
  final DateTime createdAt;
  const HistorialPrecio({
    required this.id,
    required this.productoId,
    required this.tipoPrecio,
    this.precioAnterior,
    required this.precioNuevo,
    this.motivo,
    this.usuarioId,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['producto_id'] = Variable<int>(productoId);
    map['tipo_precio'] = Variable<String>(tipoPrecio);
    if (!nullToAbsent || precioAnterior != null) {
      map['precio_anterior'] = Variable<int>(precioAnterior);
    }
    map['precio_nuevo'] = Variable<int>(precioNuevo);
    if (!nullToAbsent || motivo != null) {
      map['motivo'] = Variable<String>(motivo);
    }
    if (!nullToAbsent || usuarioId != null) {
      map['usuario_id'] = Variable<int>(usuarioId);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  HistorialPreciosCompanion toCompanion(bool nullToAbsent) {
    return HistorialPreciosCompanion(
      id: Value(id),
      productoId: Value(productoId),
      tipoPrecio: Value(tipoPrecio),
      precioAnterior: precioAnterior == null && nullToAbsent
          ? const Value.absent()
          : Value(precioAnterior),
      precioNuevo: Value(precioNuevo),
      motivo: motivo == null && nullToAbsent
          ? const Value.absent()
          : Value(motivo),
      usuarioId: usuarioId == null && nullToAbsent
          ? const Value.absent()
          : Value(usuarioId),
      createdAt: Value(createdAt),
    );
  }

  factory HistorialPrecio.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HistorialPrecio(
      id: serializer.fromJson<int>(json['id']),
      productoId: serializer.fromJson<int>(json['productoId']),
      tipoPrecio: serializer.fromJson<String>(json['tipoPrecio']),
      precioAnterior: serializer.fromJson<int?>(json['precioAnterior']),
      precioNuevo: serializer.fromJson<int>(json['precioNuevo']),
      motivo: serializer.fromJson<String?>(json['motivo']),
      usuarioId: serializer.fromJson<int?>(json['usuarioId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'productoId': serializer.toJson<int>(productoId),
      'tipoPrecio': serializer.toJson<String>(tipoPrecio),
      'precioAnterior': serializer.toJson<int?>(precioAnterior),
      'precioNuevo': serializer.toJson<int>(precioNuevo),
      'motivo': serializer.toJson<String?>(motivo),
      'usuarioId': serializer.toJson<int?>(usuarioId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  HistorialPrecio copyWith({
    int? id,
    int? productoId,
    String? tipoPrecio,
    Value<int?> precioAnterior = const Value.absent(),
    int? precioNuevo,
    Value<String?> motivo = const Value.absent(),
    Value<int?> usuarioId = const Value.absent(),
    DateTime? createdAt,
  }) => HistorialPrecio(
    id: id ?? this.id,
    productoId: productoId ?? this.productoId,
    tipoPrecio: tipoPrecio ?? this.tipoPrecio,
    precioAnterior: precioAnterior.present
        ? precioAnterior.value
        : this.precioAnterior,
    precioNuevo: precioNuevo ?? this.precioNuevo,
    motivo: motivo.present ? motivo.value : this.motivo,
    usuarioId: usuarioId.present ? usuarioId.value : this.usuarioId,
    createdAt: createdAt ?? this.createdAt,
  );
  HistorialPrecio copyWithCompanion(HistorialPreciosCompanion data) {
    return HistorialPrecio(
      id: data.id.present ? data.id.value : this.id,
      productoId: data.productoId.present
          ? data.productoId.value
          : this.productoId,
      tipoPrecio: data.tipoPrecio.present
          ? data.tipoPrecio.value
          : this.tipoPrecio,
      precioAnterior: data.precioAnterior.present
          ? data.precioAnterior.value
          : this.precioAnterior,
      precioNuevo: data.precioNuevo.present
          ? data.precioNuevo.value
          : this.precioNuevo,
      motivo: data.motivo.present ? data.motivo.value : this.motivo,
      usuarioId: data.usuarioId.present ? data.usuarioId.value : this.usuarioId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HistorialPrecio(')
          ..write('id: $id, ')
          ..write('productoId: $productoId, ')
          ..write('tipoPrecio: $tipoPrecio, ')
          ..write('precioAnterior: $precioAnterior, ')
          ..write('precioNuevo: $precioNuevo, ')
          ..write('motivo: $motivo, ')
          ..write('usuarioId: $usuarioId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    productoId,
    tipoPrecio,
    precioAnterior,
    precioNuevo,
    motivo,
    usuarioId,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HistorialPrecio &&
          other.id == this.id &&
          other.productoId == this.productoId &&
          other.tipoPrecio == this.tipoPrecio &&
          other.precioAnterior == this.precioAnterior &&
          other.precioNuevo == this.precioNuevo &&
          other.motivo == this.motivo &&
          other.usuarioId == this.usuarioId &&
          other.createdAt == this.createdAt);
}

class HistorialPreciosCompanion extends UpdateCompanion<HistorialPrecio> {
  final Value<int> id;
  final Value<int> productoId;
  final Value<String> tipoPrecio;
  final Value<int?> precioAnterior;
  final Value<int> precioNuevo;
  final Value<String?> motivo;
  final Value<int?> usuarioId;
  final Value<DateTime> createdAt;
  const HistorialPreciosCompanion({
    this.id = const Value.absent(),
    this.productoId = const Value.absent(),
    this.tipoPrecio = const Value.absent(),
    this.precioAnterior = const Value.absent(),
    this.precioNuevo = const Value.absent(),
    this.motivo = const Value.absent(),
    this.usuarioId = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  HistorialPreciosCompanion.insert({
    this.id = const Value.absent(),
    required int productoId,
    required String tipoPrecio,
    this.precioAnterior = const Value.absent(),
    required int precioNuevo,
    this.motivo = const Value.absent(),
    this.usuarioId = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : productoId = Value(productoId),
       tipoPrecio = Value(tipoPrecio),
       precioNuevo = Value(precioNuevo);
  static Insertable<HistorialPrecio> custom({
    Expression<int>? id,
    Expression<int>? productoId,
    Expression<String>? tipoPrecio,
    Expression<int>? precioAnterior,
    Expression<int>? precioNuevo,
    Expression<String>? motivo,
    Expression<int>? usuarioId,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (productoId != null) 'producto_id': productoId,
      if (tipoPrecio != null) 'tipo_precio': tipoPrecio,
      if (precioAnterior != null) 'precio_anterior': precioAnterior,
      if (precioNuevo != null) 'precio_nuevo': precioNuevo,
      if (motivo != null) 'motivo': motivo,
      if (usuarioId != null) 'usuario_id': usuarioId,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  HistorialPreciosCompanion copyWith({
    Value<int>? id,
    Value<int>? productoId,
    Value<String>? tipoPrecio,
    Value<int?>? precioAnterior,
    Value<int>? precioNuevo,
    Value<String?>? motivo,
    Value<int?>? usuarioId,
    Value<DateTime>? createdAt,
  }) {
    return HistorialPreciosCompanion(
      id: id ?? this.id,
      productoId: productoId ?? this.productoId,
      tipoPrecio: tipoPrecio ?? this.tipoPrecio,
      precioAnterior: precioAnterior ?? this.precioAnterior,
      precioNuevo: precioNuevo ?? this.precioNuevo,
      motivo: motivo ?? this.motivo,
      usuarioId: usuarioId ?? this.usuarioId,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (productoId.present) {
      map['producto_id'] = Variable<int>(productoId.value);
    }
    if (tipoPrecio.present) {
      map['tipo_precio'] = Variable<String>(tipoPrecio.value);
    }
    if (precioAnterior.present) {
      map['precio_anterior'] = Variable<int>(precioAnterior.value);
    }
    if (precioNuevo.present) {
      map['precio_nuevo'] = Variable<int>(precioNuevo.value);
    }
    if (motivo.present) {
      map['motivo'] = Variable<String>(motivo.value);
    }
    if (usuarioId.present) {
      map['usuario_id'] = Variable<int>(usuarioId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HistorialPreciosCompanion(')
          ..write('id: $id, ')
          ..write('productoId: $productoId, ')
          ..write('tipoPrecio: $tipoPrecio, ')
          ..write('precioAnterior: $precioAnterior, ')
          ..write('precioNuevo: $precioNuevo, ')
          ..write('motivo: $motivo, ')
          ..write('usuarioId: $usuarioId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $ClientesTable extends Clientes with TableInfo<$ClientesTable, Cliente> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ClientesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nombreMeta = const VerificationMeta('nombre');
  @override
  late final GeneratedColumn<String> nombre = GeneratedColumn<String>(
    'nombre',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 120,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tipoMeta = const VerificationMeta('tipo');
  @override
  late final GeneratedColumn<String> tipo = GeneratedColumn<String>(
    'tipo',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('ocasional'),
  );
  static const VerificationMeta _contactoMeta = const VerificationMeta(
    'contacto',
  );
  @override
  late final GeneratedColumn<String> contacto = GeneratedColumn<String>(
    'contacto',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _diasVisitaMeta = const VerificationMeta(
    'diasVisita',
  );
  @override
  late final GeneratedColumn<String> diasVisita = GeneratedColumn<String>(
    'dias_visita',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('L,M,X,J,V,S'),
  );
  static const VerificationMeta _notasMeta = const VerificationMeta('notas');
  @override
  late final GeneratedColumn<String> notas = GeneratedColumn<String>(
    'notas',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _activoMeta = const VerificationMeta('activo');
  @override
  late final GeneratedColumn<bool> activo = GeneratedColumn<bool>(
    'activo',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("activo" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [
    createdAt,
    updatedAt,
    deletedAt,
    id,
    nombre,
    tipo,
    contacto,
    diasVisita,
    notas,
    activo,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'clientes';
  @override
  VerificationContext validateIntegrity(
    Insertable<Cliente> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nombre')) {
      context.handle(
        _nombreMeta,
        nombre.isAcceptableOrUnknown(data['nombre']!, _nombreMeta),
      );
    } else if (isInserting) {
      context.missing(_nombreMeta);
    }
    if (data.containsKey('tipo')) {
      context.handle(
        _tipoMeta,
        tipo.isAcceptableOrUnknown(data['tipo']!, _tipoMeta),
      );
    }
    if (data.containsKey('contacto')) {
      context.handle(
        _contactoMeta,
        contacto.isAcceptableOrUnknown(data['contacto']!, _contactoMeta),
      );
    }
    if (data.containsKey('dias_visita')) {
      context.handle(
        _diasVisitaMeta,
        diasVisita.isAcceptableOrUnknown(data['dias_visita']!, _diasVisitaMeta),
      );
    }
    if (data.containsKey('notas')) {
      context.handle(
        _notasMeta,
        notas.isAcceptableOrUnknown(data['notas']!, _notasMeta),
      );
    }
    if (data.containsKey('activo')) {
      context.handle(
        _activoMeta,
        activo.isAcceptableOrUnknown(data['activo']!, _activoMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Cliente map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Cliente(
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      nombre: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nombre'],
      )!,
      tipo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tipo'],
      )!,
      contacto: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}contacto'],
      ),
      diasVisita: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}dias_visita'],
      )!,
      notas: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notas'],
      ),
      activo: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}activo'],
      )!,
    );
  }

  @override
  $ClientesTable createAlias(String alias) {
    return $ClientesTable(attachedDatabase, alias);
  }
}

class Cliente extends DataClass implements Insertable<Cliente> {
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final int id;
  final String nombre;
  final String tipo;
  final String? contacto;
  final String diasVisita;
  final String? notas;
  final bool activo;
  const Cliente({
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.id,
    required this.nombre,
    required this.tipo,
    this.contacto,
    required this.diasVisita,
    this.notas,
    required this.activo,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['id'] = Variable<int>(id);
    map['nombre'] = Variable<String>(nombre);
    map['tipo'] = Variable<String>(tipo);
    if (!nullToAbsent || contacto != null) {
      map['contacto'] = Variable<String>(contacto);
    }
    map['dias_visita'] = Variable<String>(diasVisita);
    if (!nullToAbsent || notas != null) {
      map['notas'] = Variable<String>(notas);
    }
    map['activo'] = Variable<bool>(activo);
    return map;
  }

  ClientesCompanion toCompanion(bool nullToAbsent) {
    return ClientesCompanion(
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      id: Value(id),
      nombre: Value(nombre),
      tipo: Value(tipo),
      contacto: contacto == null && nullToAbsent
          ? const Value.absent()
          : Value(contacto),
      diasVisita: Value(diasVisita),
      notas: notas == null && nullToAbsent
          ? const Value.absent()
          : Value(notas),
      activo: Value(activo),
    );
  }

  factory Cliente.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Cliente(
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      id: serializer.fromJson<int>(json['id']),
      nombre: serializer.fromJson<String>(json['nombre']),
      tipo: serializer.fromJson<String>(json['tipo']),
      contacto: serializer.fromJson<String?>(json['contacto']),
      diasVisita: serializer.fromJson<String>(json['diasVisita']),
      notas: serializer.fromJson<String?>(json['notas']),
      activo: serializer.fromJson<bool>(json['activo']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'id': serializer.toJson<int>(id),
      'nombre': serializer.toJson<String>(nombre),
      'tipo': serializer.toJson<String>(tipo),
      'contacto': serializer.toJson<String?>(contacto),
      'diasVisita': serializer.toJson<String>(diasVisita),
      'notas': serializer.toJson<String?>(notas),
      'activo': serializer.toJson<bool>(activo),
    };
  }

  Cliente copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    int? id,
    String? nombre,
    String? tipo,
    Value<String?> contacto = const Value.absent(),
    String? diasVisita,
    Value<String?> notas = const Value.absent(),
    bool? activo,
  }) => Cliente(
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    id: id ?? this.id,
    nombre: nombre ?? this.nombre,
    tipo: tipo ?? this.tipo,
    contacto: contacto.present ? contacto.value : this.contacto,
    diasVisita: diasVisita ?? this.diasVisita,
    notas: notas.present ? notas.value : this.notas,
    activo: activo ?? this.activo,
  );
  Cliente copyWithCompanion(ClientesCompanion data) {
    return Cliente(
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      id: data.id.present ? data.id.value : this.id,
      nombre: data.nombre.present ? data.nombre.value : this.nombre,
      tipo: data.tipo.present ? data.tipo.value : this.tipo,
      contacto: data.contacto.present ? data.contacto.value : this.contacto,
      diasVisita: data.diasVisita.present
          ? data.diasVisita.value
          : this.diasVisita,
      notas: data.notas.present ? data.notas.value : this.notas,
      activo: data.activo.present ? data.activo.value : this.activo,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Cliente(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('tipo: $tipo, ')
          ..write('contacto: $contacto, ')
          ..write('diasVisita: $diasVisita, ')
          ..write('notas: $notas, ')
          ..write('activo: $activo')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    createdAt,
    updatedAt,
    deletedAt,
    id,
    nombre,
    tipo,
    contacto,
    diasVisita,
    notas,
    activo,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Cliente &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.id == this.id &&
          other.nombre == this.nombre &&
          other.tipo == this.tipo &&
          other.contacto == this.contacto &&
          other.diasVisita == this.diasVisita &&
          other.notas == this.notas &&
          other.activo == this.activo);
}

class ClientesCompanion extends UpdateCompanion<Cliente> {
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<int> id;
  final Value<String> nombre;
  final Value<String> tipo;
  final Value<String?> contacto;
  final Value<String> diasVisita;
  final Value<String?> notas;
  final Value<bool> activo;
  const ClientesCompanion({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.nombre = const Value.absent(),
    this.tipo = const Value.absent(),
    this.contacto = const Value.absent(),
    this.diasVisita = const Value.absent(),
    this.notas = const Value.absent(),
    this.activo = const Value.absent(),
  });
  ClientesCompanion.insert({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.id = const Value.absent(),
    required String nombre,
    this.tipo = const Value.absent(),
    this.contacto = const Value.absent(),
    this.diasVisita = const Value.absent(),
    this.notas = const Value.absent(),
    this.activo = const Value.absent(),
  }) : nombre = Value(nombre);
  static Insertable<Cliente> custom({
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<int>? id,
    Expression<String>? nombre,
    Expression<String>? tipo,
    Expression<String>? contacto,
    Expression<String>? diasVisita,
    Expression<String>? notas,
    Expression<bool>? activo,
  }) {
    return RawValuesInsertable({
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (id != null) 'id': id,
      if (nombre != null) 'nombre': nombre,
      if (tipo != null) 'tipo': tipo,
      if (contacto != null) 'contacto': contacto,
      if (diasVisita != null) 'dias_visita': diasVisita,
      if (notas != null) 'notas': notas,
      if (activo != null) 'activo': activo,
    });
  }

  ClientesCompanion copyWith({
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<int>? id,
    Value<String>? nombre,
    Value<String>? tipo,
    Value<String?>? contacto,
    Value<String>? diasVisita,
    Value<String?>? notas,
    Value<bool>? activo,
  }) {
    return ClientesCompanion(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      tipo: tipo ?? this.tipo,
      contacto: contacto ?? this.contacto,
      diasVisita: diasVisita ?? this.diasVisita,
      notas: notas ?? this.notas,
      activo: activo ?? this.activo,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nombre.present) {
      map['nombre'] = Variable<String>(nombre.value);
    }
    if (tipo.present) {
      map['tipo'] = Variable<String>(tipo.value);
    }
    if (contacto.present) {
      map['contacto'] = Variable<String>(contacto.value);
    }
    if (diasVisita.present) {
      map['dias_visita'] = Variable<String>(diasVisita.value);
    }
    if (notas.present) {
      map['notas'] = Variable<String>(notas.value);
    }
    if (activo.present) {
      map['activo'] = Variable<bool>(activo.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ClientesCompanion(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('tipo: $tipo, ')
          ..write('contacto: $contacto, ')
          ..write('diasVisita: $diasVisita, ')
          ..write('notas: $notas, ')
          ..write('activo: $activo')
          ..write(')'))
        .toString();
  }
}

class $VentasTable extends Ventas with TableInfo<$VentasTable, Venta> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VentasTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _clienteIdMeta = const VerificationMeta(
    'clienteId',
  );
  @override
  late final GeneratedColumn<int> clienteId = GeneratedColumn<int>(
    'cliente_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _tipoCompradorMeta = const VerificationMeta(
    'tipoComprador',
  );
  @override
  late final GeneratedColumn<String> tipoComprador = GeneratedColumn<String>(
    'tipo_comprador',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _subtotalMeta = const VerificationMeta(
    'subtotal',
  );
  @override
  late final GeneratedColumn<int> subtotal = GeneratedColumn<int>(
    'subtotal',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _totalMeta = const VerificationMeta('total');
  @override
  late final GeneratedColumn<int> total = GeneratedColumn<int>(
    'total',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _estadoPagoMeta = const VerificationMeta(
    'estadoPago',
  );
  @override
  late final GeneratedColumn<String> estadoPago = GeneratedColumn<String>(
    'estado_pago',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pagado'),
  );
  static const VerificationMeta _montoPagadoMeta = const VerificationMeta(
    'montoPagado',
  );
  @override
  late final GeneratedColumn<int> montoPagado = GeneratedColumn<int>(
    'monto_pagado',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _costoTotalMeta = const VerificationMeta(
    'costoTotal',
  );
  @override
  late final GeneratedColumn<int> costoTotal = GeneratedColumn<int>(
    'costo_total',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notaMeta = const VerificationMeta('nota');
  @override
  late final GeneratedColumn<String> nota = GeneratedColumn<String>(
    'nota',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _usuarioIdMeta = const VerificationMeta(
    'usuarioId',
  );
  @override
  late final GeneratedColumn<int> usuarioId = GeneratedColumn<int>(
    'usuario_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _fechaMeta = const VerificationMeta('fecha');
  @override
  late final GeneratedColumn<DateTime> fecha = GeneratedColumn<DateTime>(
    'fecha',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    createdAt,
    updatedAt,
    deletedAt,
    id,
    clienteId,
    tipoComprador,
    subtotal,
    total,
    estadoPago,
    montoPagado,
    costoTotal,
    nota,
    usuarioId,
    fecha,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ventas';
  @override
  VerificationContext validateIntegrity(
    Insertable<Venta> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('cliente_id')) {
      context.handle(
        _clienteIdMeta,
        clienteId.isAcceptableOrUnknown(data['cliente_id']!, _clienteIdMeta),
      );
    }
    if (data.containsKey('tipo_comprador')) {
      context.handle(
        _tipoCompradorMeta,
        tipoComprador.isAcceptableOrUnknown(
          data['tipo_comprador']!,
          _tipoCompradorMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_tipoCompradorMeta);
    }
    if (data.containsKey('subtotal')) {
      context.handle(
        _subtotalMeta,
        subtotal.isAcceptableOrUnknown(data['subtotal']!, _subtotalMeta),
      );
    }
    if (data.containsKey('total')) {
      context.handle(
        _totalMeta,
        total.isAcceptableOrUnknown(data['total']!, _totalMeta),
      );
    }
    if (data.containsKey('estado_pago')) {
      context.handle(
        _estadoPagoMeta,
        estadoPago.isAcceptableOrUnknown(data['estado_pago']!, _estadoPagoMeta),
      );
    }
    if (data.containsKey('monto_pagado')) {
      context.handle(
        _montoPagadoMeta,
        montoPagado.isAcceptableOrUnknown(
          data['monto_pagado']!,
          _montoPagadoMeta,
        ),
      );
    }
    if (data.containsKey('costo_total')) {
      context.handle(
        _costoTotalMeta,
        costoTotal.isAcceptableOrUnknown(data['costo_total']!, _costoTotalMeta),
      );
    }
    if (data.containsKey('nota')) {
      context.handle(
        _notaMeta,
        nota.isAcceptableOrUnknown(data['nota']!, _notaMeta),
      );
    }
    if (data.containsKey('usuario_id')) {
      context.handle(
        _usuarioIdMeta,
        usuarioId.isAcceptableOrUnknown(data['usuario_id']!, _usuarioIdMeta),
      );
    }
    if (data.containsKey('fecha')) {
      context.handle(
        _fechaMeta,
        fecha.isAcceptableOrUnknown(data['fecha']!, _fechaMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Venta map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Venta(
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      clienteId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}cliente_id'],
      ),
      tipoComprador: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tipo_comprador'],
      )!,
      subtotal: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}subtotal'],
      )!,
      total: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total'],
      )!,
      estadoPago: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}estado_pago'],
      )!,
      montoPagado: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}monto_pagado'],
      )!,
      costoTotal: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}costo_total'],
      ),
      nota: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nota'],
      ),
      usuarioId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}usuario_id'],
      ),
      fecha: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}fecha'],
      )!,
    );
  }

  @override
  $VentasTable createAlias(String alias) {
    return $VentasTable(attachedDatabase, alias);
  }
}

class Venta extends DataClass implements Insertable<Venta> {
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final int id;
  final int? clienteId;
  final String tipoComprador;
  final int subtotal;
  final int total;
  final String estadoPago;
  final int montoPagado;
  final int? costoTotal;
  final String? nota;
  final int? usuarioId;
  final DateTime fecha;
  const Venta({
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.id,
    this.clienteId,
    required this.tipoComprador,
    required this.subtotal,
    required this.total,
    required this.estadoPago,
    required this.montoPagado,
    this.costoTotal,
    this.nota,
    this.usuarioId,
    required this.fecha,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || clienteId != null) {
      map['cliente_id'] = Variable<int>(clienteId);
    }
    map['tipo_comprador'] = Variable<String>(tipoComprador);
    map['subtotal'] = Variable<int>(subtotal);
    map['total'] = Variable<int>(total);
    map['estado_pago'] = Variable<String>(estadoPago);
    map['monto_pagado'] = Variable<int>(montoPagado);
    if (!nullToAbsent || costoTotal != null) {
      map['costo_total'] = Variable<int>(costoTotal);
    }
    if (!nullToAbsent || nota != null) {
      map['nota'] = Variable<String>(nota);
    }
    if (!nullToAbsent || usuarioId != null) {
      map['usuario_id'] = Variable<int>(usuarioId);
    }
    map['fecha'] = Variable<DateTime>(fecha);
    return map;
  }

  VentasCompanion toCompanion(bool nullToAbsent) {
    return VentasCompanion(
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      id: Value(id),
      clienteId: clienteId == null && nullToAbsent
          ? const Value.absent()
          : Value(clienteId),
      tipoComprador: Value(tipoComprador),
      subtotal: Value(subtotal),
      total: Value(total),
      estadoPago: Value(estadoPago),
      montoPagado: Value(montoPagado),
      costoTotal: costoTotal == null && nullToAbsent
          ? const Value.absent()
          : Value(costoTotal),
      nota: nota == null && nullToAbsent ? const Value.absent() : Value(nota),
      usuarioId: usuarioId == null && nullToAbsent
          ? const Value.absent()
          : Value(usuarioId),
      fecha: Value(fecha),
    );
  }

  factory Venta.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Venta(
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      id: serializer.fromJson<int>(json['id']),
      clienteId: serializer.fromJson<int?>(json['clienteId']),
      tipoComprador: serializer.fromJson<String>(json['tipoComprador']),
      subtotal: serializer.fromJson<int>(json['subtotal']),
      total: serializer.fromJson<int>(json['total']),
      estadoPago: serializer.fromJson<String>(json['estadoPago']),
      montoPagado: serializer.fromJson<int>(json['montoPagado']),
      costoTotal: serializer.fromJson<int?>(json['costoTotal']),
      nota: serializer.fromJson<String?>(json['nota']),
      usuarioId: serializer.fromJson<int?>(json['usuarioId']),
      fecha: serializer.fromJson<DateTime>(json['fecha']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'id': serializer.toJson<int>(id),
      'clienteId': serializer.toJson<int?>(clienteId),
      'tipoComprador': serializer.toJson<String>(tipoComprador),
      'subtotal': serializer.toJson<int>(subtotal),
      'total': serializer.toJson<int>(total),
      'estadoPago': serializer.toJson<String>(estadoPago),
      'montoPagado': serializer.toJson<int>(montoPagado),
      'costoTotal': serializer.toJson<int?>(costoTotal),
      'nota': serializer.toJson<String?>(nota),
      'usuarioId': serializer.toJson<int?>(usuarioId),
      'fecha': serializer.toJson<DateTime>(fecha),
    };
  }

  Venta copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    int? id,
    Value<int?> clienteId = const Value.absent(),
    String? tipoComprador,
    int? subtotal,
    int? total,
    String? estadoPago,
    int? montoPagado,
    Value<int?> costoTotal = const Value.absent(),
    Value<String?> nota = const Value.absent(),
    Value<int?> usuarioId = const Value.absent(),
    DateTime? fecha,
  }) => Venta(
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    id: id ?? this.id,
    clienteId: clienteId.present ? clienteId.value : this.clienteId,
    tipoComprador: tipoComprador ?? this.tipoComprador,
    subtotal: subtotal ?? this.subtotal,
    total: total ?? this.total,
    estadoPago: estadoPago ?? this.estadoPago,
    montoPagado: montoPagado ?? this.montoPagado,
    costoTotal: costoTotal.present ? costoTotal.value : this.costoTotal,
    nota: nota.present ? nota.value : this.nota,
    usuarioId: usuarioId.present ? usuarioId.value : this.usuarioId,
    fecha: fecha ?? this.fecha,
  );
  Venta copyWithCompanion(VentasCompanion data) {
    return Venta(
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      id: data.id.present ? data.id.value : this.id,
      clienteId: data.clienteId.present ? data.clienteId.value : this.clienteId,
      tipoComprador: data.tipoComprador.present
          ? data.tipoComprador.value
          : this.tipoComprador,
      subtotal: data.subtotal.present ? data.subtotal.value : this.subtotal,
      total: data.total.present ? data.total.value : this.total,
      estadoPago: data.estadoPago.present
          ? data.estadoPago.value
          : this.estadoPago,
      montoPagado: data.montoPagado.present
          ? data.montoPagado.value
          : this.montoPagado,
      costoTotal: data.costoTotal.present
          ? data.costoTotal.value
          : this.costoTotal,
      nota: data.nota.present ? data.nota.value : this.nota,
      usuarioId: data.usuarioId.present ? data.usuarioId.value : this.usuarioId,
      fecha: data.fecha.present ? data.fecha.value : this.fecha,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Venta(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('clienteId: $clienteId, ')
          ..write('tipoComprador: $tipoComprador, ')
          ..write('subtotal: $subtotal, ')
          ..write('total: $total, ')
          ..write('estadoPago: $estadoPago, ')
          ..write('montoPagado: $montoPagado, ')
          ..write('costoTotal: $costoTotal, ')
          ..write('nota: $nota, ')
          ..write('usuarioId: $usuarioId, ')
          ..write('fecha: $fecha')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    createdAt,
    updatedAt,
    deletedAt,
    id,
    clienteId,
    tipoComprador,
    subtotal,
    total,
    estadoPago,
    montoPagado,
    costoTotal,
    nota,
    usuarioId,
    fecha,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Venta &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.id == this.id &&
          other.clienteId == this.clienteId &&
          other.tipoComprador == this.tipoComprador &&
          other.subtotal == this.subtotal &&
          other.total == this.total &&
          other.estadoPago == this.estadoPago &&
          other.montoPagado == this.montoPagado &&
          other.costoTotal == this.costoTotal &&
          other.nota == this.nota &&
          other.usuarioId == this.usuarioId &&
          other.fecha == this.fecha);
}

class VentasCompanion extends UpdateCompanion<Venta> {
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<int> id;
  final Value<int?> clienteId;
  final Value<String> tipoComprador;
  final Value<int> subtotal;
  final Value<int> total;
  final Value<String> estadoPago;
  final Value<int> montoPagado;
  final Value<int?> costoTotal;
  final Value<String?> nota;
  final Value<int?> usuarioId;
  final Value<DateTime> fecha;
  const VentasCompanion({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.clienteId = const Value.absent(),
    this.tipoComprador = const Value.absent(),
    this.subtotal = const Value.absent(),
    this.total = const Value.absent(),
    this.estadoPago = const Value.absent(),
    this.montoPagado = const Value.absent(),
    this.costoTotal = const Value.absent(),
    this.nota = const Value.absent(),
    this.usuarioId = const Value.absent(),
    this.fecha = const Value.absent(),
  });
  VentasCompanion.insert({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.clienteId = const Value.absent(),
    required String tipoComprador,
    this.subtotal = const Value.absent(),
    this.total = const Value.absent(),
    this.estadoPago = const Value.absent(),
    this.montoPagado = const Value.absent(),
    this.costoTotal = const Value.absent(),
    this.nota = const Value.absent(),
    this.usuarioId = const Value.absent(),
    this.fecha = const Value.absent(),
  }) : tipoComprador = Value(tipoComprador);
  static Insertable<Venta> custom({
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<int>? id,
    Expression<int>? clienteId,
    Expression<String>? tipoComprador,
    Expression<int>? subtotal,
    Expression<int>? total,
    Expression<String>? estadoPago,
    Expression<int>? montoPagado,
    Expression<int>? costoTotal,
    Expression<String>? nota,
    Expression<int>? usuarioId,
    Expression<DateTime>? fecha,
  }) {
    return RawValuesInsertable({
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (id != null) 'id': id,
      if (clienteId != null) 'cliente_id': clienteId,
      if (tipoComprador != null) 'tipo_comprador': tipoComprador,
      if (subtotal != null) 'subtotal': subtotal,
      if (total != null) 'total': total,
      if (estadoPago != null) 'estado_pago': estadoPago,
      if (montoPagado != null) 'monto_pagado': montoPagado,
      if (costoTotal != null) 'costo_total': costoTotal,
      if (nota != null) 'nota': nota,
      if (usuarioId != null) 'usuario_id': usuarioId,
      if (fecha != null) 'fecha': fecha,
    });
  }

  VentasCompanion copyWith({
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<int>? id,
    Value<int?>? clienteId,
    Value<String>? tipoComprador,
    Value<int>? subtotal,
    Value<int>? total,
    Value<String>? estadoPago,
    Value<int>? montoPagado,
    Value<int?>? costoTotal,
    Value<String?>? nota,
    Value<int?>? usuarioId,
    Value<DateTime>? fecha,
  }) {
    return VentasCompanion(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      id: id ?? this.id,
      clienteId: clienteId ?? this.clienteId,
      tipoComprador: tipoComprador ?? this.tipoComprador,
      subtotal: subtotal ?? this.subtotal,
      total: total ?? this.total,
      estadoPago: estadoPago ?? this.estadoPago,
      montoPagado: montoPagado ?? this.montoPagado,
      costoTotal: costoTotal ?? this.costoTotal,
      nota: nota ?? this.nota,
      usuarioId: usuarioId ?? this.usuarioId,
      fecha: fecha ?? this.fecha,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (clienteId.present) {
      map['cliente_id'] = Variable<int>(clienteId.value);
    }
    if (tipoComprador.present) {
      map['tipo_comprador'] = Variable<String>(tipoComprador.value);
    }
    if (subtotal.present) {
      map['subtotal'] = Variable<int>(subtotal.value);
    }
    if (total.present) {
      map['total'] = Variable<int>(total.value);
    }
    if (estadoPago.present) {
      map['estado_pago'] = Variable<String>(estadoPago.value);
    }
    if (montoPagado.present) {
      map['monto_pagado'] = Variable<int>(montoPagado.value);
    }
    if (costoTotal.present) {
      map['costo_total'] = Variable<int>(costoTotal.value);
    }
    if (nota.present) {
      map['nota'] = Variable<String>(nota.value);
    }
    if (usuarioId.present) {
      map['usuario_id'] = Variable<int>(usuarioId.value);
    }
    if (fecha.present) {
      map['fecha'] = Variable<DateTime>(fecha.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VentasCompanion(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('clienteId: $clienteId, ')
          ..write('tipoComprador: $tipoComprador, ')
          ..write('subtotal: $subtotal, ')
          ..write('total: $total, ')
          ..write('estadoPago: $estadoPago, ')
          ..write('montoPagado: $montoPagado, ')
          ..write('costoTotal: $costoTotal, ')
          ..write('nota: $nota, ')
          ..write('usuarioId: $usuarioId, ')
          ..write('fecha: $fecha')
          ..write(')'))
        .toString();
  }
}

class $DetalleVentasTable extends DetalleVentas
    with TableInfo<$DetalleVentasTable, DetalleVenta> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DetalleVentasTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _ventaIdMeta = const VerificationMeta(
    'ventaId',
  );
  @override
  late final GeneratedColumn<int> ventaId = GeneratedColumn<int>(
    'venta_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _productoIdMeta = const VerificationMeta(
    'productoId',
  );
  @override
  late final GeneratedColumn<int> productoId = GeneratedColumn<int>(
    'producto_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nombreProductoMeta = const VerificationMeta(
    'nombreProducto',
  );
  @override
  late final GeneratedColumn<String> nombreProducto = GeneratedColumn<String>(
    'nombre_producto',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cantidadMeta = const VerificationMeta(
    'cantidad',
  );
  @override
  late final GeneratedColumn<double> cantidad = GeneratedColumn<double>(
    'cantidad',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _precioUnitarioMeta = const VerificationMeta(
    'precioUnitario',
  );
  @override
  late final GeneratedColumn<int> precioUnitario = GeneratedColumn<int>(
    'precio_unitario',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _precioTipoMeta = const VerificationMeta(
    'precioTipo',
  );
  @override
  late final GeneratedColumn<String> precioTipo = GeneratedColumn<String>(
    'precio_tipo',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _costoUnitarioMeta = const VerificationMeta(
    'costoUnitario',
  );
  @override
  late final GeneratedColumn<int> costoUnitario = GeneratedColumn<int>(
    'costo_unitario',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _subtotalLineaMeta = const VerificationMeta(
    'subtotalLinea',
  );
  @override
  late final GeneratedColumn<int> subtotalLinea = GeneratedColumn<int>(
    'subtotal_linea',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    ventaId,
    productoId,
    nombreProducto,
    cantidad,
    precioUnitario,
    precioTipo,
    costoUnitario,
    subtotalLinea,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'detalle_ventas';
  @override
  VerificationContext validateIntegrity(
    Insertable<DetalleVenta> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('venta_id')) {
      context.handle(
        _ventaIdMeta,
        ventaId.isAcceptableOrUnknown(data['venta_id']!, _ventaIdMeta),
      );
    } else if (isInserting) {
      context.missing(_ventaIdMeta);
    }
    if (data.containsKey('producto_id')) {
      context.handle(
        _productoIdMeta,
        productoId.isAcceptableOrUnknown(data['producto_id']!, _productoIdMeta),
      );
    } else if (isInserting) {
      context.missing(_productoIdMeta);
    }
    if (data.containsKey('nombre_producto')) {
      context.handle(
        _nombreProductoMeta,
        nombreProducto.isAcceptableOrUnknown(
          data['nombre_producto']!,
          _nombreProductoMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_nombreProductoMeta);
    }
    if (data.containsKey('cantidad')) {
      context.handle(
        _cantidadMeta,
        cantidad.isAcceptableOrUnknown(data['cantidad']!, _cantidadMeta),
      );
    } else if (isInserting) {
      context.missing(_cantidadMeta);
    }
    if (data.containsKey('precio_unitario')) {
      context.handle(
        _precioUnitarioMeta,
        precioUnitario.isAcceptableOrUnknown(
          data['precio_unitario']!,
          _precioUnitarioMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_precioUnitarioMeta);
    }
    if (data.containsKey('precio_tipo')) {
      context.handle(
        _precioTipoMeta,
        precioTipo.isAcceptableOrUnknown(data['precio_tipo']!, _precioTipoMeta),
      );
    } else if (isInserting) {
      context.missing(_precioTipoMeta);
    }
    if (data.containsKey('costo_unitario')) {
      context.handle(
        _costoUnitarioMeta,
        costoUnitario.isAcceptableOrUnknown(
          data['costo_unitario']!,
          _costoUnitarioMeta,
        ),
      );
    }
    if (data.containsKey('subtotal_linea')) {
      context.handle(
        _subtotalLineaMeta,
        subtotalLinea.isAcceptableOrUnknown(
          data['subtotal_linea']!,
          _subtotalLineaMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_subtotalLineaMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DetalleVenta map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DetalleVenta(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      ventaId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}venta_id'],
      )!,
      productoId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}producto_id'],
      )!,
      nombreProducto: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nombre_producto'],
      )!,
      cantidad: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}cantidad'],
      )!,
      precioUnitario: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}precio_unitario'],
      )!,
      precioTipo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}precio_tipo'],
      )!,
      costoUnitario: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}costo_unitario'],
      ),
      subtotalLinea: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}subtotal_linea'],
      )!,
    );
  }

  @override
  $DetalleVentasTable createAlias(String alias) {
    return $DetalleVentasTable(attachedDatabase, alias);
  }
}

class DetalleVenta extends DataClass implements Insertable<DetalleVenta> {
  final int id;
  final int ventaId;
  final int productoId;
  final String nombreProducto;
  final double cantidad;
  final int precioUnitario;
  final String precioTipo;
  final int? costoUnitario;
  final int subtotalLinea;
  const DetalleVenta({
    required this.id,
    required this.ventaId,
    required this.productoId,
    required this.nombreProducto,
    required this.cantidad,
    required this.precioUnitario,
    required this.precioTipo,
    this.costoUnitario,
    required this.subtotalLinea,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['venta_id'] = Variable<int>(ventaId);
    map['producto_id'] = Variable<int>(productoId);
    map['nombre_producto'] = Variable<String>(nombreProducto);
    map['cantidad'] = Variable<double>(cantidad);
    map['precio_unitario'] = Variable<int>(precioUnitario);
    map['precio_tipo'] = Variable<String>(precioTipo);
    if (!nullToAbsent || costoUnitario != null) {
      map['costo_unitario'] = Variable<int>(costoUnitario);
    }
    map['subtotal_linea'] = Variable<int>(subtotalLinea);
    return map;
  }

  DetalleVentasCompanion toCompanion(bool nullToAbsent) {
    return DetalleVentasCompanion(
      id: Value(id),
      ventaId: Value(ventaId),
      productoId: Value(productoId),
      nombreProducto: Value(nombreProducto),
      cantidad: Value(cantidad),
      precioUnitario: Value(precioUnitario),
      precioTipo: Value(precioTipo),
      costoUnitario: costoUnitario == null && nullToAbsent
          ? const Value.absent()
          : Value(costoUnitario),
      subtotalLinea: Value(subtotalLinea),
    );
  }

  factory DetalleVenta.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DetalleVenta(
      id: serializer.fromJson<int>(json['id']),
      ventaId: serializer.fromJson<int>(json['ventaId']),
      productoId: serializer.fromJson<int>(json['productoId']),
      nombreProducto: serializer.fromJson<String>(json['nombreProducto']),
      cantidad: serializer.fromJson<double>(json['cantidad']),
      precioUnitario: serializer.fromJson<int>(json['precioUnitario']),
      precioTipo: serializer.fromJson<String>(json['precioTipo']),
      costoUnitario: serializer.fromJson<int?>(json['costoUnitario']),
      subtotalLinea: serializer.fromJson<int>(json['subtotalLinea']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'ventaId': serializer.toJson<int>(ventaId),
      'productoId': serializer.toJson<int>(productoId),
      'nombreProducto': serializer.toJson<String>(nombreProducto),
      'cantidad': serializer.toJson<double>(cantidad),
      'precioUnitario': serializer.toJson<int>(precioUnitario),
      'precioTipo': serializer.toJson<String>(precioTipo),
      'costoUnitario': serializer.toJson<int?>(costoUnitario),
      'subtotalLinea': serializer.toJson<int>(subtotalLinea),
    };
  }

  DetalleVenta copyWith({
    int? id,
    int? ventaId,
    int? productoId,
    String? nombreProducto,
    double? cantidad,
    int? precioUnitario,
    String? precioTipo,
    Value<int?> costoUnitario = const Value.absent(),
    int? subtotalLinea,
  }) => DetalleVenta(
    id: id ?? this.id,
    ventaId: ventaId ?? this.ventaId,
    productoId: productoId ?? this.productoId,
    nombreProducto: nombreProducto ?? this.nombreProducto,
    cantidad: cantidad ?? this.cantidad,
    precioUnitario: precioUnitario ?? this.precioUnitario,
    precioTipo: precioTipo ?? this.precioTipo,
    costoUnitario: costoUnitario.present
        ? costoUnitario.value
        : this.costoUnitario,
    subtotalLinea: subtotalLinea ?? this.subtotalLinea,
  );
  DetalleVenta copyWithCompanion(DetalleVentasCompanion data) {
    return DetalleVenta(
      id: data.id.present ? data.id.value : this.id,
      ventaId: data.ventaId.present ? data.ventaId.value : this.ventaId,
      productoId: data.productoId.present
          ? data.productoId.value
          : this.productoId,
      nombreProducto: data.nombreProducto.present
          ? data.nombreProducto.value
          : this.nombreProducto,
      cantidad: data.cantidad.present ? data.cantidad.value : this.cantidad,
      precioUnitario: data.precioUnitario.present
          ? data.precioUnitario.value
          : this.precioUnitario,
      precioTipo: data.precioTipo.present
          ? data.precioTipo.value
          : this.precioTipo,
      costoUnitario: data.costoUnitario.present
          ? data.costoUnitario.value
          : this.costoUnitario,
      subtotalLinea: data.subtotalLinea.present
          ? data.subtotalLinea.value
          : this.subtotalLinea,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DetalleVenta(')
          ..write('id: $id, ')
          ..write('ventaId: $ventaId, ')
          ..write('productoId: $productoId, ')
          ..write('nombreProducto: $nombreProducto, ')
          ..write('cantidad: $cantidad, ')
          ..write('precioUnitario: $precioUnitario, ')
          ..write('precioTipo: $precioTipo, ')
          ..write('costoUnitario: $costoUnitario, ')
          ..write('subtotalLinea: $subtotalLinea')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    ventaId,
    productoId,
    nombreProducto,
    cantidad,
    precioUnitario,
    precioTipo,
    costoUnitario,
    subtotalLinea,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DetalleVenta &&
          other.id == this.id &&
          other.ventaId == this.ventaId &&
          other.productoId == this.productoId &&
          other.nombreProducto == this.nombreProducto &&
          other.cantidad == this.cantidad &&
          other.precioUnitario == this.precioUnitario &&
          other.precioTipo == this.precioTipo &&
          other.costoUnitario == this.costoUnitario &&
          other.subtotalLinea == this.subtotalLinea);
}

class DetalleVentasCompanion extends UpdateCompanion<DetalleVenta> {
  final Value<int> id;
  final Value<int> ventaId;
  final Value<int> productoId;
  final Value<String> nombreProducto;
  final Value<double> cantidad;
  final Value<int> precioUnitario;
  final Value<String> precioTipo;
  final Value<int?> costoUnitario;
  final Value<int> subtotalLinea;
  const DetalleVentasCompanion({
    this.id = const Value.absent(),
    this.ventaId = const Value.absent(),
    this.productoId = const Value.absent(),
    this.nombreProducto = const Value.absent(),
    this.cantidad = const Value.absent(),
    this.precioUnitario = const Value.absent(),
    this.precioTipo = const Value.absent(),
    this.costoUnitario = const Value.absent(),
    this.subtotalLinea = const Value.absent(),
  });
  DetalleVentasCompanion.insert({
    this.id = const Value.absent(),
    required int ventaId,
    required int productoId,
    required String nombreProducto,
    required double cantidad,
    required int precioUnitario,
    required String precioTipo,
    this.costoUnitario = const Value.absent(),
    required int subtotalLinea,
  }) : ventaId = Value(ventaId),
       productoId = Value(productoId),
       nombreProducto = Value(nombreProducto),
       cantidad = Value(cantidad),
       precioUnitario = Value(precioUnitario),
       precioTipo = Value(precioTipo),
       subtotalLinea = Value(subtotalLinea);
  static Insertable<DetalleVenta> custom({
    Expression<int>? id,
    Expression<int>? ventaId,
    Expression<int>? productoId,
    Expression<String>? nombreProducto,
    Expression<double>? cantidad,
    Expression<int>? precioUnitario,
    Expression<String>? precioTipo,
    Expression<int>? costoUnitario,
    Expression<int>? subtotalLinea,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (ventaId != null) 'venta_id': ventaId,
      if (productoId != null) 'producto_id': productoId,
      if (nombreProducto != null) 'nombre_producto': nombreProducto,
      if (cantidad != null) 'cantidad': cantidad,
      if (precioUnitario != null) 'precio_unitario': precioUnitario,
      if (precioTipo != null) 'precio_tipo': precioTipo,
      if (costoUnitario != null) 'costo_unitario': costoUnitario,
      if (subtotalLinea != null) 'subtotal_linea': subtotalLinea,
    });
  }

  DetalleVentasCompanion copyWith({
    Value<int>? id,
    Value<int>? ventaId,
    Value<int>? productoId,
    Value<String>? nombreProducto,
    Value<double>? cantidad,
    Value<int>? precioUnitario,
    Value<String>? precioTipo,
    Value<int?>? costoUnitario,
    Value<int>? subtotalLinea,
  }) {
    return DetalleVentasCompanion(
      id: id ?? this.id,
      ventaId: ventaId ?? this.ventaId,
      productoId: productoId ?? this.productoId,
      nombreProducto: nombreProducto ?? this.nombreProducto,
      cantidad: cantidad ?? this.cantidad,
      precioUnitario: precioUnitario ?? this.precioUnitario,
      precioTipo: precioTipo ?? this.precioTipo,
      costoUnitario: costoUnitario ?? this.costoUnitario,
      subtotalLinea: subtotalLinea ?? this.subtotalLinea,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (ventaId.present) {
      map['venta_id'] = Variable<int>(ventaId.value);
    }
    if (productoId.present) {
      map['producto_id'] = Variable<int>(productoId.value);
    }
    if (nombreProducto.present) {
      map['nombre_producto'] = Variable<String>(nombreProducto.value);
    }
    if (cantidad.present) {
      map['cantidad'] = Variable<double>(cantidad.value);
    }
    if (precioUnitario.present) {
      map['precio_unitario'] = Variable<int>(precioUnitario.value);
    }
    if (precioTipo.present) {
      map['precio_tipo'] = Variable<String>(precioTipo.value);
    }
    if (costoUnitario.present) {
      map['costo_unitario'] = Variable<int>(costoUnitario.value);
    }
    if (subtotalLinea.present) {
      map['subtotal_linea'] = Variable<int>(subtotalLinea.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DetalleVentasCompanion(')
          ..write('id: $id, ')
          ..write('ventaId: $ventaId, ')
          ..write('productoId: $productoId, ')
          ..write('nombreProducto: $nombreProducto, ')
          ..write('cantidad: $cantidad, ')
          ..write('precioUnitario: $precioUnitario, ')
          ..write('precioTipo: $precioTipo, ')
          ..write('costoUnitario: $costoUnitario, ')
          ..write('subtotalLinea: $subtotalLinea')
          ..write(')'))
        .toString();
  }
}

class $MovimientosInventarioTable extends MovimientosInventario
    with TableInfo<$MovimientosInventarioTable, MovimientosInventarioData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MovimientosInventarioTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _productoIdMeta = const VerificationMeta(
    'productoId',
  );
  @override
  late final GeneratedColumn<int> productoId = GeneratedColumn<int>(
    'producto_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tipoMeta = const VerificationMeta('tipo');
  @override
  late final GeneratedColumn<String> tipo = GeneratedColumn<String>(
    'tipo',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cantidadMeta = const VerificationMeta(
    'cantidad',
  );
  @override
  late final GeneratedColumn<double> cantidad = GeneratedColumn<double>(
    'cantidad',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _referenciaIdMeta = const VerificationMeta(
    'referenciaId',
  );
  @override
  late final GeneratedColumn<int> referenciaId = GeneratedColumn<int>(
    'referencia_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notaMeta = const VerificationMeta('nota');
  @override
  late final GeneratedColumn<String> nota = GeneratedColumn<String>(
    'nota',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
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
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    productoId,
    tipo,
    cantidad,
    referenciaId,
    nota,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'movimientos_inventario';
  @override
  VerificationContext validateIntegrity(
    Insertable<MovimientosInventarioData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('producto_id')) {
      context.handle(
        _productoIdMeta,
        productoId.isAcceptableOrUnknown(data['producto_id']!, _productoIdMeta),
      );
    } else if (isInserting) {
      context.missing(_productoIdMeta);
    }
    if (data.containsKey('tipo')) {
      context.handle(
        _tipoMeta,
        tipo.isAcceptableOrUnknown(data['tipo']!, _tipoMeta),
      );
    } else if (isInserting) {
      context.missing(_tipoMeta);
    }
    if (data.containsKey('cantidad')) {
      context.handle(
        _cantidadMeta,
        cantidad.isAcceptableOrUnknown(data['cantidad']!, _cantidadMeta),
      );
    } else if (isInserting) {
      context.missing(_cantidadMeta);
    }
    if (data.containsKey('referencia_id')) {
      context.handle(
        _referenciaIdMeta,
        referenciaId.isAcceptableOrUnknown(
          data['referencia_id']!,
          _referenciaIdMeta,
        ),
      );
    }
    if (data.containsKey('nota')) {
      context.handle(
        _notaMeta,
        nota.isAcceptableOrUnknown(data['nota']!, _notaMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MovimientosInventarioData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MovimientosInventarioData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      productoId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}producto_id'],
      )!,
      tipo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tipo'],
      )!,
      cantidad: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}cantidad'],
      )!,
      referenciaId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}referencia_id'],
      ),
      nota: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nota'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $MovimientosInventarioTable createAlias(String alias) {
    return $MovimientosInventarioTable(attachedDatabase, alias);
  }
}

class MovimientosInventarioData extends DataClass
    implements Insertable<MovimientosInventarioData> {
  final int id;
  final int productoId;
  final String tipo;
  final double cantidad;
  final int? referenciaId;
  final String? nota;
  final DateTime createdAt;
  const MovimientosInventarioData({
    required this.id,
    required this.productoId,
    required this.tipo,
    required this.cantidad,
    this.referenciaId,
    this.nota,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['producto_id'] = Variable<int>(productoId);
    map['tipo'] = Variable<String>(tipo);
    map['cantidad'] = Variable<double>(cantidad);
    if (!nullToAbsent || referenciaId != null) {
      map['referencia_id'] = Variable<int>(referenciaId);
    }
    if (!nullToAbsent || nota != null) {
      map['nota'] = Variable<String>(nota);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  MovimientosInventarioCompanion toCompanion(bool nullToAbsent) {
    return MovimientosInventarioCompanion(
      id: Value(id),
      productoId: Value(productoId),
      tipo: Value(tipo),
      cantidad: Value(cantidad),
      referenciaId: referenciaId == null && nullToAbsent
          ? const Value.absent()
          : Value(referenciaId),
      nota: nota == null && nullToAbsent ? const Value.absent() : Value(nota),
      createdAt: Value(createdAt),
    );
  }

  factory MovimientosInventarioData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MovimientosInventarioData(
      id: serializer.fromJson<int>(json['id']),
      productoId: serializer.fromJson<int>(json['productoId']),
      tipo: serializer.fromJson<String>(json['tipo']),
      cantidad: serializer.fromJson<double>(json['cantidad']),
      referenciaId: serializer.fromJson<int?>(json['referenciaId']),
      nota: serializer.fromJson<String?>(json['nota']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'productoId': serializer.toJson<int>(productoId),
      'tipo': serializer.toJson<String>(tipo),
      'cantidad': serializer.toJson<double>(cantidad),
      'referenciaId': serializer.toJson<int?>(referenciaId),
      'nota': serializer.toJson<String?>(nota),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  MovimientosInventarioData copyWith({
    int? id,
    int? productoId,
    String? tipo,
    double? cantidad,
    Value<int?> referenciaId = const Value.absent(),
    Value<String?> nota = const Value.absent(),
    DateTime? createdAt,
  }) => MovimientosInventarioData(
    id: id ?? this.id,
    productoId: productoId ?? this.productoId,
    tipo: tipo ?? this.tipo,
    cantidad: cantidad ?? this.cantidad,
    referenciaId: referenciaId.present ? referenciaId.value : this.referenciaId,
    nota: nota.present ? nota.value : this.nota,
    createdAt: createdAt ?? this.createdAt,
  );
  MovimientosInventarioData copyWithCompanion(
    MovimientosInventarioCompanion data,
  ) {
    return MovimientosInventarioData(
      id: data.id.present ? data.id.value : this.id,
      productoId: data.productoId.present
          ? data.productoId.value
          : this.productoId,
      tipo: data.tipo.present ? data.tipo.value : this.tipo,
      cantidad: data.cantidad.present ? data.cantidad.value : this.cantidad,
      referenciaId: data.referenciaId.present
          ? data.referenciaId.value
          : this.referenciaId,
      nota: data.nota.present ? data.nota.value : this.nota,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MovimientosInventarioData(')
          ..write('id: $id, ')
          ..write('productoId: $productoId, ')
          ..write('tipo: $tipo, ')
          ..write('cantidad: $cantidad, ')
          ..write('referenciaId: $referenciaId, ')
          ..write('nota: $nota, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    productoId,
    tipo,
    cantidad,
    referenciaId,
    nota,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MovimientosInventarioData &&
          other.id == this.id &&
          other.productoId == this.productoId &&
          other.tipo == this.tipo &&
          other.cantidad == this.cantidad &&
          other.referenciaId == this.referenciaId &&
          other.nota == this.nota &&
          other.createdAt == this.createdAt);
}

class MovimientosInventarioCompanion
    extends UpdateCompanion<MovimientosInventarioData> {
  final Value<int> id;
  final Value<int> productoId;
  final Value<String> tipo;
  final Value<double> cantidad;
  final Value<int?> referenciaId;
  final Value<String?> nota;
  final Value<DateTime> createdAt;
  const MovimientosInventarioCompanion({
    this.id = const Value.absent(),
    this.productoId = const Value.absent(),
    this.tipo = const Value.absent(),
    this.cantidad = const Value.absent(),
    this.referenciaId = const Value.absent(),
    this.nota = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  MovimientosInventarioCompanion.insert({
    this.id = const Value.absent(),
    required int productoId,
    required String tipo,
    required double cantidad,
    this.referenciaId = const Value.absent(),
    this.nota = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : productoId = Value(productoId),
       tipo = Value(tipo),
       cantidad = Value(cantidad);
  static Insertable<MovimientosInventarioData> custom({
    Expression<int>? id,
    Expression<int>? productoId,
    Expression<String>? tipo,
    Expression<double>? cantidad,
    Expression<int>? referenciaId,
    Expression<String>? nota,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (productoId != null) 'producto_id': productoId,
      if (tipo != null) 'tipo': tipo,
      if (cantidad != null) 'cantidad': cantidad,
      if (referenciaId != null) 'referencia_id': referenciaId,
      if (nota != null) 'nota': nota,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  MovimientosInventarioCompanion copyWith({
    Value<int>? id,
    Value<int>? productoId,
    Value<String>? tipo,
    Value<double>? cantidad,
    Value<int?>? referenciaId,
    Value<String?>? nota,
    Value<DateTime>? createdAt,
  }) {
    return MovimientosInventarioCompanion(
      id: id ?? this.id,
      productoId: productoId ?? this.productoId,
      tipo: tipo ?? this.tipo,
      cantidad: cantidad ?? this.cantidad,
      referenciaId: referenciaId ?? this.referenciaId,
      nota: nota ?? this.nota,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (productoId.present) {
      map['producto_id'] = Variable<int>(productoId.value);
    }
    if (tipo.present) {
      map['tipo'] = Variable<String>(tipo.value);
    }
    if (cantidad.present) {
      map['cantidad'] = Variable<double>(cantidad.value);
    }
    if (referenciaId.present) {
      map['referencia_id'] = Variable<int>(referenciaId.value);
    }
    if (nota.present) {
      map['nota'] = Variable<String>(nota.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MovimientosInventarioCompanion(')
          ..write('id: $id, ')
          ..write('productoId: $productoId, ')
          ..write('tipo: $tipo, ')
          ..write('cantidad: $cantidad, ')
          ..write('referenciaId: $referenciaId, ')
          ..write('nota: $nota, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $GastosTable extends Gastos with TableInfo<$GastosTable, Gasto> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GastosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _tipoMeta = const VerificationMeta('tipo');
  @override
  late final GeneratedColumn<String> tipo = GeneratedColumn<String>(
    'tipo',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoriaMeta = const VerificationMeta(
    'categoria',
  );
  @override
  late final GeneratedColumn<String> categoria = GeneratedColumn<String>(
    'categoria',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _descripcionMeta = const VerificationMeta(
    'descripcion',
  );
  @override
  late final GeneratedColumn<String> descripcion = GeneratedColumn<String>(
    'descripcion',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _montoMeta = const VerificationMeta('monto');
  @override
  late final GeneratedColumn<int> monto = GeneratedColumn<int>(
    'monto',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _fechaMeta = const VerificationMeta('fecha');
  @override
  late final GeneratedColumn<DateTime> fecha = GeneratedColumn<DateTime>(
    'fecha',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _periodicidadMeta = const VerificationMeta(
    'periodicidad',
  );
  @override
  late final GeneratedColumn<String> periodicidad = GeneratedColumn<String>(
    'periodicidad',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _productoIdMeta = const VerificationMeta(
    'productoId',
  );
  @override
  late final GeneratedColumn<int> productoId = GeneratedColumn<int>(
    'producto_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _cantidadMeta = const VerificationMeta(
    'cantidad',
  );
  @override
  late final GeneratedColumn<double> cantidad = GeneratedColumn<double>(
    'cantidad',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _motivoMeta = const VerificationMeta('motivo');
  @override
  late final GeneratedColumn<String> motivo = GeneratedColumn<String>(
    'motivo',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    createdAt,
    updatedAt,
    deletedAt,
    id,
    tipo,
    categoria,
    descripcion,
    monto,
    fecha,
    periodicidad,
    productoId,
    cantidad,
    motivo,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'gastos';
  @override
  VerificationContext validateIntegrity(
    Insertable<Gasto> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('tipo')) {
      context.handle(
        _tipoMeta,
        tipo.isAcceptableOrUnknown(data['tipo']!, _tipoMeta),
      );
    } else if (isInserting) {
      context.missing(_tipoMeta);
    }
    if (data.containsKey('categoria')) {
      context.handle(
        _categoriaMeta,
        categoria.isAcceptableOrUnknown(data['categoria']!, _categoriaMeta),
      );
    }
    if (data.containsKey('descripcion')) {
      context.handle(
        _descripcionMeta,
        descripcion.isAcceptableOrUnknown(
          data['descripcion']!,
          _descripcionMeta,
        ),
      );
    }
    if (data.containsKey('monto')) {
      context.handle(
        _montoMeta,
        monto.isAcceptableOrUnknown(data['monto']!, _montoMeta),
      );
    }
    if (data.containsKey('fecha')) {
      context.handle(
        _fechaMeta,
        fecha.isAcceptableOrUnknown(data['fecha']!, _fechaMeta),
      );
    }
    if (data.containsKey('periodicidad')) {
      context.handle(
        _periodicidadMeta,
        periodicidad.isAcceptableOrUnknown(
          data['periodicidad']!,
          _periodicidadMeta,
        ),
      );
    }
    if (data.containsKey('producto_id')) {
      context.handle(
        _productoIdMeta,
        productoId.isAcceptableOrUnknown(data['producto_id']!, _productoIdMeta),
      );
    }
    if (data.containsKey('cantidad')) {
      context.handle(
        _cantidadMeta,
        cantidad.isAcceptableOrUnknown(data['cantidad']!, _cantidadMeta),
      );
    }
    if (data.containsKey('motivo')) {
      context.handle(
        _motivoMeta,
        motivo.isAcceptableOrUnknown(data['motivo']!, _motivoMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Gasto map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Gasto(
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      tipo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tipo'],
      )!,
      categoria: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}categoria'],
      ),
      descripcion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}descripcion'],
      ),
      monto: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}monto'],
      )!,
      fecha: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}fecha'],
      )!,
      periodicidad: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}periodicidad'],
      ),
      productoId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}producto_id'],
      ),
      cantidad: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}cantidad'],
      ),
      motivo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}motivo'],
      ),
    );
  }

  @override
  $GastosTable createAlias(String alias) {
    return $GastosTable(attachedDatabase, alias);
  }
}

class Gasto extends DataClass implements Insertable<Gasto> {
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final int id;
  final String tipo;
  final String? categoria;
  final String? descripcion;
  final int monto;
  final DateTime fecha;
  final String? periodicidad;
  final int? productoId;
  final double? cantidad;
  final String? motivo;
  const Gasto({
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.id,
    required this.tipo,
    this.categoria,
    this.descripcion,
    required this.monto,
    required this.fecha,
    this.periodicidad,
    this.productoId,
    this.cantidad,
    this.motivo,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['id'] = Variable<int>(id);
    map['tipo'] = Variable<String>(tipo);
    if (!nullToAbsent || categoria != null) {
      map['categoria'] = Variable<String>(categoria);
    }
    if (!nullToAbsent || descripcion != null) {
      map['descripcion'] = Variable<String>(descripcion);
    }
    map['monto'] = Variable<int>(monto);
    map['fecha'] = Variable<DateTime>(fecha);
    if (!nullToAbsent || periodicidad != null) {
      map['periodicidad'] = Variable<String>(periodicidad);
    }
    if (!nullToAbsent || productoId != null) {
      map['producto_id'] = Variable<int>(productoId);
    }
    if (!nullToAbsent || cantidad != null) {
      map['cantidad'] = Variable<double>(cantidad);
    }
    if (!nullToAbsent || motivo != null) {
      map['motivo'] = Variable<String>(motivo);
    }
    return map;
  }

  GastosCompanion toCompanion(bool nullToAbsent) {
    return GastosCompanion(
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      id: Value(id),
      tipo: Value(tipo),
      categoria: categoria == null && nullToAbsent
          ? const Value.absent()
          : Value(categoria),
      descripcion: descripcion == null && nullToAbsent
          ? const Value.absent()
          : Value(descripcion),
      monto: Value(monto),
      fecha: Value(fecha),
      periodicidad: periodicidad == null && nullToAbsent
          ? const Value.absent()
          : Value(periodicidad),
      productoId: productoId == null && nullToAbsent
          ? const Value.absent()
          : Value(productoId),
      cantidad: cantidad == null && nullToAbsent
          ? const Value.absent()
          : Value(cantidad),
      motivo: motivo == null && nullToAbsent
          ? const Value.absent()
          : Value(motivo),
    );
  }

  factory Gasto.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Gasto(
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      id: serializer.fromJson<int>(json['id']),
      tipo: serializer.fromJson<String>(json['tipo']),
      categoria: serializer.fromJson<String?>(json['categoria']),
      descripcion: serializer.fromJson<String?>(json['descripcion']),
      monto: serializer.fromJson<int>(json['monto']),
      fecha: serializer.fromJson<DateTime>(json['fecha']),
      periodicidad: serializer.fromJson<String?>(json['periodicidad']),
      productoId: serializer.fromJson<int?>(json['productoId']),
      cantidad: serializer.fromJson<double?>(json['cantidad']),
      motivo: serializer.fromJson<String?>(json['motivo']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'id': serializer.toJson<int>(id),
      'tipo': serializer.toJson<String>(tipo),
      'categoria': serializer.toJson<String?>(categoria),
      'descripcion': serializer.toJson<String?>(descripcion),
      'monto': serializer.toJson<int>(monto),
      'fecha': serializer.toJson<DateTime>(fecha),
      'periodicidad': serializer.toJson<String?>(periodicidad),
      'productoId': serializer.toJson<int?>(productoId),
      'cantidad': serializer.toJson<double?>(cantidad),
      'motivo': serializer.toJson<String?>(motivo),
    };
  }

  Gasto copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    int? id,
    String? tipo,
    Value<String?> categoria = const Value.absent(),
    Value<String?> descripcion = const Value.absent(),
    int? monto,
    DateTime? fecha,
    Value<String?> periodicidad = const Value.absent(),
    Value<int?> productoId = const Value.absent(),
    Value<double?> cantidad = const Value.absent(),
    Value<String?> motivo = const Value.absent(),
  }) => Gasto(
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    id: id ?? this.id,
    tipo: tipo ?? this.tipo,
    categoria: categoria.present ? categoria.value : this.categoria,
    descripcion: descripcion.present ? descripcion.value : this.descripcion,
    monto: monto ?? this.monto,
    fecha: fecha ?? this.fecha,
    periodicidad: periodicidad.present ? periodicidad.value : this.periodicidad,
    productoId: productoId.present ? productoId.value : this.productoId,
    cantidad: cantidad.present ? cantidad.value : this.cantidad,
    motivo: motivo.present ? motivo.value : this.motivo,
  );
  Gasto copyWithCompanion(GastosCompanion data) {
    return Gasto(
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      id: data.id.present ? data.id.value : this.id,
      tipo: data.tipo.present ? data.tipo.value : this.tipo,
      categoria: data.categoria.present ? data.categoria.value : this.categoria,
      descripcion: data.descripcion.present
          ? data.descripcion.value
          : this.descripcion,
      monto: data.monto.present ? data.monto.value : this.monto,
      fecha: data.fecha.present ? data.fecha.value : this.fecha,
      periodicidad: data.periodicidad.present
          ? data.periodicidad.value
          : this.periodicidad,
      productoId: data.productoId.present
          ? data.productoId.value
          : this.productoId,
      cantidad: data.cantidad.present ? data.cantidad.value : this.cantidad,
      motivo: data.motivo.present ? data.motivo.value : this.motivo,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Gasto(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('tipo: $tipo, ')
          ..write('categoria: $categoria, ')
          ..write('descripcion: $descripcion, ')
          ..write('monto: $monto, ')
          ..write('fecha: $fecha, ')
          ..write('periodicidad: $periodicidad, ')
          ..write('productoId: $productoId, ')
          ..write('cantidad: $cantidad, ')
          ..write('motivo: $motivo')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    createdAt,
    updatedAt,
    deletedAt,
    id,
    tipo,
    categoria,
    descripcion,
    monto,
    fecha,
    periodicidad,
    productoId,
    cantidad,
    motivo,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Gasto &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.id == this.id &&
          other.tipo == this.tipo &&
          other.categoria == this.categoria &&
          other.descripcion == this.descripcion &&
          other.monto == this.monto &&
          other.fecha == this.fecha &&
          other.periodicidad == this.periodicidad &&
          other.productoId == this.productoId &&
          other.cantidad == this.cantidad &&
          other.motivo == this.motivo);
}

class GastosCompanion extends UpdateCompanion<Gasto> {
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<int> id;
  final Value<String> tipo;
  final Value<String?> categoria;
  final Value<String?> descripcion;
  final Value<int> monto;
  final Value<DateTime> fecha;
  final Value<String?> periodicidad;
  final Value<int?> productoId;
  final Value<double?> cantidad;
  final Value<String?> motivo;
  const GastosCompanion({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.tipo = const Value.absent(),
    this.categoria = const Value.absent(),
    this.descripcion = const Value.absent(),
    this.monto = const Value.absent(),
    this.fecha = const Value.absent(),
    this.periodicidad = const Value.absent(),
    this.productoId = const Value.absent(),
    this.cantidad = const Value.absent(),
    this.motivo = const Value.absent(),
  });
  GastosCompanion.insert({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.id = const Value.absent(),
    required String tipo,
    this.categoria = const Value.absent(),
    this.descripcion = const Value.absent(),
    this.monto = const Value.absent(),
    this.fecha = const Value.absent(),
    this.periodicidad = const Value.absent(),
    this.productoId = const Value.absent(),
    this.cantidad = const Value.absent(),
    this.motivo = const Value.absent(),
  }) : tipo = Value(tipo);
  static Insertable<Gasto> custom({
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<int>? id,
    Expression<String>? tipo,
    Expression<String>? categoria,
    Expression<String>? descripcion,
    Expression<int>? monto,
    Expression<DateTime>? fecha,
    Expression<String>? periodicidad,
    Expression<int>? productoId,
    Expression<double>? cantidad,
    Expression<String>? motivo,
  }) {
    return RawValuesInsertable({
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (id != null) 'id': id,
      if (tipo != null) 'tipo': tipo,
      if (categoria != null) 'categoria': categoria,
      if (descripcion != null) 'descripcion': descripcion,
      if (monto != null) 'monto': monto,
      if (fecha != null) 'fecha': fecha,
      if (periodicidad != null) 'periodicidad': periodicidad,
      if (productoId != null) 'producto_id': productoId,
      if (cantidad != null) 'cantidad': cantidad,
      if (motivo != null) 'motivo': motivo,
    });
  }

  GastosCompanion copyWith({
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<int>? id,
    Value<String>? tipo,
    Value<String?>? categoria,
    Value<String?>? descripcion,
    Value<int>? monto,
    Value<DateTime>? fecha,
    Value<String?>? periodicidad,
    Value<int?>? productoId,
    Value<double?>? cantidad,
    Value<String?>? motivo,
  }) {
    return GastosCompanion(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      id: id ?? this.id,
      tipo: tipo ?? this.tipo,
      categoria: categoria ?? this.categoria,
      descripcion: descripcion ?? this.descripcion,
      monto: monto ?? this.monto,
      fecha: fecha ?? this.fecha,
      periodicidad: periodicidad ?? this.periodicidad,
      productoId: productoId ?? this.productoId,
      cantidad: cantidad ?? this.cantidad,
      motivo: motivo ?? this.motivo,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (tipo.present) {
      map['tipo'] = Variable<String>(tipo.value);
    }
    if (categoria.present) {
      map['categoria'] = Variable<String>(categoria.value);
    }
    if (descripcion.present) {
      map['descripcion'] = Variable<String>(descripcion.value);
    }
    if (monto.present) {
      map['monto'] = Variable<int>(monto.value);
    }
    if (fecha.present) {
      map['fecha'] = Variable<DateTime>(fecha.value);
    }
    if (periodicidad.present) {
      map['periodicidad'] = Variable<String>(periodicidad.value);
    }
    if (productoId.present) {
      map['producto_id'] = Variable<int>(productoId.value);
    }
    if (cantidad.present) {
      map['cantidad'] = Variable<double>(cantidad.value);
    }
    if (motivo.present) {
      map['motivo'] = Variable<String>(motivo.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GastosCompanion(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('tipo: $tipo, ')
          ..write('categoria: $categoria, ')
          ..write('descripcion: $descripcion, ')
          ..write('monto: $monto, ')
          ..write('fecha: $fecha, ')
          ..write('periodicidad: $periodicidad, ')
          ..write('productoId: $productoId, ')
          ..write('cantidad: $cantidad, ')
          ..write('motivo: $motivo')
          ..write(')'))
        .toString();
  }
}

class $DeudasTable extends Deudas with TableInfo<$DeudasTable, Deuda> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DeudasTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _direccionMeta = const VerificationMeta(
    'direccion',
  );
  @override
  late final GeneratedColumn<String> direccion = GeneratedColumn<String>(
    'direccion',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _clienteIdMeta = const VerificationMeta(
    'clienteId',
  );
  @override
  late final GeneratedColumn<int> clienteId = GeneratedColumn<int>(
    'cliente_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _proveedorMeta = const VerificationMeta(
    'proveedor',
  );
  @override
  late final GeneratedColumn<String> proveedor = GeneratedColumn<String>(
    'proveedor',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _origenVentaIdMeta = const VerificationMeta(
    'origenVentaId',
  );
  @override
  late final GeneratedColumn<int> origenVentaId = GeneratedColumn<int>(
    'origen_venta_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _montoOriginalMeta = const VerificationMeta(
    'montoOriginal',
  );
  @override
  late final GeneratedColumn<int> montoOriginal = GeneratedColumn<int>(
    'monto_original',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _estadoMeta = const VerificationMeta('estado');
  @override
  late final GeneratedColumn<String> estado = GeneratedColumn<String>(
    'estado',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pendiente'),
  );
  static const VerificationMeta _descripcionMeta = const VerificationMeta(
    'descripcion',
  );
  @override
  late final GeneratedColumn<String> descripcion = GeneratedColumn<String>(
    'descripcion',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _fechaMeta = const VerificationMeta('fecha');
  @override
  late final GeneratedColumn<DateTime> fecha = GeneratedColumn<DateTime>(
    'fecha',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    createdAt,
    updatedAt,
    deletedAt,
    id,
    direccion,
    clienteId,
    proveedor,
    origenVentaId,
    montoOriginal,
    estado,
    descripcion,
    fecha,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'deudas';
  @override
  VerificationContext validateIntegrity(
    Insertable<Deuda> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('direccion')) {
      context.handle(
        _direccionMeta,
        direccion.isAcceptableOrUnknown(data['direccion']!, _direccionMeta),
      );
    } else if (isInserting) {
      context.missing(_direccionMeta);
    }
    if (data.containsKey('cliente_id')) {
      context.handle(
        _clienteIdMeta,
        clienteId.isAcceptableOrUnknown(data['cliente_id']!, _clienteIdMeta),
      );
    }
    if (data.containsKey('proveedor')) {
      context.handle(
        _proveedorMeta,
        proveedor.isAcceptableOrUnknown(data['proveedor']!, _proveedorMeta),
      );
    }
    if (data.containsKey('origen_venta_id')) {
      context.handle(
        _origenVentaIdMeta,
        origenVentaId.isAcceptableOrUnknown(
          data['origen_venta_id']!,
          _origenVentaIdMeta,
        ),
      );
    }
    if (data.containsKey('monto_original')) {
      context.handle(
        _montoOriginalMeta,
        montoOriginal.isAcceptableOrUnknown(
          data['monto_original']!,
          _montoOriginalMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_montoOriginalMeta);
    }
    if (data.containsKey('estado')) {
      context.handle(
        _estadoMeta,
        estado.isAcceptableOrUnknown(data['estado']!, _estadoMeta),
      );
    }
    if (data.containsKey('descripcion')) {
      context.handle(
        _descripcionMeta,
        descripcion.isAcceptableOrUnknown(
          data['descripcion']!,
          _descripcionMeta,
        ),
      );
    }
    if (data.containsKey('fecha')) {
      context.handle(
        _fechaMeta,
        fecha.isAcceptableOrUnknown(data['fecha']!, _fechaMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Deuda map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Deuda(
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      direccion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}direccion'],
      )!,
      clienteId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}cliente_id'],
      ),
      proveedor: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}proveedor'],
      ),
      origenVentaId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}origen_venta_id'],
      ),
      montoOriginal: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}monto_original'],
      )!,
      estado: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}estado'],
      )!,
      descripcion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}descripcion'],
      ),
      fecha: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}fecha'],
      )!,
    );
  }

  @override
  $DeudasTable createAlias(String alias) {
    return $DeudasTable(attachedDatabase, alias);
  }
}

class Deuda extends DataClass implements Insertable<Deuda> {
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final int id;
  final String direccion;
  final int? clienteId;
  final String? proveedor;
  final int? origenVentaId;
  final int montoOriginal;
  final String estado;
  final String? descripcion;
  final DateTime fecha;
  const Deuda({
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.id,
    required this.direccion,
    this.clienteId,
    this.proveedor,
    this.origenVentaId,
    required this.montoOriginal,
    required this.estado,
    this.descripcion,
    required this.fecha,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['id'] = Variable<int>(id);
    map['direccion'] = Variable<String>(direccion);
    if (!nullToAbsent || clienteId != null) {
      map['cliente_id'] = Variable<int>(clienteId);
    }
    if (!nullToAbsent || proveedor != null) {
      map['proveedor'] = Variable<String>(proveedor);
    }
    if (!nullToAbsent || origenVentaId != null) {
      map['origen_venta_id'] = Variable<int>(origenVentaId);
    }
    map['monto_original'] = Variable<int>(montoOriginal);
    map['estado'] = Variable<String>(estado);
    if (!nullToAbsent || descripcion != null) {
      map['descripcion'] = Variable<String>(descripcion);
    }
    map['fecha'] = Variable<DateTime>(fecha);
    return map;
  }

  DeudasCompanion toCompanion(bool nullToAbsent) {
    return DeudasCompanion(
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      id: Value(id),
      direccion: Value(direccion),
      clienteId: clienteId == null && nullToAbsent
          ? const Value.absent()
          : Value(clienteId),
      proveedor: proveedor == null && nullToAbsent
          ? const Value.absent()
          : Value(proveedor),
      origenVentaId: origenVentaId == null && nullToAbsent
          ? const Value.absent()
          : Value(origenVentaId),
      montoOriginal: Value(montoOriginal),
      estado: Value(estado),
      descripcion: descripcion == null && nullToAbsent
          ? const Value.absent()
          : Value(descripcion),
      fecha: Value(fecha),
    );
  }

  factory Deuda.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Deuda(
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      id: serializer.fromJson<int>(json['id']),
      direccion: serializer.fromJson<String>(json['direccion']),
      clienteId: serializer.fromJson<int?>(json['clienteId']),
      proveedor: serializer.fromJson<String?>(json['proveedor']),
      origenVentaId: serializer.fromJson<int?>(json['origenVentaId']),
      montoOriginal: serializer.fromJson<int>(json['montoOriginal']),
      estado: serializer.fromJson<String>(json['estado']),
      descripcion: serializer.fromJson<String?>(json['descripcion']),
      fecha: serializer.fromJson<DateTime>(json['fecha']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'id': serializer.toJson<int>(id),
      'direccion': serializer.toJson<String>(direccion),
      'clienteId': serializer.toJson<int?>(clienteId),
      'proveedor': serializer.toJson<String?>(proveedor),
      'origenVentaId': serializer.toJson<int?>(origenVentaId),
      'montoOriginal': serializer.toJson<int>(montoOriginal),
      'estado': serializer.toJson<String>(estado),
      'descripcion': serializer.toJson<String?>(descripcion),
      'fecha': serializer.toJson<DateTime>(fecha),
    };
  }

  Deuda copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    int? id,
    String? direccion,
    Value<int?> clienteId = const Value.absent(),
    Value<String?> proveedor = const Value.absent(),
    Value<int?> origenVentaId = const Value.absent(),
    int? montoOriginal,
    String? estado,
    Value<String?> descripcion = const Value.absent(),
    DateTime? fecha,
  }) => Deuda(
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    id: id ?? this.id,
    direccion: direccion ?? this.direccion,
    clienteId: clienteId.present ? clienteId.value : this.clienteId,
    proveedor: proveedor.present ? proveedor.value : this.proveedor,
    origenVentaId: origenVentaId.present
        ? origenVentaId.value
        : this.origenVentaId,
    montoOriginal: montoOriginal ?? this.montoOriginal,
    estado: estado ?? this.estado,
    descripcion: descripcion.present ? descripcion.value : this.descripcion,
    fecha: fecha ?? this.fecha,
  );
  Deuda copyWithCompanion(DeudasCompanion data) {
    return Deuda(
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      id: data.id.present ? data.id.value : this.id,
      direccion: data.direccion.present ? data.direccion.value : this.direccion,
      clienteId: data.clienteId.present ? data.clienteId.value : this.clienteId,
      proveedor: data.proveedor.present ? data.proveedor.value : this.proveedor,
      origenVentaId: data.origenVentaId.present
          ? data.origenVentaId.value
          : this.origenVentaId,
      montoOriginal: data.montoOriginal.present
          ? data.montoOriginal.value
          : this.montoOriginal,
      estado: data.estado.present ? data.estado.value : this.estado,
      descripcion: data.descripcion.present
          ? data.descripcion.value
          : this.descripcion,
      fecha: data.fecha.present ? data.fecha.value : this.fecha,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Deuda(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('direccion: $direccion, ')
          ..write('clienteId: $clienteId, ')
          ..write('proveedor: $proveedor, ')
          ..write('origenVentaId: $origenVentaId, ')
          ..write('montoOriginal: $montoOriginal, ')
          ..write('estado: $estado, ')
          ..write('descripcion: $descripcion, ')
          ..write('fecha: $fecha')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    createdAt,
    updatedAt,
    deletedAt,
    id,
    direccion,
    clienteId,
    proveedor,
    origenVentaId,
    montoOriginal,
    estado,
    descripcion,
    fecha,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Deuda &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.id == this.id &&
          other.direccion == this.direccion &&
          other.clienteId == this.clienteId &&
          other.proveedor == this.proveedor &&
          other.origenVentaId == this.origenVentaId &&
          other.montoOriginal == this.montoOriginal &&
          other.estado == this.estado &&
          other.descripcion == this.descripcion &&
          other.fecha == this.fecha);
}

class DeudasCompanion extends UpdateCompanion<Deuda> {
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<int> id;
  final Value<String> direccion;
  final Value<int?> clienteId;
  final Value<String?> proveedor;
  final Value<int?> origenVentaId;
  final Value<int> montoOriginal;
  final Value<String> estado;
  final Value<String?> descripcion;
  final Value<DateTime> fecha;
  const DeudasCompanion({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.direccion = const Value.absent(),
    this.clienteId = const Value.absent(),
    this.proveedor = const Value.absent(),
    this.origenVentaId = const Value.absent(),
    this.montoOriginal = const Value.absent(),
    this.estado = const Value.absent(),
    this.descripcion = const Value.absent(),
    this.fecha = const Value.absent(),
  });
  DeudasCompanion.insert({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.id = const Value.absent(),
    required String direccion,
    this.clienteId = const Value.absent(),
    this.proveedor = const Value.absent(),
    this.origenVentaId = const Value.absent(),
    required int montoOriginal,
    this.estado = const Value.absent(),
    this.descripcion = const Value.absent(),
    this.fecha = const Value.absent(),
  }) : direccion = Value(direccion),
       montoOriginal = Value(montoOriginal);
  static Insertable<Deuda> custom({
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<int>? id,
    Expression<String>? direccion,
    Expression<int>? clienteId,
    Expression<String>? proveedor,
    Expression<int>? origenVentaId,
    Expression<int>? montoOriginal,
    Expression<String>? estado,
    Expression<String>? descripcion,
    Expression<DateTime>? fecha,
  }) {
    return RawValuesInsertable({
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (id != null) 'id': id,
      if (direccion != null) 'direccion': direccion,
      if (clienteId != null) 'cliente_id': clienteId,
      if (proveedor != null) 'proveedor': proveedor,
      if (origenVentaId != null) 'origen_venta_id': origenVentaId,
      if (montoOriginal != null) 'monto_original': montoOriginal,
      if (estado != null) 'estado': estado,
      if (descripcion != null) 'descripcion': descripcion,
      if (fecha != null) 'fecha': fecha,
    });
  }

  DeudasCompanion copyWith({
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<int>? id,
    Value<String>? direccion,
    Value<int?>? clienteId,
    Value<String?>? proveedor,
    Value<int?>? origenVentaId,
    Value<int>? montoOriginal,
    Value<String>? estado,
    Value<String?>? descripcion,
    Value<DateTime>? fecha,
  }) {
    return DeudasCompanion(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      id: id ?? this.id,
      direccion: direccion ?? this.direccion,
      clienteId: clienteId ?? this.clienteId,
      proveedor: proveedor ?? this.proveedor,
      origenVentaId: origenVentaId ?? this.origenVentaId,
      montoOriginal: montoOriginal ?? this.montoOriginal,
      estado: estado ?? this.estado,
      descripcion: descripcion ?? this.descripcion,
      fecha: fecha ?? this.fecha,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (direccion.present) {
      map['direccion'] = Variable<String>(direccion.value);
    }
    if (clienteId.present) {
      map['cliente_id'] = Variable<int>(clienteId.value);
    }
    if (proveedor.present) {
      map['proveedor'] = Variable<String>(proveedor.value);
    }
    if (origenVentaId.present) {
      map['origen_venta_id'] = Variable<int>(origenVentaId.value);
    }
    if (montoOriginal.present) {
      map['monto_original'] = Variable<int>(montoOriginal.value);
    }
    if (estado.present) {
      map['estado'] = Variable<String>(estado.value);
    }
    if (descripcion.present) {
      map['descripcion'] = Variable<String>(descripcion.value);
    }
    if (fecha.present) {
      map['fecha'] = Variable<DateTime>(fecha.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DeudasCompanion(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('direccion: $direccion, ')
          ..write('clienteId: $clienteId, ')
          ..write('proveedor: $proveedor, ')
          ..write('origenVentaId: $origenVentaId, ')
          ..write('montoOriginal: $montoOriginal, ')
          ..write('estado: $estado, ')
          ..write('descripcion: $descripcion, ')
          ..write('fecha: $fecha')
          ..write(')'))
        .toString();
  }
}

class $PagosDeudaTable extends PagosDeuda
    with TableInfo<$PagosDeudaTable, PagosDeudaData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PagosDeudaTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _deudaIdMeta = const VerificationMeta(
    'deudaId',
  );
  @override
  late final GeneratedColumn<int> deudaId = GeneratedColumn<int>(
    'deuda_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _montoMeta = const VerificationMeta('monto');
  @override
  late final GeneratedColumn<int> monto = GeneratedColumn<int>(
    'monto',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _notaMeta = const VerificationMeta('nota');
  @override
  late final GeneratedColumn<String> nota = GeneratedColumn<String>(
    'nota',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _usuarioIdMeta = const VerificationMeta(
    'usuarioId',
  );
  @override
  late final GeneratedColumn<int> usuarioId = GeneratedColumn<int>(
    'usuario_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _fechaMeta = const VerificationMeta('fecha');
  @override
  late final GeneratedColumn<DateTime> fecha = GeneratedColumn<DateTime>(
    'fecha',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
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
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    deudaId,
    monto,
    nota,
    usuarioId,
    fecha,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pagos_deuda';
  @override
  VerificationContext validateIntegrity(
    Insertable<PagosDeudaData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('deuda_id')) {
      context.handle(
        _deudaIdMeta,
        deudaId.isAcceptableOrUnknown(data['deuda_id']!, _deudaIdMeta),
      );
    } else if (isInserting) {
      context.missing(_deudaIdMeta);
    }
    if (data.containsKey('monto')) {
      context.handle(
        _montoMeta,
        monto.isAcceptableOrUnknown(data['monto']!, _montoMeta),
      );
    } else if (isInserting) {
      context.missing(_montoMeta);
    }
    if (data.containsKey('nota')) {
      context.handle(
        _notaMeta,
        nota.isAcceptableOrUnknown(data['nota']!, _notaMeta),
      );
    }
    if (data.containsKey('usuario_id')) {
      context.handle(
        _usuarioIdMeta,
        usuarioId.isAcceptableOrUnknown(data['usuario_id']!, _usuarioIdMeta),
      );
    }
    if (data.containsKey('fecha')) {
      context.handle(
        _fechaMeta,
        fecha.isAcceptableOrUnknown(data['fecha']!, _fechaMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PagosDeudaData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PagosDeudaData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      deudaId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}deuda_id'],
      )!,
      monto: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}monto'],
      )!,
      nota: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nota'],
      ),
      usuarioId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}usuario_id'],
      ),
      fecha: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}fecha'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $PagosDeudaTable createAlias(String alias) {
    return $PagosDeudaTable(attachedDatabase, alias);
  }
}

class PagosDeudaData extends DataClass implements Insertable<PagosDeudaData> {
  final int id;
  final int deudaId;
  final int monto;
  final String? nota;
  final int? usuarioId;
  final DateTime fecha;
  final DateTime createdAt;
  const PagosDeudaData({
    required this.id,
    required this.deudaId,
    required this.monto,
    this.nota,
    this.usuarioId,
    required this.fecha,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['deuda_id'] = Variable<int>(deudaId);
    map['monto'] = Variable<int>(monto);
    if (!nullToAbsent || nota != null) {
      map['nota'] = Variable<String>(nota);
    }
    if (!nullToAbsent || usuarioId != null) {
      map['usuario_id'] = Variable<int>(usuarioId);
    }
    map['fecha'] = Variable<DateTime>(fecha);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  PagosDeudaCompanion toCompanion(bool nullToAbsent) {
    return PagosDeudaCompanion(
      id: Value(id),
      deudaId: Value(deudaId),
      monto: Value(monto),
      nota: nota == null && nullToAbsent ? const Value.absent() : Value(nota),
      usuarioId: usuarioId == null && nullToAbsent
          ? const Value.absent()
          : Value(usuarioId),
      fecha: Value(fecha),
      createdAt: Value(createdAt),
    );
  }

  factory PagosDeudaData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PagosDeudaData(
      id: serializer.fromJson<int>(json['id']),
      deudaId: serializer.fromJson<int>(json['deudaId']),
      monto: serializer.fromJson<int>(json['monto']),
      nota: serializer.fromJson<String?>(json['nota']),
      usuarioId: serializer.fromJson<int?>(json['usuarioId']),
      fecha: serializer.fromJson<DateTime>(json['fecha']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'deudaId': serializer.toJson<int>(deudaId),
      'monto': serializer.toJson<int>(monto),
      'nota': serializer.toJson<String?>(nota),
      'usuarioId': serializer.toJson<int?>(usuarioId),
      'fecha': serializer.toJson<DateTime>(fecha),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  PagosDeudaData copyWith({
    int? id,
    int? deudaId,
    int? monto,
    Value<String?> nota = const Value.absent(),
    Value<int?> usuarioId = const Value.absent(),
    DateTime? fecha,
    DateTime? createdAt,
  }) => PagosDeudaData(
    id: id ?? this.id,
    deudaId: deudaId ?? this.deudaId,
    monto: monto ?? this.monto,
    nota: nota.present ? nota.value : this.nota,
    usuarioId: usuarioId.present ? usuarioId.value : this.usuarioId,
    fecha: fecha ?? this.fecha,
    createdAt: createdAt ?? this.createdAt,
  );
  PagosDeudaData copyWithCompanion(PagosDeudaCompanion data) {
    return PagosDeudaData(
      id: data.id.present ? data.id.value : this.id,
      deudaId: data.deudaId.present ? data.deudaId.value : this.deudaId,
      monto: data.monto.present ? data.monto.value : this.monto,
      nota: data.nota.present ? data.nota.value : this.nota,
      usuarioId: data.usuarioId.present ? data.usuarioId.value : this.usuarioId,
      fecha: data.fecha.present ? data.fecha.value : this.fecha,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PagosDeudaData(')
          ..write('id: $id, ')
          ..write('deudaId: $deudaId, ')
          ..write('monto: $monto, ')
          ..write('nota: $nota, ')
          ..write('usuarioId: $usuarioId, ')
          ..write('fecha: $fecha, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, deudaId, monto, nota, usuarioId, fecha, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PagosDeudaData &&
          other.id == this.id &&
          other.deudaId == this.deudaId &&
          other.monto == this.monto &&
          other.nota == this.nota &&
          other.usuarioId == this.usuarioId &&
          other.fecha == this.fecha &&
          other.createdAt == this.createdAt);
}

class PagosDeudaCompanion extends UpdateCompanion<PagosDeudaData> {
  final Value<int> id;
  final Value<int> deudaId;
  final Value<int> monto;
  final Value<String?> nota;
  final Value<int?> usuarioId;
  final Value<DateTime> fecha;
  final Value<DateTime> createdAt;
  const PagosDeudaCompanion({
    this.id = const Value.absent(),
    this.deudaId = const Value.absent(),
    this.monto = const Value.absent(),
    this.nota = const Value.absent(),
    this.usuarioId = const Value.absent(),
    this.fecha = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  PagosDeudaCompanion.insert({
    this.id = const Value.absent(),
    required int deudaId,
    required int monto,
    this.nota = const Value.absent(),
    this.usuarioId = const Value.absent(),
    this.fecha = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : deudaId = Value(deudaId),
       monto = Value(monto);
  static Insertable<PagosDeudaData> custom({
    Expression<int>? id,
    Expression<int>? deudaId,
    Expression<int>? monto,
    Expression<String>? nota,
    Expression<int>? usuarioId,
    Expression<DateTime>? fecha,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (deudaId != null) 'deuda_id': deudaId,
      if (monto != null) 'monto': monto,
      if (nota != null) 'nota': nota,
      if (usuarioId != null) 'usuario_id': usuarioId,
      if (fecha != null) 'fecha': fecha,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  PagosDeudaCompanion copyWith({
    Value<int>? id,
    Value<int>? deudaId,
    Value<int>? monto,
    Value<String?>? nota,
    Value<int?>? usuarioId,
    Value<DateTime>? fecha,
    Value<DateTime>? createdAt,
  }) {
    return PagosDeudaCompanion(
      id: id ?? this.id,
      deudaId: deudaId ?? this.deudaId,
      monto: monto ?? this.monto,
      nota: nota ?? this.nota,
      usuarioId: usuarioId ?? this.usuarioId,
      fecha: fecha ?? this.fecha,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (deudaId.present) {
      map['deuda_id'] = Variable<int>(deudaId.value);
    }
    if (monto.present) {
      map['monto'] = Variable<int>(monto.value);
    }
    if (nota.present) {
      map['nota'] = Variable<String>(nota.value);
    }
    if (usuarioId.present) {
      map['usuario_id'] = Variable<int>(usuarioId.value);
    }
    if (fecha.present) {
      map['fecha'] = Variable<DateTime>(fecha.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PagosDeudaCompanion(')
          ..write('id: $id, ')
          ..write('deudaId: $deudaId, ')
          ..write('monto: $monto, ')
          ..write('nota: $nota, ')
          ..write('usuarioId: $usuarioId, ')
          ..write('fecha: $fecha, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $UsuariosTable extends Usuarios with TableInfo<$UsuariosTable, Usuario> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsuariosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nombreMeta = const VerificationMeta('nombre');
  @override
  late final GeneratedColumn<String> nombre = GeneratedColumn<String>(
    'nombre',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pinHashMeta = const VerificationMeta(
    'pinHash',
  );
  @override
  late final GeneratedColumn<String> pinHash = GeneratedColumn<String>(
    'pin_hash',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _rolMeta = const VerificationMeta('rol');
  @override
  late final GeneratedColumn<String> rol = GeneratedColumn<String>(
    'rol',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('dueno'),
  );
  static const VerificationMeta _biometriaHabilitadaMeta =
      const VerificationMeta('biometriaHabilitada');
  @override
  late final GeneratedColumn<bool> biometriaHabilitada = GeneratedColumn<bool>(
    'biometria_habilitada',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("biometria_habilitada" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    createdAt,
    updatedAt,
    deletedAt,
    id,
    nombre,
    pinHash,
    rol,
    biometriaHabilitada,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'usuarios';
  @override
  VerificationContext validateIntegrity(
    Insertable<Usuario> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nombre')) {
      context.handle(
        _nombreMeta,
        nombre.isAcceptableOrUnknown(data['nombre']!, _nombreMeta),
      );
    } else if (isInserting) {
      context.missing(_nombreMeta);
    }
    if (data.containsKey('pin_hash')) {
      context.handle(
        _pinHashMeta,
        pinHash.isAcceptableOrUnknown(data['pin_hash']!, _pinHashMeta),
      );
    }
    if (data.containsKey('rol')) {
      context.handle(
        _rolMeta,
        rol.isAcceptableOrUnknown(data['rol']!, _rolMeta),
      );
    }
    if (data.containsKey('biometria_habilitada')) {
      context.handle(
        _biometriaHabilitadaMeta,
        biometriaHabilitada.isAcceptableOrUnknown(
          data['biometria_habilitada']!,
          _biometriaHabilitadaMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Usuario map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Usuario(
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      nombre: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nombre'],
      )!,
      pinHash: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pin_hash'],
      ),
      rol: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}rol'],
      )!,
      biometriaHabilitada: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}biometria_habilitada'],
      )!,
    );
  }

  @override
  $UsuariosTable createAlias(String alias) {
    return $UsuariosTable(attachedDatabase, alias);
  }
}

class Usuario extends DataClass implements Insertable<Usuario> {
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final int id;
  final String nombre;
  final String? pinHash;
  final String rol;
  final bool biometriaHabilitada;
  const Usuario({
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.id,
    required this.nombre,
    this.pinHash,
    required this.rol,
    required this.biometriaHabilitada,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['id'] = Variable<int>(id);
    map['nombre'] = Variable<String>(nombre);
    if (!nullToAbsent || pinHash != null) {
      map['pin_hash'] = Variable<String>(pinHash);
    }
    map['rol'] = Variable<String>(rol);
    map['biometria_habilitada'] = Variable<bool>(biometriaHabilitada);
    return map;
  }

  UsuariosCompanion toCompanion(bool nullToAbsent) {
    return UsuariosCompanion(
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      id: Value(id),
      nombre: Value(nombre),
      pinHash: pinHash == null && nullToAbsent
          ? const Value.absent()
          : Value(pinHash),
      rol: Value(rol),
      biometriaHabilitada: Value(biometriaHabilitada),
    );
  }

  factory Usuario.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Usuario(
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      id: serializer.fromJson<int>(json['id']),
      nombre: serializer.fromJson<String>(json['nombre']),
      pinHash: serializer.fromJson<String?>(json['pinHash']),
      rol: serializer.fromJson<String>(json['rol']),
      biometriaHabilitada: serializer.fromJson<bool>(
        json['biometriaHabilitada'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'id': serializer.toJson<int>(id),
      'nombre': serializer.toJson<String>(nombre),
      'pinHash': serializer.toJson<String?>(pinHash),
      'rol': serializer.toJson<String>(rol),
      'biometriaHabilitada': serializer.toJson<bool>(biometriaHabilitada),
    };
  }

  Usuario copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    int? id,
    String? nombre,
    Value<String?> pinHash = const Value.absent(),
    String? rol,
    bool? biometriaHabilitada,
  }) => Usuario(
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    id: id ?? this.id,
    nombre: nombre ?? this.nombre,
    pinHash: pinHash.present ? pinHash.value : this.pinHash,
    rol: rol ?? this.rol,
    biometriaHabilitada: biometriaHabilitada ?? this.biometriaHabilitada,
  );
  Usuario copyWithCompanion(UsuariosCompanion data) {
    return Usuario(
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      id: data.id.present ? data.id.value : this.id,
      nombre: data.nombre.present ? data.nombre.value : this.nombre,
      pinHash: data.pinHash.present ? data.pinHash.value : this.pinHash,
      rol: data.rol.present ? data.rol.value : this.rol,
      biometriaHabilitada: data.biometriaHabilitada.present
          ? data.biometriaHabilitada.value
          : this.biometriaHabilitada,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Usuario(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('pinHash: $pinHash, ')
          ..write('rol: $rol, ')
          ..write('biometriaHabilitada: $biometriaHabilitada')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    createdAt,
    updatedAt,
    deletedAt,
    id,
    nombre,
    pinHash,
    rol,
    biometriaHabilitada,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Usuario &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.id == this.id &&
          other.nombre == this.nombre &&
          other.pinHash == this.pinHash &&
          other.rol == this.rol &&
          other.biometriaHabilitada == this.biometriaHabilitada);
}

class UsuariosCompanion extends UpdateCompanion<Usuario> {
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<int> id;
  final Value<String> nombre;
  final Value<String?> pinHash;
  final Value<String> rol;
  final Value<bool> biometriaHabilitada;
  const UsuariosCompanion({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.nombre = const Value.absent(),
    this.pinHash = const Value.absent(),
    this.rol = const Value.absent(),
    this.biometriaHabilitada = const Value.absent(),
  });
  UsuariosCompanion.insert({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.id = const Value.absent(),
    required String nombre,
    this.pinHash = const Value.absent(),
    this.rol = const Value.absent(),
    this.biometriaHabilitada = const Value.absent(),
  }) : nombre = Value(nombre);
  static Insertable<Usuario> custom({
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<int>? id,
    Expression<String>? nombre,
    Expression<String>? pinHash,
    Expression<String>? rol,
    Expression<bool>? biometriaHabilitada,
  }) {
    return RawValuesInsertable({
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (id != null) 'id': id,
      if (nombre != null) 'nombre': nombre,
      if (pinHash != null) 'pin_hash': pinHash,
      if (rol != null) 'rol': rol,
      if (biometriaHabilitada != null)
        'biometria_habilitada': biometriaHabilitada,
    });
  }

  UsuariosCompanion copyWith({
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<int>? id,
    Value<String>? nombre,
    Value<String?>? pinHash,
    Value<String>? rol,
    Value<bool>? biometriaHabilitada,
  }) {
    return UsuariosCompanion(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      pinHash: pinHash ?? this.pinHash,
      rol: rol ?? this.rol,
      biometriaHabilitada: biometriaHabilitada ?? this.biometriaHabilitada,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nombre.present) {
      map['nombre'] = Variable<String>(nombre.value);
    }
    if (pinHash.present) {
      map['pin_hash'] = Variable<String>(pinHash.value);
    }
    if (rol.present) {
      map['rol'] = Variable<String>(rol.value);
    }
    if (biometriaHabilitada.present) {
      map['biometria_habilitada'] = Variable<bool>(biometriaHabilitada.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsuariosCompanion(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('pinHash: $pinHash, ')
          ..write('rol: $rol, ')
          ..write('biometriaHabilitada: $biometriaHabilitada')
          ..write(')'))
        .toString();
  }
}

class $AuditoriasTable extends Auditorias
    with TableInfo<$AuditoriasTable, Auditoria> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AuditoriasTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _entidadMeta = const VerificationMeta(
    'entidad',
  );
  @override
  late final GeneratedColumn<String> entidad = GeneratedColumn<String>(
    'entidad',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _entidadIdMeta = const VerificationMeta(
    'entidadId',
  );
  @override
  late final GeneratedColumn<int> entidadId = GeneratedColumn<int>(
    'entidad_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _accionMeta = const VerificationMeta('accion');
  @override
  late final GeneratedColumn<String> accion = GeneratedColumn<String>(
    'accion',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _campoMeta = const VerificationMeta('campo');
  @override
  late final GeneratedColumn<String> campo = GeneratedColumn<String>(
    'campo',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _valorAnteriorMeta = const VerificationMeta(
    'valorAnterior',
  );
  @override
  late final GeneratedColumn<String> valorAnterior = GeneratedColumn<String>(
    'valor_anterior',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _valorNuevoMeta = const VerificationMeta(
    'valorNuevo',
  );
  @override
  late final GeneratedColumn<String> valorNuevo = GeneratedColumn<String>(
    'valor_nuevo',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _usuarioIdMeta = const VerificationMeta(
    'usuarioId',
  );
  @override
  late final GeneratedColumn<int> usuarioId = GeneratedColumn<int>(
    'usuario_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
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
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    entidad,
    entidadId,
    accion,
    campo,
    valorAnterior,
    valorNuevo,
    usuarioId,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'auditorias';
  @override
  VerificationContext validateIntegrity(
    Insertable<Auditoria> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('entidad')) {
      context.handle(
        _entidadMeta,
        entidad.isAcceptableOrUnknown(data['entidad']!, _entidadMeta),
      );
    } else if (isInserting) {
      context.missing(_entidadMeta);
    }
    if (data.containsKey('entidad_id')) {
      context.handle(
        _entidadIdMeta,
        entidadId.isAcceptableOrUnknown(data['entidad_id']!, _entidadIdMeta),
      );
    }
    if (data.containsKey('accion')) {
      context.handle(
        _accionMeta,
        accion.isAcceptableOrUnknown(data['accion']!, _accionMeta),
      );
    } else if (isInserting) {
      context.missing(_accionMeta);
    }
    if (data.containsKey('campo')) {
      context.handle(
        _campoMeta,
        campo.isAcceptableOrUnknown(data['campo']!, _campoMeta),
      );
    }
    if (data.containsKey('valor_anterior')) {
      context.handle(
        _valorAnteriorMeta,
        valorAnterior.isAcceptableOrUnknown(
          data['valor_anterior']!,
          _valorAnteriorMeta,
        ),
      );
    }
    if (data.containsKey('valor_nuevo')) {
      context.handle(
        _valorNuevoMeta,
        valorNuevo.isAcceptableOrUnknown(data['valor_nuevo']!, _valorNuevoMeta),
      );
    }
    if (data.containsKey('usuario_id')) {
      context.handle(
        _usuarioIdMeta,
        usuarioId.isAcceptableOrUnknown(data['usuario_id']!, _usuarioIdMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Auditoria map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Auditoria(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      entidad: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entidad'],
      )!,
      entidadId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}entidad_id'],
      ),
      accion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}accion'],
      )!,
      campo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}campo'],
      ),
      valorAnterior: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}valor_anterior'],
      ),
      valorNuevo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}valor_nuevo'],
      ),
      usuarioId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}usuario_id'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $AuditoriasTable createAlias(String alias) {
    return $AuditoriasTable(attachedDatabase, alias);
  }
}

class Auditoria extends DataClass implements Insertable<Auditoria> {
  final int id;
  final String entidad;
  final int? entidadId;
  final String accion;
  final String? campo;
  final String? valorAnterior;
  final String? valorNuevo;
  final int? usuarioId;
  final DateTime createdAt;
  const Auditoria({
    required this.id,
    required this.entidad,
    this.entidadId,
    required this.accion,
    this.campo,
    this.valorAnterior,
    this.valorNuevo,
    this.usuarioId,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['entidad'] = Variable<String>(entidad);
    if (!nullToAbsent || entidadId != null) {
      map['entidad_id'] = Variable<int>(entidadId);
    }
    map['accion'] = Variable<String>(accion);
    if (!nullToAbsent || campo != null) {
      map['campo'] = Variable<String>(campo);
    }
    if (!nullToAbsent || valorAnterior != null) {
      map['valor_anterior'] = Variable<String>(valorAnterior);
    }
    if (!nullToAbsent || valorNuevo != null) {
      map['valor_nuevo'] = Variable<String>(valorNuevo);
    }
    if (!nullToAbsent || usuarioId != null) {
      map['usuario_id'] = Variable<int>(usuarioId);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  AuditoriasCompanion toCompanion(bool nullToAbsent) {
    return AuditoriasCompanion(
      id: Value(id),
      entidad: Value(entidad),
      entidadId: entidadId == null && nullToAbsent
          ? const Value.absent()
          : Value(entidadId),
      accion: Value(accion),
      campo: campo == null && nullToAbsent
          ? const Value.absent()
          : Value(campo),
      valorAnterior: valorAnterior == null && nullToAbsent
          ? const Value.absent()
          : Value(valorAnterior),
      valorNuevo: valorNuevo == null && nullToAbsent
          ? const Value.absent()
          : Value(valorNuevo),
      usuarioId: usuarioId == null && nullToAbsent
          ? const Value.absent()
          : Value(usuarioId),
      createdAt: Value(createdAt),
    );
  }

  factory Auditoria.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Auditoria(
      id: serializer.fromJson<int>(json['id']),
      entidad: serializer.fromJson<String>(json['entidad']),
      entidadId: serializer.fromJson<int?>(json['entidadId']),
      accion: serializer.fromJson<String>(json['accion']),
      campo: serializer.fromJson<String?>(json['campo']),
      valorAnterior: serializer.fromJson<String?>(json['valorAnterior']),
      valorNuevo: serializer.fromJson<String?>(json['valorNuevo']),
      usuarioId: serializer.fromJson<int?>(json['usuarioId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'entidad': serializer.toJson<String>(entidad),
      'entidadId': serializer.toJson<int?>(entidadId),
      'accion': serializer.toJson<String>(accion),
      'campo': serializer.toJson<String?>(campo),
      'valorAnterior': serializer.toJson<String?>(valorAnterior),
      'valorNuevo': serializer.toJson<String?>(valorNuevo),
      'usuarioId': serializer.toJson<int?>(usuarioId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Auditoria copyWith({
    int? id,
    String? entidad,
    Value<int?> entidadId = const Value.absent(),
    String? accion,
    Value<String?> campo = const Value.absent(),
    Value<String?> valorAnterior = const Value.absent(),
    Value<String?> valorNuevo = const Value.absent(),
    Value<int?> usuarioId = const Value.absent(),
    DateTime? createdAt,
  }) => Auditoria(
    id: id ?? this.id,
    entidad: entidad ?? this.entidad,
    entidadId: entidadId.present ? entidadId.value : this.entidadId,
    accion: accion ?? this.accion,
    campo: campo.present ? campo.value : this.campo,
    valorAnterior: valorAnterior.present
        ? valorAnterior.value
        : this.valorAnterior,
    valorNuevo: valorNuevo.present ? valorNuevo.value : this.valorNuevo,
    usuarioId: usuarioId.present ? usuarioId.value : this.usuarioId,
    createdAt: createdAt ?? this.createdAt,
  );
  Auditoria copyWithCompanion(AuditoriasCompanion data) {
    return Auditoria(
      id: data.id.present ? data.id.value : this.id,
      entidad: data.entidad.present ? data.entidad.value : this.entidad,
      entidadId: data.entidadId.present ? data.entidadId.value : this.entidadId,
      accion: data.accion.present ? data.accion.value : this.accion,
      campo: data.campo.present ? data.campo.value : this.campo,
      valorAnterior: data.valorAnterior.present
          ? data.valorAnterior.value
          : this.valorAnterior,
      valorNuevo: data.valorNuevo.present
          ? data.valorNuevo.value
          : this.valorNuevo,
      usuarioId: data.usuarioId.present ? data.usuarioId.value : this.usuarioId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Auditoria(')
          ..write('id: $id, ')
          ..write('entidad: $entidad, ')
          ..write('entidadId: $entidadId, ')
          ..write('accion: $accion, ')
          ..write('campo: $campo, ')
          ..write('valorAnterior: $valorAnterior, ')
          ..write('valorNuevo: $valorNuevo, ')
          ..write('usuarioId: $usuarioId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    entidad,
    entidadId,
    accion,
    campo,
    valorAnterior,
    valorNuevo,
    usuarioId,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Auditoria &&
          other.id == this.id &&
          other.entidad == this.entidad &&
          other.entidadId == this.entidadId &&
          other.accion == this.accion &&
          other.campo == this.campo &&
          other.valorAnterior == this.valorAnterior &&
          other.valorNuevo == this.valorNuevo &&
          other.usuarioId == this.usuarioId &&
          other.createdAt == this.createdAt);
}

class AuditoriasCompanion extends UpdateCompanion<Auditoria> {
  final Value<int> id;
  final Value<String> entidad;
  final Value<int?> entidadId;
  final Value<String> accion;
  final Value<String?> campo;
  final Value<String?> valorAnterior;
  final Value<String?> valorNuevo;
  final Value<int?> usuarioId;
  final Value<DateTime> createdAt;
  const AuditoriasCompanion({
    this.id = const Value.absent(),
    this.entidad = const Value.absent(),
    this.entidadId = const Value.absent(),
    this.accion = const Value.absent(),
    this.campo = const Value.absent(),
    this.valorAnterior = const Value.absent(),
    this.valorNuevo = const Value.absent(),
    this.usuarioId = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  AuditoriasCompanion.insert({
    this.id = const Value.absent(),
    required String entidad,
    this.entidadId = const Value.absent(),
    required String accion,
    this.campo = const Value.absent(),
    this.valorAnterior = const Value.absent(),
    this.valorNuevo = const Value.absent(),
    this.usuarioId = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : entidad = Value(entidad),
       accion = Value(accion);
  static Insertable<Auditoria> custom({
    Expression<int>? id,
    Expression<String>? entidad,
    Expression<int>? entidadId,
    Expression<String>? accion,
    Expression<String>? campo,
    Expression<String>? valorAnterior,
    Expression<String>? valorNuevo,
    Expression<int>? usuarioId,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (entidad != null) 'entidad': entidad,
      if (entidadId != null) 'entidad_id': entidadId,
      if (accion != null) 'accion': accion,
      if (campo != null) 'campo': campo,
      if (valorAnterior != null) 'valor_anterior': valorAnterior,
      if (valorNuevo != null) 'valor_nuevo': valorNuevo,
      if (usuarioId != null) 'usuario_id': usuarioId,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  AuditoriasCompanion copyWith({
    Value<int>? id,
    Value<String>? entidad,
    Value<int?>? entidadId,
    Value<String>? accion,
    Value<String?>? campo,
    Value<String?>? valorAnterior,
    Value<String?>? valorNuevo,
    Value<int?>? usuarioId,
    Value<DateTime>? createdAt,
  }) {
    return AuditoriasCompanion(
      id: id ?? this.id,
      entidad: entidad ?? this.entidad,
      entidadId: entidadId ?? this.entidadId,
      accion: accion ?? this.accion,
      campo: campo ?? this.campo,
      valorAnterior: valorAnterior ?? this.valorAnterior,
      valorNuevo: valorNuevo ?? this.valorNuevo,
      usuarioId: usuarioId ?? this.usuarioId,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (entidad.present) {
      map['entidad'] = Variable<String>(entidad.value);
    }
    if (entidadId.present) {
      map['entidad_id'] = Variable<int>(entidadId.value);
    }
    if (accion.present) {
      map['accion'] = Variable<String>(accion.value);
    }
    if (campo.present) {
      map['campo'] = Variable<String>(campo.value);
    }
    if (valorAnterior.present) {
      map['valor_anterior'] = Variable<String>(valorAnterior.value);
    }
    if (valorNuevo.present) {
      map['valor_nuevo'] = Variable<String>(valorNuevo.value);
    }
    if (usuarioId.present) {
      map['usuario_id'] = Variable<int>(usuarioId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AuditoriasCompanion(')
          ..write('id: $id, ')
          ..write('entidad: $entidad, ')
          ..write('entidadId: $entidadId, ')
          ..write('accion: $accion, ')
          ..write('campo: $campo, ')
          ..write('valorAnterior: $valorAnterior, ')
          ..write('valorNuevo: $valorNuevo, ')
          ..write('usuarioId: $usuarioId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $PreferenciasVisualizacionTable extends PreferenciasVisualizacion
    with
        TableInfo<
          $PreferenciasVisualizacionTable,
          PreferenciasVisualizacionData
        > {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PreferenciasVisualizacionTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _widgetKeyMeta = const VerificationMeta(
    'widgetKey',
  );
  @override
  late final GeneratedColumn<String> widgetKey = GeneratedColumn<String>(
    'widget_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tipoVistaMeta = const VerificationMeta(
    'tipoVista',
  );
  @override
  late final GeneratedColumn<String> tipoVista = GeneratedColumn<String>(
    'tipo_vista',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _usuarioIdMeta = const VerificationMeta(
    'usuarioId',
  );
  @override
  late final GeneratedColumn<int> usuarioId = GeneratedColumn<int>(
    'usuario_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    widgetKey,
    tipoVista,
    usuarioId,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'preferencias_visualizacion';
  @override
  VerificationContext validateIntegrity(
    Insertable<PreferenciasVisualizacionData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('widget_key')) {
      context.handle(
        _widgetKeyMeta,
        widgetKey.isAcceptableOrUnknown(data['widget_key']!, _widgetKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_widgetKeyMeta);
    }
    if (data.containsKey('tipo_vista')) {
      context.handle(
        _tipoVistaMeta,
        tipoVista.isAcceptableOrUnknown(data['tipo_vista']!, _tipoVistaMeta),
      );
    } else if (isInserting) {
      context.missing(_tipoVistaMeta);
    }
    if (data.containsKey('usuario_id')) {
      context.handle(
        _usuarioIdMeta,
        usuarioId.isAcceptableOrUnknown(data['usuario_id']!, _usuarioIdMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {widgetKey};
  @override
  PreferenciasVisualizacionData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PreferenciasVisualizacionData(
      widgetKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}widget_key'],
      )!,
      tipoVista: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tipo_vista'],
      )!,
      usuarioId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}usuario_id'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $PreferenciasVisualizacionTable createAlias(String alias) {
    return $PreferenciasVisualizacionTable(attachedDatabase, alias);
  }
}

class PreferenciasVisualizacionData extends DataClass
    implements Insertable<PreferenciasVisualizacionData> {
  final String widgetKey;
  final String tipoVista;
  final int? usuarioId;
  final DateTime updatedAt;
  const PreferenciasVisualizacionData({
    required this.widgetKey,
    required this.tipoVista,
    this.usuarioId,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['widget_key'] = Variable<String>(widgetKey);
    map['tipo_vista'] = Variable<String>(tipoVista);
    if (!nullToAbsent || usuarioId != null) {
      map['usuario_id'] = Variable<int>(usuarioId);
    }
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  PreferenciasVisualizacionCompanion toCompanion(bool nullToAbsent) {
    return PreferenciasVisualizacionCompanion(
      widgetKey: Value(widgetKey),
      tipoVista: Value(tipoVista),
      usuarioId: usuarioId == null && nullToAbsent
          ? const Value.absent()
          : Value(usuarioId),
      updatedAt: Value(updatedAt),
    );
  }

  factory PreferenciasVisualizacionData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PreferenciasVisualizacionData(
      widgetKey: serializer.fromJson<String>(json['widgetKey']),
      tipoVista: serializer.fromJson<String>(json['tipoVista']),
      usuarioId: serializer.fromJson<int?>(json['usuarioId']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'widgetKey': serializer.toJson<String>(widgetKey),
      'tipoVista': serializer.toJson<String>(tipoVista),
      'usuarioId': serializer.toJson<int?>(usuarioId),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  PreferenciasVisualizacionData copyWith({
    String? widgetKey,
    String? tipoVista,
    Value<int?> usuarioId = const Value.absent(),
    DateTime? updatedAt,
  }) => PreferenciasVisualizacionData(
    widgetKey: widgetKey ?? this.widgetKey,
    tipoVista: tipoVista ?? this.tipoVista,
    usuarioId: usuarioId.present ? usuarioId.value : this.usuarioId,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  PreferenciasVisualizacionData copyWithCompanion(
    PreferenciasVisualizacionCompanion data,
  ) {
    return PreferenciasVisualizacionData(
      widgetKey: data.widgetKey.present ? data.widgetKey.value : this.widgetKey,
      tipoVista: data.tipoVista.present ? data.tipoVista.value : this.tipoVista,
      usuarioId: data.usuarioId.present ? data.usuarioId.value : this.usuarioId,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PreferenciasVisualizacionData(')
          ..write('widgetKey: $widgetKey, ')
          ..write('tipoVista: $tipoVista, ')
          ..write('usuarioId: $usuarioId, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(widgetKey, tipoVista, usuarioId, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PreferenciasVisualizacionData &&
          other.widgetKey == this.widgetKey &&
          other.tipoVista == this.tipoVista &&
          other.usuarioId == this.usuarioId &&
          other.updatedAt == this.updatedAt);
}

class PreferenciasVisualizacionCompanion
    extends UpdateCompanion<PreferenciasVisualizacionData> {
  final Value<String> widgetKey;
  final Value<String> tipoVista;
  final Value<int?> usuarioId;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const PreferenciasVisualizacionCompanion({
    this.widgetKey = const Value.absent(),
    this.tipoVista = const Value.absent(),
    this.usuarioId = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PreferenciasVisualizacionCompanion.insert({
    required String widgetKey,
    required String tipoVista,
    this.usuarioId = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : widgetKey = Value(widgetKey),
       tipoVista = Value(tipoVista);
  static Insertable<PreferenciasVisualizacionData> custom({
    Expression<String>? widgetKey,
    Expression<String>? tipoVista,
    Expression<int>? usuarioId,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (widgetKey != null) 'widget_key': widgetKey,
      if (tipoVista != null) 'tipo_vista': tipoVista,
      if (usuarioId != null) 'usuario_id': usuarioId,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PreferenciasVisualizacionCompanion copyWith({
    Value<String>? widgetKey,
    Value<String>? tipoVista,
    Value<int?>? usuarioId,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return PreferenciasVisualizacionCompanion(
      widgetKey: widgetKey ?? this.widgetKey,
      tipoVista: tipoVista ?? this.tipoVista,
      usuarioId: usuarioId ?? this.usuarioId,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (widgetKey.present) {
      map['widget_key'] = Variable<String>(widgetKey.value);
    }
    if (tipoVista.present) {
      map['tipo_vista'] = Variable<String>(tipoVista.value);
    }
    if (usuarioId.present) {
      map['usuario_id'] = Variable<int>(usuarioId.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PreferenciasVisualizacionCompanion(')
          ..write('widgetKey: $widgetKey, ')
          ..write('tipoVista: $tipoVista, ')
          ..write('usuarioId: $usuarioId, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ConfiguracionesTable extends Configuraciones
    with TableInfo<$ConfiguracionesTable, Configuracione> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ConfiguracionesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _claveMeta = const VerificationMeta('clave');
  @override
  late final GeneratedColumn<String> clave = GeneratedColumn<String>(
    'clave',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valorMeta = const VerificationMeta('valor');
  @override
  late final GeneratedColumn<String> valor = GeneratedColumn<String>(
    'valor',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [clave, valor];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'configuraciones';
  @override
  VerificationContext validateIntegrity(
    Insertable<Configuracione> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('clave')) {
      context.handle(
        _claveMeta,
        clave.isAcceptableOrUnknown(data['clave']!, _claveMeta),
      );
    } else if (isInserting) {
      context.missing(_claveMeta);
    }
    if (data.containsKey('valor')) {
      context.handle(
        _valorMeta,
        valor.isAcceptableOrUnknown(data['valor']!, _valorMeta),
      );
    } else if (isInserting) {
      context.missing(_valorMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {clave};
  @override
  Configuracione map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Configuracione(
      clave: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}clave'],
      )!,
      valor: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}valor'],
      )!,
    );
  }

  @override
  $ConfiguracionesTable createAlias(String alias) {
    return $ConfiguracionesTable(attachedDatabase, alias);
  }
}

class Configuracione extends DataClass implements Insertable<Configuracione> {
  final String clave;
  final String valor;
  const Configuracione({required this.clave, required this.valor});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['clave'] = Variable<String>(clave);
    map['valor'] = Variable<String>(valor);
    return map;
  }

  ConfiguracionesCompanion toCompanion(bool nullToAbsent) {
    return ConfiguracionesCompanion(clave: Value(clave), valor: Value(valor));
  }

  factory Configuracione.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Configuracione(
      clave: serializer.fromJson<String>(json['clave']),
      valor: serializer.fromJson<String>(json['valor']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'clave': serializer.toJson<String>(clave),
      'valor': serializer.toJson<String>(valor),
    };
  }

  Configuracione copyWith({String? clave, String? valor}) =>
      Configuracione(clave: clave ?? this.clave, valor: valor ?? this.valor);
  Configuracione copyWithCompanion(ConfiguracionesCompanion data) {
    return Configuracione(
      clave: data.clave.present ? data.clave.value : this.clave,
      valor: data.valor.present ? data.valor.value : this.valor,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Configuracione(')
          ..write('clave: $clave, ')
          ..write('valor: $valor')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(clave, valor);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Configuracione &&
          other.clave == this.clave &&
          other.valor == this.valor);
}

class ConfiguracionesCompanion extends UpdateCompanion<Configuracione> {
  final Value<String> clave;
  final Value<String> valor;
  final Value<int> rowid;
  const ConfiguracionesCompanion({
    this.clave = const Value.absent(),
    this.valor = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ConfiguracionesCompanion.insert({
    required String clave,
    required String valor,
    this.rowid = const Value.absent(),
  }) : clave = Value(clave),
       valor = Value(valor);
  static Insertable<Configuracione> custom({
    Expression<String>? clave,
    Expression<String>? valor,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (clave != null) 'clave': clave,
      if (valor != null) 'valor': valor,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ConfiguracionesCompanion copyWith({
    Value<String>? clave,
    Value<String>? valor,
    Value<int>? rowid,
  }) {
    return ConfiguracionesCompanion(
      clave: clave ?? this.clave,
      valor: valor ?? this.valor,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (clave.present) {
      map['clave'] = Variable<String>(clave.value);
    }
    if (valor.present) {
      map['valor'] = Variable<String>(valor.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ConfiguracionesCompanion(')
          ..write('clave: $clave, ')
          ..write('valor: $valor, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $CategoriasTable categorias = $CategoriasTable(this);
  late final $ProductosTable productos = $ProductosTable(this);
  late final $HistorialPreciosTable historialPrecios = $HistorialPreciosTable(
    this,
  );
  late final $ClientesTable clientes = $ClientesTable(this);
  late final $VentasTable ventas = $VentasTable(this);
  late final $DetalleVentasTable detalleVentas = $DetalleVentasTable(this);
  late final $MovimientosInventarioTable movimientosInventario =
      $MovimientosInventarioTable(this);
  late final $GastosTable gastos = $GastosTable(this);
  late final $DeudasTable deudas = $DeudasTable(this);
  late final $PagosDeudaTable pagosDeuda = $PagosDeudaTable(this);
  late final $UsuariosTable usuarios = $UsuariosTable(this);
  late final $AuditoriasTable auditorias = $AuditoriasTable(this);
  late final $PreferenciasVisualizacionTable preferenciasVisualizacion =
      $PreferenciasVisualizacionTable(this);
  late final $ConfiguracionesTable configuraciones = $ConfiguracionesTable(
    this,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    categorias,
    productos,
    historialPrecios,
    clientes,
    ventas,
    detalleVentas,
    movimientosInventario,
    gastos,
    deudas,
    pagosDeuda,
    usuarios,
    auditorias,
    preferenciasVisualizacion,
    configuraciones,
  ];
}

typedef $$CategoriasTableCreateCompanionBuilder =
    CategoriasCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<int> id,
      required String nombre,
      Value<int> orden,
      Value<bool> activo,
    });
typedef $$CategoriasTableUpdateCompanionBuilder =
    CategoriasCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<int> id,
      Value<String> nombre,
      Value<int> orden,
      Value<bool> activo,
    });

class $$CategoriasTableFilterComposer
    extends Composer<_$AppDatabase, $CategoriasTable> {
  $$CategoriasTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get orden => $composableBuilder(
    column: $table.orden,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get activo => $composableBuilder(
    column: $table.activo,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CategoriasTableOrderingComposer
    extends Composer<_$AppDatabase, $CategoriasTable> {
  $$CategoriasTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get orden => $composableBuilder(
    column: $table.orden,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get activo => $composableBuilder(
    column: $table.activo,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CategoriasTableAnnotationComposer
    extends Composer<_$AppDatabase, $CategoriasTable> {
  $$CategoriasTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nombre =>
      $composableBuilder(column: $table.nombre, builder: (column) => column);

  GeneratedColumn<int> get orden =>
      $composableBuilder(column: $table.orden, builder: (column) => column);

  GeneratedColumn<bool> get activo =>
      $composableBuilder(column: $table.activo, builder: (column) => column);
}

class $$CategoriasTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CategoriasTable,
          Categoria,
          $$CategoriasTableFilterComposer,
          $$CategoriasTableOrderingComposer,
          $$CategoriasTableAnnotationComposer,
          $$CategoriasTableCreateCompanionBuilder,
          $$CategoriasTableUpdateCompanionBuilder,
          (
            Categoria,
            BaseReferences<_$AppDatabase, $CategoriasTable, Categoria>,
          ),
          Categoria,
          PrefetchHooks Function()
        > {
  $$CategoriasTableTableManager(_$AppDatabase db, $CategoriasTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CategoriasTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CategoriasTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CategoriasTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> id = const Value.absent(),
                Value<String> nombre = const Value.absent(),
                Value<int> orden = const Value.absent(),
                Value<bool> activo = const Value.absent(),
              }) => CategoriasCompanion(
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                id: id,
                nombre: nombre,
                orden: orden,
                activo: activo,
              ),
          createCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> id = const Value.absent(),
                required String nombre,
                Value<int> orden = const Value.absent(),
                Value<bool> activo = const Value.absent(),
              }) => CategoriasCompanion.insert(
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                id: id,
                nombre: nombre,
                orden: orden,
                activo: activo,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CategoriasTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CategoriasTable,
      Categoria,
      $$CategoriasTableFilterComposer,
      $$CategoriasTableOrderingComposer,
      $$CategoriasTableAnnotationComposer,
      $$CategoriasTableCreateCompanionBuilder,
      $$CategoriasTableUpdateCompanionBuilder,
      (Categoria, BaseReferences<_$AppDatabase, $CategoriasTable, Categoria>),
      Categoria,
      PrefetchHooks Function()
    >;
typedef $$ProductosTableCreateCompanionBuilder =
    ProductosCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<int> id,
      required String nombre,
      Value<int?> categoriaId,
      Value<String> unidadVenta,
      Value<int> precioVendedor,
      Value<int> precioPublico,
      Value<int?> costoProduccion,
      Value<double> stockActual,
      Value<double> stockMinimo,
      Value<String> estado,
    });
typedef $$ProductosTableUpdateCompanionBuilder =
    ProductosCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<int> id,
      Value<String> nombre,
      Value<int?> categoriaId,
      Value<String> unidadVenta,
      Value<int> precioVendedor,
      Value<int> precioPublico,
      Value<int?> costoProduccion,
      Value<double> stockActual,
      Value<double> stockMinimo,
      Value<String> estado,
    });

class $$ProductosTableFilterComposer
    extends Composer<_$AppDatabase, $ProductosTable> {
  $$ProductosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get categoriaId => $composableBuilder(
    column: $table.categoriaId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get unidadVenta => $composableBuilder(
    column: $table.unidadVenta,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get precioVendedor => $composableBuilder(
    column: $table.precioVendedor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get precioPublico => $composableBuilder(
    column: $table.precioPublico,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get costoProduccion => $composableBuilder(
    column: $table.costoProduccion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get stockActual => $composableBuilder(
    column: $table.stockActual,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get stockMinimo => $composableBuilder(
    column: $table.stockMinimo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get estado => $composableBuilder(
    column: $table.estado,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ProductosTableOrderingComposer
    extends Composer<_$AppDatabase, $ProductosTable> {
  $$ProductosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get categoriaId => $composableBuilder(
    column: $table.categoriaId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get unidadVenta => $composableBuilder(
    column: $table.unidadVenta,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get precioVendedor => $composableBuilder(
    column: $table.precioVendedor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get precioPublico => $composableBuilder(
    column: $table.precioPublico,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get costoProduccion => $composableBuilder(
    column: $table.costoProduccion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get stockActual => $composableBuilder(
    column: $table.stockActual,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get stockMinimo => $composableBuilder(
    column: $table.stockMinimo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get estado => $composableBuilder(
    column: $table.estado,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ProductosTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProductosTable> {
  $$ProductosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nombre =>
      $composableBuilder(column: $table.nombre, builder: (column) => column);

  GeneratedColumn<int> get categoriaId => $composableBuilder(
    column: $table.categoriaId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get unidadVenta => $composableBuilder(
    column: $table.unidadVenta,
    builder: (column) => column,
  );

  GeneratedColumn<int> get precioVendedor => $composableBuilder(
    column: $table.precioVendedor,
    builder: (column) => column,
  );

  GeneratedColumn<int> get precioPublico => $composableBuilder(
    column: $table.precioPublico,
    builder: (column) => column,
  );

  GeneratedColumn<int> get costoProduccion => $composableBuilder(
    column: $table.costoProduccion,
    builder: (column) => column,
  );

  GeneratedColumn<double> get stockActual => $composableBuilder(
    column: $table.stockActual,
    builder: (column) => column,
  );

  GeneratedColumn<double> get stockMinimo => $composableBuilder(
    column: $table.stockMinimo,
    builder: (column) => column,
  );

  GeneratedColumn<String> get estado =>
      $composableBuilder(column: $table.estado, builder: (column) => column);
}

class $$ProductosTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProductosTable,
          Producto,
          $$ProductosTableFilterComposer,
          $$ProductosTableOrderingComposer,
          $$ProductosTableAnnotationComposer,
          $$ProductosTableCreateCompanionBuilder,
          $$ProductosTableUpdateCompanionBuilder,
          (Producto, BaseReferences<_$AppDatabase, $ProductosTable, Producto>),
          Producto,
          PrefetchHooks Function()
        > {
  $$ProductosTableTableManager(_$AppDatabase db, $ProductosTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProductosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProductosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProductosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> id = const Value.absent(),
                Value<String> nombre = const Value.absent(),
                Value<int?> categoriaId = const Value.absent(),
                Value<String> unidadVenta = const Value.absent(),
                Value<int> precioVendedor = const Value.absent(),
                Value<int> precioPublico = const Value.absent(),
                Value<int?> costoProduccion = const Value.absent(),
                Value<double> stockActual = const Value.absent(),
                Value<double> stockMinimo = const Value.absent(),
                Value<String> estado = const Value.absent(),
              }) => ProductosCompanion(
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                id: id,
                nombre: nombre,
                categoriaId: categoriaId,
                unidadVenta: unidadVenta,
                precioVendedor: precioVendedor,
                precioPublico: precioPublico,
                costoProduccion: costoProduccion,
                stockActual: stockActual,
                stockMinimo: stockMinimo,
                estado: estado,
              ),
          createCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> id = const Value.absent(),
                required String nombre,
                Value<int?> categoriaId = const Value.absent(),
                Value<String> unidadVenta = const Value.absent(),
                Value<int> precioVendedor = const Value.absent(),
                Value<int> precioPublico = const Value.absent(),
                Value<int?> costoProduccion = const Value.absent(),
                Value<double> stockActual = const Value.absent(),
                Value<double> stockMinimo = const Value.absent(),
                Value<String> estado = const Value.absent(),
              }) => ProductosCompanion.insert(
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                id: id,
                nombre: nombre,
                categoriaId: categoriaId,
                unidadVenta: unidadVenta,
                precioVendedor: precioVendedor,
                precioPublico: precioPublico,
                costoProduccion: costoProduccion,
                stockActual: stockActual,
                stockMinimo: stockMinimo,
                estado: estado,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ProductosTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProductosTable,
      Producto,
      $$ProductosTableFilterComposer,
      $$ProductosTableOrderingComposer,
      $$ProductosTableAnnotationComposer,
      $$ProductosTableCreateCompanionBuilder,
      $$ProductosTableUpdateCompanionBuilder,
      (Producto, BaseReferences<_$AppDatabase, $ProductosTable, Producto>),
      Producto,
      PrefetchHooks Function()
    >;
typedef $$HistorialPreciosTableCreateCompanionBuilder =
    HistorialPreciosCompanion Function({
      Value<int> id,
      required int productoId,
      required String tipoPrecio,
      Value<int?> precioAnterior,
      required int precioNuevo,
      Value<String?> motivo,
      Value<int?> usuarioId,
      Value<DateTime> createdAt,
    });
typedef $$HistorialPreciosTableUpdateCompanionBuilder =
    HistorialPreciosCompanion Function({
      Value<int> id,
      Value<int> productoId,
      Value<String> tipoPrecio,
      Value<int?> precioAnterior,
      Value<int> precioNuevo,
      Value<String?> motivo,
      Value<int?> usuarioId,
      Value<DateTime> createdAt,
    });

class $$HistorialPreciosTableFilterComposer
    extends Composer<_$AppDatabase, $HistorialPreciosTable> {
  $$HistorialPreciosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get productoId => $composableBuilder(
    column: $table.productoId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tipoPrecio => $composableBuilder(
    column: $table.tipoPrecio,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get precioAnterior => $composableBuilder(
    column: $table.precioAnterior,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get precioNuevo => $composableBuilder(
    column: $table.precioNuevo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get motivo => $composableBuilder(
    column: $table.motivo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get usuarioId => $composableBuilder(
    column: $table.usuarioId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$HistorialPreciosTableOrderingComposer
    extends Composer<_$AppDatabase, $HistorialPreciosTable> {
  $$HistorialPreciosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get productoId => $composableBuilder(
    column: $table.productoId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tipoPrecio => $composableBuilder(
    column: $table.tipoPrecio,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get precioAnterior => $composableBuilder(
    column: $table.precioAnterior,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get precioNuevo => $composableBuilder(
    column: $table.precioNuevo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get motivo => $composableBuilder(
    column: $table.motivo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get usuarioId => $composableBuilder(
    column: $table.usuarioId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$HistorialPreciosTableAnnotationComposer
    extends Composer<_$AppDatabase, $HistorialPreciosTable> {
  $$HistorialPreciosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get productoId => $composableBuilder(
    column: $table.productoId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get tipoPrecio => $composableBuilder(
    column: $table.tipoPrecio,
    builder: (column) => column,
  );

  GeneratedColumn<int> get precioAnterior => $composableBuilder(
    column: $table.precioAnterior,
    builder: (column) => column,
  );

  GeneratedColumn<int> get precioNuevo => $composableBuilder(
    column: $table.precioNuevo,
    builder: (column) => column,
  );

  GeneratedColumn<String> get motivo =>
      $composableBuilder(column: $table.motivo, builder: (column) => column);

  GeneratedColumn<int> get usuarioId =>
      $composableBuilder(column: $table.usuarioId, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$HistorialPreciosTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $HistorialPreciosTable,
          HistorialPrecio,
          $$HistorialPreciosTableFilterComposer,
          $$HistorialPreciosTableOrderingComposer,
          $$HistorialPreciosTableAnnotationComposer,
          $$HistorialPreciosTableCreateCompanionBuilder,
          $$HistorialPreciosTableUpdateCompanionBuilder,
          (
            HistorialPrecio,
            BaseReferences<
              _$AppDatabase,
              $HistorialPreciosTable,
              HistorialPrecio
            >,
          ),
          HistorialPrecio,
          PrefetchHooks Function()
        > {
  $$HistorialPreciosTableTableManager(
    _$AppDatabase db,
    $HistorialPreciosTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HistorialPreciosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HistorialPreciosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HistorialPreciosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> productoId = const Value.absent(),
                Value<String> tipoPrecio = const Value.absent(),
                Value<int?> precioAnterior = const Value.absent(),
                Value<int> precioNuevo = const Value.absent(),
                Value<String?> motivo = const Value.absent(),
                Value<int?> usuarioId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => HistorialPreciosCompanion(
                id: id,
                productoId: productoId,
                tipoPrecio: tipoPrecio,
                precioAnterior: precioAnterior,
                precioNuevo: precioNuevo,
                motivo: motivo,
                usuarioId: usuarioId,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int productoId,
                required String tipoPrecio,
                Value<int?> precioAnterior = const Value.absent(),
                required int precioNuevo,
                Value<String?> motivo = const Value.absent(),
                Value<int?> usuarioId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => HistorialPreciosCompanion.insert(
                id: id,
                productoId: productoId,
                tipoPrecio: tipoPrecio,
                precioAnterior: precioAnterior,
                precioNuevo: precioNuevo,
                motivo: motivo,
                usuarioId: usuarioId,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$HistorialPreciosTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $HistorialPreciosTable,
      HistorialPrecio,
      $$HistorialPreciosTableFilterComposer,
      $$HistorialPreciosTableOrderingComposer,
      $$HistorialPreciosTableAnnotationComposer,
      $$HistorialPreciosTableCreateCompanionBuilder,
      $$HistorialPreciosTableUpdateCompanionBuilder,
      (
        HistorialPrecio,
        BaseReferences<_$AppDatabase, $HistorialPreciosTable, HistorialPrecio>,
      ),
      HistorialPrecio,
      PrefetchHooks Function()
    >;
typedef $$ClientesTableCreateCompanionBuilder =
    ClientesCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<int> id,
      required String nombre,
      Value<String> tipo,
      Value<String?> contacto,
      Value<String> diasVisita,
      Value<String?> notas,
      Value<bool> activo,
    });
typedef $$ClientesTableUpdateCompanionBuilder =
    ClientesCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<int> id,
      Value<String> nombre,
      Value<String> tipo,
      Value<String?> contacto,
      Value<String> diasVisita,
      Value<String?> notas,
      Value<bool> activo,
    });

class $$ClientesTableFilterComposer
    extends Composer<_$AppDatabase, $ClientesTable> {
  $$ClientesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tipo => $composableBuilder(
    column: $table.tipo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contacto => $composableBuilder(
    column: $table.contacto,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get diasVisita => $composableBuilder(
    column: $table.diasVisita,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notas => $composableBuilder(
    column: $table.notas,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get activo => $composableBuilder(
    column: $table.activo,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ClientesTableOrderingComposer
    extends Composer<_$AppDatabase, $ClientesTable> {
  $$ClientesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tipo => $composableBuilder(
    column: $table.tipo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contacto => $composableBuilder(
    column: $table.contacto,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get diasVisita => $composableBuilder(
    column: $table.diasVisita,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notas => $composableBuilder(
    column: $table.notas,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get activo => $composableBuilder(
    column: $table.activo,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ClientesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ClientesTable> {
  $$ClientesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nombre =>
      $composableBuilder(column: $table.nombre, builder: (column) => column);

  GeneratedColumn<String> get tipo =>
      $composableBuilder(column: $table.tipo, builder: (column) => column);

  GeneratedColumn<String> get contacto =>
      $composableBuilder(column: $table.contacto, builder: (column) => column);

  GeneratedColumn<String> get diasVisita => $composableBuilder(
    column: $table.diasVisita,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notas =>
      $composableBuilder(column: $table.notas, builder: (column) => column);

  GeneratedColumn<bool> get activo =>
      $composableBuilder(column: $table.activo, builder: (column) => column);
}

class $$ClientesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ClientesTable,
          Cliente,
          $$ClientesTableFilterComposer,
          $$ClientesTableOrderingComposer,
          $$ClientesTableAnnotationComposer,
          $$ClientesTableCreateCompanionBuilder,
          $$ClientesTableUpdateCompanionBuilder,
          (Cliente, BaseReferences<_$AppDatabase, $ClientesTable, Cliente>),
          Cliente,
          PrefetchHooks Function()
        > {
  $$ClientesTableTableManager(_$AppDatabase db, $ClientesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ClientesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ClientesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ClientesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> id = const Value.absent(),
                Value<String> nombre = const Value.absent(),
                Value<String> tipo = const Value.absent(),
                Value<String?> contacto = const Value.absent(),
                Value<String> diasVisita = const Value.absent(),
                Value<String?> notas = const Value.absent(),
                Value<bool> activo = const Value.absent(),
              }) => ClientesCompanion(
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                id: id,
                nombre: nombre,
                tipo: tipo,
                contacto: contacto,
                diasVisita: diasVisita,
                notas: notas,
                activo: activo,
              ),
          createCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> id = const Value.absent(),
                required String nombre,
                Value<String> tipo = const Value.absent(),
                Value<String?> contacto = const Value.absent(),
                Value<String> diasVisita = const Value.absent(),
                Value<String?> notas = const Value.absent(),
                Value<bool> activo = const Value.absent(),
              }) => ClientesCompanion.insert(
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                id: id,
                nombre: nombre,
                tipo: tipo,
                contacto: contacto,
                diasVisita: diasVisita,
                notas: notas,
                activo: activo,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ClientesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ClientesTable,
      Cliente,
      $$ClientesTableFilterComposer,
      $$ClientesTableOrderingComposer,
      $$ClientesTableAnnotationComposer,
      $$ClientesTableCreateCompanionBuilder,
      $$ClientesTableUpdateCompanionBuilder,
      (Cliente, BaseReferences<_$AppDatabase, $ClientesTable, Cliente>),
      Cliente,
      PrefetchHooks Function()
    >;
typedef $$VentasTableCreateCompanionBuilder =
    VentasCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<int> id,
      Value<int?> clienteId,
      required String tipoComprador,
      Value<int> subtotal,
      Value<int> total,
      Value<String> estadoPago,
      Value<int> montoPagado,
      Value<int?> costoTotal,
      Value<String?> nota,
      Value<int?> usuarioId,
      Value<DateTime> fecha,
    });
typedef $$VentasTableUpdateCompanionBuilder =
    VentasCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<int> id,
      Value<int?> clienteId,
      Value<String> tipoComprador,
      Value<int> subtotal,
      Value<int> total,
      Value<String> estadoPago,
      Value<int> montoPagado,
      Value<int?> costoTotal,
      Value<String?> nota,
      Value<int?> usuarioId,
      Value<DateTime> fecha,
    });

class $$VentasTableFilterComposer
    extends Composer<_$AppDatabase, $VentasTable> {
  $$VentasTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get clienteId => $composableBuilder(
    column: $table.clienteId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tipoComprador => $composableBuilder(
    column: $table.tipoComprador,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get subtotal => $composableBuilder(
    column: $table.subtotal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get total => $composableBuilder(
    column: $table.total,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get estadoPago => $composableBuilder(
    column: $table.estadoPago,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get montoPagado => $composableBuilder(
    column: $table.montoPagado,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get costoTotal => $composableBuilder(
    column: $table.costoTotal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nota => $composableBuilder(
    column: $table.nota,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get usuarioId => $composableBuilder(
    column: $table.usuarioId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get fecha => $composableBuilder(
    column: $table.fecha,
    builder: (column) => ColumnFilters(column),
  );
}

class $$VentasTableOrderingComposer
    extends Composer<_$AppDatabase, $VentasTable> {
  $$VentasTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get clienteId => $composableBuilder(
    column: $table.clienteId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tipoComprador => $composableBuilder(
    column: $table.tipoComprador,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get subtotal => $composableBuilder(
    column: $table.subtotal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get total => $composableBuilder(
    column: $table.total,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get estadoPago => $composableBuilder(
    column: $table.estadoPago,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get montoPagado => $composableBuilder(
    column: $table.montoPagado,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get costoTotal => $composableBuilder(
    column: $table.costoTotal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nota => $composableBuilder(
    column: $table.nota,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get usuarioId => $composableBuilder(
    column: $table.usuarioId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get fecha => $composableBuilder(
    column: $table.fecha,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$VentasTableAnnotationComposer
    extends Composer<_$AppDatabase, $VentasTable> {
  $$VentasTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get clienteId =>
      $composableBuilder(column: $table.clienteId, builder: (column) => column);

  GeneratedColumn<String> get tipoComprador => $composableBuilder(
    column: $table.tipoComprador,
    builder: (column) => column,
  );

  GeneratedColumn<int> get subtotal =>
      $composableBuilder(column: $table.subtotal, builder: (column) => column);

  GeneratedColumn<int> get total =>
      $composableBuilder(column: $table.total, builder: (column) => column);

  GeneratedColumn<String> get estadoPago => $composableBuilder(
    column: $table.estadoPago,
    builder: (column) => column,
  );

  GeneratedColumn<int> get montoPagado => $composableBuilder(
    column: $table.montoPagado,
    builder: (column) => column,
  );

  GeneratedColumn<int> get costoTotal => $composableBuilder(
    column: $table.costoTotal,
    builder: (column) => column,
  );

  GeneratedColumn<String> get nota =>
      $composableBuilder(column: $table.nota, builder: (column) => column);

  GeneratedColumn<int> get usuarioId =>
      $composableBuilder(column: $table.usuarioId, builder: (column) => column);

  GeneratedColumn<DateTime> get fecha =>
      $composableBuilder(column: $table.fecha, builder: (column) => column);
}

class $$VentasTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $VentasTable,
          Venta,
          $$VentasTableFilterComposer,
          $$VentasTableOrderingComposer,
          $$VentasTableAnnotationComposer,
          $$VentasTableCreateCompanionBuilder,
          $$VentasTableUpdateCompanionBuilder,
          (Venta, BaseReferences<_$AppDatabase, $VentasTable, Venta>),
          Venta,
          PrefetchHooks Function()
        > {
  $$VentasTableTableManager(_$AppDatabase db, $VentasTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VentasTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VentasTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$VentasTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> id = const Value.absent(),
                Value<int?> clienteId = const Value.absent(),
                Value<String> tipoComprador = const Value.absent(),
                Value<int> subtotal = const Value.absent(),
                Value<int> total = const Value.absent(),
                Value<String> estadoPago = const Value.absent(),
                Value<int> montoPagado = const Value.absent(),
                Value<int?> costoTotal = const Value.absent(),
                Value<String?> nota = const Value.absent(),
                Value<int?> usuarioId = const Value.absent(),
                Value<DateTime> fecha = const Value.absent(),
              }) => VentasCompanion(
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                id: id,
                clienteId: clienteId,
                tipoComprador: tipoComprador,
                subtotal: subtotal,
                total: total,
                estadoPago: estadoPago,
                montoPagado: montoPagado,
                costoTotal: costoTotal,
                nota: nota,
                usuarioId: usuarioId,
                fecha: fecha,
              ),
          createCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> id = const Value.absent(),
                Value<int?> clienteId = const Value.absent(),
                required String tipoComprador,
                Value<int> subtotal = const Value.absent(),
                Value<int> total = const Value.absent(),
                Value<String> estadoPago = const Value.absent(),
                Value<int> montoPagado = const Value.absent(),
                Value<int?> costoTotal = const Value.absent(),
                Value<String?> nota = const Value.absent(),
                Value<int?> usuarioId = const Value.absent(),
                Value<DateTime> fecha = const Value.absent(),
              }) => VentasCompanion.insert(
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                id: id,
                clienteId: clienteId,
                tipoComprador: tipoComprador,
                subtotal: subtotal,
                total: total,
                estadoPago: estadoPago,
                montoPagado: montoPagado,
                costoTotal: costoTotal,
                nota: nota,
                usuarioId: usuarioId,
                fecha: fecha,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$VentasTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $VentasTable,
      Venta,
      $$VentasTableFilterComposer,
      $$VentasTableOrderingComposer,
      $$VentasTableAnnotationComposer,
      $$VentasTableCreateCompanionBuilder,
      $$VentasTableUpdateCompanionBuilder,
      (Venta, BaseReferences<_$AppDatabase, $VentasTable, Venta>),
      Venta,
      PrefetchHooks Function()
    >;
typedef $$DetalleVentasTableCreateCompanionBuilder =
    DetalleVentasCompanion Function({
      Value<int> id,
      required int ventaId,
      required int productoId,
      required String nombreProducto,
      required double cantidad,
      required int precioUnitario,
      required String precioTipo,
      Value<int?> costoUnitario,
      required int subtotalLinea,
    });
typedef $$DetalleVentasTableUpdateCompanionBuilder =
    DetalleVentasCompanion Function({
      Value<int> id,
      Value<int> ventaId,
      Value<int> productoId,
      Value<String> nombreProducto,
      Value<double> cantidad,
      Value<int> precioUnitario,
      Value<String> precioTipo,
      Value<int?> costoUnitario,
      Value<int> subtotalLinea,
    });

class $$DetalleVentasTableFilterComposer
    extends Composer<_$AppDatabase, $DetalleVentasTable> {
  $$DetalleVentasTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get ventaId => $composableBuilder(
    column: $table.ventaId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get productoId => $composableBuilder(
    column: $table.productoId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nombreProducto => $composableBuilder(
    column: $table.nombreProducto,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get cantidad => $composableBuilder(
    column: $table.cantidad,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get precioUnitario => $composableBuilder(
    column: $table.precioUnitario,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get precioTipo => $composableBuilder(
    column: $table.precioTipo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get costoUnitario => $composableBuilder(
    column: $table.costoUnitario,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get subtotalLinea => $composableBuilder(
    column: $table.subtotalLinea,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DetalleVentasTableOrderingComposer
    extends Composer<_$AppDatabase, $DetalleVentasTable> {
  $$DetalleVentasTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get ventaId => $composableBuilder(
    column: $table.ventaId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get productoId => $composableBuilder(
    column: $table.productoId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nombreProducto => $composableBuilder(
    column: $table.nombreProducto,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get cantidad => $composableBuilder(
    column: $table.cantidad,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get precioUnitario => $composableBuilder(
    column: $table.precioUnitario,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get precioTipo => $composableBuilder(
    column: $table.precioTipo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get costoUnitario => $composableBuilder(
    column: $table.costoUnitario,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get subtotalLinea => $composableBuilder(
    column: $table.subtotalLinea,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DetalleVentasTableAnnotationComposer
    extends Composer<_$AppDatabase, $DetalleVentasTable> {
  $$DetalleVentasTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get ventaId =>
      $composableBuilder(column: $table.ventaId, builder: (column) => column);

  GeneratedColumn<int> get productoId => $composableBuilder(
    column: $table.productoId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get nombreProducto => $composableBuilder(
    column: $table.nombreProducto,
    builder: (column) => column,
  );

  GeneratedColumn<double> get cantidad =>
      $composableBuilder(column: $table.cantidad, builder: (column) => column);

  GeneratedColumn<int> get precioUnitario => $composableBuilder(
    column: $table.precioUnitario,
    builder: (column) => column,
  );

  GeneratedColumn<String> get precioTipo => $composableBuilder(
    column: $table.precioTipo,
    builder: (column) => column,
  );

  GeneratedColumn<int> get costoUnitario => $composableBuilder(
    column: $table.costoUnitario,
    builder: (column) => column,
  );

  GeneratedColumn<int> get subtotalLinea => $composableBuilder(
    column: $table.subtotalLinea,
    builder: (column) => column,
  );
}

class $$DetalleVentasTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DetalleVentasTable,
          DetalleVenta,
          $$DetalleVentasTableFilterComposer,
          $$DetalleVentasTableOrderingComposer,
          $$DetalleVentasTableAnnotationComposer,
          $$DetalleVentasTableCreateCompanionBuilder,
          $$DetalleVentasTableUpdateCompanionBuilder,
          (
            DetalleVenta,
            BaseReferences<_$AppDatabase, $DetalleVentasTable, DetalleVenta>,
          ),
          DetalleVenta,
          PrefetchHooks Function()
        > {
  $$DetalleVentasTableTableManager(_$AppDatabase db, $DetalleVentasTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DetalleVentasTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DetalleVentasTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DetalleVentasTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> ventaId = const Value.absent(),
                Value<int> productoId = const Value.absent(),
                Value<String> nombreProducto = const Value.absent(),
                Value<double> cantidad = const Value.absent(),
                Value<int> precioUnitario = const Value.absent(),
                Value<String> precioTipo = const Value.absent(),
                Value<int?> costoUnitario = const Value.absent(),
                Value<int> subtotalLinea = const Value.absent(),
              }) => DetalleVentasCompanion(
                id: id,
                ventaId: ventaId,
                productoId: productoId,
                nombreProducto: nombreProducto,
                cantidad: cantidad,
                precioUnitario: precioUnitario,
                precioTipo: precioTipo,
                costoUnitario: costoUnitario,
                subtotalLinea: subtotalLinea,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int ventaId,
                required int productoId,
                required String nombreProducto,
                required double cantidad,
                required int precioUnitario,
                required String precioTipo,
                Value<int?> costoUnitario = const Value.absent(),
                required int subtotalLinea,
              }) => DetalleVentasCompanion.insert(
                id: id,
                ventaId: ventaId,
                productoId: productoId,
                nombreProducto: nombreProducto,
                cantidad: cantidad,
                precioUnitario: precioUnitario,
                precioTipo: precioTipo,
                costoUnitario: costoUnitario,
                subtotalLinea: subtotalLinea,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DetalleVentasTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DetalleVentasTable,
      DetalleVenta,
      $$DetalleVentasTableFilterComposer,
      $$DetalleVentasTableOrderingComposer,
      $$DetalleVentasTableAnnotationComposer,
      $$DetalleVentasTableCreateCompanionBuilder,
      $$DetalleVentasTableUpdateCompanionBuilder,
      (
        DetalleVenta,
        BaseReferences<_$AppDatabase, $DetalleVentasTable, DetalleVenta>,
      ),
      DetalleVenta,
      PrefetchHooks Function()
    >;
typedef $$MovimientosInventarioTableCreateCompanionBuilder =
    MovimientosInventarioCompanion Function({
      Value<int> id,
      required int productoId,
      required String tipo,
      required double cantidad,
      Value<int?> referenciaId,
      Value<String?> nota,
      Value<DateTime> createdAt,
    });
typedef $$MovimientosInventarioTableUpdateCompanionBuilder =
    MovimientosInventarioCompanion Function({
      Value<int> id,
      Value<int> productoId,
      Value<String> tipo,
      Value<double> cantidad,
      Value<int?> referenciaId,
      Value<String?> nota,
      Value<DateTime> createdAt,
    });

class $$MovimientosInventarioTableFilterComposer
    extends Composer<_$AppDatabase, $MovimientosInventarioTable> {
  $$MovimientosInventarioTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get productoId => $composableBuilder(
    column: $table.productoId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tipo => $composableBuilder(
    column: $table.tipo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get cantidad => $composableBuilder(
    column: $table.cantidad,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get referenciaId => $composableBuilder(
    column: $table.referenciaId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nota => $composableBuilder(
    column: $table.nota,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MovimientosInventarioTableOrderingComposer
    extends Composer<_$AppDatabase, $MovimientosInventarioTable> {
  $$MovimientosInventarioTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get productoId => $composableBuilder(
    column: $table.productoId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tipo => $composableBuilder(
    column: $table.tipo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get cantidad => $composableBuilder(
    column: $table.cantidad,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get referenciaId => $composableBuilder(
    column: $table.referenciaId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nota => $composableBuilder(
    column: $table.nota,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MovimientosInventarioTableAnnotationComposer
    extends Composer<_$AppDatabase, $MovimientosInventarioTable> {
  $$MovimientosInventarioTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get productoId => $composableBuilder(
    column: $table.productoId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get tipo =>
      $composableBuilder(column: $table.tipo, builder: (column) => column);

  GeneratedColumn<double> get cantidad =>
      $composableBuilder(column: $table.cantidad, builder: (column) => column);

  GeneratedColumn<int> get referenciaId => $composableBuilder(
    column: $table.referenciaId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get nota =>
      $composableBuilder(column: $table.nota, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$MovimientosInventarioTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MovimientosInventarioTable,
          MovimientosInventarioData,
          $$MovimientosInventarioTableFilterComposer,
          $$MovimientosInventarioTableOrderingComposer,
          $$MovimientosInventarioTableAnnotationComposer,
          $$MovimientosInventarioTableCreateCompanionBuilder,
          $$MovimientosInventarioTableUpdateCompanionBuilder,
          (
            MovimientosInventarioData,
            BaseReferences<
              _$AppDatabase,
              $MovimientosInventarioTable,
              MovimientosInventarioData
            >,
          ),
          MovimientosInventarioData,
          PrefetchHooks Function()
        > {
  $$MovimientosInventarioTableTableManager(
    _$AppDatabase db,
    $MovimientosInventarioTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MovimientosInventarioTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$MovimientosInventarioTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$MovimientosInventarioTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> productoId = const Value.absent(),
                Value<String> tipo = const Value.absent(),
                Value<double> cantidad = const Value.absent(),
                Value<int?> referenciaId = const Value.absent(),
                Value<String?> nota = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => MovimientosInventarioCompanion(
                id: id,
                productoId: productoId,
                tipo: tipo,
                cantidad: cantidad,
                referenciaId: referenciaId,
                nota: nota,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int productoId,
                required String tipo,
                required double cantidad,
                Value<int?> referenciaId = const Value.absent(),
                Value<String?> nota = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => MovimientosInventarioCompanion.insert(
                id: id,
                productoId: productoId,
                tipo: tipo,
                cantidad: cantidad,
                referenciaId: referenciaId,
                nota: nota,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MovimientosInventarioTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MovimientosInventarioTable,
      MovimientosInventarioData,
      $$MovimientosInventarioTableFilterComposer,
      $$MovimientosInventarioTableOrderingComposer,
      $$MovimientosInventarioTableAnnotationComposer,
      $$MovimientosInventarioTableCreateCompanionBuilder,
      $$MovimientosInventarioTableUpdateCompanionBuilder,
      (
        MovimientosInventarioData,
        BaseReferences<
          _$AppDatabase,
          $MovimientosInventarioTable,
          MovimientosInventarioData
        >,
      ),
      MovimientosInventarioData,
      PrefetchHooks Function()
    >;
typedef $$GastosTableCreateCompanionBuilder =
    GastosCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<int> id,
      required String tipo,
      Value<String?> categoria,
      Value<String?> descripcion,
      Value<int> monto,
      Value<DateTime> fecha,
      Value<String?> periodicidad,
      Value<int?> productoId,
      Value<double?> cantidad,
      Value<String?> motivo,
    });
typedef $$GastosTableUpdateCompanionBuilder =
    GastosCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<int> id,
      Value<String> tipo,
      Value<String?> categoria,
      Value<String?> descripcion,
      Value<int> monto,
      Value<DateTime> fecha,
      Value<String?> periodicidad,
      Value<int?> productoId,
      Value<double?> cantidad,
      Value<String?> motivo,
    });

class $$GastosTableFilterComposer
    extends Composer<_$AppDatabase, $GastosTable> {
  $$GastosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tipo => $composableBuilder(
    column: $table.tipo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get categoria => $composableBuilder(
    column: $table.categoria,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get monto => $composableBuilder(
    column: $table.monto,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get fecha => $composableBuilder(
    column: $table.fecha,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get periodicidad => $composableBuilder(
    column: $table.periodicidad,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get productoId => $composableBuilder(
    column: $table.productoId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get cantidad => $composableBuilder(
    column: $table.cantidad,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get motivo => $composableBuilder(
    column: $table.motivo,
    builder: (column) => ColumnFilters(column),
  );
}

class $$GastosTableOrderingComposer
    extends Composer<_$AppDatabase, $GastosTable> {
  $$GastosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tipo => $composableBuilder(
    column: $table.tipo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get categoria => $composableBuilder(
    column: $table.categoria,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get monto => $composableBuilder(
    column: $table.monto,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get fecha => $composableBuilder(
    column: $table.fecha,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get periodicidad => $composableBuilder(
    column: $table.periodicidad,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get productoId => $composableBuilder(
    column: $table.productoId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get cantidad => $composableBuilder(
    column: $table.cantidad,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get motivo => $composableBuilder(
    column: $table.motivo,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$GastosTableAnnotationComposer
    extends Composer<_$AppDatabase, $GastosTable> {
  $$GastosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get tipo =>
      $composableBuilder(column: $table.tipo, builder: (column) => column);

  GeneratedColumn<String> get categoria =>
      $composableBuilder(column: $table.categoria, builder: (column) => column);

  GeneratedColumn<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => column,
  );

  GeneratedColumn<int> get monto =>
      $composableBuilder(column: $table.monto, builder: (column) => column);

  GeneratedColumn<DateTime> get fecha =>
      $composableBuilder(column: $table.fecha, builder: (column) => column);

  GeneratedColumn<String> get periodicidad => $composableBuilder(
    column: $table.periodicidad,
    builder: (column) => column,
  );

  GeneratedColumn<int> get productoId => $composableBuilder(
    column: $table.productoId,
    builder: (column) => column,
  );

  GeneratedColumn<double> get cantidad =>
      $composableBuilder(column: $table.cantidad, builder: (column) => column);

  GeneratedColumn<String> get motivo =>
      $composableBuilder(column: $table.motivo, builder: (column) => column);
}

class $$GastosTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $GastosTable,
          Gasto,
          $$GastosTableFilterComposer,
          $$GastosTableOrderingComposer,
          $$GastosTableAnnotationComposer,
          $$GastosTableCreateCompanionBuilder,
          $$GastosTableUpdateCompanionBuilder,
          (Gasto, BaseReferences<_$AppDatabase, $GastosTable, Gasto>),
          Gasto,
          PrefetchHooks Function()
        > {
  $$GastosTableTableManager(_$AppDatabase db, $GastosTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GastosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GastosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GastosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> id = const Value.absent(),
                Value<String> tipo = const Value.absent(),
                Value<String?> categoria = const Value.absent(),
                Value<String?> descripcion = const Value.absent(),
                Value<int> monto = const Value.absent(),
                Value<DateTime> fecha = const Value.absent(),
                Value<String?> periodicidad = const Value.absent(),
                Value<int?> productoId = const Value.absent(),
                Value<double?> cantidad = const Value.absent(),
                Value<String?> motivo = const Value.absent(),
              }) => GastosCompanion(
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                id: id,
                tipo: tipo,
                categoria: categoria,
                descripcion: descripcion,
                monto: monto,
                fecha: fecha,
                periodicidad: periodicidad,
                productoId: productoId,
                cantidad: cantidad,
                motivo: motivo,
              ),
          createCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> id = const Value.absent(),
                required String tipo,
                Value<String?> categoria = const Value.absent(),
                Value<String?> descripcion = const Value.absent(),
                Value<int> monto = const Value.absent(),
                Value<DateTime> fecha = const Value.absent(),
                Value<String?> periodicidad = const Value.absent(),
                Value<int?> productoId = const Value.absent(),
                Value<double?> cantidad = const Value.absent(),
                Value<String?> motivo = const Value.absent(),
              }) => GastosCompanion.insert(
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                id: id,
                tipo: tipo,
                categoria: categoria,
                descripcion: descripcion,
                monto: monto,
                fecha: fecha,
                periodicidad: periodicidad,
                productoId: productoId,
                cantidad: cantidad,
                motivo: motivo,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$GastosTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $GastosTable,
      Gasto,
      $$GastosTableFilterComposer,
      $$GastosTableOrderingComposer,
      $$GastosTableAnnotationComposer,
      $$GastosTableCreateCompanionBuilder,
      $$GastosTableUpdateCompanionBuilder,
      (Gasto, BaseReferences<_$AppDatabase, $GastosTable, Gasto>),
      Gasto,
      PrefetchHooks Function()
    >;
typedef $$DeudasTableCreateCompanionBuilder =
    DeudasCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<int> id,
      required String direccion,
      Value<int?> clienteId,
      Value<String?> proveedor,
      Value<int?> origenVentaId,
      required int montoOriginal,
      Value<String> estado,
      Value<String?> descripcion,
      Value<DateTime> fecha,
    });
typedef $$DeudasTableUpdateCompanionBuilder =
    DeudasCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<int> id,
      Value<String> direccion,
      Value<int?> clienteId,
      Value<String?> proveedor,
      Value<int?> origenVentaId,
      Value<int> montoOriginal,
      Value<String> estado,
      Value<String?> descripcion,
      Value<DateTime> fecha,
    });

class $$DeudasTableFilterComposer
    extends Composer<_$AppDatabase, $DeudasTable> {
  $$DeudasTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get direccion => $composableBuilder(
    column: $table.direccion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get clienteId => $composableBuilder(
    column: $table.clienteId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get proveedor => $composableBuilder(
    column: $table.proveedor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get origenVentaId => $composableBuilder(
    column: $table.origenVentaId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get montoOriginal => $composableBuilder(
    column: $table.montoOriginal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get estado => $composableBuilder(
    column: $table.estado,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get fecha => $composableBuilder(
    column: $table.fecha,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DeudasTableOrderingComposer
    extends Composer<_$AppDatabase, $DeudasTable> {
  $$DeudasTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get direccion => $composableBuilder(
    column: $table.direccion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get clienteId => $composableBuilder(
    column: $table.clienteId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get proveedor => $composableBuilder(
    column: $table.proveedor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get origenVentaId => $composableBuilder(
    column: $table.origenVentaId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get montoOriginal => $composableBuilder(
    column: $table.montoOriginal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get estado => $composableBuilder(
    column: $table.estado,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get fecha => $composableBuilder(
    column: $table.fecha,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DeudasTableAnnotationComposer
    extends Composer<_$AppDatabase, $DeudasTable> {
  $$DeudasTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get direccion =>
      $composableBuilder(column: $table.direccion, builder: (column) => column);

  GeneratedColumn<int> get clienteId =>
      $composableBuilder(column: $table.clienteId, builder: (column) => column);

  GeneratedColumn<String> get proveedor =>
      $composableBuilder(column: $table.proveedor, builder: (column) => column);

  GeneratedColumn<int> get origenVentaId => $composableBuilder(
    column: $table.origenVentaId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get montoOriginal => $composableBuilder(
    column: $table.montoOriginal,
    builder: (column) => column,
  );

  GeneratedColumn<String> get estado =>
      $composableBuilder(column: $table.estado, builder: (column) => column);

  GeneratedColumn<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get fecha =>
      $composableBuilder(column: $table.fecha, builder: (column) => column);
}

class $$DeudasTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DeudasTable,
          Deuda,
          $$DeudasTableFilterComposer,
          $$DeudasTableOrderingComposer,
          $$DeudasTableAnnotationComposer,
          $$DeudasTableCreateCompanionBuilder,
          $$DeudasTableUpdateCompanionBuilder,
          (Deuda, BaseReferences<_$AppDatabase, $DeudasTable, Deuda>),
          Deuda,
          PrefetchHooks Function()
        > {
  $$DeudasTableTableManager(_$AppDatabase db, $DeudasTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DeudasTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DeudasTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DeudasTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> id = const Value.absent(),
                Value<String> direccion = const Value.absent(),
                Value<int?> clienteId = const Value.absent(),
                Value<String?> proveedor = const Value.absent(),
                Value<int?> origenVentaId = const Value.absent(),
                Value<int> montoOriginal = const Value.absent(),
                Value<String> estado = const Value.absent(),
                Value<String?> descripcion = const Value.absent(),
                Value<DateTime> fecha = const Value.absent(),
              }) => DeudasCompanion(
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                id: id,
                direccion: direccion,
                clienteId: clienteId,
                proveedor: proveedor,
                origenVentaId: origenVentaId,
                montoOriginal: montoOriginal,
                estado: estado,
                descripcion: descripcion,
                fecha: fecha,
              ),
          createCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> id = const Value.absent(),
                required String direccion,
                Value<int?> clienteId = const Value.absent(),
                Value<String?> proveedor = const Value.absent(),
                Value<int?> origenVentaId = const Value.absent(),
                required int montoOriginal,
                Value<String> estado = const Value.absent(),
                Value<String?> descripcion = const Value.absent(),
                Value<DateTime> fecha = const Value.absent(),
              }) => DeudasCompanion.insert(
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                id: id,
                direccion: direccion,
                clienteId: clienteId,
                proveedor: proveedor,
                origenVentaId: origenVentaId,
                montoOriginal: montoOriginal,
                estado: estado,
                descripcion: descripcion,
                fecha: fecha,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DeudasTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DeudasTable,
      Deuda,
      $$DeudasTableFilterComposer,
      $$DeudasTableOrderingComposer,
      $$DeudasTableAnnotationComposer,
      $$DeudasTableCreateCompanionBuilder,
      $$DeudasTableUpdateCompanionBuilder,
      (Deuda, BaseReferences<_$AppDatabase, $DeudasTable, Deuda>),
      Deuda,
      PrefetchHooks Function()
    >;
typedef $$PagosDeudaTableCreateCompanionBuilder =
    PagosDeudaCompanion Function({
      Value<int> id,
      required int deudaId,
      required int monto,
      Value<String?> nota,
      Value<int?> usuarioId,
      Value<DateTime> fecha,
      Value<DateTime> createdAt,
    });
typedef $$PagosDeudaTableUpdateCompanionBuilder =
    PagosDeudaCompanion Function({
      Value<int> id,
      Value<int> deudaId,
      Value<int> monto,
      Value<String?> nota,
      Value<int?> usuarioId,
      Value<DateTime> fecha,
      Value<DateTime> createdAt,
    });

class $$PagosDeudaTableFilterComposer
    extends Composer<_$AppDatabase, $PagosDeudaTable> {
  $$PagosDeudaTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get deudaId => $composableBuilder(
    column: $table.deudaId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get monto => $composableBuilder(
    column: $table.monto,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nota => $composableBuilder(
    column: $table.nota,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get usuarioId => $composableBuilder(
    column: $table.usuarioId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get fecha => $composableBuilder(
    column: $table.fecha,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PagosDeudaTableOrderingComposer
    extends Composer<_$AppDatabase, $PagosDeudaTable> {
  $$PagosDeudaTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get deudaId => $composableBuilder(
    column: $table.deudaId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get monto => $composableBuilder(
    column: $table.monto,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nota => $composableBuilder(
    column: $table.nota,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get usuarioId => $composableBuilder(
    column: $table.usuarioId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get fecha => $composableBuilder(
    column: $table.fecha,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PagosDeudaTableAnnotationComposer
    extends Composer<_$AppDatabase, $PagosDeudaTable> {
  $$PagosDeudaTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get deudaId =>
      $composableBuilder(column: $table.deudaId, builder: (column) => column);

  GeneratedColumn<int> get monto =>
      $composableBuilder(column: $table.monto, builder: (column) => column);

  GeneratedColumn<String> get nota =>
      $composableBuilder(column: $table.nota, builder: (column) => column);

  GeneratedColumn<int> get usuarioId =>
      $composableBuilder(column: $table.usuarioId, builder: (column) => column);

  GeneratedColumn<DateTime> get fecha =>
      $composableBuilder(column: $table.fecha, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$PagosDeudaTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PagosDeudaTable,
          PagosDeudaData,
          $$PagosDeudaTableFilterComposer,
          $$PagosDeudaTableOrderingComposer,
          $$PagosDeudaTableAnnotationComposer,
          $$PagosDeudaTableCreateCompanionBuilder,
          $$PagosDeudaTableUpdateCompanionBuilder,
          (
            PagosDeudaData,
            BaseReferences<_$AppDatabase, $PagosDeudaTable, PagosDeudaData>,
          ),
          PagosDeudaData,
          PrefetchHooks Function()
        > {
  $$PagosDeudaTableTableManager(_$AppDatabase db, $PagosDeudaTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PagosDeudaTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PagosDeudaTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PagosDeudaTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> deudaId = const Value.absent(),
                Value<int> monto = const Value.absent(),
                Value<String?> nota = const Value.absent(),
                Value<int?> usuarioId = const Value.absent(),
                Value<DateTime> fecha = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => PagosDeudaCompanion(
                id: id,
                deudaId: deudaId,
                monto: monto,
                nota: nota,
                usuarioId: usuarioId,
                fecha: fecha,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int deudaId,
                required int monto,
                Value<String?> nota = const Value.absent(),
                Value<int?> usuarioId = const Value.absent(),
                Value<DateTime> fecha = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => PagosDeudaCompanion.insert(
                id: id,
                deudaId: deudaId,
                monto: monto,
                nota: nota,
                usuarioId: usuarioId,
                fecha: fecha,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PagosDeudaTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PagosDeudaTable,
      PagosDeudaData,
      $$PagosDeudaTableFilterComposer,
      $$PagosDeudaTableOrderingComposer,
      $$PagosDeudaTableAnnotationComposer,
      $$PagosDeudaTableCreateCompanionBuilder,
      $$PagosDeudaTableUpdateCompanionBuilder,
      (
        PagosDeudaData,
        BaseReferences<_$AppDatabase, $PagosDeudaTable, PagosDeudaData>,
      ),
      PagosDeudaData,
      PrefetchHooks Function()
    >;
typedef $$UsuariosTableCreateCompanionBuilder =
    UsuariosCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<int> id,
      required String nombre,
      Value<String?> pinHash,
      Value<String> rol,
      Value<bool> biometriaHabilitada,
    });
typedef $$UsuariosTableUpdateCompanionBuilder =
    UsuariosCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<int> id,
      Value<String> nombre,
      Value<String?> pinHash,
      Value<String> rol,
      Value<bool> biometriaHabilitada,
    });

class $$UsuariosTableFilterComposer
    extends Composer<_$AppDatabase, $UsuariosTable> {
  $$UsuariosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get pinHash => $composableBuilder(
    column: $table.pinHash,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get rol => $composableBuilder(
    column: $table.rol,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get biometriaHabilitada => $composableBuilder(
    column: $table.biometriaHabilitada,
    builder: (column) => ColumnFilters(column),
  );
}

class $$UsuariosTableOrderingComposer
    extends Composer<_$AppDatabase, $UsuariosTable> {
  $$UsuariosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pinHash => $composableBuilder(
    column: $table.pinHash,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get rol => $composableBuilder(
    column: $table.rol,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get biometriaHabilitada => $composableBuilder(
    column: $table.biometriaHabilitada,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UsuariosTableAnnotationComposer
    extends Composer<_$AppDatabase, $UsuariosTable> {
  $$UsuariosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nombre =>
      $composableBuilder(column: $table.nombre, builder: (column) => column);

  GeneratedColumn<String> get pinHash =>
      $composableBuilder(column: $table.pinHash, builder: (column) => column);

  GeneratedColumn<String> get rol =>
      $composableBuilder(column: $table.rol, builder: (column) => column);

  GeneratedColumn<bool> get biometriaHabilitada => $composableBuilder(
    column: $table.biometriaHabilitada,
    builder: (column) => column,
  );
}

class $$UsuariosTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UsuariosTable,
          Usuario,
          $$UsuariosTableFilterComposer,
          $$UsuariosTableOrderingComposer,
          $$UsuariosTableAnnotationComposer,
          $$UsuariosTableCreateCompanionBuilder,
          $$UsuariosTableUpdateCompanionBuilder,
          (Usuario, BaseReferences<_$AppDatabase, $UsuariosTable, Usuario>),
          Usuario,
          PrefetchHooks Function()
        > {
  $$UsuariosTableTableManager(_$AppDatabase db, $UsuariosTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UsuariosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UsuariosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UsuariosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> id = const Value.absent(),
                Value<String> nombre = const Value.absent(),
                Value<String?> pinHash = const Value.absent(),
                Value<String> rol = const Value.absent(),
                Value<bool> biometriaHabilitada = const Value.absent(),
              }) => UsuariosCompanion(
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                id: id,
                nombre: nombre,
                pinHash: pinHash,
                rol: rol,
                biometriaHabilitada: biometriaHabilitada,
              ),
          createCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> id = const Value.absent(),
                required String nombre,
                Value<String?> pinHash = const Value.absent(),
                Value<String> rol = const Value.absent(),
                Value<bool> biometriaHabilitada = const Value.absent(),
              }) => UsuariosCompanion.insert(
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                id: id,
                nombre: nombre,
                pinHash: pinHash,
                rol: rol,
                biometriaHabilitada: biometriaHabilitada,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$UsuariosTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UsuariosTable,
      Usuario,
      $$UsuariosTableFilterComposer,
      $$UsuariosTableOrderingComposer,
      $$UsuariosTableAnnotationComposer,
      $$UsuariosTableCreateCompanionBuilder,
      $$UsuariosTableUpdateCompanionBuilder,
      (Usuario, BaseReferences<_$AppDatabase, $UsuariosTable, Usuario>),
      Usuario,
      PrefetchHooks Function()
    >;
typedef $$AuditoriasTableCreateCompanionBuilder =
    AuditoriasCompanion Function({
      Value<int> id,
      required String entidad,
      Value<int?> entidadId,
      required String accion,
      Value<String?> campo,
      Value<String?> valorAnterior,
      Value<String?> valorNuevo,
      Value<int?> usuarioId,
      Value<DateTime> createdAt,
    });
typedef $$AuditoriasTableUpdateCompanionBuilder =
    AuditoriasCompanion Function({
      Value<int> id,
      Value<String> entidad,
      Value<int?> entidadId,
      Value<String> accion,
      Value<String?> campo,
      Value<String?> valorAnterior,
      Value<String?> valorNuevo,
      Value<int?> usuarioId,
      Value<DateTime> createdAt,
    });

class $$AuditoriasTableFilterComposer
    extends Composer<_$AppDatabase, $AuditoriasTable> {
  $$AuditoriasTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get entidad => $composableBuilder(
    column: $table.entidad,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get entidadId => $composableBuilder(
    column: $table.entidadId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get accion => $composableBuilder(
    column: $table.accion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get campo => $composableBuilder(
    column: $table.campo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get valorAnterior => $composableBuilder(
    column: $table.valorAnterior,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get valorNuevo => $composableBuilder(
    column: $table.valorNuevo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get usuarioId => $composableBuilder(
    column: $table.usuarioId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AuditoriasTableOrderingComposer
    extends Composer<_$AppDatabase, $AuditoriasTable> {
  $$AuditoriasTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get entidad => $composableBuilder(
    column: $table.entidad,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get entidadId => $composableBuilder(
    column: $table.entidadId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get accion => $composableBuilder(
    column: $table.accion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get campo => $composableBuilder(
    column: $table.campo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get valorAnterior => $composableBuilder(
    column: $table.valorAnterior,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get valorNuevo => $composableBuilder(
    column: $table.valorNuevo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get usuarioId => $composableBuilder(
    column: $table.usuarioId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AuditoriasTableAnnotationComposer
    extends Composer<_$AppDatabase, $AuditoriasTable> {
  $$AuditoriasTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get entidad =>
      $composableBuilder(column: $table.entidad, builder: (column) => column);

  GeneratedColumn<int> get entidadId =>
      $composableBuilder(column: $table.entidadId, builder: (column) => column);

  GeneratedColumn<String> get accion =>
      $composableBuilder(column: $table.accion, builder: (column) => column);

  GeneratedColumn<String> get campo =>
      $composableBuilder(column: $table.campo, builder: (column) => column);

  GeneratedColumn<String> get valorAnterior => $composableBuilder(
    column: $table.valorAnterior,
    builder: (column) => column,
  );

  GeneratedColumn<String> get valorNuevo => $composableBuilder(
    column: $table.valorNuevo,
    builder: (column) => column,
  );

  GeneratedColumn<int> get usuarioId =>
      $composableBuilder(column: $table.usuarioId, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$AuditoriasTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AuditoriasTable,
          Auditoria,
          $$AuditoriasTableFilterComposer,
          $$AuditoriasTableOrderingComposer,
          $$AuditoriasTableAnnotationComposer,
          $$AuditoriasTableCreateCompanionBuilder,
          $$AuditoriasTableUpdateCompanionBuilder,
          (
            Auditoria,
            BaseReferences<_$AppDatabase, $AuditoriasTable, Auditoria>,
          ),
          Auditoria,
          PrefetchHooks Function()
        > {
  $$AuditoriasTableTableManager(_$AppDatabase db, $AuditoriasTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AuditoriasTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AuditoriasTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AuditoriasTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> entidad = const Value.absent(),
                Value<int?> entidadId = const Value.absent(),
                Value<String> accion = const Value.absent(),
                Value<String?> campo = const Value.absent(),
                Value<String?> valorAnterior = const Value.absent(),
                Value<String?> valorNuevo = const Value.absent(),
                Value<int?> usuarioId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => AuditoriasCompanion(
                id: id,
                entidad: entidad,
                entidadId: entidadId,
                accion: accion,
                campo: campo,
                valorAnterior: valorAnterior,
                valorNuevo: valorNuevo,
                usuarioId: usuarioId,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String entidad,
                Value<int?> entidadId = const Value.absent(),
                required String accion,
                Value<String?> campo = const Value.absent(),
                Value<String?> valorAnterior = const Value.absent(),
                Value<String?> valorNuevo = const Value.absent(),
                Value<int?> usuarioId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => AuditoriasCompanion.insert(
                id: id,
                entidad: entidad,
                entidadId: entidadId,
                accion: accion,
                campo: campo,
                valorAnterior: valorAnterior,
                valorNuevo: valorNuevo,
                usuarioId: usuarioId,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AuditoriasTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AuditoriasTable,
      Auditoria,
      $$AuditoriasTableFilterComposer,
      $$AuditoriasTableOrderingComposer,
      $$AuditoriasTableAnnotationComposer,
      $$AuditoriasTableCreateCompanionBuilder,
      $$AuditoriasTableUpdateCompanionBuilder,
      (Auditoria, BaseReferences<_$AppDatabase, $AuditoriasTable, Auditoria>),
      Auditoria,
      PrefetchHooks Function()
    >;
typedef $$PreferenciasVisualizacionTableCreateCompanionBuilder =
    PreferenciasVisualizacionCompanion Function({
      required String widgetKey,
      required String tipoVista,
      Value<int?> usuarioId,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });
typedef $$PreferenciasVisualizacionTableUpdateCompanionBuilder =
    PreferenciasVisualizacionCompanion Function({
      Value<String> widgetKey,
      Value<String> tipoVista,
      Value<int?> usuarioId,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$PreferenciasVisualizacionTableFilterComposer
    extends Composer<_$AppDatabase, $PreferenciasVisualizacionTable> {
  $$PreferenciasVisualizacionTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get widgetKey => $composableBuilder(
    column: $table.widgetKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tipoVista => $composableBuilder(
    column: $table.tipoVista,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get usuarioId => $composableBuilder(
    column: $table.usuarioId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PreferenciasVisualizacionTableOrderingComposer
    extends Composer<_$AppDatabase, $PreferenciasVisualizacionTable> {
  $$PreferenciasVisualizacionTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get widgetKey => $composableBuilder(
    column: $table.widgetKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tipoVista => $composableBuilder(
    column: $table.tipoVista,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get usuarioId => $composableBuilder(
    column: $table.usuarioId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PreferenciasVisualizacionTableAnnotationComposer
    extends Composer<_$AppDatabase, $PreferenciasVisualizacionTable> {
  $$PreferenciasVisualizacionTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get widgetKey =>
      $composableBuilder(column: $table.widgetKey, builder: (column) => column);

  GeneratedColumn<String> get tipoVista =>
      $composableBuilder(column: $table.tipoVista, builder: (column) => column);

  GeneratedColumn<int> get usuarioId =>
      $composableBuilder(column: $table.usuarioId, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$PreferenciasVisualizacionTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PreferenciasVisualizacionTable,
          PreferenciasVisualizacionData,
          $$PreferenciasVisualizacionTableFilterComposer,
          $$PreferenciasVisualizacionTableOrderingComposer,
          $$PreferenciasVisualizacionTableAnnotationComposer,
          $$PreferenciasVisualizacionTableCreateCompanionBuilder,
          $$PreferenciasVisualizacionTableUpdateCompanionBuilder,
          (
            PreferenciasVisualizacionData,
            BaseReferences<
              _$AppDatabase,
              $PreferenciasVisualizacionTable,
              PreferenciasVisualizacionData
            >,
          ),
          PreferenciasVisualizacionData,
          PrefetchHooks Function()
        > {
  $$PreferenciasVisualizacionTableTableManager(
    _$AppDatabase db,
    $PreferenciasVisualizacionTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PreferenciasVisualizacionTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$PreferenciasVisualizacionTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$PreferenciasVisualizacionTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> widgetKey = const Value.absent(),
                Value<String> tipoVista = const Value.absent(),
                Value<int?> usuarioId = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PreferenciasVisualizacionCompanion(
                widgetKey: widgetKey,
                tipoVista: tipoVista,
                usuarioId: usuarioId,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String widgetKey,
                required String tipoVista,
                Value<int?> usuarioId = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PreferenciasVisualizacionCompanion.insert(
                widgetKey: widgetKey,
                tipoVista: tipoVista,
                usuarioId: usuarioId,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PreferenciasVisualizacionTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PreferenciasVisualizacionTable,
      PreferenciasVisualizacionData,
      $$PreferenciasVisualizacionTableFilterComposer,
      $$PreferenciasVisualizacionTableOrderingComposer,
      $$PreferenciasVisualizacionTableAnnotationComposer,
      $$PreferenciasVisualizacionTableCreateCompanionBuilder,
      $$PreferenciasVisualizacionTableUpdateCompanionBuilder,
      (
        PreferenciasVisualizacionData,
        BaseReferences<
          _$AppDatabase,
          $PreferenciasVisualizacionTable,
          PreferenciasVisualizacionData
        >,
      ),
      PreferenciasVisualizacionData,
      PrefetchHooks Function()
    >;
typedef $$ConfiguracionesTableCreateCompanionBuilder =
    ConfiguracionesCompanion Function({
      required String clave,
      required String valor,
      Value<int> rowid,
    });
typedef $$ConfiguracionesTableUpdateCompanionBuilder =
    ConfiguracionesCompanion Function({
      Value<String> clave,
      Value<String> valor,
      Value<int> rowid,
    });

class $$ConfiguracionesTableFilterComposer
    extends Composer<_$AppDatabase, $ConfiguracionesTable> {
  $$ConfiguracionesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get clave => $composableBuilder(
    column: $table.clave,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get valor => $composableBuilder(
    column: $table.valor,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ConfiguracionesTableOrderingComposer
    extends Composer<_$AppDatabase, $ConfiguracionesTable> {
  $$ConfiguracionesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get clave => $composableBuilder(
    column: $table.clave,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get valor => $composableBuilder(
    column: $table.valor,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ConfiguracionesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ConfiguracionesTable> {
  $$ConfiguracionesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get clave =>
      $composableBuilder(column: $table.clave, builder: (column) => column);

  GeneratedColumn<String> get valor =>
      $composableBuilder(column: $table.valor, builder: (column) => column);
}

class $$ConfiguracionesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ConfiguracionesTable,
          Configuracione,
          $$ConfiguracionesTableFilterComposer,
          $$ConfiguracionesTableOrderingComposer,
          $$ConfiguracionesTableAnnotationComposer,
          $$ConfiguracionesTableCreateCompanionBuilder,
          $$ConfiguracionesTableUpdateCompanionBuilder,
          (
            Configuracione,
            BaseReferences<
              _$AppDatabase,
              $ConfiguracionesTable,
              Configuracione
            >,
          ),
          Configuracione,
          PrefetchHooks Function()
        > {
  $$ConfiguracionesTableTableManager(
    _$AppDatabase db,
    $ConfiguracionesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ConfiguracionesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ConfiguracionesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ConfiguracionesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> clave = const Value.absent(),
                Value<String> valor = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ConfiguracionesCompanion(
                clave: clave,
                valor: valor,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String clave,
                required String valor,
                Value<int> rowid = const Value.absent(),
              }) => ConfiguracionesCompanion.insert(
                clave: clave,
                valor: valor,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ConfiguracionesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ConfiguracionesTable,
      Configuracione,
      $$ConfiguracionesTableFilterComposer,
      $$ConfiguracionesTableOrderingComposer,
      $$ConfiguracionesTableAnnotationComposer,
      $$ConfiguracionesTableCreateCompanionBuilder,
      $$ConfiguracionesTableUpdateCompanionBuilder,
      (
        Configuracione,
        BaseReferences<_$AppDatabase, $ConfiguracionesTable, Configuracione>,
      ),
      Configuracione,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$CategoriasTableTableManager get categorias =>
      $$CategoriasTableTableManager(_db, _db.categorias);
  $$ProductosTableTableManager get productos =>
      $$ProductosTableTableManager(_db, _db.productos);
  $$HistorialPreciosTableTableManager get historialPrecios =>
      $$HistorialPreciosTableTableManager(_db, _db.historialPrecios);
  $$ClientesTableTableManager get clientes =>
      $$ClientesTableTableManager(_db, _db.clientes);
  $$VentasTableTableManager get ventas =>
      $$VentasTableTableManager(_db, _db.ventas);
  $$DetalleVentasTableTableManager get detalleVentas =>
      $$DetalleVentasTableTableManager(_db, _db.detalleVentas);
  $$MovimientosInventarioTableTableManager get movimientosInventario =>
      $$MovimientosInventarioTableTableManager(_db, _db.movimientosInventario);
  $$GastosTableTableManager get gastos =>
      $$GastosTableTableManager(_db, _db.gastos);
  $$DeudasTableTableManager get deudas =>
      $$DeudasTableTableManager(_db, _db.deudas);
  $$PagosDeudaTableTableManager get pagosDeuda =>
      $$PagosDeudaTableTableManager(_db, _db.pagosDeuda);
  $$UsuariosTableTableManager get usuarios =>
      $$UsuariosTableTableManager(_db, _db.usuarios);
  $$AuditoriasTableTableManager get auditorias =>
      $$AuditoriasTableTableManager(_db, _db.auditorias);
  $$PreferenciasVisualizacionTableTableManager get preferenciasVisualizacion =>
      $$PreferenciasVisualizacionTableTableManager(
        _db,
        _db.preferenciasVisualizacion,
      );
  $$ConfiguracionesTableTableManager get configuraciones =>
      $$ConfiguracionesTableTableManager(_db, _db.configuraciones);
}
