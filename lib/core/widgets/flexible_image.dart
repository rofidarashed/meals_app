import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class FlexibleImage extends StatelessWidget {
  final String? image;
  final double height;
  final double width;
  final double borderRadius;

  const FlexibleImage({
    super.key,
    required this.image,
    required this.height,
    required this.width,
    this.borderRadius = 12,
  });

  @override
  Widget build(BuildContext context) {
    if (image == null) {
      return _fallback();
    }

    if (image!.startsWith('http')) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: CachedNetworkImage(
          imageUrl: image!,
          height: height,
          width: width,
          fit: BoxFit.cover,
          placeholder: (context, url) =>
              const Center(child: CircularProgressIndicator()),
          errorWidget: (context, url, error) =>
              const Icon(Icons.error, color: Colors.red),
        ),
      );
    } else if (image!.startsWith('data:image/')) {
      try {
        final base64Str = image!.split(',').last;
        final bytes = base64Decode(base64Str);
        return ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: Image.memory(
            bytes,
            height: height,
            width: width,
            fit: BoxFit.cover,
          ),
        );
      } catch (e) {
        return _fallback();
      }
    } else {
      return _fallback();
    }
  }

  Widget _fallback() => Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          color: Colors.grey.shade300,
        ),
        child: const Icon(Icons.hide_image, size: 40, color: Colors.grey),
      );
}
