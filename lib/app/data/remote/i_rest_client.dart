import 'package:atproto/core.dart';
import 'package:bluesky/bluesky.dart';

abstract interface class IRestClient{
  Future<XRPCResponse<Feed>> getFeedByAtUri({
    required String atUri,
    int limit = 30,
    String? cursor,
  });
} 