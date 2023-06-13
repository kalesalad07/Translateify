import 'dart:convert';
import 'package:http/http.dart' as http;

class TranslateAPI {
  static const apiKey = "991a1779demshbb49135bb161b12p1c24b7jsn50d6ba889c63";

  getTranslation(String query, String target) async {
    String resString = '';
    Map data;

    var headers = {
      'content-type': 'application/x-www-form-urlencoded',
      'Accept-Encoding': 'application/gzip',
      'X-RapidAPI-Key': apiKey,
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
