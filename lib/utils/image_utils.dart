enum ImageItems { infoguy1, infoguy2, infoguy3, message }

extension ImageItemsExtension on ImageItems {
  String _imagePath() {
    switch (this) {
      case ImageItems.infoguy1:
        return "3d_info_guy";

      case ImageItems.infoguy2:
        return "3d_info_guy2";

      case ImageItems.infoguy3:
        return "3d_info_guy3";

      case ImageItems.message:
        return "3d_messages";
    }
  }

  String get imagePath => "assets/${_imagePath()}.png";
}
