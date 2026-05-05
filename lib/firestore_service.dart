import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/book_model.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Obtener un stream de la lista de libros
  Stream<List<Book>> getBooks() {
    return _db.collection('books').snapshots().map((snapshot) => 
      snapshot.docs.map((doc) => Book.fromFirestore(doc)).toList()
    );
  }

  // Añadir un nuevo libro
  Future<void> addBook(Book book) {
    return _db.collection('books').add(book.toJson());
  }

  // Actualizar un libro existente
  Future<void> updateBook(Book book) {
    return _db.collection('books').doc(book.id).update(book.toJson());
  }

  // Borrar un libro
  Future<void> deleteBook(String bookId) {
    return _db.collection('books').doc(bookId).delete();
  }
}
