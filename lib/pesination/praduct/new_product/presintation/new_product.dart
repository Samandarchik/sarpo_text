import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../praduct/data/product_request/get_all_brand_request.dart';
import '../data/new_praduct_request/new_product_request.dart';
import 'bloc/new_product_bolc.dart'; // Bloc sinfi
import 'bloc/new_product_event.dart'; // Bloc Eventlar
import 'bloc/new_product_state.dart'; // Bloc State
import 'dialog/dialog.dart'; // showCreateCategoryDialog funksiyasi

class AddProductForm extends StatefulWidget {
  final VoidCallback onSaved;

  const AddProductForm({super.key, required this.onSaved});

  @override
  State<AddProductForm> createState() => _AddProductFormState();
}

class _AddProductFormState extends State<AddProductForm> {
  // --- Text Controllerlar ---
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController brandCategorises = TextEditingController();
  final TextEditingController brandBrand = TextEditingController();
  final TextEditingController brandController = TextEditingController();
  final TextEditingController originController = TextEditingController();

  late int brand_id = 0;
  late int categoriy_id = 0;

  List<Map<String, String>> variants = [
    {'size': 'S', 'color': 'Red', 'stock': '10', 'price': '19.99'},
  ];
  bool isActive = true;
  final TextEditingController basePriceController = TextEditingController();
  String discountType = 'Percentage';
  final TextEditingController discountController = TextEditingController();

  @override
  void dispose() {
    productNameController.dispose();
    descriptionController.dispose();
    brandController.dispose();
    originController.dispose();
    basePriceController.dispose();
    discountController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    context.read<NewProductsScreenBloc>().add(
      BrandEvent(brandGetAllRequest: BrandGetAllRequest(limit: 0, offset: 0)),
    );

    context.read<NewProductsScreenBloc>().add(
      CategoriesEvent(brandGetAllRequest: BrandGetAllRequest(limit: 0, offset: 0)),
    );
  }


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewProductsScreenBloc, NewProductsScreenBlocState>(
      listener: (context, state) {
        if (state.status == NewProductsScreenStatus.success) {
          setState(() {
            if (state.categoriesEvent.isNotEmpty) {
              final latestCategory = state.categoriesEvent.reduce((curr, next) => curr.id > next.id ? curr : next);
              categoriy_id = latestCategory.id;
            }


            if (state.brand.isNotEmpty) {
              final latestBrand = state.brand.reduce((curr, next) => curr.id > next.id ? curr : next);
              brand_id = latestBrand.id;
            }
          });
        }
      },

      builder: (context, state) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAddProductForm(state),
              const SizedBox(height: 32),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    context.read<NewProductsScreenBloc>().add(
                      NewProductsEvent(
                        newProductRequest: NewProductRequest(
                          barCode: [],
                          brandId: brand_id,
                          categoryId: categoriy_id,
                          description: descriptionController.text,
                          isActive: true,
                          name: productNameController.text,
                          vatRate: 0,
                        ),
                      ),
                    );
                    widget.onSaved();
                    print("clickbosiiddi");
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    backgroundColor: Colors.green,
                  ),
                  child: const Text('Save Product', style: TextStyle(fontSize: 18, color: Colors.white)),
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAddProductForm(NewProductsScreenBlocState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildGeneralInformation(state),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildGeneralInformation(NewProductsScreenBlocState state) {
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

          // ... Product Name va Description ...

          const Text('Product Name', style: TextStyle(fontWeight: FontWeight.w500)),
          const SizedBox(height: 8),
          TextField(
            controller: productNameController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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

                    DropdownButtonFormField<int>(
                        value: categoriy_id > 0 ? categoriy_id : null,
                        onChanged: (int? value){
                          if (value != null) {
                            if (value == -1) {
                              showCreateCategoryDialog(
                                  context,
                                      (date){
                                    context.read<NewProductsScreenBloc>().add(
                                      NewCategoryEvent(newCategoryRequest: date),
                                    );
                                  }
                              );
                            } else {
                              setState(() {
                                categoriy_id = value;
                              });
                            }
                          }
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        ),
                        items: [
                          ...state.categoriesEvent
                              .map<DropdownMenuItem<int>>(
                                (category) => DropdownMenuItem<int>(
                              value: category.id,
                              child: Text(category.name),
                            ),
                          )
                              .toList(),

                          DropdownMenuItem<int>(
                            value: -1,
                            child: const Text("➕ Yangi Kategoriya Qo'shish", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
                          ),
                        ]
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
                    DropdownButtonFormField<int>(
                      value: brand_id > 0 ? brand_id : null,
                      onChanged: (int? value) {
                        if (value != null) {
                          if (value == -1) {
                            showCreateCategoryDialog(
                                context,
                                    (date){
                                  context.read<NewProductsScreenBloc>().add(
                                    NewBrandEvent(newCategoryRequest: date),
                                  );
                                }
                            );
                          } else {
                            setState(() {
                              brand_id = value;
                            });
                          }
                        }
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                      items: [
                        ...state.brand
                            .map<DropdownMenuItem<int>>(
                              (brand) => DropdownMenuItem<int>(
                            value: brand.id,
                            child: Text(brand.name),
                          ),
                        )
                            .toList(),

                        DropdownMenuItem<int>(
                          value: -1,
                          child: const Text("➕ Yangi Brand Qo'shish", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
                        ),
                      ],
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


