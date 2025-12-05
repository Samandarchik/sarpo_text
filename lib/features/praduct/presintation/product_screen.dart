import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/product_request/edite_product_request.dart';
import '../data/product_request/product_delete.dart';
import '../data/product_response/product_request.dart';
import 'bloc/product_bloc.dart';
import 'bloc/product_event.dart';
import 'bloc/product_state.dart';
import 'dialog/EditeProductDialog.dart';

class ProductsScreen extends StatefulWidget {
  final VoidCallback onAddNewProduct;
  final Function(EditeProductRequest product) onEditProduct;
  final Function(int id) id;

  const ProductsScreen({
    Key? key,
    required this.onAddNewProduct,
    required this.onEditProduct,
    required this.id,
  }) : super(key: key);

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchProducts();
    });
  }

  void _fetchProducts() {
    context.read<ProductsScreenBloc>().add(
      GetAlProductsScreenBlocEvent(
        productGetAllRequest: ProductGetAllRequest(
          limit: 0,
          offset: 0,
          search: "",
          categoryId: "",
          brandId: "",
          isActive: "",
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductsScreenBloc, ProductsScreenBlocState>(
      listener: (context, state) {
        if (state.status == ProductsScreenStatus.failure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text("Xatolik yuz berdi")));
        }
      },
      builder: (context, state) {
        final products = state.response;

        return Column(
          children: [
            _buildHeader(),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: _buildProductListTable(products, context),
              ),
            ),

            // _buildPagination(),
          ],
        );
      },
    );
  }

  Widget _buildProductListTable(List<dynamic> products, BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            height: 50,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: const Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    'Kod',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    'Nomi',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    'Kurut amalari',
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
          ),

          ...products.map((product) {
            return GestureDetector(
              onTap: () {
                widget.id(product.id!);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.grey[200]!)),
                ),
                child: Row(
                  children: [
                    Expanded(flex: 1, child: Text(product.id.toString())),

                    Expanded(
                      flex: 3,
                      child: Text(
                        product.name.toString(),
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: PopupMenuButton<String>(
                          icon: const Icon(Icons.more_vert),
                          onSelected: (value) {
                            if (value == 'edit') {
                              final data = EditeProductRequest(
                                id: product.id!,
                                barCode: product.barCode,
                                brandId: product.brandId!,
                                categoryId: product.categoryId!,
                                description: product.description!,
                                isActive: product.isActive!,
                                name: product.name!,
                                vatRate: product.vatRate!,
                              );

                              showEditeProductDialog(context, data, (d) async {
                                context.read<ProductsScreenBloc>().add(
                                  EditeProductsEvent(newProductRequest: d),
                                );

                                await context
                                    .read<ProductsScreenBloc>()
                                    .stream
                                    .last;

                                _fetchProducts();
                              });
                            } else if (value == 'delete') {
                              context.read<ProductsScreenBloc>().add(
                                DeleteProductsScreenBlocEvent(
                                  id: ProductDelete(product.id),
                                ),
                              );
                            }
                          },
                          itemBuilder: (context) => const [
                            PopupMenuItem(value: 'edit', child: Text('Edit')),
                            PopupMenuItem(
                              value: 'delete',
                              child: Text('Delete'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Mahsulotlar Ro\'yxati',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Tovarlar zaxirasini boshqaring.',
                    style: TextStyle(color: Colors.grey[600], fontSize: 14),
                  ),
                ],
              ),
              // ElevatedButton.icon(
              //   onPressed: widget.onAddNewProduct,
              //   icon: const Icon(Icons.add, size: 18),
              //   label: const Text('Yangi Mahsulot Qo\'shish'),
              //   style: ElevatedButton.styleFrom(
              //     backgroundColor: Colors.blue[600],
              //     foregroundColor: Colors.white,
              //     padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(8),
              //     ),
              //   ),
              // ),
            ],
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
