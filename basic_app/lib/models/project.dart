class Project {
  final int id;
  final String title;
  final String description;

  Project({
    this.id = 0,
    required this.title,
    required this.description,
  });

  @override
  String toString() {
    return 'Project{title: $title, description: $description}';
  }
}
