import 'package:flutter/material.dart';
import 'package:islami/home/providers/settings_provider.dart';
import 'package:islami/my_theme.dart';
import 'package:provider/provider.dart';

class TasbehTab extends StatefulWidget {
  @override
  State<TasbehTab> createState() => _TasbehTabState();
}

class _TasbehTabState extends State<TasbehTab> {
  double angle = 0;
  int counter = 0;
  int currentIndex = 0;
  List<String> askar =[
    "سبحان الله",
    "الحمد لله",
    "الله اكبر"
  ];
  @override
  Widget build(BuildContext context) {
    var settingsProvider = Provider.of<SettingsProvider>(context);
    Size size = MediaQuery.of(context).size;
    return Container(
      color: Colors.transparent,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: size.height * 0.4,
            child: Stack(
              children: [
                Positioned(child: Image.asset(settingsProvider.getTasbehHeadBackGround()),
                left: size.width * 0.48,),
                Positioned(child: InkWell(
                    onTap: onPressed,
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    child: Transform.rotate(
                        angle: angle,
                        child: Image.asset(settingsProvider.getTasbehBackGround()))),
                top: 80,
                left: size.width * 0.21,
                right: size.width * 0.21,),
              ],
            ),
          ),
          Text("عدد التسبيحات",
          style: Theme.of(context).textTheme.headline5!.copyWith(fontWeight: FontWeight.bold,)),
          SizedBox(height: 20,),
          Container(
            alignment: Alignment.center,
            width: 70,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: settingsProvider.isDark()?Color.fromRGBO(20, 26, 46, 1):MyTheme.colorGold,
            ),
            child: Text("$counter",style: Theme.of(context).textTheme.headline5!.copyWith(
              fontWeight: FontWeight.bold,
              color: settingsProvider.isDark()?Colors.white:Colors.black,)),
          ),
          SizedBox(height: 20,),
          Container(
            alignment: Alignment.center,
            width: 135,
            height: 50,
            decoration: BoxDecoration(
              color: settingsProvider.isDark()?MyTheme.colorYellow:MyTheme.colorGold,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Text("${askar[currentIndex]}",style: Theme.of(context).textTheme.headline5!.copyWith(
              fontWeight: FontWeight.bold,
              color: settingsProvider.isDark()?Colors.black:Colors.white,
            ),),
          )
        ],
      ),
    );
  }
  onPressed(){
    counter++;
    angle--;
    if(counter == 34){
      currentIndex++;
      counter = 0;
    }
    if(currentIndex > askar.length-1){
      currentIndex = 0;
    }
    setState(() {});
  }
}
