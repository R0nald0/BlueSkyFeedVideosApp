import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:spark_desafio_tecnico/app/presentation/controllers/home_page_controller.dart';
import 'package:spark_desafio_tecnico/app/presentation/ui/hompage/widgets/find_new_video_widget.dart';
import 'package:spark_desafio_tecnico/app/presentation/ui/hompage/widgets/video_player_item.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final controller = Modular.get<HomePageController>();
  late VoidCallback listener;

  @override
  void initState() {
    super.initState();
   
    WidgetsBinding.instance.addPostFrameCallback((_) {
        listener =  () {
       final erro  = controller.message;
       if (erro != null && erro.isNotEmpty) {
         ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(erro)));
       }
       
      };
        controller.addListener(listener);
        controller.configToMoreVideos(0);
    });
    
  }

  @override
  Widget build(BuildContext context) {
  

    return Scaffold(
      backgroundColor: Colors.grey.withAlpha(60),
      body: ListenableBuilder(
        listenable: controller,
        builder: (context, child) {
          return Visibility(
            visible: controller.appVideos.isNotEmpty,
            replacement: controller.isloading && controller.appVideos.isEmpty
                ? Center(child: CircularProgressIndicator())
                : FindNewVideosWidget(
                    onTap: () => controller.configToMoreVideos(0),
                  ),
            child: PageView.builder(
              onPageChanged: (value) {
                controller.configToMoreVideos(value);
              },
              scrollDirection: Axis.vertical,
              itemCount: controller.appVideos.length,
              itemBuilder: (context, index) {
                final videoIndex = controller.appVideos[index];
                return VideoPlayerItem(
                  videoUrl: videoIndex.videoUrl,
                  userName: videoIndex.userName,
                  profileImage: videoIndex.profileImge,
                );
              },
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    controller.removeListener(listener);
    super.dispose();
  }
}
