class Photo {
  Photo({
    required this.fileId,
    required this.fileName,
    required this.description,
    // required this.fileData,
    required this.fileSize,
    required this.mimeType,
    // required this.hostelPhotos,
    // required this.roomPhotos,
  });
  late final int fileId;
  late final String fileName;
  late final String description;
  // late final String fileData;
  late final int fileSize;
  late final String mimeType;
  // late final List<dynamic> hostelPhotos;
  // late final List<dynamic> roomPhotos;

  Photo.fromJson(Map<String, dynamic> json){
    fileId = json['fileId'];
    fileName = json['fileName'];
    description = json['description'];
    // fileData = json['fileData'];
    fileSize = json['fileSize'];
    mimeType = json['mimeType'];
    // hostelPhotos = List.castFrom<dynamic, dynamic>(json['hostelPhotos']);
    // roomPhotos = List.castFrom<dynamic, dynamic>(json['roomPhotos']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['fileId'] = fileId;
    _data['fileName'] = fileName;
    _data['description'] = description;
    // _data['fileData'] = fileData;
    _data['fileSize'] = fileSize;
    _data['mimeType'] = mimeType;
    // _data['hostelPhotos'] = hostelPhotos;
    // _data['roomPhotos'] = roomPhotos;
    return _data;
  }
}