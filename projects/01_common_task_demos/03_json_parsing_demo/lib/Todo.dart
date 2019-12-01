class Todo {
    bool completed;
    String dueDate;
    int id;
    List<String> tags;
    String title;

    Todo({this.completed, this.dueDate, this.id, this.tags, this.title});

    factory Todo.fromJson(Map<String, dynamic> json) {
        return Todo(
            completed: json['completed'], 
            dueDate: json['dueDate'], 
            id: json['id'], 
            tags: json['tags'] != null ? new List<String>.from(json['tags']) : null, 
            title: json['title'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['completed'] = this.completed;
        data['dueDate'] = this.dueDate;
        data['id'] = this.id;
        data['title'] = this.title;
        if (this.tags != null) {
            data['tags'] = this.tags;
        }
        return data;
    }
}