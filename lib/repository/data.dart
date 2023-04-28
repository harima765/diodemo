import '../api/http_manager.dart';

class Repository {
  static var httpManager = HTTPManager();

  static Future getData(int pageNum) async {
    final result = await httpManager.get(
      url: "posts",
      queryParams: {"page": pageNum, "limit": 10},
      loading: true,
    );
    return result;
  }
}
