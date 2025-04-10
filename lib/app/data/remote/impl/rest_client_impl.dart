
import 'package:atproto/core.dart';
import 'package:bluesky/bluesky.dart';
import 'package:spark_desafio_tecnico/app/core/constants/constants.dart';
import 'package:spark_desafio_tecnico/app/data/remote/i_rest_client.dart';

class RestClientImpl implements IRestClient {
   late Bluesky atClient;
    RestClientImpl() {
         atClient = Bluesky.anonymous(service: Constants.SERVICE_NAME);
   }
   
   @override
     Future<XRPCResponse<Feed>> getFeedByAtUri({
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
