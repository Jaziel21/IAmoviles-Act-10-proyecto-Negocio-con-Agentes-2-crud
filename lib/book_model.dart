import 'package:cloud_firestore/cloud_firestore.dart';

class Book {
  final String id;
  final String title;
  final String author;
  final String? description; // Campo opcional
  final String? genre;       // Campo opcional
  final String? publishedDate; // Campo opcional

  Book({
    required this.id,
    required this.title,
    required this.author,
    this.description,
    this.genre,
    this.publishedDate,
  });

  // Convertir el objeto Book a un mapa para Firestore (sin el id)
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'author': author,
      'description': description,
      'genre': genre,
      'publishedDate': publishedDate,
    };
  }

  // Crear un objeto Book a partir de un DocumentSnapshot de Firestore
  factory Book.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Book(
      id: doc.id,
      title: data['title'] ?? '',
      author: data['author'] ?? '',
      description: data['description'] as String?,
      genre: data['genre'] as String?,
      publishedDate: data['publishedDate'] as String?,
    );
  }
}
