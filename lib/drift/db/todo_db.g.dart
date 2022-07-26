// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_db.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: type=lint
<<<<<<< Updated upstream
class Todo extends DataClass implements Insertable<Todo> {
=======
class TodoItemData extends DataClass implements Insertable<TodoItemData> {
>>>>>>> Stashed changes
  final int id;
  final String title;
  final String description;
  final DateTime addDate;
  final DateTime limitDate;
<<<<<<< Updated upstream
  Todo(
=======
  TodoItemData(
>>>>>>> Stashed changes
      {required this.id,
      required this.title,
      required this.description,
      required this.addDate,
      required this.limitDate});
<<<<<<< Updated upstream
  factory Todo.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Todo(
=======
  factory TodoItemData.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return TodoItemData(
>>>>>>> Stashed changes
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      title: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}title'])!,
      description: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}description'])!,
      addDate: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}add_date'])!,
      limitDate: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}limit_date'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['description'] = Variable<String>(description);
    map['add_date'] = Variable<DateTime>(addDate);
    map['limit_date'] = Variable<DateTime>(limitDate);
    return map;
  }

<<<<<<< Updated upstream
  TodosCompanion toCompanion(bool nullToAbsent) {
    return TodosCompanion(
=======
  TodoItemCompanion toCompanion(bool nullToAbsent) {
    return TodoItemCompanion(
>>>>>>> Stashed changes
      id: Value(id),
      title: Value(title),
      description: Value(description),
      addDate: Value(addDate),
      limitDate: Value(limitDate),
    );
  }

<<<<<<< Updated upstream
  factory Todo.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Todo(
=======
  factory TodoItemData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TodoItemData(
>>>>>>> Stashed changes
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String>(json['description']),
      addDate: serializer.fromJson<DateTime>(json['addDate']),
      limitDate: serializer.fromJson<DateTime>(json['limitDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String>(description),
      'addDate': serializer.toJson<DateTime>(addDate),
      'limitDate': serializer.toJson<DateTime>(limitDate),
    };
  }

<<<<<<< Updated upstream
  Todo copyWith(
=======
  TodoItemData copyWith(
>>>>>>> Stashed changes
          {int? id,
          String? title,
          String? description,
          DateTime? addDate,
          DateTime? limitDate}) =>
<<<<<<< Updated upstream
      Todo(
=======
      TodoItemData(
>>>>>>> Stashed changes
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        addDate: addDate ?? this.addDate,
        limitDate: limitDate ?? this.limitDate,
      );
  @override
  String toString() {
<<<<<<< Updated upstream
    return (StringBuffer('Todo(')
=======
    return (StringBuffer('TodoItemData(')
>>>>>>> Stashed changes
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('addDate: $addDate, ')
          ..write('limitDate: $limitDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, description, addDate, limitDate);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
<<<<<<< Updated upstream
      (other is Todo &&
=======
      (other is TodoItemData &&
>>>>>>> Stashed changes
          other.id == this.id &&
          other.title == this.title &&
          other.description == this.description &&
          other.addDate == this.addDate &&
          other.limitDate == this.limitDate);
}

<<<<<<< Updated upstream
class TodosCompanion extends UpdateCompanion<Todo> {
=======
class TodoItemCompanion extends UpdateCompanion<TodoItemData> {
>>>>>>> Stashed changes
  final Value<int> id;
  final Value<String> title;
  final Value<String> description;
  final Value<DateTime> addDate;
  final Value<DateTime> limitDate;
<<<<<<< Updated upstream
  const TodosCompanion({
=======
  const TodoItemCompanion({
>>>>>>> Stashed changes
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.addDate = const Value.absent(),
    this.limitDate = const Value.absent(),
  });
<<<<<<< Updated upstream
  TodosCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required String description,
    required DateTime addDate,
    required DateTime limitDate,
  })  : title = Value(title),
        description = Value(description),
        addDate = Value(addDate),
        limitDate = Value(limitDate);
  static Insertable<Todo> custom({
=======
  TodoItemCompanion.insert({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    required DateTime addDate,
    required DateTime limitDate,
  })  : addDate = Value(addDate),
        limitDate = Value(limitDate);
  static Insertable<TodoItemData> custom({
>>>>>>> Stashed changes
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? description,
    Expression<DateTime>? addDate,
    Expression<DateTime>? limitDate,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (addDate != null) 'add_date': addDate,
      if (limitDate != null) 'limit_date': limitDate,
    });
  }

<<<<<<< Updated upstream
  TodosCompanion copyWith(
=======
  TodoItemCompanion copyWith(
>>>>>>> Stashed changes
      {Value<int>? id,
      Value<String>? title,
      Value<String>? description,
      Value<DateTime>? addDate,
      Value<DateTime>? limitDate}) {
<<<<<<< Updated upstream
    return TodosCompanion(
=======
    return TodoItemCompanion(
>>>>>>> Stashed changes
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      addDate: addDate ?? this.addDate,
      limitDate: limitDate ?? this.limitDate,
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
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (addDate.present) {
      map['add_date'] = Variable<DateTime>(addDate.value);
    }
    if (limitDate.present) {
      map['limit_date'] = Variable<DateTime>(limitDate.value);
    }
    return map;
  }

  @override
  String toString() {
<<<<<<< Updated upstream
    return (StringBuffer('TodosCompanion(')
=======
    return (StringBuffer('TodoItemCompanion(')
>>>>>>> Stashed changes
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('addDate: $addDate, ')
          ..write('limitDate: $limitDate')
          ..write(')'))
        .toString();
  }
}

<<<<<<< Updated upstream
class $TodosTable extends Todos with TableInfo<$TodosTable, Todo> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TodosTable(this.attachedDatabase, [this._alias]);
=======
class $TodoItemTable extends TodoItem
    with TableInfo<$TodoItemTable, TodoItemData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TodoItemTable(this.attachedDatabase, [this._alias]);
>>>>>>> Stashed changes
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
<<<<<<< Updated upstream
  late final GeneratedColumn<String?> title = GeneratedColumn<String?>(
      'title', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: const StringType(),
      requiredDuringInsert: true);
=======
  late final GeneratedColumn<String?> title =
      GeneratedColumn<String?>('title', aliasedName, false,
          additionalChecks: GeneratedColumn.checkTextLength(
            minTextLength: 1,
          ),
          type: const StringType(),
          requiredDuringInsert: false,
          defaultValue: const Constant(''));
>>>>>>> Stashed changes
  final VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String?> description = GeneratedColumn<String?>(
      'description', aliasedName, false,
<<<<<<< Updated upstream
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: const StringType(),
      requiredDuringInsert: true);
=======
      type: const StringType(),
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
>>>>>>> Stashed changes
  final VerificationMeta _addDateMeta = const VerificationMeta('addDate');
  @override
  late final GeneratedColumn<DateTime?> addDate = GeneratedColumn<DateTime?>(
      'add_date', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _limitDateMeta = const VerificationMeta('limitDate');
  @override
  late final GeneratedColumn<DateTime?> limitDate = GeneratedColumn<DateTime?>(
      'limit_date', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, title, description, addDate, limitDate];
  @override
<<<<<<< Updated upstream
  String get aliasedName => _alias ?? 'todos';
  @override
  String get actualTableName => 'todos';
  @override
  VerificationContext validateIntegrity(Insertable<Todo> instance,
=======
  String get aliasedName => _alias ?? 'todo_item';
  @override
  String get actualTableName => 'todo_item';
  @override
  VerificationContext validateIntegrity(Insertable<TodoItemData> instance,
>>>>>>> Stashed changes
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
<<<<<<< Updated upstream
    } else if (isInserting) {
      context.missing(_titleMeta);
=======
>>>>>>> Stashed changes
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
<<<<<<< Updated upstream
    } else if (isInserting) {
      context.missing(_descriptionMeta);
=======
>>>>>>> Stashed changes
    }
    if (data.containsKey('add_date')) {
      context.handle(_addDateMeta,
          addDate.isAcceptableOrUnknown(data['add_date']!, _addDateMeta));
    } else if (isInserting) {
      context.missing(_addDateMeta);
    }
    if (data.containsKey('limit_date')) {
      context.handle(_limitDateMeta,
          limitDate.isAcceptableOrUnknown(data['limit_date']!, _limitDateMeta));
    } else if (isInserting) {
      context.missing(_limitDateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
<<<<<<< Updated upstream
  Todo map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Todo.fromData(data,
=======
  TodoItemData map(Map<String, dynamic> data, {String? tablePrefix}) {
    return TodoItemData.fromData(data,
>>>>>>> Stashed changes
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
<<<<<<< Updated upstream
  $TodosTable createAlias(String alias) {
    return $TodosTable(attachedDatabase, alias);
=======
  $TodoItemTable createAlias(String alias) {
    return $TodoItemTable(attachedDatabase, alias);
>>>>>>> Stashed changes
  }
}

abstract class _$MyDatabase extends GeneratedDatabase {
  _$MyDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
<<<<<<< Updated upstream
  late final $TodosTable todos = $TodosTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [todos];
=======
  late final $TodoItemTable todoItem = $TodoItemTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [todoItem];
>>>>>>> Stashed changes
}
