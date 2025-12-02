// new_category_dialog.dart yoki shu kabi alohida faylda saqlang

import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
// importlar:
// Import yo'llarini o'zingizning loyihangizga moslang!
import 'package:flutter_bloc/flutter_bloc.dart';

class ImageList {
  final List<String> image;
  final String name;

  ImageList({
    required this.image,
    this.name = '',
  });
}


void addImage(BuildContext context, Function(ImageList) newBranch) {
  showDialog(
    context: context,
    builder: (context) => _CategoryDialogContent(newBranch: newBranch),
  );
}

class _CategoryDialogContent extends StatefulWidget {
  final Function(ImageList) newBranch;

  const _CategoryDialogContent({required this.newBranch});

  @override
  State<_CategoryDialogContent> createState() => _CategoryDialogContentState();
}

class _CategoryDialogContentState extends State<_CategoryDialogContent> {
  final List<Map<String, dynamic>> selectedImages = [];
  final int maxImages = 3;
  final ImagePicker picker = ImagePicker();

  bool isLoading = false;

  Future<void> pickImage(int index) async {
    if (selectedImages.length >= maxImages) return;

    setState(() {
      isLoading = true;
    });

    try {
      final XFile? image = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 400,
        maxHeight: 400,
        imageQuality: 70,
      );

      if (image != null) {
        final bytes = await image.readAsBytes();

        final newImage = {
          'bytes': bytes,
          'path': image.path,
          'name': image.name,
        };

        setState(() {
          selectedImages.add(newImage);
        });

      }
    } catch (e) {
      print('❌ Rasm tanlashda xatolik: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void removeImage(int index) {
    setState(() {
      selectedImages.removeAt(index);
    });
  }

  Widget _buildImageSlot(int index) {
    final bool isFilled = index < selectedImages.length;
    final Map<String, dynamic>? image = isFilled ? selectedImages[index] : null;

    return Expanded(
      child: InkWell(
        onTap: isFilled ? null : () => pickImage(index),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          height: 120,
          decoration: BoxDecoration(
            color: isFilled ? Colors.transparent : Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isFilled ? Colors.transparent : Colors.blue[300]!,
              width: 1.5,
              style: isFilled ? BorderStyle.none : BorderStyle.solid,
            ),
          ),
          child: isFilled
              ? Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.memory(
                  image!['bytes'] as Uint8List,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
              Positioned(
                top: 4,
                right: 4,
                child: InkWell(
                  onTap: () => removeImage(index),
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.close, color: Colors.white, size: 16),
                  ),
                ),
              ),
            ],
          )
              : Center(
            child: isLoading
                ? const CircularProgressIndicator()
                : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.add_photo_alternate_outlined,
                  size: 32,
                  color: Colors.blue[400],
                ),
                const SizedBox(height: 4),
                Text(
                  'Rasm ${index + 1}',
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _saveImages() {
    if (selectedImages.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Iltimos, kamida bitta rasm tanlang!'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    final List<String> imagePathsOrBase64 = selectedImages.map((imageMap) {



        return imageMap['path'] as String;

    }).toList();

    final categoryData = ImageList(
      image: imagePathsOrBase64,
      name: '',
    );

    print('📤 ${imagePathsOrBase64.length} ta rasm ma\'lumoti (List<String>) yuborildi.');
    widget.newBranch(categoryData);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        width: 450,
        constraints: const BoxConstraints(maxHeight: 450),
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Sarlavha
            const Text(
              '3 tagacha rasm joylash',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 24),

            // Rasm joylari (3 ta slot)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildImageSlot(0),
                const SizedBox(width: 12),
                _buildImageSlot(1),
                const SizedBox(width: 12),
                _buildImageSlot(2),
              ],
            ),
            const SizedBox(height: 30),

            // Tugmalar
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      side: BorderSide(color: Colors.grey[300]!),
                    ),
                    child: const Text('Bekor qilish', style: TextStyle(fontSize: 15, color: Colors.black87)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _saveImages,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      elevation: 0,
                    ),
                    child: Text(
                      'Saqlash (${selectedImages.length}/$maxImages)',
                      style: const TextStyle(fontSize: 15, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}