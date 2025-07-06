import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CashImage extends StatelessWidget {
  final String image;
  const CashImage({super.key,required this.image});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
    
      imageUrl: image,
      imageBuilder: (context, imageProvioder) {
        return Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: imageProvioder, fit: BoxFit.fill),
          ),
        );
      },
      placeholder: (context, url) => const Center(
        child: CircularProgressIndicator(
          color: Colors.blue,
        ),
      ),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}
