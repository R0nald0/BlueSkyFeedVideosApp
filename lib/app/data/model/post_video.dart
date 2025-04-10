import 'dart:convert';

class PostVideo {
 final String videoUrl;
 final  String userName;
 final  String profileImge;
    PostVideo({
    required this.videoUrl,
    required this.userName,
    required this.profileImge
  });
 
  PostVideo copyWith({
    String? videoUri,
    String? userName,
    String? profileImge    
  }) {
    return PostVideo(
          videoUrl: videoUri ?? videoUrl,
      userName: userName ?? this.userName,
      profileImge: profileImge ?? this.profileImge
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'videoUri': videoUrl,
      'userName': userName,
      'profileImge': profileImge,
      
    };
  }

  factory PostVideo.fromMap(Map<String, dynamic> map) {
    return PostVideo(
      videoUrl: map['videoUri'] ?? '',
      userName: map['userName'] ?? '',
      profileImge: map['profileImge'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory PostVideo.fromJson(String source) => PostVideo.fromMap(json.decode(source));
}
