import 'package:todoey/core/base_api.dart';
import 'package:todoey/models/todo_model.dart';

class TodoServiceDio extends BaseAPI {
  // CODE START
  factory TodoServiceDio() {
    return instance;
  }

  TodoServiceDio._internal();
  static final TodoServiceDio instance = TodoServiceDio._internal();
  // CODE END

  Future<List<Todo>> getTodos() async {
    const url = 'todos?page=1&limit=10';

    try {
      final res = await dio().get(
        url,
      );

      switch (res.statusCode) {
        case 200:
          List<Todo> dirs = [];
          for (var a in (res.data['items'] as List)) {
            dirs.add(
              Todo.fromJson(a),
            );
          }
          return dirs;

        default:
          throw error(res.data);
      }
    } catch (e) {
      log(e);
      return [];
    }
  }

  Future<bool> createTodo({
    required String title,
    required String description,
  }) async {
    const url = 'todos';

    try {
      final res = await dio('application/json').post(
        url,
        data: {
          "title": title,
          "description": description,
          "is_completed": false
        },
      );

      log(res.statusCode);
      log(res.data);

      switch (res.statusCode) {
        case 201:
          return true;

        default:
          return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateTodo({
    required String id,
    required String title,
    required String description,
    required bool isCompleted,
  }) async {
    final url = 'todos/$id';

    try {
      final res = await dio('application/json').put(
        url,
        data: {
          "title": title,
          "description": description,
          "is_completed": isCompleted,
        },
      );

      log(res.statusCode);
      log(res.data);

      switch (res.statusCode) {
        case 200:
          return true;

        default:
          return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteTodoById({required String id}) async {
    final url = 'todos/$id';

    try {
      final res = await dio('application/json').delete(
        url,
      );

      log(res.statusCode);
      log(res.data);

      switch (res.statusCode) {
        case 200:
          return true;

        default:
          return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<Todo> getTodoById({required String id}) async {
    final url = 'todos/$id';

    try {
      final res = await dio('application/json').get(
        url,
      );

      log(res.statusCode);
      log(res.data);

      switch (res.statusCode) {
        case 200:
          return Todo.fromJson((res.data as Map<String, dynamic>)['data']);

        default:
          return Todo();
      }
    } catch (e) {
      return Todo();
    }
  }
}
