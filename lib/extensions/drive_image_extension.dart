extension GoogleDriveImage on String {
  String get driveImageUrl {
    final url = this;

    if (url.contains("drive.google.com/drive/folders")) {
      return ""; 
    }

    if (url.contains("drive.google.com/file/d/")) {
      final fileId = url.split("/d/")[1].split("/")[0];
      return "https://drive.google.com/uc?export=view&id=$fileId";
    }

    if (url.contains("open?id=")) {
      final fileId = url.split("id=")[1];
      return "https://drive.google.com/uc?export=view&id=$fileId";
    }

    return url;
  }
}
