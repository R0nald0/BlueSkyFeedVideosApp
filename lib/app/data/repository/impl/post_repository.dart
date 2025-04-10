import 'dart:developer';

import 'package:atproto/core.dart';
import 'package:bluesky/app_bsky_embed_video.dart';
import 'package:bluesky/bluesky.dart';
import 'package:spark_desafio_tecnico/app/core/exceptions/repostory_exception.dart';
import 'package:spark_desafio_tecnico/app/data/model/post_video.dart';
import 'package:spark_desafio_tecnico/app/data/remote/i_rest_client.dart';
import 'package:spark_desafio_tecnico/app/data/repository/i_post_repository.dart';

class PostRepository implements IPostRepository {

  final IRestClient _restClient;

  PostRepository({required IRestClient client}) : _restClient = client ;

  String? cursorUkrainianView;
  String? cursorWhatsHot;
  String? cursorHotClassic;
  String? cursorAll;

  @override
  Future<List<PostVideo>> getFeedPostVideo({
    int limit = 50,
  }) async {
    final allFeeds = await Future.wait([
      _restClient.getFeedByAtUri(
          atUri:
              'at://did:plc:dvgliotey33vix3wlltybgkd/app.bsky.feed.generator/ukrainian-view',
          limit: limit,
          cursor: cursorUkrainianView),
      _restClient.getFeedByAtUri(
          atUri:
              'at://did:plc:z72i7hdynmk6r22z27h6tvur/app.bsky.feed.generator/whats-hot',
          limit: limit,
          cursor: cursorWhatsHot),
      _restClient.getFeedByAtUri(
          atUri:
              'at://did:plc:z72i7hdynmk6r22z27h6tvur/app.bsky.feed.generator/hot-classic',
          limit: limit,
          cursor: cursorHotClassic),
      _restClient.getFeedByAtUri(
          atUri:
              'at://did:plc:dvgliotey33vix3wlltybgkd/app.bsky.feed.generator/all',
          limit: limit,
          cursor: cursorAll),
    ], eagerError: true)
        .catchError((erro) {
      log('Erro ao buscar dados',error: erro);
      throw RepositoryException(message: 'erro ao buscar Lista');
    });

    _configCursor(allFeeds);

    final feeds = allFeeds.expand((feed) {
      return feed.data.feed;
    }).toList();

    return _parseVideoFeed(feeds);
  }

  List<PostVideo> _parseVideoFeed(List<FeedView> feedItems) {
    return feedItems
        .map((feedItem) {
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
        })
        .whereType<PostVideo>()
        .toList();
  }

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
}

class UrlVideoData {
  final String videoUrl;
  final String thumbnail;
  UrlVideoData({
    required this.videoUrl,
    required this.thumbnail,
  });
}
