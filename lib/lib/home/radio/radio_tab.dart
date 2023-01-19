import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:islami_sun_c6/home/providers/settings_provider.dart';
import 'package:islami_sun_c6/home/radio/radio_controller.dart';
import 'package:islami_sun_c6/model/RadioResponse.dart';
import 'package:islami_sun_c6/my_theme.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class RadioTab extends StatefulWidget {
  @override
  State<RadioTab> createState() => _RadioTabState();
}

class _RadioTabState extends State<RadioTab> {
  late Future<RadioResponse> responseRadio;
  late AudioPlayer audioPlayer;

  @override
  void initState() {
    super.initState();
    responseRadio = fetchRadio();
    audioPlayer = AudioPlayer();
  }

  play(String url) async {
    int result = await audioPlayer.play(url);
  }

  pause() async {
    audioPlayer.pause();
  }

  Widget build(BuildContext context) {
    return FutureBuilder<RadioResponse>(
      future: responseRadio,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  flex: 3, child: Image.asset("assets/images/radio_image.png")),
              Expanded(
                flex: 2,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const PageScrollPhysics(),
                  itemBuilder: (context, index) => RadioController(
                    radioResponse: snapshot.data!.radios![index],
                    play: play(snapshot.data!.radios![index].radioUrl ?? ""),
                    pause: pause(),
                  ),
                  itemCount: snapshot.data!.radios!.length,
                ),
              ),
            ],
          );
        } else if (snapshot.hasError) {
          return Center(
            child: IconButton(
                onPressed: () {
                  responseRadio = fetchRadio();
                },
                icon: Icon(
                  Icons.refresh,
                  color: Theme.of(context).primaryColor,
                  size: 35,
                )),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(
              color: Theme.of(context).primaryColor,
            ),
          );
        }
      },
    );
  }

  Future<RadioResponse> fetchRadio() async {
    final response = await http
        .get(Uri.parse("http://api.mp3quran.net/radios/radio_arabic.json"));
    if (response.statusCode == 200) {
      return RadioResponse.fromJson(
          jsonDecode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception("Failed to load RadioResponse");
    }
  }
}
