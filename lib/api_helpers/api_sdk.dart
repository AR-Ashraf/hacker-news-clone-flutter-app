import '../rest_api_handler.dart';
import 'apiConstrants.dart';

class ApiSdk {
  static fetchTopId() async {
    final response = await RestApiHandler.getData(
        '${apiConstants["hacker_news"]}/topstories.json');
    return response;
  }

  static fetchItems(int id) async {
    final response = await RestApiHandler.getData(
        '${apiConstants["hacker_news"]}/item/$id.json');
    return response;
  }
}