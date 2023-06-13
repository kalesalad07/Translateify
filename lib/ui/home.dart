import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:translateify/services/app_services.dart';

import 'package:translateify/services/auth_service.dart';

import '../services/translator_service.dart';
import 'package:translateify/utils/globals.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  TextEditingController totranslate = TextEditingController();
  var isLoading = true;
  late String response;
  String initialLang = 'es';

  @override
  void initState() {
    super.initState();
  }

  doATranslate() async {
    response =
        await TranslateAPI().getTranslation(totranslate.text, initialLang);
    setState(() {
      isLoading = false;
    });
    return response;
  }

  dropDownLangs() {
    List<DropdownMenuItem<String>> items = [];
    for (final lang in languages) {
      items.add(DropdownMenuItem(
        value: lang,
        child: Text(lang),
      ));
    }
    return items;
  }

  Widget languageDropDown() {
    return DropdownButton(
      value: initialLang,
      items: dropDownLangs(),
      onChanged: (value) => initialLang = value!,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Color.fromARGB(255, 152, 13, 187)),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
    );
  }

  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final appService = Provider.of<AppService>(context);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey[850],
          title: Text(
            appService.uid,
            style: const TextStyle(fontFamily: 'Product Sans'),
          ),
          actions: <Widget>[
            Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {
                    authService.signOut();
                  },
                  child: const Icon(
                    Icons.logout,
                    size: 26.0,
                  ),
                )),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                flex: 1,
                child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: Colors.black,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: TextField(
                            controller: totranslate,
                            maxLines: 5,
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        width: 2, color: Colors.white),
                                    borderRadius: BorderRadius.circular(10)),
                                hintStyle: const TextStyle(color: Colors.white),
                                hintText: 'Enter Text to Be Translated'),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 50,
                              width: 100,
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(
                                      Radius.elliptical(5, 3))),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(13, 0, 0, 0),
                                child: DropdownButton(
                                  value: initialLang,
                                  items: dropDownLangs(),
                                  onChanged: (value) => setState(() {
                                    initialLang = value!;
                                  }),
                                  icon: const Icon(Icons.arrow_downward),
                                  elevation: 16,
                                  style: const TextStyle(
                                    color: Colors.black,
                                  ),
                                  underline: Container(
                                    height: 2,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 40,
                            ),
                            Container(
                              width: 100,
                              height: 50,
                              child: MaterialButton(
                                onPressed: () {
                                  doATranslate();
                                },
                                color: Colors.white,
                                child: const Text(
                                  'Translate',
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    )),
              ),
              Flexible(
                flex: 1,
                child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        (isLoading)
                            ? const Text(
                                'Press Translate Button',
                                style: TextStyle(
                                    fontFamily: 'Product Sans', fontSize: 18),
                              )
                            : Text(
                                response,
                                style: const TextStyle(
                                    fontFamily: 'Product Sans', fontSize: 18),
                              ),
                        MaterialButton(
                          onPressed: () {
                            totranslate.text = '';
                          },
                          child: const Icon(Icons.clear),
                        )
                      ],
                    )),
              )
            ],
          ),
        ));
  }
}
