import 'package:flowery_rider_app/app/feature/home_tab/data/models/product_dto.dart';
import 'package:test/test.dart';
void main() {
  group('ProductDto test cases', () {
    test('fromJson should parse all fields', () {
      final json={
        "_id":'id1',
        "title":"title1",
        "slug":"slug1",
        "description":"description1",
        "imgCover":"imgCover1",
        "images":['img1','img2'],
        "price":400,
        "priceAfterDiscount":380,
        "quantity":1,
        "category":"category1",
        "occasion":"occasion1",
        "__v":1,
        "sold":50,
        "isSuperAdmin":true,
        "rateAvg":50,
        "rateCount":5
      };
      final dto=ProductDTO.fromJson(json);
      expect(dto.id, equals(json['_id']));
      expect(dto.title, equals(json['title']));
      expect(dto.slug, equals(json['slug']));
      expect(dto.description, equals(json['description']));
      expect(dto.imgCover, equals(json['imgCover']));
      expect(dto.images?.length, equals((json['images'] as List).length));
      expect(dto.images![0], equals((json['images'] as List)[0]));
      expect(dto.images![1], equals((json['images'] as List)[1]));
      expect(dto.price, equals(json['price']));
      expect(dto.priceAfterDiscount, equals(json['priceAfterDiscount']));
      expect(dto.quantity, equals(json['quantity']));
      expect(dto.category, equals(json['category']));
      expect(dto.occasion, equals(json['occasion']));
      expect(dto.v, equals(json['__v']));
      expect(dto.sold, equals(json['sold']));
      expect(dto.isSuperAdmin, equals(json['isSuperAdmin']));
      expect(dto.rateAvg, equals(json['rateAvg']));
      expect(dto.rateCount, equals(json['rateCount']));
    },);
    test('toDomain should map all relevant fields', () {
      final dto=ProductDTO(
        id:'id1',
        title: 'title1',
        slug: 'slug1',
        description: 'description1',
        imgCover: 'imgCover1',
        images: ['img1','img2'],
        price: 300,
        priceAfterDiscount: 290,
        quantity: 4,
        category: 'category1',
        occasion: 'occasion1',
        createdAt: DateTime(2026,3,5),
        updatedAt: DateTime(2026,3,6),
        v: 1,
        sold: 37,
        isSuperAdmin: true,
        rateAvg: 50,
        rateCount: 5
      );
      final model=dto.toDomain();
      expect(model.productId, equals(dto.id));
      expect(model.productImage, equals('https://flower.elevateegy.com/uploads/${dto.imgCover}'));
      expect(model.productName, equals(dto.title));
      expect(model.productPrice, equals(dto.price));
    },);
    test('toJson should serialize all fields', () {
      final dto=ProductDTO(
        id:'id1',
        title: 'title1',
        slug: 'slug1',
        description: 'description1',
        imgCover: 'imgCover1',
        images: ['img1','img2'],
        price: 300,
        priceAfterDiscount: 290,
        quantity: 4,
        category: 'category1',
        occasion: 'occasion1',
        createdAt: DateTime(2026,3,5),
        updatedAt: DateTime(2026,3,6),
        v: 1,
        sold: 37,
        isSuperAdmin: true,
        rateAvg: 50,
        rateCount: 5
      );
      final json=dto.toJson();
      expect(json['_id'], equals(dto.id));
      expect(json['title'], equals(dto.title));
      expect(json['slug'], equals(dto.slug));
      expect(json['description'], equals(dto.description));
      expect(json['imgCover'], equals(dto.imgCover));
      expect((json['images'] as List).length, equals(dto.images?.length));
      expect((json['images'] as List)[0], equals(dto.images![0]));
      expect((json['images'] as List)[1], equals(dto.images![1]));
      expect(json['price'], equals(dto.price));
      expect(json['priceAfterDiscount'], equals(dto.priceAfterDiscount));
      expect(json['quantity'], equals(dto.quantity));
      expect(json['category'], equals(dto.category));
      expect(json['occasion'], equals(dto.occasion));
      expect(json['createdAt'], equals(dto.createdAt?.toIso8601String()));
      expect(json['updatedAt'], equals(dto.updatedAt?.toIso8601String()));
      expect(json['__v'], equals(dto.v));
      expect(json['sold'], equals(dto.sold));
      expect(json['isSuperAdmin'], equals(dto.isSuperAdmin));
      expect(json['rateAvg'], equals(dto.rateAvg));
      expect(json['rateCount'], equals(dto.rateCount));
    },);
  },);
}