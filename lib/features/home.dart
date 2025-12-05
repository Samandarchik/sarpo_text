import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled7/features/praduct/data/product_response/product_request.dart';
import 'package:untitled7/features/praduct/presintation/bloc/product_bloc.dart';
import 'package:untitled7/features/praduct/presintation/bloc/product_event.dart';
import 'package:untitled7/features/praduct/presintation/product_screen.dart';

import 'chaild_new_product/presintation/child_product_screen.dart';
import 'incoming_goods/presentation/incoming_goods_screen.dart';
import 'new_product/presintation/new_product.dart';



class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 1;
  int selectedProductId = 1;

  bool isSidebarVisible = true;

  bool isActive = true;

  final TextEditingController productNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController brandController = TextEditingController();
  final TextEditingController originController = TextEditingController();
  final TextEditingController basePriceController = TextEditingController();
  final TextEditingController discountController = TextEditingController();

  String discountType = 'Percentage';
  List<Map<String, String>> variants = [
    {'size': '', 'color': '', 'stock': '', 'price': ''},
    {'size': '', 'color': '', 'stock': '', 'price': ''},
  ];

  List<String> productImages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          if (isSidebarVisible) _buildSidebar(),
          Expanded(
            child: Column(
              children: [
                _buildTopBar(),
                Expanded(
                  child: selectedIndex == 1
                      ? BlocProvider.value(
                    value: context.read<ProductsScreenBloc>(),
                    child: ProductsScreen(
                      onAddNewProduct: () {},
                      id: (id) {
                        selectedProductId = id;
                        setState(() {
                          selectedIndex = 5;
                        });
                      },
                      onEditProduct: (date) {
                        // BlocProvider.value(
                        //   value: context.read<EditeProductsScreenBloc>(),
                        //   child: EditeProductForm(
                        //     editeProductRequest: date,
                        //     onSaved: () {},
                        //   ),
                        // );
                      },
                    ),
                  )
                      : selectedIndex == 4
                      ? SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    child: AddProductForm(

                      onSaved: () {
                        final bloc = context.read<ProductsScreenBloc>();
                        print("Bloc: $bloc");

                        bloc.add(
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

                        setState(() {
                          selectedIndex = 1;
                        });
                      },
                    ),
                  )
                      : selectedIndex == 5
                      ? ChildProductsScreen(
                    product_id: selectedProductId,
                    onAddNewProduct: () {

                    },
                    onTabBack: (){
                      setState(() {
                        selectedIndex=1;
                      });
                    },
                    id: (id) {},
                  )
                  :selectedIndex==3?
                  IncomingGoodsScreen():
                       Center(
                    child: Text(
                      'Other Screen',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebar() {
    return Container(
      width: 260,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(right: BorderSide(color: Colors.grey[200]!)),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.shopping_bag, color: Colors.blue[600], size: 28),
                    const SizedBox(width: 8),
                    Text(
                      'Commerce',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[600],
                      ),
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.menu_open, color: Colors.grey),
                  onPressed: () {
                    setState(() {
                      isSidebarVisible = false;
                    });
                  },
                  tooltip: 'Sidebar\'ni yashirish',
                ),
              ],
            ),
          ),
          Divider(height: 1, color: Colors.grey[200]),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildMenuItem(
                  Icons.dashboard,
                  'Dashboard',
                  selectedIndex == 0,
                      (index) {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  0,
                ),
                _buildMenuItem(
                  Icons.inventory_2,
                  'Products',
                  selectedIndex == 1,
                      (index) {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  1,
                ),
                _buildMenuItem(
                  Icons.shopping_cart,
                  'Orders',
                  selectedIndex == 3,
                      (index) {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  3,
                ),

                _buildMenuItem(Icons.add, 'New Product', selectedIndex == 4, (
                    index,
                    ) {
                  setState(() {
                    selectedIndex = index;
                  });
                }, 4),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
      IconData icon,
      String label,
      bool isSelected,
      Function(int) onTap,
      int index,
      ) {
    return GestureDetector(
      onTap: () => onTap(index),
      child: Container(
        margin: const EdgeInsets.only(bottom: 4),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue[50] : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: ListTile(
          leading: Icon(
            icon,
            color: isSelected ? Colors.blue[600] : Colors.grey[700],
            size: 20,
          ),
          title: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.blue[600] : Colors.grey[700],
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              fontSize: 14,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 4,
          ),
          dense: true,
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    // String title = selectedIndex == 1
    //     ? 'Products'
    //     : selectedIndex == 4
    //     ? 'Add New Product'
    //     : selectedIndex == 2
    //     ? 'Orders'
    //     : selectedIndex == 3
    //     ? 'Customers'
    //     : selectedIndex == 5
    //     ? 'Child Products'
    //     : 'Dashboard';
    //
    // final menuButton = !isSidebarVisible
    //     ? IconButton(
    //   icon: const Icon(Icons.menu, color: Colors.grey),
    //   onPressed: () {
    //     setState(() {
    //       isSidebarVisible = true;
    //     });
    //   },
    //   tooltip: 'Sidebar\'ni ko\'rsatish',
    // )
    //     : SizedBox.shrink();


    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Colors.grey[200]!)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

        ],
      ),
    );
  }




}