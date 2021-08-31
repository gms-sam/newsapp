import 'dart:convert';

import 'package:flutter/foundation.dart';

class CategoriesList {
  final int currentPage;
  final List<Category> data;
  CategoriesList({
    required this.currentPage,
    required this.data,
  });

  Map<String, dynamic> toMap() {
    return {
      'current_page': currentPage,
      'data': data.map((x) => x.toMap()).toList(),
    };
  }

  factory CategoriesList.fromMap(Map<String, dynamic> map) {
    return CategoriesList(
      currentPage: map['current_page'],
      data: List<Category>.from(map['data']?.map((x) => Category.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoriesList.fromJson(String source) => CategoriesList.fromMap(json.decode(source));

  @override
  String toString() => 'CategoriesList(currentPage: $currentPage, data: $data)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is CategoriesList &&
      o.currentPage == currentPage &&
      listEquals(o.data, data);
  }

  @override
  int get hashCode => currentPage.hashCode ^ data.hashCode;
}

class Category {
  final int id;
  final String name;
  final String slug;
  final String createdAt;
  final String updatedAt;
  final String deletedAt;
  Category({
   required this.id,
   required this.name,
   required this.slug,
   required this.createdAt,
   required this.updatedAt,
   required this.deletedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'slug': slug,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'deleted_at': deletedAt,
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'] ?? "",
      slug: map["slug"]?? "",
      name: map['name'] ?? "",
      createdAt: map['created_at']?? "",
      updatedAt: map['updated_at']?? "",
      deletedAt: map['deleted_at']?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory Category.fromJson(String source) => Category.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Category(id: $id, name: $name, slug: $slug, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt)';
  }
}
