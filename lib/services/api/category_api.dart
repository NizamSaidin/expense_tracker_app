import 'package:expense_tracker_app/services/api/base_api.dart';

class CategoryAPI extends BaseAPI {
  Future<Map<String, dynamic>> getCategories() async {
    return await request(
      url: 'https://media.halogen.my/experiment/mobile/expenseCategories.json',
      method: Method.get,
    );
  }
}
