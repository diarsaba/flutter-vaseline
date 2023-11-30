class BookInfo {
  String title;
  String description;
  String timestamp;
  //List<int> timeaverage;
  String image;
  int words;

  BookInfo({
    required this.title,
    required this.description,
    required this.timestamp,
    //required this.timeaverage,
    required this.image,
    required this.words,
  });

  BookInfo.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        description = json['description'],
        image = json['image'],
        words = json['words'],
        timestamp = json['timestamp'];

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'words': words,
      'image': image,
      'timestamp': timestamp,
    };
  }
}
