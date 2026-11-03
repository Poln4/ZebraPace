import '../../core/constants/enums.dart';

/// A brace the person added themselves ("Achilles night splint"). Kept in
/// settings (see customBracesProvider); [id] is what logged days point at,
/// so renaming the list entry later wouldn't orphan them.
class CustomBrace {
  const CustomBrace({required this.id, required this.name});

  final String id;
  final String name;

  Map<String, Object?> toJson() => {'id': id, 'name': name};

  static CustomBrace? fromJson(Object? json) {
    if (json is! Map) return null;
    final id = json['id'], name = json['name'];
    if (id is! String || name is! String || name.trim().isEmpty) return null;
    return CustomBrace(id: id, name: name);
  }
}

/// One brace worn on a day. Built-in braces record a [side] (paired body
/// parts) or a [count] (ring splints), per [BraceType.amount]; custom
/// braces record a count and carry their name, so a day still reads right
/// after the brace is removed from the person's list.
///
/// Stored in DailyLogs.bracesUsed as a JSON list. Older days hold plain
/// type names ("ankle"); [fromJson] reads those as one brace, side unknown.
class BraceUse {
  const BraceUse.builtIn(BraceType this.type, {this.side, this.count = 1})
      : customId = null,
        customName = null;

  BraceUse.custom(CustomBrace brace, {this.count = 1})
      : type = null,
        side = null,
        customId = brace.id,
        customName = brace.name;

  final BraceType? type;
  final String? customId;
  final String? customName;
  final BraceSide? side;
  final int count;

  /// Identifies which brace this is, for selection in the picker.
  String get key => type?.name ?? 'custom:$customId';

  BraceAmount get amount => type?.amount ?? BraceAmount.count;

  BraceUse withSide(BraceSide side) => BraceUse.builtIn(type!, side: side, count: count);

  BraceUse withCount(int count) => type == null
      ? BraceUse.custom(CustomBrace(id: customId!, name: customName!), count: count)
      : BraceUse.builtIn(type!, side: side, count: count);

  Object toJson() => type == null
      ? {'type': 'custom', 'id': customId, 'name': customName, 'count': count}
      : {
          'type': type!.db,
          if (type!.amount == BraceAmount.side && side != null) 'side': side!.name,
          if (type!.amount == BraceAmount.count) 'count': count,
        };

  static BraceUse? fromJson(Object? json) {
    if (json is String) {
      final type = BraceType.fromDb(json);
      return type == null ? null : BraceUse.builtIn(type);
    }
    if (json is! Map) return null;
    final count = json['count'] is int && (json['count'] as int) > 0 ? json['count'] as int : 1;
    if (json['type'] == 'custom') {
      final brace = CustomBrace.fromJson(json);
      return brace == null ? null : BraceUse.custom(brace, count: count);
    }
    final type = json['type'] is String ? BraceType.fromDb(json['type'] as String) : null;
    if (type == null) return null;
    return BraceUse.builtIn(type, side: BraceSide.fromDb(json['side']), count: count);
  }

  @override
  bool operator ==(Object other) =>
      other is BraceUse &&
      other.key == key &&
      other.side == side &&
      other.count == count &&
      other.customName == customName;

  @override
  int get hashCode => Object.hash(key, side, count, customName);
}
