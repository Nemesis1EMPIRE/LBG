import 'package:flutter/material.dart';

void main() {
  runApp(BibliothequeGabonaiseApp());
}

class BibliothequeGabonaiseApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bibliothèque Gabonaise',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
 final List<Map<String, String>> items = [
  {"image": "assets/1.png", "route": "story"},
  {"image": "assets/2.png", "route": "environ"},
  {"image": "assets/3.png", "route": "faune"},
  {"image": "assets/4.png", "route": "flore"},
];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Fond blanc
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 4,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset("assets/photo.png", height: 50), // Logo à gauche
            Image.asset("assets/GABONAISE.png", width: 200), // Image au centre
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
              child: Image.asset("assets/banner.png", fit: BoxFit.cover),
            ),
            SizedBox(height: 15),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: items.map((item) {
                    return GestureDetector(
                      onTap: () {
                          Widget page;
                          switch (item["route"]) {
                            case "story":
                              page = StoryPage();
                              break;
                            default:
                              page = DetailPage(item["route"]!);
                          }
                        
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => page),
                          );
                        },

                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(item["image"]!, fit: BoxFit.cover),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  final String pageName;
  DetailPage(this.pageName);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(pageName.toUpperCase())),
      body: Center(
        child: Text("Page $pageName en construction..."),
      ),
    );
  }
}

class StoryPage extends StatelessWidget {
  const StoryPage({super.key});

  final List<Map<String, String>> videos = const [
    {
      "image": "assets/lbvpart1.png",
      "title": "Découvrez dans cette vidéo l'histoire de Libreville Partie 1",
      "route": "play_video1"
    },
    {
      "image": "assets/lbvpart2.png",
      "title": "Découvrez dans cette vidéo l'histoire de Libreville Partie 2",
      "route": "play_video2"
    },
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 4,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset("assets/photo.png", height: 50),
            Row(
              children: [
                IconButton(
                  icon: Image.asset("assets/3.png"),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Image.asset("assets/4.png"),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Image.asset("assets/1.png"),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Image.asset("assets/2.png"),
                  onPressed: () {},
                ),
              ],
            )
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset("assets/banner.png", fit: BoxFit.cover),
            ),
            SizedBox(height: 15),
            Expanded(
              child: ListView.builder(
                itemCount: videos.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => VideoPage(videos[index]["title"]!),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(videos[index]["image"]!, fit: BoxFit.cover),
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Image.asset("assets/photo(1).png", width: 35),
                              SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  videos[index]["title"]!,
                                  style: TextStyle(fontSize: 13, color: Colors.black),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class VideoPage extends StatelessWidget {
  final String title;
  VideoPage(this.title);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Text("Lecture de la vidéo en cours..."),
      ),
    );
  }
}
