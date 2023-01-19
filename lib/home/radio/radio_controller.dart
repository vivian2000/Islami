import 'package:flutter/material.dart';
import 'package:islami/home/providers/settings_provider.dart';
import 'package:islami/model/Radios.dart';
import 'package:islami/my_theme.dart';
import 'package:provider/provider.dart';

class RadioController extends StatefulWidget {
  Radios radioResponse;
  Function play;
  Function pause;

  RadioController({
    required this.radioResponse,
    required this.play,
    required this.pause,
  });

  @override
  State<RadioController> createState() => _RadioControllerState();
}

class _RadioControllerState extends State<RadioController> {
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    var settingsProvider = Provider.of<SettingsProvider>(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Text(
            widget.radioResponse.name ?? "",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline5!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          SizedBox(
            height: 50,
          ),
          Row(
            children: [
              Spacer(),
              IconButton(
                onPressed: () {
                  widget.play();
                },
                icon: Icon(
                  Icons.play_arrow,
                  size: 45,
                  color: settingsProvider.isDark()
                      ? MyTheme.colorYellow
                      : MyTheme.colorGold,
                ),
              ),
              Spacer(),
              IconButton(
                onPressed: () {
                  widget.pause();
                },
                icon: Icon(
                  Icons.pause,
                  size: 45,
                  color: settingsProvider.isDark()
                      ? MyTheme.colorYellow
                      : MyTheme.colorGold,
                ),
              ),
              Spacer(),
            ],
          )
        ],
      ),
    );
  }
}
