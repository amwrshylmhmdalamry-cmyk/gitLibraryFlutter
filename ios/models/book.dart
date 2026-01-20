class Book {
  final String id;
  final String title;
  final String author;
  final String imageUrl;

  Book({required this.id, required this.title, required this.author, required this.imageUrl});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'imageUrl': imageUrl,
    };
  }

  factory Book.fromMap(Map<String, dynamic> map) {
    return Book(
      id: map['id'],
      title: map['title'],
      author: map['author'],
      imageUrl: map['imageUrl'],
    );
  }
}
