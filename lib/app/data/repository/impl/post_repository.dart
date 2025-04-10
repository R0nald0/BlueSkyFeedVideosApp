import 'dart:developer';

import 'package:atproto/core.dart';
import 'package:bluesky/app_bsky_embed_video.dart';
import 'package:bluesky/bluesky.dart';
import 'package:spark_desafio_tecnico/app/data/model/post_video.dart';
import 'package:spark_desafio_tecnico/app/data/repository/i_post_repository.dart';


class Postrepository implements IPostRepository {
  late Bluesky atClient;

  Postrepository() {
    atClient = Bluesky.anonymous(service: "api.bsky.app");
  }
    String? cursorUkrainianView;
    String? cursorWhatsHot;
    String? cursorHotClassic; 
    String? cursorAll;
  @override
  Future<List<PostVideo>> getFeedVideo({
    int limit = 50,
  }) async {
    final allFeeds = await Future.wait([
      _getFeedUView(
          atUri:
              'at://did:plc:dvgliotey33vix3wlltybgkd/app.bsky.feed.generator/ukrainian-view',
              limit: limit,
              cursor: cursorUkrainianView
              ),
      _getFeedUView(
          atUri:'at://did:plc:z72i7hdynmk6r22z27h6tvur/app.bsky.feed.generator/whats-hot',
          limit: limit,
          cursor: cursorWhatsHot
          ),
      _getFeedUView(
          atUri: 'at://did:plc:z72i7hdynmk6r22z27h6tvur/app.bsky.feed.generator/hot-classic',
          limit: limit,
          cursor: cursorHotClassic
          ),

      _getFeedUView(
          atUri:
              'at://did:plc:dvgliotey33vix3wlltybgkd/app.bsky.feed.generator/all',
              limit: limit,
              cursor: cursorAll
              ),
    ], 
    
    eagerError: true)
        .catchError((erro) {
      log('Erro ao buscar dados !! $erro');
      throw Exception('erro ao buscar Lista');
    });

    _configCursor(allFeeds);

    final feeds = allFeeds.expand((feed)  {
      return feed.data.feed;
    }).toList();
    return _parseVideoFeed(feeds);
  }

 
  List<PostVideo> _parseVideoFeed(List<FeedView> feedItems) {
  return feedItems.map((feedItem) {
    final embed = feedItem.post.embed?.data;
    if (embed is EmbedViewRecord) {
      final record = embed.record.data;
      if (record is EmbedViewRecordViewRecord) {
        for (final embed in record.embeds ?? []) {
          final data = embed.data;
          if (data is EmbedVideoView) {
            final urlDataVideo = _getVideoUrl(data);
            final urlVideo = urlDataVideo.videoUrl;

            if (urlVideo.isNotEmpty) {
              return PostVideo(
                videoUrl: urlVideo,
                userName: feedItem.post.author.displayName ?? 'Autor',
                profileImge: feedItem.post.author.avatar ?? '',
              );
            }
          }
        }
      }
    }
    return null;
  }).whereType<PostVideo>().toList();
}

 /*  List<PostVideo> _parseVideoFeed(List<FeedView> feedItems) {
    return feedItems
        .map((ele) {
          final embedViewRecord = ele.post.embed?.data;
          if (embedViewRecord is EmbedViewRecord) {
            final recordData = embedViewRecord.record.data;

            if (recordData is EmbedViewRecordViewRecord) {
              final value = recordData;
              final postData = value.value.embed?.data;

              if (postData is EmbedVideo) {
                postData.video.size;
              }

              final embeds = value.embeds;
              if (embeds == null || embeds.isEmpty) {
                return null;
              }

              for (final embed in embeds) {
                final data = embed.data;
                if (data is EmbedVideoView) {
                  final urlDataVideo = _getVideoUrl(data);
                  final urlVideo = urlDataVideo.videoUrl;

                  if (urlVideo.isNotEmpty) {
                    return PostVideo(
                      videoUrl: urlVideo,
                      userName: ele.post.author.displayName ?? 'Autor',
                      profileImge: ele.post.author.avatar ?? '',
                    );
                  }
                }
              }
            }
          }

          return null; 
        })
        .whereType<PostVideo>() 
        .toList();
  } */
  
  UrlVideoData _getVideoUrl(EmbedVideoView value) {
    final videoUrl = value.playlist;
    final thumbUrl = value.thumbnail;
    return UrlVideoData(videoUrl: videoUrl, thumbnail: thumbUrl ?? '');
  }
   void _configCursor(List<XRPCResponse<Feed>> t) {
    cursorUkrainianView = t[0].data.cursor;
    cursorWhatsHot = t[1].data.cursor;
    cursorHotClassic = t[2].data.cursor;
    cursorAll = t[3].data.cursor;
  }

  Future<XRPCResponse<Feed>> _getFeedUView({
    required String atUri,
    int limit = 30,
    String? cursor,
  }) async {
    return await atClient.feed.getFeed(
      generatorUri: AtUri(
        atUri,
      ),
      limit: limit,
      cursor: cursor, 
    );
  }
}

class UrlVideoData {
  final String videoUrl;
  final String thumbnail;
  UrlVideoData({
    required this.videoUrl,
    required this.thumbnail,
  });
}
