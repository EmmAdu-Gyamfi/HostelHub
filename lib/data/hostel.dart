class Hostel {
  Hostel({
    // required this.hostelId,
    required this.name,
    required this.locality,
    required this.address,
    required this.condition,
    required this.furnishing,
    required this.minimumRentTime,
    required this.negotiation,
    required this.minimumPriceRange,
    required this.maximumPriceRange,
    required this.description,
    // required this.region,
    // required this.city,
    required this.phoneNumber,
    required this.alternativePhoneNumber,
    required this.wiFi,
    required this.laundryServices,
    required this.studyRoom,
    required this.security,
    // required this.addedBy



    // required this.hostelPhotos,
    // required this.hostelRatings,
    // required this.hostelReviews,
    // required this.hostelRooms,
  });
  late final int hostelId;
  late final String name;
  late final String locality;
  late final String address;
  late final String condition;
  late final String furnishing;
  late final String region;
  late final String city;
  late final int minimumRentTime;
  late final bool negotiation;
  late final int? minimumPriceRange;
  late final int? maximumPriceRange;
  late final String description;
  late final String phoneNumber;
  late final String alternativePhoneNumber;
  late final String wiFi;
  late final String laundryServices;
  late final String studyRoom;
  late final String security;
  late final int addedBy;

  late final List<HostelPhotos> hostelPhotos;
  late final List<dynamic> hostelRatings;
  late final List<dynamic> hostelReviews;
  late final List<HostelRooms> hostelRooms;
  late bool isLiked = false;

  Hostel.fromJson(Map<String, dynamic> json){
    hostelId = json['hostelId'];
    name = json['name'];
    locality = json['locality'];
    address = json['address'];
    condition = json['condition'];
    furnishing = json['furnishing'];
    region = json['region'];
    city = json['city'];
    minimumRentTime = json['minimumRentTime'];
    negotiation = json['negotiation'];
    minimumPriceRange = json['minimumPriceRange'];
    maximumPriceRange = json['maximumPriceRange'];
    description = json['description'];
    phoneNumber = json['phoneNumber'];
    alternativePhoneNumber = json['alternativePhoneNumber'];
    wiFi = json['wiFi'];
    laundryServices = json['laundryServices'];
    studyRoom = json['studyRoom'];
    security = json['security'];
    addedBy = json['addedBy'];
    hostelPhotos = List.from(json['hostelPhotos']).map((e)=>HostelPhotos.fromJson(e)).toList();
    hostelRatings = List.castFrom<dynamic, dynamic>(json['hostelRatings']);
    hostelReviews = List.castFrom<dynamic, dynamic>(json['hostelReviews']);
    hostelRooms = List.from(json['hostelRooms']).map((e)=>HostelRooms.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['hostelId'] = hostelId;
    _data['name'] = name;
    _data['locality'] = locality;
    _data['address'] = address;
    _data['condition'] = condition;
    _data['furnishing'] = furnishing;
    _data['region'] = region;
    _data['city'] = city;
    _data['minimumRentTime'] = minimumRentTime;
    _data['negotiation'] = negotiation;
    _data['minimumPriceRange'] = minimumPriceRange;
    _data['maximumPriceRange'] = maximumPriceRange;
    _data['description'] = description;
    _data['phoneNumber'] = phoneNumber;
    _data['alternativePhoneNumber'] = alternativePhoneNumber;
    _data['wiFi'] = wiFi;
    _data['laundryServices'] = laundryServices;
    _data['studyRoom'] = studyRoom;
    _data['security'] = security;
    _data['addedBy'] = addedBy;
    _data['hostelPhotos'] = hostelPhotos.map((e)=>e.toJson()).toList();
    _data['hostelRatings'] = hostelRatings;
    _data['hostelReviews'] = hostelReviews;
    _data['hostelRooms'] = hostelRooms.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class HostelPhotos {
  HostelPhotos({
    required this.hostelPhotoId,
    required this.hostelId,
    required this.fileId,
    this.file,
  });
  late final int hostelPhotoId;
  late final int hostelId;
  late final int fileId;
  late final Null file;

  HostelPhotos.fromJson(Map<String, dynamic> json){
    hostelPhotoId = json['hostelPhotoId'];
    hostelId = json['hostelId'];
    fileId = json['fileId'];
    file = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['hostelPhotoId'] = hostelPhotoId;
    _data['hostelId'] = hostelId;
    _data['fileId'] = fileId;
    _data['file'] = file;
    return _data;
  }
}

class HostelRooms {
  HostelRooms({
    required this.hostelRoomId,
    required this.hostelId,
    required this.roomId,
    required this.room,
  });
  late final int hostelRoomId;
  late final int hostelId;
  late final int roomId;
  late final Room room;

  HostelRooms.fromJson(Map<String, dynamic> json){
    hostelRoomId = json['hostelRoomId'];
    hostelId = json['hostelId'];
    roomId = json['roomId'];
    room = Room.fromJson(json['room']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['hostelRoomId'] = hostelRoomId;
    _data['hostelId'] = hostelId;
    _data['roomId'] = roomId;
    _data['room'] = room.toJson();
    return _data;
  }
}

class RoomPhotos {
  RoomPhotos({
    required this.roomPhotoId,
    required this.roomId,
    required this.fileId,
    this.file,
  });
  late final int? roomPhotoId;
  late final int? roomId;
  late final int? fileId;
  late final Null file;

  RoomPhotos.fromJson(Map<String, dynamic> json){
    roomPhotoId = json['hostelPhotoId'];
    roomId = json['hostelId'];
    fileId = json['fileId'];
    file = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['hostelPhotoId'] = roomPhotoId;
    _data['hostelId'] = roomId;
    _data['fileId'] = fileId;
    _data['file'] = file;
    return _data;
  }
}

class Room {
  Room({
    // required this.roomId,
    required this.roomCategory,
    required this.roomLabel,
    required this.price,
    // required this.hostelRooms,
    // required this.roomPhotos,
  });
  late final int roomId;
  late final String roomCategory;
  late final String roomLabel;
  late final double price;
  late final List<dynamic> hostelRooms;
  late final List<RoomPhotos> roomPhotos;

  Room.fromJson(Map<String, dynamic> json){
    roomId = json['roomId'];
    roomCategory = json['roomCategory'];
    roomLabel = json['roomLabel'];
    price = json['price'];
    hostelRooms = List.castFrom<dynamic, dynamic>(json['hostelRooms']);
    roomPhotos = List.from(json['roomPhotos']).map((e)=>RoomPhotos.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['roomId'] = roomId;
    _data['roomCategory'] = roomCategory;
    _data['roomLabel'] = roomLabel;
    _data['price'] = price;
    _data['hostelRooms'] = hostelRooms;
    _data['roomPhotos'] = roomPhotos.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class FilterParams {
  FilterParams({
    required this.regions,
    required this.citys,
    required this.towns,
  });
  late final List<String> regions;
  late final List<String> citys;
  late final List<String> towns;

  FilterParams.fromJson(Map<String, dynamic> json){
    regions = List.castFrom<dynamic, String>(json['regions']);
    citys = List.castFrom<dynamic, String>(json['citys']);
    towns = List.castFrom<dynamic, String>(json['towns']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['regions'] = regions;
    _data['citys'] = citys;
    _data['towns'] = towns;
    return _data;
  }
}