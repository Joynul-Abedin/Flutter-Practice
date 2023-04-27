class ProductDataModel {
  final int albumId;
  final int id;
  final String title;
  final String thumbnailUrl;
  final String url;

  ProductDataModel({
    required this.albumId,
    required this.id,
    required this.title,
    required this.thumbnailUrl,
    required this.url,
  });

  factory ProductDataModel.fromMap(Map<String, dynamic> map) {
    return ProductDataModel(
      albumId: map['albumId'],
      id: map['id'],
      title: map['title'],
      thumbnailUrl: map['thumbnailUrl'],
      url: map['url'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'albumId': albumId,
      'id': id,
      'title': title,
      'thumbnailUrl': thumbnailUrl,
      'url': url,
    };
  }
}
