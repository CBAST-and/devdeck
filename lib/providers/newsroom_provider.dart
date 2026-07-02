import 'package:flutter/material.dart';
import '../core/enums/view_state.dart';
import '../core/network/api_client.dart';
import '../models/article_model.dart';
import '../services/newsroom_service.dart';

/// Provider de la pantalla Newsroom. Carga las últimas 3 noticias
/// y la información del sitio (nombre y logo) desde WordPress.
class NewsroomProvider extends ChangeNotifier {
  final NewsroomService _service = NewsroomService();

  ViewState _state = ViewState.loading;
  List<ArticleModel> _articles = [];
  SiteModel? _site;
  String _errorMessage = '';

  ViewState get state => _state;
  List<ArticleModel> get articles => _articles;
  SiteModel? get site => _site;
  String get errorMessage => _errorMessage;

  Future<void> loadNews() async {
    _state = ViewState.loading;
    notifyListeners();

    try {
      final results = await Future.wait([
        _service.fetchLatestArticles(),
        _service.fetchSiteInfo(),
      ]);

      final articles = results[0] as List<ArticleModel>;
      final site = results[1] as SiteModel;

      _site = site;

      if (articles.isEmpty) {
        _articles = [];
        _state = ViewState.empty;
      } else {
        _articles = articles;
        _state = ViewState.success;
      }
    } on ApiException catch (e) {
      _errorMessage = e.message;
      _state = ViewState.error;
    } catch (_) {
      _errorMessage = 'Something went wrong. Please try again.';
      _state = ViewState.error;
    }

    notifyListeners();
  }
}