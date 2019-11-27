import 'dart:collection';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  final client = GetIt.I<http.Client>();

  final String appId = "iOMlMm4s";
  final String consumerKey =
      "dj0yJmk9ek1aVHUxRTlGbDBlJmQ9WVdrOWFVOU5iRTF0TkhNbWNHbzlNQS0tJnM9Y29uc3VtZXJzZWNyZXQmc3Y9MCZ4PTQ1";
  final String consumerSecret = "b8fb01995ff9a0112392688147dd61027b384fa1";
  final String signature = "oD%2Fv1S%2F1XicbZb%2FqkZcLUY3ec3Q%3D";
  final String baseUrl = "https://weather-ydn-yql.media.yahoo.com/forecastrss";

  void fetchWeaher(int woeid) async {
    int timestamp = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    List<String> parameters = new List<String>();
    final oauthNonce = "anc";
    parameters.add("oauth_consumer_key=" + consumerKey);
    parameters.add("oauth_nonce=" + oauthNonce);
    parameters.add("oauth_signature_method=HMAC-SHA1");
    parameters.add("oauth_timestamp=" + timestamp.toString());
    parameters.add("oauth_version=1.0");
    // Make sure value is encoded
    parameters.add("woeid=" + woeid.toString());
    parameters.add("format=json");
    parameters.sort();

    StringBuffer parametersList = new StringBuffer();
    for (int i = 0; i < parameters.length; i++) {
      parametersList.write(((i > 0) ? "&" : "") + parameters[i]);
    }

    String signatureString = "GET&" +
        Uri.encodeComponent(baseUrl) +
        "&" +
        Uri.encodeComponent(parametersList.toString());

    var key = utf8.encode('$consumerSecret&');
    var bytes = utf8.encode(signatureString);
    var hmacSha1 = new Hmac(sha1, key);
    var digest = hmacSha1.convert(bytes);
    final signature = base64Encode(digest.bytes);

    String authorizationLine = "OAuth " +
        "oauth_consumer_key=\"" +
        consumerKey +
        "\", " +
        "oauth_nonce=\"" +
        oauthNonce +
        "\", " +
        "oauth_timestamp=\"" +
        timestamp.toString() +
        "\", " +
        "oauth_signature_method=\"HMAC-SHA1\", " +
        "oauth_signature=\"" +
        signature +
        "\", " +
        "oauth_version=\"1.0\"";

    Map<String, String> header = new HashMap();
    header["X-Yahoo-App-Id"] = appId;
    header["Content-Type"] = "application/json";
    header["Authorization"] = authorizationLine;

    final query = "?woeid=$woeid&format=json";
    final response = await client.get(baseUrl + query, headers: header);
    print(response.body);
  }
}
