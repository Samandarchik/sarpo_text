import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../chaild_new_product/presintation/dialog/child_add_product_dialog_screen.dart';
import '../../incoming_goods/data/response/incoming_goods_get_all_date.dart';
import '../../incoming_goods/presentation/bloc/IncomingGoods_state.dart';
import '../data/response/incoming_goods_items_get_all_response.dart';
import 'bloc/IncomingGoods_bloc_item.dart';
import 'bloc/IncomingGoods_state_item.dart';


class IncomingGoodsItemsScreen extends StatefulWidget {
  const IncomingGoodsItemsScreen({super.key});

  @override
  State<IncomingGoodsItemsScreen> createState() => _IncomingGoodsItemsScreen();
}

class _IncomingGoodsItemsScreen extends State<IncomingGoodsItemsScreen> {
  @override
  void initState() {
    super.initState();
    // context.read<IncomingGoodsScreenBloc>().add(
    //   FactorysGetAllDate(
    //     FactoryGetAllRequest(search: "", offset: 0, limit: 100),
    //   ),
    // );
    // context.read<IncomingGoodsScreenBloc>().add(
    //   IncomingGoodsGetAllDateEvent(
    //     IncomingGoodsGetAllDateRequest(offset: 0, limit: 100),
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<IncomingGoodsItemScreenBloc, IncomingGoodsItemState>(
      listener: (context, state) {},
      builder: (context, state) {
         final products = state.incomingGoodsResponse;

        return Column(
          children: [
            _buildHeader(state),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child:  _buildProductListTable(products.items, context)
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildProductListTable(
      List<IncomingGoodsGetAllItem> products,
      BuildContext context,
      ) {
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
                  flex: 2,
                  child: Text(
                    'CreatedAt',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    'purchase_name',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),

                Expanded(
                  flex: 4,
                  child: Text(
                    'purchase_price',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),

                Expanded(
                  flex: 5,
                  child: Text(
                    'quantity',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Text(
                    'selling_price',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  flex: 7,
                  child: Text(
                    'total',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),

          ...products.map((product) {
            return GestureDetector(
              onTap: () {
                // widget.id(product.id!);
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
                      flex: 2,
                      child: Text(
                        product.createdAt,
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(
                        product.productName,
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),

                    Expanded(
                      flex: 4,
                      child: Text(
                        product.purchasePrice.toString(),
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),

                    Expanded(
                      flex: 5,
                      child: Text(
                        product.quantity.toString(),
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),

                    Expanded(
                      flex: 6,
                      child: Text(
                        product.sellingPrice.toString(),
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),
                    Expanded(
                      flex: 7,
                      child: Text(
                        product.total.toString(),
                        style: const TextStyle(fontWeight: FontWeight.w500),
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

  Widget _buildHeader( IncomingGoodsItemState incoming) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton.icon(
                onPressed: () {

                  {
                    // showIncomingGoodDialog(
                    //   context,
                    //       (data) {
                    //     context.read<IncomingGoodsScreenBloc>().add(
                    //       IncomingGoodsAddDateEvent(data),
                    //     );
                    //   },
                    //       (addFactriysDate) async {
                    //     context.read<IncomingGoodsScreenBloc>().add(
                    //       FactrysAddDate(addFactriysDate),
                    //     );
                    //
                    //     await Future.delayed(Duration(milliseconds: 500));
                    //
                    //     context.read<IncomingGoodsScreenBloc>().add(
                    //       FactorysGetAllDate(
                    //         FactoryGetAllRequest(search: "", offset: 0, limit: 100),
                    //       ),
                    //     );
                    //   },
                    //   incoming.factoryStates,
                    // );
                  }
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

              // context.read<FactrysScreenBloc>().add(
              // FactorysGetAllDate(
              // FactoryGetAllRequest(
              // search: "dd",
              // offset: 100,
              // limit: 100
              // )
              // ),
              // );
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Nom bo\'yicha qidirish...',
                    prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 12),
            ],
          ),
        ],
      ),
    );
  }
}
