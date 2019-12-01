import 'Todo.dart';

class Todos {
    List<Todo> todos;

    Todos({this.todos});

    factory Todos.fromJson(Map<String, dynamic> json) {
        return Todos(
            todos: json['todos'] != null ? (json['todos'] as List).map((i) => Todo.fromJson(i)).toList() : null, 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        if (this.todos != null) {
            data['todos'] = this.todos.map((v) => v.toJson()).toList();
        }
        return data;
    }
}