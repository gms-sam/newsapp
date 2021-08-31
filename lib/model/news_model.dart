import 'dart:convert';

import 'package:flutter/foundation.dart';

class NewsModel {
  final int currentPage;
  final List<Data> data;
  final String firstPageUrl;
  final int from;
  final int lastPage;
  final String lastPageUrl;
  final List<Link> links;
  final String nextPageUrl;
  final String path;
  final int perPage;
  final String prevPageUrl;
  final int to;
  final int total;
  NewsModel({
    required this.currentPage,
    required this.data,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    required this.links,
    required this.nextPageUrl,
    required this.path,
    required this.perPage,
    required this.prevPageUrl,
    required this.to,
    required this.total,
  });

  NewsModel copyWith({
    required int currentPage,
    required List<Data> data,
    required String firstPageUrl,
    required int from,
    required int lastPage,
    required String lastPageUrl,
    required List<Link> links,
    required String nextPageUrl,
    required String path,
    required int perPage,
    required String prevPageUrl,
    required int to,
    required int total,
  }) {
    return NewsModel(
      currentPage: currentPage,
      data: data,
      firstPageUrl: firstPageUrl,
      from: from,
      lastPage: lastPage,
      lastPageUrl: lastPageUrl,
      links: links,
      nextPageUrl: nextPageUrl,
      path: path,
      perPage: perPage,
      prevPageUrl: prevPageUrl,
      to: to,
      total: total,
    );
  }

  NewsModel merge(NewsModel model) {
    return NewsModel(
      currentPage: model.currentPage,
      data: model.data,
      firstPageUrl: model.firstPageUrl,
      from: model.from,
      lastPage: model.lastPage,
      lastPageUrl: model.lastPageUrl,
      links: model.links,
      nextPageUrl: model.nextPageUrl,
      path: model.path,
      perPage: model.perPage,
      prevPageUrl: model.prevPageUrl,
      to: model.to,
      total: model.total,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'current_page': currentPage,
      'data': data.map((x) => x.toMap()).toList(),
      'first_page_url': firstPageUrl,
      'from': from,
      'last_page': lastPage,
      'last_page_url': lastPageUrl,
      'links': links.map((x) => x.toMap()).toList(),
      'next_page_url': nextPageUrl,
      'path': path,
      'per_page': perPage,
      'prev_page_url': prevPageUrl,
      'to': to,
      'total': total,
    };
  }

  factory NewsModel.fromMap(Map<String, dynamic> map) {
  
    return NewsModel(
      currentPage: map['current_page']?.toInt(),
      data: List<Data>.from(map['data']?.map((x) => Data.fromMap(x))),
      firstPageUrl: map['first_page_url'],
      from: map['from']?.toInt(),
      lastPage: map['last_page']?.toInt(),
      lastPageUrl: map['last_page_url'],
      links: List<Link>.from(map['links']?.map((x) => Link.fromMap(x))),
      nextPageUrl: map['next_page_url'] ?? 
      '',
      path: map['path'],
      perPage: map['per_page']?.toInt(),
      prevPageUrl: map['prev_page_url']??"",
      to: map['to']?.toInt(),
      total: map['total']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory NewsModel.fromJson(String source) => NewsModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'NewsModel(currentPage: $currentPage, data: $data, firstPageUrl: $firstPageUrl, from: $from, lastPage: $lastPage, lastPageUrl: $lastPageUrl, links: $links, nextPageUrl: $nextPageUrl, path: $path, perPage: $perPage, prevPageUrl: $prevPageUrl, to: $to, total: $total)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is NewsModel &&
      o.currentPage == currentPage &&
      listEquals(o.data, data) &&
      o.firstPageUrl == firstPageUrl &&
      o.from == from &&
      o.lastPage == lastPage &&
      o.lastPageUrl == lastPageUrl &&
      listEquals(o.links, links) &&
      o.nextPageUrl == nextPageUrl &&
      o.path == path &&
      o.perPage == perPage &&
      o.prevPageUrl == prevPageUrl &&
      o.to == to &&
      o.total == total;
  }

  @override
  int get hashCode {
    return currentPage.hashCode ^
      data.hashCode ^
      firstPageUrl.hashCode ^
      from.hashCode ^
      lastPage.hashCode ^
      lastPageUrl.hashCode ^
      links.hashCode ^
      nextPageUrl.hashCode ^
      path.hashCode ^
      perPage.hashCode ^
      prevPageUrl.hashCode ^
      to.hashCode ^
      total.hashCode;
  }
}

class Data {
  final int id;
  final String heading;
  final String slug;
  final String excerpt;
  final String content;
  final String image;
  final int userId;
  final int categoryId;
  final int?cityId;
  final String createdAt;
  final String updatedAt;
  Data({
    required this.id,
    required this.heading,
    required this.slug,
    required this.excerpt,
    required this.content,
    required this.image,
    required this.userId,
    required this.categoryId,
    required this.cityId,
    required this.createdAt,
    required this.updatedAt,
  });

