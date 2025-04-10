import 'package:flutter/material.dart';
import 'package:spark_desafio_tecnico/app/presentation/ui/hompage/widgets/profile_widget.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerItem extends StatefulWidget {
  final String videoUrl;
  final String userName;
  final String profileImage;

  const VideoPlayerItem({
    super.key,
    required this.videoUrl,
    required this.userName,
    required this.profileImage,
  });

  @override
  State<VideoPlayerItem> createState() => _VideoPlayerItemState();
}

class _VideoPlayerItemState extends State<VideoPlayerItem> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl));
    
    WidgetsBinding.instance.addPostFrameCallback((_){
      initializeVideo();
    });
      
  }
  
  Future<void> initializeVideo()async{
     await  _controller.initialize();
     setState(() {});
        _controller.play();
        _controller.setLooping(true);
  }
  void _togglePlayPause() {
    setState(() {
      _controller.value.isPlaying ? _controller.pause() : _controller.play();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _togglePlayPause,
      child: Stack(
        fit: StackFit.loose,
        children: [
          _controller.value.isInitialized
              ? VideoPlayer(_controller)
              : const Center(child: CircularProgressIndicator()),
          AnimatedOpacity(
            duration: Duration(milliseconds: 300),
            opacity: !_controller.value.isPlaying && _controller.value.isInitialized 
               ? 1 : 0.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: IconButton(
                      alignment: Alignment.center,
                      icon: Icon(Icons.play_arrow),
                      iconSize: MediaQuery.of(context).size.height * 0.1,
                      color: Colors.white,
                      onPressed: () {
                         _togglePlayPause();
                      },
                    ),
                  ),
                ),
                Align(
                    alignment: Alignment.bottomCenter,
                    child: ProfileWidget(
                        userName: widget.userName,
                        profileImage: widget.profileImage)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
