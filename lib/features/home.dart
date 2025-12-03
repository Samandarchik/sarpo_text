import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled7/features/praduct/data/product_response/product_request.dart';
import 'package:untitled7/features/praduct/presintation/bloc/product_bloc.dart';
import 'package:untitled7/features/praduct/presintation/bloc/product_event.dart';
import 'package:untitled7/features/praduct/presintation/product_screen.dart';

import 'chaild_new_product/presintation/child_product_screen.dart';
import 'new_product/presintation/new_product.dart';



class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

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
                    onAddNewProduct: () {},
                    onEditProduct: (onEditProduct) {},
                    id: (id) {},
                  )
                      : Center(
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
                  selectedIndex == 2,
                      (index) {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  2,
                ),
                _buildMenuItem(Icons.people, 'Customers', selectedIndex == 3, (
                    index,
                    ) {
                  setState(() {
                    selectedIndex = index;
                  });
                }, 3),
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
    String title = selectedIndex == 1
        ? 'Products'
        : selectedIndex == 4
        ? 'Add New Product'
        : 'Dashboard';

    final menuButton = !isSidebarVisible
        ? IconButton(
      icon: const Icon(Icons.menu, color: Colors.grey),
      onPressed: () {
        setState(() {
          isSidebarVisible = true;
        });
      },
      tooltip: 'Sidebar\'ni ko\'rsatish',
    )
        : SizedBox.shrink();


    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Colors.grey[200]!)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              menuButton,
              if (!isSidebarVisible) const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ],
          ),

        ],
      ),
    );
  }

  Widget _buildAddProductForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildGeneralInformation(),
        const SizedBox(height: 24),
        _buildVariants(),
        const SizedBox(height: 24),
        _buildSettings(),
        const SizedBox(height: 24),
        _buildPricingDiscounts(),
        const SizedBox(height: 24),
        _buildProductImages(),
      ],
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
          const Text(
            'General Information',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),

          const Text(
            'Product Name',
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
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

          const Text(
            'Product Description',
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
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
                    const Text(
                      'Category',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                      items: ['Clothing', 'Electronics', 'Food', 'Books']
                          .map(
                            (cat) =>
                            DropdownMenuItem(value: cat, child: Text(cat)),
                      )
                          .toList(),
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
                    const Text(
                      'Brand',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: brandController,
                      decoration: InputDecoration(
                        hintText: 'e.g. Nike',
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
                      'Origin',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: originController,
                      decoration: InputDecoration(
                        hintText: 'e.g. Vietnam',
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
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildVariants() {
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Variants',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    variants.add({
                      'size': '',
                      'color': '',
                      'stock': '',
                      'price': '',
                    });
                  });
                },
                icon: const Icon(Icons.add, size: 18),
                label: const Text('Add Variant'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[600],
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: variants.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey[200]!),
                ),
                child: Row(
                  children: [
                    Icon(Icons.drag_indicator, color: Colors.grey[400]),
                    const SizedBox(width: 16),

                    Expanded(
                      child: TextField(
                        decoration: const InputDecoration(
                          labelText: 'Size',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.all(12),
                        ),
                        controller: TextEditingController(
                          text: variants[index]['size'],
                        ),
                        onChanged: (value) {
                          variants[index]['size'] = value;
                        },
                      ),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: TextField(
                        decoration: const InputDecoration(
                          labelText: 'Color',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.all(12),
                        ),
                        controller: TextEditingController(
                          text: variants[index]['color'],
                        ),
                        onChanged: (value) {
                          variants[index]['color'] = value;
                        },
                      ),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: TextField(
                        decoration: const InputDecoration(
                          labelText: 'Stock',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.all(12),
                        ),
                        controller: TextEditingController(
                          text: variants[index]['stock'],
                        ),
                        onChanged: (value) {
                          variants[index]['stock'] = value;
                        },
                      ),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: TextField(
                        decoration: const InputDecoration(
                          labelText: 'Price',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.all(12),
                        ),
                        controller: TextEditingController(
                          text: variants[index]['price'],
                        ),
                        onChanged: (value) {
                          variants[index]['price'] = value;
                        },
                      ),
                    ),

                    const SizedBox(width: 12),

                    IconButton(
                      onPressed: () {
                        setState(() {
                          variants.removeAt(index);
                        });
                      },
                      icon: Icon(Icons.delete_outline, color: Colors.red[400]),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSettings() {
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
          const Text(
            'Settings',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Status (IsActive)',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              Switch(
                value: isActive,
                onChanged: (value) => setState(() => isActive = value),
                activeColor: Colors.blue[600],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPricingDiscounts() {
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
          const Text(
            'Pricing & Discounts',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),

          const Text(
            'Base Price',
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: basePriceController,
            decoration: InputDecoration(
              prefixText: '\$ ',
              hintText: '0.00',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
            ),
            keyboardType: TextInputType.number,
          ),

          const SizedBox(height: 20),

          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Discount Type',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      value: discountType,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                      items: ['Percentage', 'Fixed']
                          .map(
                            (type) => DropdownMenuItem(
                          value: type,
                          child: Text(type),
                        ),
                      )
                          .toList(),
                      onChanged: (value) =>
                          setState(() => discountType = value!),
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
                      'Discount Value',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: discountController,
                      decoration: InputDecoration(
                        hintText: '0',
                        suffixText: '%',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProductImages() {
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
          const Text(
            'Product Images',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),

          Container(
            height: 200,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey[300]!,
                style: BorderStyle.solid,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.cloud_upload_outlined,
                    size: 48,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 12),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(color: Colors.grey[600], fontSize: 14),
                      children: [
                        TextSpan(
                          text: 'Click to upload',
                          style: TextStyle(
                            color: Colors.blue[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const TextSpan(text: ' or drag and drop'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'SVG, PNG, JPG or GIF (max. 800x400px)',
                    style: TextStyle(color: Colors.grey[500], fontSize: 12),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          Row(
            children: [
              _buildImageThumbnail(Colors.green[700]!),
              const SizedBox(width: 12),
              _buildImageThumbnail(Colors.brown[300]!),
              const SizedBox(width: 12),
              _buildImageThumbnail(Colors.green[200]!),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildImageThumbnail(Color color) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}