import 'package:dawn/api_manager.dart';
import 'package:dawn/globals/globals.dart';
import 'package:dawn/models/model_story.dart';
import 'package:dawn/screens/screen_description/screen_description.dart';
import 'package:dawn/utils/utils.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int categoryIndex = 0;
  List<ModelStory> stories = [];
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    getTribuneNews();
    
  }



  getTribuneNews() async {
    stories = (await ApiService().getNews("home"));
    Future.delayed(const Duration(seconds: 1))
        .then((value) => setState(() => {}));
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark; 
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Image.asset(
                isDarkMode
                ? "assets/tribune-logo-dark-mode.png"
                : "assets/tribune-logo.png",
                
                fit: BoxFit.contain,
              )
            ),

            //Home category
            ListTile(
              title: const Text('Home'),
              onTap: () async {
                stories = (await ApiService().getNews("home"));
                if (mounted) {
                  setState(() {
                    Navigator.pop(context);
                    categoryIndex = 0;
                    scrollToTopInstantly(_controller);
                  });
                }
              },
            ),

            //Business category
            ListTile(
              title: const Text('Business'),
              onTap: () async {
                stories = (await ApiService().getNews("business"));
                if (mounted) {
                  setState(() {
                    Navigator.pop(context);
                    categoryIndex = 1;
                    scrollToTopInstantly(_controller);
                  });
                }
              },
            ),

            //World category
            ListTile(
              title: const Text('World'),
              onTap: () async {
                stories = (await ApiService().getNews("world"));
                if (mounted) {
                  setState(() {
                    Navigator.pop(context);
                    categoryIndex = 2;
                    scrollToTopInstantly(_controller);
                  });
                }
              },
            ),

            //Sports category
            ListTile(
              title: const Text('Sports'),
              onTap: () async {
                stories = (await ApiService().getNews("sports"));
                if (mounted) {
                  setState(() {
                    Navigator.pop(context);
                    categoryIndex = 3;
                    scrollToTopInstantly(_controller);
                  });
                }
              },
            ),

            //Opinion category
            ListTile(
              title: const Text('Opinion'),
              onTap: () async {
                stories = (await ApiService().getNews("opinion"));
                if (mounted) {
                  setState(() {
                    Navigator.pop(context);
                    categoryIndex = 4;
                    scrollToTopInstantly(_controller);
                  });
                }
              },
            ),

            //TV category
            ListTile(
              title: const Text('TV'),
              onTap: () async {
                stories = (await ApiService().getNews("tv"));
                if (mounted) {
                  setState(() {
                    Navigator.pop(context);
                    categoryIndex = 5;
                    scrollToTopInstantly(_controller);
                  });
                }
              },
            ),

            //Latest Category
            ListTile(
              title: const Text('Latest'),
              onTap: () async {
                stories = (await ApiService().getNews("latest"));
                if (mounted) {
                  setState(() {
                    Navigator.pop(context);
                    categoryIndex = 6;
                    scrollToTopInstantly(_controller);
                  });
                }
              },
            ),

            //Analysis Category
            ListTile(
              title: const Text('Analysis'),
              onTap: () async {
                stories = (await ApiService().getNews("analysis"));
                if (mounted) {
                  setState(() {
                    Navigator.pop(context);
                    categoryIndex = 7;
                    scrollToTopInstantly(_controller);
                  });
                }
              },
            ),
          ],
        ),
      ),

      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.only(left: MediaQuery.sizeOf(context).width*0.12),  
          child: Image.asset(
                isDarkMode
                ? "assets/tribune-logo-dark-mode.png"
                : "assets/tribune-logo.png",
                width: MediaQuery.sizeOf(context).width * 0.4,
                fit: BoxFit.contain,
              )
        ),
        actions: [
          IconButton(onPressed: (){
            ThemeData.dark();
          }, icon: Icon(Icons.dark_mode))
        ],
      ),

      body: Column(
        children: [
          Center(
            child: Text(
              categories[categoryIndex],
              
              style: const TextStyle(fontSize: 20, ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              controller: _controller,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => {
                      (Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ScreenDescription(stories: stories[index]))))
                    },
                    child: Stack(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.2,
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            gradient: const LinearGradient(
                                colors: [Colors.black, Colors.transparent],
                                stops: [0.6, 1],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter),
                            image: DecorationImage(
                              opacity: 0.7,
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                stories[index].imageURL.toString(),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 50,
                          left: 18,
                          width: 350,
                          child: Text(
                            stories[index].title.toString(),
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                        Positioned(
                          bottom: 15,
                          right: 15,
                          child: Text(
                            stories[index].date.toString(),
                            textAlign: TextAlign.right,
                            style: kCardTextColor,
                          ),
                        )
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(
                      height: 5,
                    ),
                itemCount: stories.length),
          ),
        ],
      ),
    );
  }
}