  Data copyWith({
    required int id,
    required String heading,
    required String slug,
    required String excerpt,
    required String content,
    required String image,
    required int userId,
    required int categoryId,
    required int cityId,
    required String createdAt,
    required String updatedAt,
  }) {
    return Data(
      id: id,
      heading: heading,
      slug: slug,
      excerpt: excerpt,
      content: content,
      image: image,
      userId: userId,
      categoryId: categoryId,
      cityId: cityId,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  Data merge(Data model) {
    return Data(
      id: model.id,
      heading: model.heading,
      slug: model.slug,
      excerpt: model.excerpt,
      content: model.content,
      image: model.image,
      userId: model.userId,
      categoryId: model.categoryId,
      cityId: model.cityId,
      createdAt: model.createdAt,
      updatedAt: model.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'heading': heading,
      'slug': slug,
      'excerpt': excerpt,
      'content': content,
      'image': image,
      'user_id': userId,
      'category_id': categoryId,
      'city_id': cityId,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  factory Data.fromMap(Map<String, dynamic> map) {
   
  
    return Data(
      id: map['id']?.toInt(),
      heading: map['heading'],
      slug: map['slug'],
      excerpt: map['excerpt'],
      content: map['content'],
      image: map['image'] ?? "",
      userId: map['user_id']?.toInt(),
      categoryId: map['category_id']?.toInt(),
      cityId: map['city_id']?.toInt(),
      createdAt: map['created_at'],
      updatedAt: map['updated_at'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Data.fromJson(String source) => Data.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Data(id: $id, heading: $heading, slug: $slug, excerpt: $excerpt, content: $content, image: $image, userId: $userId, categoryId: $categoryId, cityId: $cityId, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is Data &&
      o.id == id &&
      o.heading == heading &&
      o.slug == slug &&
      o.excerpt == excerpt &&
      o.content == content &&
      o.image == image &&
      o.userId == userId &&
      o.categoryId == categoryId &&
      o.cityId == cityId &&
      o.createdAt == createdAt &&
      o.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      heading.hashCode ^
      slug.hashCode ^
      excerpt.hashCode ^
      content.hashCode ^
      image.hashCode ^
      userId.hashCode ^
      categoryId.hashCode ^
      cityId.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode;
  }
}


class Link {
  final String url;
  final String label;
  final bool active;
  Link({
    required this.url,
    required this.label,
    required this.active,
  });

  Link copyWith({
    required String url,
    required String label,
    required bool active,
  }) {
    return Link(
      url: url,
      label: label,
      active: active,
    );
  }

  Link merge(Link model) {
    return Link(
      url: model.url,
      label: model.label,
      active: model.active,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'url': url,
      'label': label,
      'active': active,
    };
  }

  factory Link.fromMap(Map<String, dynamic> map) {
  
    return Link(
      url: map['url'] ?? "",
      label: map['label'],
      active: map['active'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Link.fromJson(String source) => Link.fromMap(json.decode(source));

  @override
  String toString() => 'Link(url: $url, label: $label, active: $active)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is Link &&
      o.url == url &&
      o.label == label &&
      o.active == active;
  }

  @override
  int get hashCode => url.hashCode ^ label.hashCode ^ active.hashCode;
}

