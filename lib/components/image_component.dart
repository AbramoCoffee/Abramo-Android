import 'package:abramo_coffee/resources/color.dart';
import 'package:flutter/material.dart';

class ImageComponent extends StatelessWidget {
  const ImageComponent({super.key, required this.source});

  final String source;
  @override
  Widget build(BuildContext context) {
    return Image.network(
      source,
      height: 100,
      width: 100,
      errorBuilder: (context, error, stackTrace) => Image.asset(
        'assets/images/placeholder.png',
        width: 120,
        height: 120,
      ),
      loadingBuilder: (context, child, loadingProgress) =>
          loadingProgress == null
              ? Card(
                  elevation: 4,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      source,
                      width: 100,
                      height: 100,
                      fit: BoxFit.contain,
                    ),
                  ),
                )
              : CircularProgressIndicator(
                  color: cYellowPrimary,
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null,
                ),
    );
  }
}
