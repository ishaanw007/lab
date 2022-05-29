class ProductDescription {
  late String productId;
  late int quantity;
  late String price;

   late String url;
   late String name;

  ProductDescription(
    this.productId,
    this.quantity, this.price, this.url, this.name,
  );

  Map<String, dynamic> toJSON() {
    return {
      "productId": productId,
      "quantity": quantity,
      "price":price,
       "url":url,
       "name":name
    };
  }
}
