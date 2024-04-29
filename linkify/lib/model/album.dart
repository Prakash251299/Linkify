// class CategoriesData {
//   Categories? categories;

//   CategoriesData({this.categories});

//   CategoriesData.fromJson(Map<String, dynamic> json) {
//     categories = json['categories'] != null
//         ? new Categories.fromJson(json['categories'])
//         : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.categories != null) {
//       data['categories'] = this.categories!.toJson();
//     }
//     return data;
//   }
// }

// class Categories {
//   String? href;
//   List<Items>? items;
//   int? limit;
//   String? next;
//   int? offset;
//   Null? previous;
//   int? total;

//   Categories(
//       {this.href,
//       this.items,
//       this.limit,
//       this.next,
//       this.offset,
//       this.previous,
//       this.total});

//   Categories.fromJson(Map<String, dynamic> json) {
//     href = json['href'];
//     if (json['items'] != null) {
//       items = <Items>[];
//       json['items'].forEach((v) {
//         items!.add(new Items.fromJson(v));
//       });
//     }
//     limit = json['limit'];
//     next = json['next'];
//     offset = json['offset'];
//     previous = json['previous'];
//     total = json['total'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['href'] = this.href;
//     if (this.items != null) {
//       data['items'] = this.items!.map((v) => v.toJson()).toList();
//     }
//     data['limit'] = this.limit;
//     data['next'] = this.next;
//     data['offset'] = this.offset;
//     data['previous'] = this.previous;
//     data['total'] = this.total;
//     return data;
//   }
// }

// class Items {
//   String? href;
//   String? id;
//   List<Icons>? icons;
//   String? name;

//   Items({this.href, this.id, this.icons, this.name});

//   Items.fromJson(Map<String, dynamic> json) {
//     href = json['href'];
//     id = json['id'];
//     if (json['icons'] != null) {
//       icons = <Icons>[];
//       json['icons'].forEach((v) {
//         icons!.add(new Icons.fromJson(v));
//       });
//     }
//     name = json['name'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['href'] = this.href;
//     data['id'] = this.id;
//     if (this.icons != null) {
//       data['icons'] = this.icons!.map((v) => v.toJson()).toList();
//     }
//     data['name'] = this.name;
//     return data;
//   }
// }

// class Icons {
//   int? height;
//   String? url;
//   int? width;

//   Icons({this.height, this.url, this.width});

//   Icons.fromJson(Map<String, dynamic> json) {
//     height = json['height'];
//     url = json['url'];
//     width = json['width'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['height'] = this.height;
//     data['url'] = this.url;
//     data['width'] = this.width;
//     return data;
//   }
// }