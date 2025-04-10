
import 'package:flutter_modular/flutter_modular.dart';
import 'package:spark_desafio_tecnico/app/data/remote/i_rest_client.dart';
import 'package:spark_desafio_tecnico/app/data/remote/impl/rest_client_impl.dart';

import 'package:spark_desafio_tecnico/app/data/repository/i_post_repository.dart';
import 'package:spark_desafio_tecnico/app/data/repository/impl/post_repository.dart';
import 'package:spark_desafio_tecnico/app/presentation/controllers/home_page_controller.dart';
import 'package:spark_desafio_tecnico/app/presentation/ui/hompage/home.dart';


class AppModule extends Module {
  @override
  void binds(Injector i) {
     i.addSingleton<IRestClient>(RestClientImpl.new);
     i.addSingleton<IPostRepository>(PostRepository.new);
     i.addSingleton(HomePageController.new);
     
    super.binds(i);
  }

  @override
  void routes(RouteManager r) {
    r.child('/', child: (context) => Home());
    super.routes(r);
  }
}