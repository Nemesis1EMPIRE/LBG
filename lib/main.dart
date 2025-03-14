import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

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
           Image.asset("assets/GABONAISE.png", width: 200),
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






class VideoPage extends StatefulWidget {
  final String title; // Ajout du paramètre title
  
  VideoPage(this.title); // Constructeur prenant un titre en paramètre

  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/video.mp4')
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title), // Utilisation du titre passé en paramètre
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          _controller.value.isInitialized
              ? AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                )
              : Center(child: CircularProgressIndicator()),
          SizedBox(height: 10),
          Text(widget.title, // Affichage du titre
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          SizedBox(height: 20),
          Expanded(
            child: ListView(
              children: [
                VideoItem(
                  thumbnail: 'assets/lbvpart2.png',
                  title: "Découvrez dans cette vidéo l'histoire de Libreville Partie 2",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => VideoPage("Libreville Partie 2")),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


class VideoItem extends StatelessWidget {
  final String thumbnail;
  final String title;
  final VoidCallback onTap;

  VideoItem({required this.thumbnail, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            Image.asset(thumbnail, fit: BoxFit.cover),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}

class VideoPage2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Libreville Partie 2')),
      body: Center(child: Text('Vidéo 2 ici')), // Remplace par le player de la 2e vidéo
    );
  }
}

