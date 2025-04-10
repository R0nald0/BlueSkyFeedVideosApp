import 'package:spark_desafio_tecnico/app/data/model/post_video.dart';

abstract interface class IPostRepository{
   Future<List<PostVideo>> getFeedVideo({ int limit = 30 });

}