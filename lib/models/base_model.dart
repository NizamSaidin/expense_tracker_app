import 'base_model_interface.dart';

class BaseModel<T> implements BaseModelInterface<T> {
  @override
  T fromJson(Map<String, dynamic> json) {
    /// implement fromJson() to class that extend this
    throw UnimplementedError();
  }

  /// list from json
  @override
  List<T> listFromJson(List<dynamic> json) {
    final List<T> items = <T>[];
    for (final dynamic item in json) {
      if (item is Map<String, dynamic>) {
        items.add(fromJson(mapKeyToCamelCase(item)));
      }
    }

    return items;
  }

  /// list to json
  @override
  List listToJson(List list) {
    return list.map((e) => e.toJson()).toList();
  }

  @override
  Map<String, dynamic> toJson() {
    /// implement toJson() to class that extend this
    throw UnimplementedError();
  }

  /// use toJson() to print all property data
  @override
  toString() {
    try {
      return '[$runtimeType] ${toJson().toString()}';
    } catch (e) {
      return 'Instance of $runtimeType';
    }
  }

  /// create new instance of T based on current instance T with same property value
  T copy() {
    return fromJson(toJson());
  }

  /// clone current instances of List<T> to new instance of List<T>
  /// without previous references
  List<T> copyList(List<T> records) {
    final List<T> items = <T>[];
    for (final dynamic item in records) {
      items.add(item.copy());
    }
    return items;
  }

  Map<String, dynamic> mapKeyToCamelCase(Map<String, dynamic> data) {
    final RegExp regex = RegExp(r'_([a-z])');
    final Map<String, dynamic> result = {};

    data.forEach((key, value) {
      final String newKey = key.replaceAllMapped(regex, (match) => match.group(1)!.toUpperCase());
      result[newKey] = value;
    });

    return result;
  }
}
