import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../new_product/data/new_praduct_request/new_brands.dart';
import '../../data/product_request/add_child_product.dart';
import 'image_add_dialog.dart';

typedef OnProductEditeSaved =
    void Function(ChildProductAddRequest updatedProduct);

Future<void> showAddProductDialog(
  BuildContext context,
  int id,
  Function(ChildProductAddRequest) onSavedCallback,
) async {
  await showDialog<void>(
    context: context,
    barrierDismissible: false,

    builder: (BuildContext dialogContext) {
      return _AddChildProductDialogContent(
        productId: id,
        onSavedCallback: onSavedCallback,
      );
    },
  );
}

class _AddChildProductDialogContent extends StatefulWidget {
  final OnProductEditeSaved onSavedCallback;
  final int productId;

  _AddChildProductDialogContent({
    required this.onSavedCallback,
    required this.productId,
  });

  @override
  State<_AddChildProductDialogContent> createState() =>
      __EditeProductDialogContentState();
}

class __EditeProductDialogContentState
    extends State<_AddChildProductDialogContent> {
  final TextEditingController colorName = TextEditingController();
  final TextEditingController color = TextEditingController();
  final TextEditingController facturaName = TextEditingController();
  final TextEditingController productName = TextEditingController();
  final TextEditingController qrCode = TextEditingController();
  final TextEditingController size = TextEditingController();
  final List<String> image = [];
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController brandController = TextEditingController();
  final TextEditingController test = TextEditingController();

  final List<Map<String, dynamic>> staticBrands = [
    {'id': 101, 'name': 'Qizil Brand', 'colorCode': 0xFFFF0000},
    {'id': 102, 'name': 'Yashil Brand', 'colorCode': 0xFF00FF00},
    {'id': 103, 'name': 'Moviy Brand', 'colorCode': 0xFF0000FF},
    {'id': 104, 'name': 'Sariq Brand', 'colorCode': 0xFFFFFF00},
  ];
  late List<String> imageList = [];

  late String hexColor = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    descriptionController.dispose();
    brandController.dispose();
    super.dispose();
  }

  void _onSavePressed() {
    final updatedProduct = ChildProductAddRequest(
      color: hexColor,
      colorName: colorName.text,
      fakturaName: facturaName.text,
      image: imageList,
      name: productName.text,
      productId: widget.productId,
      qrCode: qrCode.text,
      size: size.text,
      price: 10,
    );

    widget.onSavedCallback(updatedProduct);

    print("CALLBACK worked!");

    Navigator.pop(context);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Mahsulot tahrirlash uchun yuborildi...")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Mahsulot qoshish "),
      content: SingleChildScrollView(
        child: SizedBox(
          width: 800,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildGeneralInformation(),

              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [

                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Bekor Qilish'),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: _onSavePressed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[600],
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Saqlash'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGeneralInformation() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          SizedBox(height: 16,),
          ElevatedButton.icon(
            onPressed: () {
              addImage(context, (date) {
                imageList = date.image;
              });
              print("kjnj${imageList}");





            },
            icon: Icon(Icons.add, size: 18),
            label: Text('Rasim qoshish'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue[600],
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          SizedBox(height: 16,),

          Text('Mahsulot nomi', style: TextStyle(fontWeight: FontWeight.w500)),
          const SizedBox(height: 8),
          TextField(
            controller: productName,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
            ),
          ),

          const SizedBox(height: 20),

          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Maxsulot rangi nomi ',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: colorName,
                      decoration: InputDecoration(
                        hintText: 'Maxsulot rangi nomi',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Maxsulot rangi kodi',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<int>(
                      onChanged: (int? value) {
                        if (value != null) {
                          if (value == -1) {
                            // showCreateCategoryDialog(
                            //     context,
                            //         (date){
                            //       context.read<NewProductsScreenBloc>().add(
                            //         NewBrandEvent(newCategoryRequest: date),
                            //       );
                            //     }
                            // );
                          } else {
                            setState(() {});
                          }
                        }
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                      items: [
                        ...staticBrands.map<DropdownMenuItem<int>>((brandData) {
                          final int brandId = brandData['id'] as int;
                          final String brandName = brandData['name'] as String;
                          final int colorValue = brandData['colorCode'] as int;

                          hexColor =
                              '#${colorValue.toRadixString(16).substring(2).toUpperCase()}';
                          return DropdownMenuItem<int>(
                            value: brandId,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 12,
                                  height: 12,
                                  decoration: BoxDecoration(
                                    color: Color(colorValue),
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                ),

                                const SizedBox(width: 8),

                                Text(
                                  hexColor,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),

                                const SizedBox(width: 8),

                                // 3. ELEMENT NOMI
                                Text(brandName),
                              ],
                            ),
                          );
                        }).toList(),

                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
            ],
          ),

          const SizedBox(height: 20),

          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'factira nomi',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: facturaName,
                      decoration: InputDecoration(
                        hintText: 'actira nomi',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'qr code',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: qrCode,
                      decoration: InputDecoration(
                        hintText: 'qr code',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Maxsulot xajmi',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Faqat raqam kiritiladi',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: test,
                      decoration: InputDecoration(
                        hintText: '',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
            ],
          ),
        ],
      ),
    );
  }
}
