import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:music/screen/splash/splash_screen.dart';
import 'package:music/screen/widget/settings_screens/reset.dart';
import 'package:music/screen/widget/settings_screens/settings_about.dart';
import 'package:music/screen/widget/settings_screens/settings_privacy.dart';
import 'package:music/screen/widget/settings_screens/term&condi.dart';
import 'package:music/screen/widget/songcontroller/song_controller.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Settings",style: TextStyle(
          color: Colors.black,
        ),),
        centerTitle: true,
        leading: IconButton(onPressed:(){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back,
        color: Colors.black,
        
        ),
        ),
      ),
      body: SafeArea(
        child:Padding(padding: EdgeInsets.symmetric(
          horizontal: 20),
          child: Column(
            children: [
              Expanded(flex: 5,
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height* .03,
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.info,
                      color:Colors.black,),
                       onTap: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>AboutScreen())),
                      title: Text("About Us",
                      style: TextStyle(
                        color: Colors.black,
                      ),),
                      

                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .02,
                  ),
                   ListTile(
                      leading: const Icon(Icons.share,color:Colors.black,),
                    
                    title: const Text('Share',style: TextStyle(color:Colors.black),),
                    onTap: () {
                    }
                  ),
                  SizedBox(
                      height: MediaQuery.of(context).size.height * .02,
                    ),
                    ListTile(
                      leading:const Icon(Icons.lock,color:Colors.black,),
                       onTap: () =>Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>PrivacyScreen())),
                      title: const Text(
                        'Privacy And Policy',
                        style: TextStyle(color:Colors.black),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .02,
                    ),
                    ListTile(
                      leading:const Icon(Icons.text_snippet,color:Colors.black,),
                       onTap: () =>Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>TermsAndCondition())),
                      title: const Text(
                        'Terms And Condition',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height*.02,
                    ),
                    ListTile(
                      leading:const  Icon(Icons.restart_alt_rounded,
                      color: Colors.black,),
                      title: const Text("Reset",
                      style: TextStyle(color: Colors.black),),
                      onTap: () {
                        showDialog(
                          context: context,
                           builder: (context){
                            return   AlertDialog(
                              backgroundColor: Colors.grey,
                              title: const  Text("Reset Music App",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),),
                              content:const  Text("Are you sure do you want to reset the App?\nYour saved data will be erased. ",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 17
                              ),),
                              actions: [
                             TextButton(onPressed: (){
                              Navigator.pop(context);
                             }, child:const  Text("No")),
                             TextButton(onPressed: (){
                              reset(context);
                              SongController.audioPlayer.stop();
                              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>const SplashScreen(),), (route) => false);
                             }, child:const  Text("Yes",
                             style: TextStyle(color: Colors.red),
                             ),
                             ),
                              ],
                            );
                           });
                        
                      },
                    ),
                ],
              ),)
            ],
          ),
        )),
    );
  }
}