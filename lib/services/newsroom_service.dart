import '../core/network/api_client.dart';
import '../core/constants/app_endpoints.dart';
import '../models/article_model.dart';

/// Service encargado de consumir la API REST de WordPress
/// (steamdeckhq.com) para Newsroom.
class NewsroomService {
  final ApiClient _client = ApiClient();

  Future<List<ArticleModel>> fetchLatestArticles() async {
    final data = await _client.get(AppEndpoints.wordpressPostsEndpoint);

    if (data is! List) return [];

    return data
        .whereType<Map<String, dynamic>>()
        .map((json) => ArticleModel.fromJson(json))
        .toList();
  }

  Future<SiteModel> fetchSiteInfo() async {
    final url = '${AppEndpoints.wordpressSite}/wp-json';
    final data = await _client.get(url);
    return SiteModel.fromJson(data as Map<String, dynamic>);
  }
}