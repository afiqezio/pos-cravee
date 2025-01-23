import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;

Future<AssetImage> cutImageInHalfHorizontally(String assetPath) async {
  // Load the image from the asset
  ByteData data = await rootBundle.load(assetPath);
  Uint8List bytes = data.buffer.asUint8List();

  // Decode the image
  img.Image? originalImage = img.decodeImage(bytes);
  if (originalImage == null) {
    throw Exception('Failed to decode the image.');
  }

  // Calculate the dimensions of the top half
  int width = originalImage.width;
  int height = originalImage.height;
  int halfHeight = height ~/ 2;

  // Crop the top half of the image
  img.Image croppedImage = img.copyCrop(
    originalImage,
    x: 0,
    y: 0,
    width: width,
    height: halfHeight,
  );

  // Encode the cropped image back to a PNG
  Uint8List croppedBytes = Uint8List.fromList(img.encodePng(croppedImage));

  // Convert the bytes to an ImageProvider (AssetImage cannot be created directly from bytes)
  ui.Codec codec = await ui.instantiateImageCodec(croppedBytes);
  ui.FrameInfo frameInfo = await codec.getNextFrame();
  ui.Image uiImage = frameInfo.image;

  // Convert the ui.Image to a memory image
  ByteData? byteData = await uiImage.toByteData(format: ui.ImageByteFormat.png);
  if (byteData == null) {
    throw Exception('Failed to convert the image to byte data.');
  }

  // Use MemoryImage to display the cropped image
  return AssetImage(String.fromCharCodes(byteData.buffer.asUint8List()));
}

extension AssetImageExtension on AssetImage {
  static AssetImage fromBytes(Uint8List bytes) {
    return AssetImage(String.fromCharCodes(bytes));
  }
}
