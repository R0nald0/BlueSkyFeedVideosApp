import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:spark_desafio_tecnico/app/core/exceptions/repostory_exception.dart';
import 'package:spark_desafio_tecnico/app/data/model/post_video.dart';
import 'package:spark_desafio_tecnico/app/data/repository/i_post_repository.dart';

class HomePageController extends ChangeNotifier {
  final IPostRepository _repository;
  List<PostVideo> appVideos = <PostVideo>[];

  bool _isLoading = false;
  String  _message ='';

  bool get isloading => _isLoading;
  String get message => _message;

  HomePageController({required IPostRepository client})
      : _repository = client,
        super();

  Future<void> _getFeedVideos() async {
    try {
      showLoader();
      final videos = await _repository.getFeedPostVideo();
      appVideos.addAll(videos); 
    } on RepositoryException catch (e) {
        _message = 'Erro ao buscar video';
        log('erro ao buscar dados',error: e);
    }finally{
        hideLoader();
        notifyListeners();
        clearErrorMessage();
    }
  
  }

  Future<void> configToMoreVideos(int currentPage) async {
    final totalPage = appVideos.length;
    if (currentPage >= totalPage - 2) {
      _getFeedVideos();
    }
  }
  
  Future<void> showLoader() async {
    _isLoading = true;
    notifyListeners();
  }

  Future<void> hideLoader() async {
    if (_isLoading) {
      _isLoading = false;
    }
  }
  void clearErrorMessage() {
    if(_message.isNotEmpty){
      _message = '';
    }
  }
}
