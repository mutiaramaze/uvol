extension GoogleDriveImage on String {
  /// Convert Google Drive share link into direct image link
  String get driveImageUrl {
    final url = this;

    // CASE 1 → LINK TIPE FOLDER (tidak bisa langsung)
    if (url.contains("drive.google.com/drive/folders")) {
      return ""; // folder tidak punya direct image
    }

    // CASE 2 → https://drive.google.com/file/d/FILE_ID/view?usp=sharing
    if (url.contains("drive.google.com/file/d/")) {
      final fileId = url.split("/d/")[1].split("/")[0];
      return "https://drive.google.com/uc?export=view&id=$fileId";
    }

    // CASE 3 → https://drive.google.com/open?id=FILE_ID
    if (url.contains("open?id=")) {
      final fileId = url.split("id=")[1];
      return "https://drive.google.com/uc?export=view&id=$fileId";
    }

    // CASE 4 → sudah berupa direct URL
    return url;
  }
}
