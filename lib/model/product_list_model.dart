class ProductListModel {
  List<ProductList>? productList;

  ProductListModel({this.productList});

  ProductListModel.fromJson(List json) {
    if (json != null) {
      productList = <ProductList>[];
      json.forEach((v) {
        productList!.add(ProductList.fromJson(v));
      });
    }
  }
}

class ProductList {
  int? id;
  String? title;
  double? price;
  String? description;
  String? category;
  String? image;
  Rating? rating;

  ProductList(
      {this.id,
      this.title,
      this.price,
      this.description,
      this.category,
      this.image,
      this.rating});

  ProductList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    price = double.tryParse(json['price'].toString()) != null
        ? double.parse(json['price'].toString())
        : 0.0;
    description = json['description'];
    category = json['category'];
    image = json['image'];
    rating =
        json['rating'] != null ? new Rating.fromJson(json['rating']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['price'] = this.price;
    data['description'] = this.description;
    data['category'] = this.category;
    data['image'] = this.image;
    if (this.rating != null) {
      data['rating'] = this.rating!.toJson();
    }
    return data;
  }
}

class Rating {
  double? rate;
  int? count;

  Rating({this.rate, this.count});

  Rating.fromJson(Map<String, dynamic> json) {
    rate = double.tryParse(json['rate'].toString()) != null
        ? double.parse(json['rate'].toString())
        : 0.0;
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rate'] = this.rate;
    data['count'] = this.count;
    return data;
  }
}
