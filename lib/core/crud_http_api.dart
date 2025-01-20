import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:todoey/models/todo_model.dart';

class TodoServiceHttp {
  factory TodoServiceHttp() {
    return instance;
  }

  TodoServiceHttp._internal();
  static final TodoServiceHttp instance = TodoServiceHttp._internal();

  static const String _baseUrl = 'https://api.nstack.in/v1/todos';

  /// GET /v1/todos
  /// Fetch all todos //
  static Future<List<Todo>> fetchTodos() async {
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      final bodyResponse = jsonDecode(response.body);
      final List decoded = bodyResponse['items'];
      return decoded.map((json) => Todo.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load todos (status: ${response.statusCode})');
    }
  }

  /// GET /v1/todos/{id}
  /// Fetch a single todo by its ID
  static Future<Todo> fetchTodoById(String id) async {
    final url = '$_baseUrl/$id';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic> decoded = jsonDecode(response.body);
      return Todo.fromJson(decoded);
    } else {
      throw Exception(
          'Failed to fetch todo $id (status: ${response.statusCode})');
    }
  }

  /// POST /v1/todos
  /// Create a new todo
  static Future<Todo> createTodo(Todo newTodo) async {
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(newTodo.toJson()),
    );

    if (response.statusCode == 201) {
      final Map<String, dynamic> decoded = jsonDecode(response.body);
      return Todo.fromJson(decoded);
    } else {
      throw Exception('Failed to create todo (status: ${response.statusCode})');
    }
  }

  /// PUT /v1/todos/{id}
  /// Update an existing todo
  static Future<Todo> updateTodo(String id, Todo updatedTodo) async {
    final url = '$_baseUrl/$id';
    final response = await http.put(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(updatedTodo.toJson()),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> decoded = jsonDecode(response.body);
      return Todo.fromJson(decoded);
    } else {
      throw Exception('Failed to update todo (status: ${response.statusCode})');
    }
  }

  /// DELETE /v1/todos/{id}
  /// Delete a todo by its ID
  static Future<void> deleteTodoById(String id) async {
    final url = '$_baseUrl/$id';
    final response = await http.delete(Uri.parse(url));

    if (response.statusCode != 200) {
      throw Exception('Failed to delete todo (status: ${response.statusCode})');
    }
  }
}
