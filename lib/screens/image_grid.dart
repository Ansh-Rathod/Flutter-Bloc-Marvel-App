import 'dart:math';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PhotoGrid extends StatelessWidget {
  final int maxImages;
  final List imageUrls;
  final Function(int) onImageClicked;
  final Function onExpandClicked;
  PhotoGrid(
      {@required this.imageUrls,
      @required this.onImageClicked,
      @required this.onExpandClicked,
      this.maxImages = 4,
      Key key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    var images = buildImages();
    return GridView(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: images.length == 3
            ? 3
            : images.length == 2
                ? 2
                : images.length == 1
                    ? 1
                    : 4,
        crossAxisSpacing: 2,
        childAspectRatio: 16 / 9,
        mainAxisExtent: 200,
        // mainAxisSpacing: 2,
      ),
      children: images,
    );
  }

  List<Widget> buildImages() {
    int numImages = imageUrls.length;
    return List<Widget>.generate(min(numImages, maxImages), (index) {
      String imageUrl =
          "${imageUrls[index]['path']}.${imageUrls[index]['extension']}";
      // If its the last image
      if (index == maxImages - 1) {
        // Check how many more images are left
        int remaining = numImages - maxImages;
        // If no more are remaining return a simple image widget
        if (remaining == 0) {
          return GestureDetector(
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              fit: BoxFit.cover,
            ),
            onTap: () => onImageClicked(index),
          );
        } else {
          // Create the facebook like effect for the last image with number of remaining  images
          return GestureDetector(
            onTap: () => onExpandClicked(),
            child: Stack(
              fit: StackFit.passthrough,
              children: [
                CachedNetworkImage(
                  imageUrl: imageUrl,
                  fit: BoxFit.cover,
                ),
                Positioned.fill(
                  child: Container(
                    alignment: Alignment.center,
                    color: Colors.black54,
                    child: Text(
                      '+' + remaining.toString(),
                      style: TextStyle(fontSize: 32, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      } else {
        return GestureDetector(
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            fit: BoxFit.cover,
          ),
          onTap: () => onImageClicked(index),
        );
      }
    });
  }
}
