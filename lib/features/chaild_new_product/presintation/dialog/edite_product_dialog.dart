import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/product_request/add_child_product.dart';

typedef OnProductEditeSaved =
    void Function(ChildProductAddRequest updatedProduct);

Future<void> showEditeProductChildDialog(
  BuildContext context,
  int id,
  ChildProductAddRequest childProduct,
  Function(ChildProductAddRequest) onSavedCallback,
) async {
  await showDialog<void>(
    context: context,
    barrierDismissible: false,

    builder: (BuildContext dialogContext) {
      return _AddChildProductDialogContent(
        productId: id,
        onSavedCallback: onSavedCallback,
        childProductAddRequest: childProduct,
      );
    },
  );
}

class _AddChildProductDialogContent extends StatefulWidget {
  final OnProductEditeSaved onSavedCallback;
  final int productId;
  final ChildProductAddRequest childProductAddRequest;

  const _AddChildProductDialogContent({
    required this.onSavedCallback,
    required this.productId,
    required this.childProductAddRequest,
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
  final TextEditingController dollarExchange = TextEditingController();
  final TextEditingController min_limit = TextEditingController();
  final TextEditingController price = TextEditingController();
  final TextEditingController stock = TextEditingController();
  final List<String> image = [];
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController brandController = TextEditingController();
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
    imageList = widget.childProductAddRequest.image;
    colorName.text = widget.childProductAddRequest.colorName;
    color.text = widget.childProductAddRequest.color;
    facturaName.text = widget.childProductAddRequest.fakturaName;
    productName.text = widget.childProductAddRequest.name;
    qrCode.text = widget.childProductAddRequest.qrCode;
    size.text = widget.childProductAddRequest.size;
    hexColor = "#${widget.childProductAddRequest.color}";
    descriptionController.text=widget.childProductAddRequest.dollarExchangeRate.toString();
    min_limit.text=widget.childProductAddRequest.minLimit.toString();
    price.text=widget.childProductAddRequest.price.toString();
    stock.text=widget.childProductAddRequest.stock.toString();
  }

  @override
  void dispose() {
    descriptionController.dispose();
    brandController.dispose();
    super.dispose();
  }

  void _onSavePressed() {

    int dollarExchangeNumber = int.tryParse(dollarExchange.text) ?? 0;
    int minLimitNumber = int.tryParse(min_limit.text) ?? 0;
    int priceNumber = int.tryParse(price.text) ?? 0;
    int stockNumber = int.tryParse(stock.text) ?? 0;
    final updatedProduct = ChildProductAddRequest(
      color: hexColor,
      colorName: colorName.text,
      dollarExchangeRate: dollarExchangeNumber,
      fakturaName: facturaName.text,
      image: imageList,
      minLimit: minLimitNumber,
      name: productName.text,
      productId: widget.productId,
      qrCode: qrCode.text,
      size: size.text,
      price: priceNumber,
      stock: stockNumber,
    );
    print("CALLBACK worked!${productName.text}");
    widget.onSavedCallback(updatedProduct);

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

          const Text(
            'Mahsulot nomi',
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
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
                                Text(hexColor),
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
                      'Factira nomi',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: facturaName,
                      decoration: InputDecoration(
                        hintText: 'Factira nomi',
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
                      'Maxsulot narxi',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: price,
                      decoration: InputDecoration(
                        hintText: 'Maxsulot narxi',
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
                      'Dollar kursi',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller:dollarExchange ,
                      decoration: InputDecoration(
                        hintText: 'Dollar kursi',
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
                      'Minimal chegara',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: min_limit,
                      decoration: InputDecoration(
                        hintText: 'Minimal chegara',
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
                      'Zaxira',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller:stock ,
                      decoration: InputDecoration(
                        hintText: 'Zaxira',
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
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      controller: size,
                      decoration: InputDecoration(
                        hintText: 'Maxsulot xajmi',
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
                  children: [],
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
