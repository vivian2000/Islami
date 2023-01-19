import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:islami/home/hadeth/hadeth_title_widget.dart';
import 'package:islami/home/providers/settings_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class HadethTab extends StatefulWidget {
  @override
  State<HadethTab> createState() => _HadethTabState();
}

class _HadethTabState extends State<HadethTab> {
  List<Hadeth> hadethList = [];

  @override
  Widget build(BuildContext context) {
    var settingsProvider = Provider.of<SettingsProvider>(context);
    if (hadethList.isEmpty) loadHadethData();
    return Column(
      children: [
        Image.asset("assets/images/hadeth_logo.png"),
        Container(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Text(
            AppLocalizations.of(context)!.ahadeth,
            style: Theme.of(context).textTheme.headline4,
          ),
          alignment: Alignment.center,
          width: double.infinity,
          decoration: BoxDecoration(
              border: Border.symmetric(
                  horizontal: BorderSide(
                      color: Theme.of(context).primaryColor, width: 2))),
        ),
        Container(
          child: hadethList.isEmpty
              ? Center(child: CircularProgressIndicator())
              : Expanded(
                child: ListView.separated(
                    itemBuilder: (_, index) {
                      return HadethTitleWidget(hadethList[index]);
                    },
                    separatorBuilder: (_, index) {
                      return Container(
                        height: 2,
                        margin: EdgeInsets.symmetric(horizontal: 64),
                        width: double.infinity,
                        color: Theme.of(context).primaryColor,
                      );
                    },
                    itemCount: hadethList.length,
                  ),
              ),
        ),
      ],
    );
  }

  void loadHadethData() async {
    List<Hadeth> mHadethList = [];
    String content = await rootBundle.loadString('assets/files/ahadeth.txt');
    List<String> allHadeth = content.trim().split("#");
    for (int i = 0; i < allHadeth.length; i++) {
      String singleHadethContent = allHadeth[i];
      List<String> hadethLines = singleHadethContent.trim().split("\n");
      String title = hadethLines[0];
      if (title.isEmpty) continue;
      hadethLines.removeAt(0);
      String content = hadethLines.join("\n");
      Hadeth h = Hadeth(title, content);
      mHadethList.add(h);
    }
    this.hadethList = mHadethList;
    setState(() {});
  }
}

class Hadeth {
  String title;
  String content;

  Hadeth(this.title, this.content);
}
