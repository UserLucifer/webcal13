import '../../shared/models/app_models.dart';

PageResult<T> parsePage<T>(
  Object? data,
  T Function(Map<String, dynamic>) fromJson,
) {
  final map = _asStringKeyMap(data);
  if (map != null) {
    final records = _parseRecordList(_listPayloadFrom(map), fromJson);
    return PageResult<T>(
      records: records,
      total: _intFromJson(map['total']) ?? records.length,
      pageNo: _intFromJson(map['pageNo']) ?? 1,
      pageSize: _intFromJson(map['pageSize']) ?? records.length,
    );
  }
  if (data is List) {
    return PageResult<T>(
      records: _parseRecordList(data, fromJson),
      total: data.length,
      pageSize: data.length,
    );
  }
  return PageResult<T>(records: <T>[]);
}

T parseObject<T>(Object? data, T Function(Map<String, dynamic>) fromJson) {
  if (data is Map<String, dynamic>) {
    return fromJson(data);
  }
  if (data is Map) {
    return fromJson(Map<String, dynamic>.from(data));
  }
  throw const FormatException('接口响应结构不符合预期');
}

List<T> parseList<T>(Object? data, T Function(Map<String, dynamic>) fromJson) {
  final map = _asStringKeyMap(data);
  if (map != null) {
    return _parseRecordList(_listPayloadFrom(map), fromJson);
  }
  if (data is List) {
    return _parseRecordList(data, fromJson);
  }
  return <T>[];
}

Map<String, dynamic>? _asStringKeyMap(Object? data) {
  if (data is Map<String, dynamic>) {
    return data;
  }
  if (data is Map) {
    return Map<String, dynamic>.from(data);
  }
  return null;
}

Object? _listPayloadFrom(Map<String, dynamic> data) {
  for (final key in const ['records', 'items', 'list', 'rows']) {
    if (data.containsKey(key)) {
      return data[key];
    }
  }
  return const <Object?>[];
}

List<T> _parseRecordList<T>(
  Object? data,
  T Function(Map<String, dynamic>) fromJson,
) {
  if (data is! List) {
    return <T>[];
  }
  return data
      .whereType<Map>()
      .map((item) => fromJson(Map<String, dynamic>.from(item)))
      .toList();
}

int? _intFromJson(Object? value) {
  if (value is int) {
    return value;
  }
  if (value is num) {
    return value.toInt();
  }
  if (value is String) {
    return int.tryParse(value);
  }
  return null;
}
