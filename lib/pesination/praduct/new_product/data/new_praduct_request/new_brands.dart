class NewCategoryAndBrandRequest {
  final String image;
  final String name;

  NewCategoryAndBrandRequest({
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
