import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LearningPage extends StatefulWidget {
  @override
  _LearningPageState createState() => _LearningPageState();
}

class _LearningPageState extends State<LearningPage> {
  List<Map<String, String>> videos = [
    {'title': 'Waste Management 101', 'url': 'https://www.youtube.com/watch?v=p4l4ipDHscU', 'category': 'Basics'},
    {'title': 'Recycling Tips', 'url': 'https://www.youtube.com/watch?v=1e6-R6Vvtog', 'category': 'Recycling'},
    {'title': 'Composting at Home', 'url': 'https://www.youtube.com/watch?v=_K25WjjCBuw', 'category': 'Composting'},
  ];

  List<String> watchedVideos = [];
  String selectedCategory = 'All';
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    _loadWatchedVideos();
  }

  Future<void> _loadWatchedVideos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      watchedVideos = prefs.getStringList('watchedVideos') ?? [];
    });
  }

  Future<void> _markAsWatched(String videoTitle) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      watchedVideos.add(videoTitle);
      prefs.setStringList('watchedVideos', watchedVideos);
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> filteredVideos = videos.where((video) {
      return (selectedCategory == 'All' || video['category'] == selectedCategory) &&
          video['title']!.toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Learning Hub'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            _buildCategoryFilter(),
            _buildSearchBar(),
            Expanded(
              child: ListView.builder(
                itemCount: filteredVideos.length,
                itemBuilder: (context, index) {
                  return _buildVideoCard(filteredVideos[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryFilter() {
    return DropdownButton<String>(
      value: selectedCategory,
      onChanged: (newValue) {
        setState(() {
          selectedCategory = newValue!;
        });
      },
      items: ['All', 'Basics', 'Recycling', 'Composting']
          .map((category) => DropdownMenuItem(
                child: Text(category),
                value: category,
              ))
          .toList(),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        decoration: InputDecoration(
          labelText: 'Search Videos',
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.search),
        ),
        onChanged: (query) {
          setState(() {
            searchQuery = query;
          });
        },
      ),
    );
  }

  Widget _buildVideoCard(Map<String, String> video) {
    String videoId = YoutubePlayer.convertUrlToId(video['url']!)!;
    YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: YoutubePlayerFlags(autoPlay: false, mute: false),
    );

    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(video['title']!, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            YoutubePlayer(controller: _controller),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(
                    watchedVideos.contains(video['title']) ? Icons.check_circle : Icons.check_circle_outline,
                    color: Colors.green,
                  ),
                  onPressed: () => _markAsWatched(video['title']!),
                ),
                IconButton(
                  icon: Icon(Icons.download, color: Colors.blue),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Download feature coming soon!')),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
