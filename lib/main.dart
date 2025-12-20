import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'supabase_options.dart';
import 'models/note.dart';
import 'edit_note_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeSupabase();
  runApp(const SimpleNotesApp());
}

class SimpleNotesApp extends StatelessWidget {
  const SimpleNotesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Notes',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const AuthPage(),
    );
  }
}

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isSignUp = false; // Флаг для регистрации/входа
  String? _errorMessage;

  Future<void> _authAction() async {
    try {
      if (_isSignUp) {
        await supabase.auth.signUp(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
      } else {
        await supabase.auth.signInWithPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
      }
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const NotesPage()),
        );
      }
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_isSignUp ? 'Регистрация' : 'Вход')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Пароль'),
              obscureText: true,
            ),
            if (_errorMessage != null)
              Text(_errorMessage!, style: const TextStyle(color: Colors.red)),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _authAction,
              child: Text(_isSignUp ? 'Зарегистрироваться' : 'Войти'),
            ),
            TextButton(
              onPressed: () => setState(() => _isSignUp = !_isSignUp),
              child: Text(
                _isSignUp
                    ? 'Уже есть аккаунт? Войти'
                    : 'Нет аккаунта? Зарегистрироваться',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final _supabase = supabase;
  String _searchQuery = '';

  Future<void> _addNote() async {
    final newNote = await Navigator.push<Note>(
      context,
      MaterialPageRoute(builder: (_) => const EditNotePage()),
    );

    if (newNote != null) {
      await _supabase.from('notes').insert({
        'user_id': _supabase.auth.currentUser!.id,
        'title': newNote.title,
        'body': newNote.body,
      });
    }
  }

  Future<void> _editNote(Note note) async {
    final updated = await Navigator.push<Note>(
      context,
      MaterialPageRoute(builder: (_) => EditNotePage(existing: note)),
    );

    if (updated != null) {
      await _supabase
          .from('notes')
          .update({'title': updated.title, 'body': updated.body})
          .eq('id', note.id);
    }
  }

  void _deleteNote(Note note) async {
    await _supabase.from('notes').delete().eq('id', note.id);
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Заметка удалена')));
  }

  Widget _buildNoteItem(Note note) {
    return Dismissible(
      key: ValueKey(note.id),
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      secondaryBackground: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      confirmDismiss: (direction) async {
        return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Удалить заметку?'),
            content: Text('Вы уверены, что хотите удалить "${note.title}"?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Отмена'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text(
                  'Удалить',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
        );
      },
      onDismissed: (direction) => _deleteNote(note),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: ListTile(
          contentPadding: const EdgeInsets.all(16),
          leading: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.note, color: Colors.blue.shade700),
          ),
          title: Text(
            note.title.isEmpty ? '(без названия)' : note.title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              Text(note.body, maxLines: 2, overflow: TextOverflow.ellipsis),
              const SizedBox(height: 8),
              Text(
                'ID: ${note.id}',
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
              ),
            ],
          ),
          trailing: IconButton(
            icon: const Icon(Icons.delete_outline, color: Colors.red),
            onPressed: () => _deleteNote(note),
          ),
          onTap: () => _editNote(note),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Проверка аутентификации
    if (_supabase.auth.currentUser == null) {
      return const AuthPage();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Simple Notes'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: _NotesSearchDelegate(_editNote),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await _supabase.auth.signOut();
              if (mounted) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const AuthPage()),
                );
              }
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNote,
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: _supabase
            .from('notes')
            .stream(primaryKey: ['id'])
            .eq('user_id', _supabase.auth.currentUser!.id)
            .order('created_at', ascending: false),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Ошибка загрузки заметок'));
          }
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final notes = snapshot.data!.map((map) => Note.fromMap(map)).toList();

          final filteredNotes = _searchQuery.isEmpty
              ? notes
              : notes
                    .where(
                      (note) =>
                          note.title.toLowerCase().contains(
                            _searchQuery.toLowerCase(),
                          ) ||
                          note.body.toLowerCase().contains(
                            _searchQuery.toLowerCase(),
                          ),
                    )
                    .toList();

          if (filteredNotes.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.note_add, size: 64, color: Colors.grey.shade400),
                  const SizedBox(height: 16),
                  const Text(
                    'Пока нет заметок',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Нажмите + чтобы добавить первую заметку',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            itemCount: filteredNotes.length,
            itemBuilder: (context, index) =>
                _buildNoteItem(filteredNotes[index]),
          );
        },
      ),
    );
  }
}

class _NotesSearchDelegate extends SearchDelegate {
  final Function(Note) onEditNote;

  _NotesSearchDelegate(this.onEditNote);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildSearchResults();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildSearchResults();
  }

  Widget _buildSearchResults() {
    final supabase = Supabase.instance.client;
    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: supabase
          .from('notes')
          .stream(primaryKey: ['id'])
          .eq('user_id', supabase.auth.currentUser!.id),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return const Center(child: CircularProgressIndicator());

        final notes = snapshot.data!
            .map((map) => Note.fromMap(map))
            .where(
              (note) =>
                  note.title.toLowerCase().contains(query.toLowerCase()) ||
                  note.body.toLowerCase().contains(query.toLowerCase()),
            )
            .toList();

        if (notes.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.search_off, size: 64, color: Colors.grey.shade400),
                const SizedBox(height: 16),
                Text(
                  'Ничего не найдено для "$query"',
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          itemCount: notes.length,
          itemBuilder: (context, index) {
            final note = notes[index];
            return ListTile(
              leading: const Icon(Icons.note),
              title: Text(note.title.isEmpty ? '(без названия)' : note.title),
              subtitle: Text(
                note.body,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              onTap: () {
                close(context, null);
                onEditNote(note);
              },
            );
          },
        );
      },
    );
  }
}
