abstract class BaseModelInterface<T> {
  /// parse json result to <T> Model Instance
  T fromJson(Map<String, dynamic> json);

  /// parse Model Instance to Map<String, dynamic>
  Map<String, dynamic> toJson();

  /// transform list of json to List<T> of specific model
  List<T> listFromJson(List<dynamic> json);

  /// transform List of Model Instance (List<T>) to List of Map<String, dynamic> json
  List listToJson(List list);
}
