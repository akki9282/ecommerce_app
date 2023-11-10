// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database_config.dart';

// ignore_for_file: type=lint
class $CartValuesTable extends CartValues
    with TableInfo<$CartValuesTable, CartValue> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CartValuesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _priceMeta = const VerificationMeta('price');
  @override
  late final GeneratedColumn<double> price = GeneratedColumn<double>(
      'price', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _categoryMeta =
      const VerificationMeta('category');
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
      'category', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _image_urlMeta =
      const VerificationMeta('image_url');
  @override
  late final GeneratedColumn<String> image_url = GeneratedColumn<String>(
      'image_url', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _quantityMeta =
      const VerificationMeta('quantity');
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
      'quantity', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, title, price, description, category, image_url, quantity];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cart_values';
  @override
  VerificationContext validateIntegrity(Insertable<CartValue> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('price')) {
      context.handle(
          _priceMeta, price.isAcceptableOrUnknown(data['price']!, _priceMeta));
    } else if (isInserting) {
      context.missing(_priceMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('image_url')) {
      context.handle(_image_urlMeta,
          image_url.isAcceptableOrUnknown(data['image_url']!, _image_urlMeta));
    } else if (isInserting) {
      context.missing(_image_urlMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(_quantityMeta,
          quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta));
    } else if (isInserting) {
      context.missing(_quantityMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CartValue map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CartValue(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      price: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}price'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
      category: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category'])!,
      image_url: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}image_url'])!,
      quantity: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}quantity'])!,
    );
  }

  @override
  $CartValuesTable createAlias(String alias) {
    return $CartValuesTable(attachedDatabase, alias);
  }
}

class CartValue extends DataClass implements Insertable<CartValue> {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image_url;
  final int quantity;
  const CartValue(
      {required this.id,
      required this.title,
      required this.price,
      required this.description,
      required this.category,
      required this.image_url,
      required this.quantity});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['price'] = Variable<double>(price);
    map['description'] = Variable<String>(description);
    map['category'] = Variable<String>(category);
    map['image_url'] = Variable<String>(image_url);
    map['quantity'] = Variable<int>(quantity);
    return map;
  }

  CartValuesCompanion toCompanion(bool nullToAbsent) {
    return CartValuesCompanion(
      id: Value(id),
      title: Value(title),
      price: Value(price),
      description: Value(description),
      category: Value(category),
      image_url: Value(image_url),
      quantity: Value(quantity),
    );
  }

  factory CartValue.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CartValue(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      price: serializer.fromJson<double>(json['price']),
      description: serializer.fromJson<String>(json['description']),
      category: serializer.fromJson<String>(json['category']),
      image_url: serializer.fromJson<String>(json['image_url']),
      quantity: serializer.fromJson<int>(json['quantity']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'price': serializer.toJson<double>(price),
      'description': serializer.toJson<String>(description),
      'category': serializer.toJson<String>(category),
      'image_url': serializer.toJson<String>(image_url),
      'quantity': serializer.toJson<int>(quantity),
    };
  }

  CartValue copyWith(
          {int? id,
          String? title,
          double? price,
          String? description,
          String? category,
          String? image_url,
          int? quantity}) =>
      CartValue(
        id: id ?? this.id,
        title: title ?? this.title,
        price: price ?? this.price,
        description: description ?? this.description,
        category: category ?? this.category,
        image_url: image_url ?? this.image_url,
        quantity: quantity ?? this.quantity,
      );
  @override
  String toString() {
    return (StringBuffer('CartValue(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('price: $price, ')
          ..write('description: $description, ')
          ..write('category: $category, ')
          ..write('image_url: $image_url, ')
          ..write('quantity: $quantity')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, title, price, description, category, image_url, quantity);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CartValue &&
          other.id == this.id &&
          other.title == this.title &&
          other.price == this.price &&
          other.description == this.description &&
          other.category == this.category &&
          other.image_url == this.image_url &&
          other.quantity == this.quantity);
}

class CartValuesCompanion extends UpdateCompanion<CartValue> {
  final Value<int> id;
  final Value<String> title;
  final Value<double> price;
  final Value<String> description;
  final Value<String> category;
  final Value<String> image_url;
  final Value<int> quantity;
  const CartValuesCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.price = const Value.absent(),
    this.description = const Value.absent(),
    this.category = const Value.absent(),
    this.image_url = const Value.absent(),
    this.quantity = const Value.absent(),
  });
  CartValuesCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required double price,
    required String description,
    required String category,
    required String image_url,
    required int quantity,
  })  : title = Value(title),
        price = Value(price),
        description = Value(description),
        category = Value(category),
        image_url = Value(image_url),
        quantity = Value(quantity);
  static Insertable<CartValue> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<double>? price,
    Expression<String>? description,
    Expression<String>? category,
    Expression<String>? image_url,
    Expression<int>? quantity,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (price != null) 'price': price,
      if (description != null) 'description': description,
      if (category != null) 'category': category,
      if (image_url != null) 'image_url': image_url,
      if (quantity != null) 'quantity': quantity,
    });
  }

  CartValuesCompanion copyWith(
      {Value<int>? id,
      Value<String>? title,
      Value<double>? price,
      Value<String>? description,
      Value<String>? category,
      Value<String>? image_url,
      Value<int>? quantity}) {
    return CartValuesCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      price: price ?? this.price,
      description: description ?? this.description,
      category: category ?? this.category,
      image_url: image_url ?? this.image_url,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (price.present) {
      map['price'] = Variable<double>(price.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (image_url.present) {
      map['image_url'] = Variable<String>(image_url.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CartValuesCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('price: $price, ')
          ..write('description: $description, ')
          ..write('category: $category, ')
          ..write('image_url: $image_url, ')
          ..write('quantity: $quantity')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  late final $CartValuesTable cartValues = $CartValuesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [cartValues];
}
