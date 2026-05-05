import 'package:flutter/material.dart';
import 'package:myapp/auth_service.dart';
import 'package:myapp/book_detail_page.dart';
import 'package:myapp/book_model.dart';
import 'package:myapp/firestore_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirestoreService _firestoreService = FirestoreService();
  final AuthService _authService = AuthService();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _genreController = TextEditingController();
  final TextEditingController _publishedDateController = TextEditingController();

  void _showBookDialog({Book? book}) {
    _titleController.text = book?.title ?? '';
    _authorController.text = book?.author ?? '';
    _descriptionController.text = book?.description ?? '';
    _genreController.text = book?.genre ?? '';
    _publishedDateController.text = book?.publishedDate ?? '';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(book == null ? 'Añadir Nuevo Libro' : 'Editar Libro'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 24),
                TextField(
                    controller: _titleController,
                    decoration: const InputDecoration(labelText: 'Título')),
                const SizedBox(height: 16),
                TextField(
                    controller: _authorController,
                    decoration: const InputDecoration(labelText: 'Autor')),
                const SizedBox(height: 16),
                TextField(
                    controller: _genreController,
                    decoration: const InputDecoration(labelText: 'Género')),
                const SizedBox(height: 16),
                TextField(
                    controller: _publishedDateController,
                    decoration:
                        const InputDecoration(labelText: 'Fecha de Publicación')),
                const SizedBox(height: 16),
                TextField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(labelText: 'Descripción'),
                    maxLines: 3),
              ],
            ),
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancelar')),
            ElevatedButton(
              onPressed: () {
                final newBook = Book(
                  id: book?.id ?? '',
                  title: _titleController.text,
                  author: _authorController.text,
                  description: _descriptionController.text,
                  genre: _genreController.text,
                  publishedDate: _publishedDateController.text,
                );

                if (book == null) {
                  _firestoreService.addBook(newBook);
                } else {
                  _firestoreService.updateBook(newBook);
                }
                Navigator.pop(context);
              },
              child: const Text('Guardar'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _signOut() async {
    final BuildContext currentContext = context;
    await _authService.signOut();
    if (!currentContext.mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Libreria AJMG'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Cerrar Sesión',
            onPressed: _signOut,
          ),
        ],
      ),
      body: StreamBuilder<List<Book>>(
        stream: _firestoreService.getBooks(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
                child: Text('Aún no hay libros. ¡Añade uno!'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              Book book = snapshot.data![index];
              return BookListItem(
                book: book,
                onView: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BookDetailPage(book: book)),
                ),
                onEdit: () => _showBookDialog(book: book),
                onDelete: () => _firestoreService.deleteBook(book.id),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: _showBookDialog,
          child: const Icon(Icons.add)),
    );
  }
}

class LabelledText extends StatelessWidget {
  final String label;
  final String text;

  const LabelledText({super.key, required this.label, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: RichText(
        text: TextSpan(
          style: Theme.of(context).textTheme.bodyMedium,
          children: [
            TextSpan(
                text: label,
                style: const TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: text),
          ],
        ),
      ),
    );
  }
}

class BookListItem extends StatefulWidget {
  final Book book;
  final VoidCallback onView;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const BookListItem(
      {super.key,
      required this.book,
      required this.onView,
      required this.onEdit,
      required this.onDelete});

  @override
  State<BookListItem> createState() => _BookListItemState();
}

class _BookListItemState extends State<BookListItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final book = widget.book;
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        child: Card(
          elevation: _isHovered ? 8.0 : 2.0,
          shadowColor: _isHovered
              ? Theme.of(context).colorScheme.secondary.withAlpha(128) // Usando withAlpha
              : Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(book.title,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(fontWeight: FontWeight.bold)),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.visibility),
                          onPressed: widget.onView,
                          tooltip: 'Ver ${book.title}',
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: widget.onEdit,
                            tooltip: 'Editar ${book.title}',
                            color: Colors.blue.shade700),
                        IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: widget.onDelete,
                            tooltip: 'Eliminar',
                            color: Colors.red.shade700),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                LabelledText(label: 'Autor: ', text: book.author),
                if (book.genre != null && book.genre!.isNotEmpty)
                  LabelledText(label: 'Género: ', text: book.genre!),
                if (book.publishedDate != null && book.publishedDate!.isNotEmpty)
                  LabelledText(
                      label: 'Publicado en: ', text: book.publishedDate!),
                if (book.description != null && book.description!.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: LabelledText(
                        label: 'Descripción: ', text: book.description!),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
