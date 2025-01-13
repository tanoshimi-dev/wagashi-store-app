class Product {
  final int productId;
  final String name;
  final String description;
  final int price;

  const Product({
    required this.productId,
    required this.name,
    required this.description,
    required this.price,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'productId': int productId,
        'name': String name,
        'description': String description,
        'price': int price,
      } =>
        Product(
          productId: productId,
          name: name,
          description: description,
          price: price,
        ),
      _ => throw const FormatException('Failed to load Menu.'),
    };
  }

  get id => null;
}
