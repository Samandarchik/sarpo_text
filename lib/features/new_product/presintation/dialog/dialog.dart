import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';

import '../../../praduct/data/product_request/get_all_brand_request.dart';
import '../../../praduct/presintation/bloc/product_event.dart';
import '../../data/new_praduct_request/new_brands.dart';
import '../bloc/new_product_bolc.dart';

void showCreateCategoryDialog(BuildContext context, Function(NewCategoryAndBrandRequest) newBranch) {
  showDialog(
    context: context,
    builder: (context) => _CategoryDialogContent(newBranch: newBranch),
  );
}

class _CategoryDialogContent extends StatefulWidget {
  final Function(NewCategoryAndBrandRequest) newBranch;

  const _CategoryDialogContent({required this.newBranch});

  @override
  State<_CategoryDialogContent> createState() => _CategoryDialogContentState();
}

class _CategoryDialogContentState extends State<_CategoryDialogContent> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priorityController = TextEditingController(text: '1');

  Uint8List? imageBytes;
  String? imagePath;
  String? imageName;

  final ImagePicker picker = ImagePicker();
  bool isLoading = false;

  Future<void> pickImage() async {
    try {
      final XFile? image = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 100,
        maxHeight: 100,
        imageQuality: 50,
      );

      if (image != null) {
        print('✅ Rasm tanlandi ${image.name}');

        final bytes = await image.readAsBytes();

        setState(() {
          imageBytes = bytes;
          imagePath = image.path;
          imageName = image.name;
          isLoading = false;
        });

        print('✅ Rasm yuklandi ${bytes.length} bytes');
      }
    } catch (e) {
      print('❌ Xatolik: $e');
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    priorityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        width: 400,
        constraints: const BoxConstraints(maxHeight: 600),
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text(
                    'Brend qoshish',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: kIsWeb ? Colors.blue[100] : Colors.green[100],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      kIsWeb ? 'WEB' : 'MOBILE',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: kIsWeb ? Colors.blue[900] : Colors.green[900],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // UNIVERSAL - Rasm tanlash
              InkWell(
                onTap: () {
                  print('📸 Container bosildi!');
                  pickImage();
                },
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  height: 140,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.blue[300]!, width: 2),
                  ),
                  child: isLoading
                      ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 8),
                        Text('Yuklanmoqda...'),
                      ],
                    ),
                  )
                      : imageBytes == null
                      ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        kIsWeb ? Icons.cloud_upload_outlined : Icons.add_photo_alternate_outlined,
                        size: 48,
                        color: Colors.blue[400],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Rasmni tanlash uchun bosing',
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        kIsWeb ? 'PNG, JPG, JPEG' : 'Galereyadan tanlang',
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 12,
                        ),
                      ),
                    ],
                  )
                      : Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.memory(
                          imageBytes!,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      ),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              imageBytes = null;
                              imagePath = null;
                              imageName = null;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                      if (imageName != null)
                        Positioned(
                          bottom: 8,
                          left: 8,
                          right: 8,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.black54,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              imageName!,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                              maxLines: 1,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              const Text(
                'Kategoriya nomi',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  hintText: 'Nomi kiriting',
                  prefixIcon: const Icon(Icons.category_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.blue, width: 2),
                  ),
                  filled: true,
                  fillColor: Colors.grey[50],
                ),
              ),
              const SizedBox(height: 24),

              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        side: BorderSide(color: Colors.grey[300]!),
                      ),
                      child: const Text(
                        'Bekor qilish',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // Validation
                        if (nameController.text.trim().isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Iltimos, nom kiriting!'),
                              backgroundColor: Colors.orange,
                            ),
                          );
                          return;
                        }

                        if (imageBytes == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Iltimos, rasm tanlang!'),
                              backgroundColor: Colors.orange,
                            ),
                          );
                          return;
                        }

                        String imageData=imagePath!;


                        final categoryData = NewCategoryAndBrandRequest(
                          image: imageData,
                          name: nameController.text,
                        );

                        print('📤 Ma\'lumot yuborildi:');
                        print('   Platform: ${kIsWeb ? "Web" : "Mobile"}');
                        print('   Nom: ${categoryData.name}');
                        print('   Rasm: ${kIsWeb ? "Base64 (${imageData.length} chars)" : imagePath}');

                        widget.newBranch(categoryData);
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Saqlash',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

}