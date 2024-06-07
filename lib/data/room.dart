// class Room {
//   Room({
//     // required this.roomId,
//     required this.roomCategory,
//     required this.roomLabel,
//     required this.price,
//   });
//   late final int roomId;
//   late final String roomCategory;
//   late final String roomLabel;
//   late final double price;
//
//   Room.fromJson(Map<String, dynamic> json){
//     roomId = json['roomId'];
//     roomCategory = json['roomCategory'];
//     roomLabel = json['roomLabel'];
//     price = json['price'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['roomId'] = roomId;
//     _data['roomCategory'] = roomCategory;
//     _data['roomLabel'] = roomLabel;
//     _data['price'] = price;
//     return _data;
//   }
// }