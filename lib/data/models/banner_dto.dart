import 'package:artifitia_test_e_commerce/domain/entities/banner.dart';

class BannerDto {
  final String category;
  final String url;

  BannerDto({required this.category, required this.url});

  factory BannerDto.fromMap(MapEntry<String, dynamic> entry) {
        final rawUrl = entry.value as String;
    final directUrl = _toDirectUrl(rawUrl);
    return BannerDto(
      category: entry.key,
      url: directUrl,
    );
  }

  BannerModel toDomain() {
    return BannerModel(category: category, imageUrl: url);
  }

  static String _toDirectUrl(String originalUrl) {
    final driveFileIdRegex = RegExp(r"https?://drive\.google\.com/file/d/([^/]+)/");
    final match = driveFileIdRegex.firstMatch(originalUrl);
    if (match != null && match.groupCount >= 1) {
      final fileId = match.group(1)!;
      return "https://drive.google.com/uc?export=view&id=$fileId";
    }
    return originalUrl;
  }

}
