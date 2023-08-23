import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';


class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("About",
        style: TextStyle(
          color: Colors.black,
        ),),
        centerTitle: true,
        leading: IconButton(onPressed: (){
          Navigator.pop(context);

        }, icon:const Icon(Icons.arrow_back,
        color: Colors.black,
        ),
        ),
      ),
      body: SafeArea(child:
      Padding(padding: const EdgeInsets.symmetric(
        horizontal: 10
      ),
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(width: 2,color:Colors.black),
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          height: MediaQuery.of(context).size.height*.8,
          width: MediaQuery.of(context).size.width*.8,
          child: Column(
            children: [
              Expanded(child: ListView(
                padding: const EdgeInsets.all(10),
                children: const[
                   Text(
'''Welcome to MUsic App, make your life more live.
We are dedicated to providing you the very best
 quality of sound and the music varient,with an 
 emphasis on new features. playlists and favourites,
 and a rich user experience\n\n Founded in 2023
by Safvan Ekkadan. Music app is our first major
project with a basic performance of music hub
and creates a better versions in future.Music
 World gives you the best music experience that
 you never had. it includes attractivemode of
 UI\'s and good practices.\n\nIt gives good quality
and had increased the settings to power up the
system as well as to provide better music rythms.
 \n\nWe hope you enjoy our music as much as we
 enjoy offering them to you.If you have any
 questions or comments, please don/'t hesitate
to contact us.\n\nSincerely,\n\nSafvan Ekkdan,
                  ''',)
                ],
              ))
            ],
          ),
        ),
      ),
      ),
      ),
    );
  }
}