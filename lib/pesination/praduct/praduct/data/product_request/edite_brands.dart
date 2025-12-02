class EditeCategoryRequest {
  final String image;
  final String name;

  EditeCategoryRequest({
    required this.image,
    required this.name,
  });

  Map<String, dynamic> toJson() {
    return {
      "image": image,
      "name": name,
    };
  }
}
