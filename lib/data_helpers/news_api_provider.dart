

import 'package:hacker_news_clone/api_helpers/api_sdk.dart';

import 'news_item_model.dart';
import 'news_repository.dart';

class NewsApiProvider implements Source {
  Future<List<int>> fetchTopId() async {
    final response = await ApiSdk.fetchTopId();
    final ids = response;
    return ids.cast<int>();
  }

  Future<NewsItemModel> fetchItems(int id) async {
    final response = await ApiSdk.fetchItems(id);
    final parsedJson = response;
    return NewsItemModel.fromJson(parsedJson);
  }
}