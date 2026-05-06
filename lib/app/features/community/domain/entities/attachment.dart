class Attachment {
  const Attachment({
    required this.id,
    required this.fileUrl,
    required this.fileType,
    required this.fileName,
    required this.fileSize,
  });

  factory Attachment.fromJson(Map<String, dynamic> json) {
    return Attachment(
      id: json['id'] as String,
      fileUrl: json['fileUrl'] as String,
      fileType: json['fileType'] as String,
      fileName: json['fileName'] as String,
      fileSize: json['fileSize'] as int,
    );
  }

  final String id;
  final String fileUrl;
  final String fileType;
  final String fileName;
  final int fileSize;
}
