import 'dart:convert';
import 'package:http/http.dart' as http;

class TranslateAPI {
  static const apiKey = "9ce5bbc697msh8fbe6b51bbdaa93p154485jsnc28d1622adfa";

  getTranslation(String query, String target) async {
    String resString = '';
    Map data;

    var headers = {
      'content-type': 'application/x-www-form-urlencoded',
      'Accept-Encoding': 'application/gzip',
      'X-RapidAPI-Key': '82845ce4a6msh7ddc95d1f43627cp195e9djsn4ebc094d0a20',
      'X-RapidAPI-Host': 'google-translate1.p.rapidapi.com'
    };
    var request = http.Request(
        'POST',
        Uri.parse(
            'https://google-translate1.p.rapidapi.com/language/translate/v2'));
    request.bodyFields = {'q': query, 'target': target};
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      resString = await response.stream.bytesToString();
      data = jsonDecode(resString);
      return getString(data);
    } else {
      return response.reasonPhrase;
    }
  }

  getString(Map data) => data['data']['translations'][0]['translatedText'];
  getSource(Map data) =>
      data['data']['translations'][0]['detectedSourceLanguage'];
}
