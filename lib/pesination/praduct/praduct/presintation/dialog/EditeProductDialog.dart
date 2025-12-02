import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/product_request/edite_product_request.dart';





typedef OnProductEditeSaved = void Function(EditeProductRequest updatedProduct);

Future<void> showEditeProductDialog(
    BuildContext context,
    EditeProductRequest initialData,
    Function(EditeProductRequest) onSavedCallback,
    ) async {
  await showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext dialogContext) {
      return _EditeProductDialogContent(
        initialData: initialData,
        onSavedCallback: onSavedCallback,
      );
    },
  );
}


class _EditeProductDialogContent extends StatefulWidget {
  final EditeProductRequest initialData;
  final OnProductEditeSaved onSavedCallback;

  const _EditeProductDialogContent({
    required this.initialData,
    required this.onSavedCallback,
  });

  @override
  State<_EditeProductDialogContent> createState() =>
      __EditeProductDialogContentState();
}

class __EditeProductDialogContentState
    extends State<_EditeProductDialogContent> {
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController brandController = TextEditingController();


  @override
  void initState() {
    super.initState();
    productNameController.text = widget.initialData.name;
    descriptionController.text = widget.initialData.description ?? '';
    brandController.text = widget.initialData.brandId.toString();
  }

  @override
  void dispose() {
    productNameController.dispose();
    descriptionController.dispose();
    brandController.dispose();
    super.dispose();
  }

  void _onSavePressed() {

    final updatedProduct = EditeProductRequest(
      id: widget.initialData.id,
      barCode: widget.initialData.barCode,
      brandId: int.tryParse(brandController.text) ?? widget.initialData.brandId,
      categoryId: widget.initialData.categoryId,
      description: descriptionController.text,
      isActive: widget.initialData.isActive,
      name: productNameController.text,
      vatRate: widget.initialData.vatRate,
    );

    // context.read<EditeProductsScreenBloc>().add(
    //   EditeProductsEvent(
    //     newProductRequest: updatedProduct,
    //   ),
    // );

    widget.onSavedCallback(updatedProduct);


    Navigator.pop(context);

    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Mahsulot tahrirlash uchun yuborildi...")));
  }


  @override
  Widget build(BuildContext context) {

    return AlertDialog(
      title: const Text('Mahsulotni Tahrirlash'),
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
          Row(
            children: [
              const Text(
                'General Information',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
            ],
          ),
          const SizedBox(height: 24),


          const Text('Product Name', style: TextStyle(fontWeight: FontWeight.w500)),
          const SizedBox(height: 8),
          TextField(
            controller: productNameController,
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

          const Text('Product Description', style: TextStyle(fontWeight: FontWeight.w500)),
          const SizedBox(height: 8),
          TextField(
            controller: descriptionController,
            maxLines: 5,
            decoration: InputDecoration(
              hintText: 'Describe the product in detail...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              contentPadding: const EdgeInsets.all(16),
            ),
          ),

          const SizedBox(height: 20),


          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Category', style: TextStyle(fontWeight: FontWeight.w500)),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                      items: ['Clothing', 'Electronics', 'Food', 'Books'].map((cat) => DropdownMenuItem(value: cat, child: Text(cat))).toList(),
                      onChanged: (value) {},
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Brand', style: TextStyle(fontWeight: FontWeight.w500)),
                    const SizedBox(height: 8),
                    TextField(
                      controller: brandController,
                      decoration: InputDecoration(
                        hintText: 'e.g. Nike',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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