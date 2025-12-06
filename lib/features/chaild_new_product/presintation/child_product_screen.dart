import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../praduct/data/product_request/edite_product_request.dart';
import '../data/product_request/add_child_product.dart';
import '../data/product_request/child_product_delete.dart';
import 'bloc/child_bloc.dart';
import 'bloc/product_child_event.dart';
import 'bloc/product_child_state.dart';
import 'dialog/child_add_product_dialog_screen.dart';
import 'dialog/edite_product_dialog.dart';

class ChildProductsScreen extends StatefulWidget {
  final VoidCallback onAddNewProduct;
  final VoidCallback onTabBack;
  final Function(int product) id;
  final int product_id;

  const ChildProductsScreen({
    Key? key,
    required this.onAddNewProduct,
    required this.onTabBack,
    required this.product_id,
    required this.id,
  }) : super(key: key);

  @override
  State<ChildProductsScreen> createState() => _ChildProductsScreenState();
}

class _ChildProductsScreenState extends State<ChildProductsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchProducts();
    });
  }

  void _fetchProducts() {
    context.read<ChildProductsScreenBloc>().add(
      ChildGetAlProductsScreenBlocEvent(
        productGetAllRequest: widget.product_id,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChildProductsScreenBloc, ChildProductsScreenBlocState>(
      listener: (context, state) {
        if (state.status == ChildProductsScreenStatus.failure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("Xatolik yuz berdi")));
        }
      },
      builder: (context, state) {
        return Column(
          children: [
            _buildHeader(),

            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: DataTable(
                    columnSpacing: 16,
                    horizontalMargin: 16,
                    headingRowHeight: 50,
                    headingRowColor: MaterialStateProperty.all(
                      Colors.grey[100],
                    ),
                    columns: const [
                      DataColumn(
                        label: Text(
                          'Kod',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Nomi',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'price',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Maxsulot rangi',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'qrCode',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Maxsulot qshilgan sana',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Dollor kurs',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),

                      DataColumn(
                        label: Text(
                          '',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                    rows: state.response!.map((product) {
                      return DataRow(
                        cells: [
                          DataCell(Text(product.id.toString())),
                          DataCell(
                            Text(
                              product.name.toString(),
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                          ),

                          DataCell(
                            Text(
                              product.price.toString(),
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                          ),

                          DataCell(
                            Text(
                              product.colorName.toString(),
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                          ),
                          DataCell(
                            Text(
                              product.qrCode.toString(),
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                          ),
                          DataCell(
                            Text(
                              product.createdAt.toString(),
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                          ),
                          DataCell(
                            Text(
                              product.dollarExchangeRate.toString(),
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                          ),

                          DataCell(
                            PopupMenuButton<String>(
                              icon: Icon(Icons.more_vert),
                              onSelected: (value) {
                                if (value == 'edit') {
                                  final data = ChildProductAddRequest(
                                    color: product.color,
                                    colorName: product.colorName,
                                    dollarExchangeRate:
                                        product.dollarExchangeRate,
                                    fakturaName: product.fakturaName,
                                    image: [],
                                    minLimit: product.minLimit,
                                    name: product.name,
                                    productId: product.id,
                                    qrCode: product.qrCode,
                                    size: product.size,
                                    price: product.price,
                                    stock: product.stock,
                                  );

                                  showEditeProductChildDialog(
                                    context,
                                    product.id,
                                    data,
                                    (updatedChildProduct) {
                                      context
                                          .read<ChildProductsScreenBloc>()
                                          .add(
                                            ChildEditeProductsEvent(
                                              newProductRequest:
                                                  updatedChildProduct,
                                              product_id: product.id,
                                            ),
                                          );
                                    },
                                  );

                                  setState(() {
                                    _fetchProducts();
                                  });
                                } else if (value == 'delete') {
                                  context.read<ChildProductsScreenBloc>().add(
                                    ChildDeleteProductsScreenBlocEvent(
                                      id: ChildProductDelete(product.id),
                                    ),
                                  );
                                }
                              },
                              itemBuilder: (context) => [
                                PopupMenuItem(
                                  value: 'edit',
                                  child: Text('Edit'),
                                ),
                                PopupMenuItem(
                                  value: 'delete',
                                  child: Text('Delete'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),

            // Pagination (optional)
            // _buildPagination(),
          ],
        );
      },
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
                  Row(
                    children: [
                      GestureDetector(
                        onTap: (){
                          widget.onTabBack();
                        },
                        child: Icon(Icons.arrow_back_rounded,size: 32,),
                      )
,

                      SizedBox(width: 32,),

                    ],
                  ),
                  SizedBox(height: 16,),

                  Text(
                    'Mahsulotlar Ro\'yxati',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Tovarlar zaxirasini boshqaring.',
                    style: TextStyle(color: Colors.grey[600], fontSize: 14),
                  ),
                ],
              ),
              ElevatedButton.icon(
                onPressed: () {
                  showAddProductDialog(context, widget.product_id, (date) {
                    context.read<ChildProductsScreenBloc>().add(
                      ChildAddProductsEvent(newProductRequest: date),
                    );
                  });
                },
                icon: Icon(Icons.add, size: 18),
                label: Text('Yangi Mahsulot Qo\'shish'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[600],
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 24),

          // Search bar
        ],
      ),
    );
  }

  // Widget _buildPagination() {
  //   return Container(
  //     padding: const EdgeInsets.all(24),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       children: [
  //         Text(
  //           '48 natijadan 1 dan 12 gachasi ko\'rsatilmoqda',
  //           style: TextStyle(color: Colors.grey[600], fontSize: 14),
  //         ),
  //         Row(
  //           children: [
  //             IconButton(
  //               onPressed: () {},
  //               icon: Icon(Icons.chevron_left),
  //               color: Colors.grey[400],
  //             ),
  //             _buildPaginationButton('1', true),
  //             _buildPaginationButton('2', false),
  //             _buildPaginationButton('3', false),
  //             IconButton(
  //               onPressed: () {},
  //               icon: Icon(Icons.chevron_right),
  //               color: Colors.grey[600],
  //             ),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
