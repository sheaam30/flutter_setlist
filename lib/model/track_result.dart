enum ImageSize { small, medium, large, extralarge }

class TrackResult {
  String name;
  String artist = "";
  String imageUrl;

  TrackResult(this.name, this.artist, this.imageUrl);
}

class SearchResult {
  static const TARGET_IMAGE_SIZE = "medium";

  List<TrackResult> searchItems;

  SearchResult(this.searchItems);

  static SearchResult fromJson(Map<String, dynamic> responseJson) {
    List<TrackResult> searchItems = List();

    List trackList = responseJson['results']['trackmatches']['track'];

    for (int i = 0; i < trackList.length; i++) {
      searchItems.add(TrackResult(
          trackList.elementAt(i)['name'],
          trackList.elementAt(i)['artist'],
          getTrackImageUrl(trackList.elementAt(i)['image'])));
    }
    return SearchResult(searchItems);
  }

  static String getTrackImageUrl(List trackImages) {
    String returnUrl;

    for (int i = 0; i < trackImages.length; i++) {
      if (trackImages.elementAt(i)['size'] == TARGET_IMAGE_SIZE) {
        returnUrl = trackImages.elementAt(i)['#text'];
      }
    }

    if (returnUrl == null || returnUrl.isEmpty) {
      returnUrl = trackImages.elementAt(0)['#text'];
    }

    return returnUrl;
  }
}
