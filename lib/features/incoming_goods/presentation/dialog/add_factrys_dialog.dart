import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


import '../../data/request/factrys_add_request.dart';

typedef OnFactryEditeSaved =
void Function(FactriysAddRequest updatedFactry);

Future<void> showAddFactrysDialog(
    BuildContext context,
    int? factryId,
    Function(FactriysAddRequest) onSavedCallback,
    ) async {
  await showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext dialogContext) {
      return _AddFactryDialogContent(
        factryId: factryId,
        onSavedCallback: onSavedCallback,
      );
    },
  );
}

class _AddFactryDialogContent extends StatefulWidget {
  final OnFactryEditeSaved onSavedCallback;
  final int? factryId;

  _AddFactryDialogContent({
    required this.onSavedCallback,
    required this.factryId,
  });

  @override
  State<_AddFactryDialogContent> createState() =>
      __AddFactryDialogContentState();
}

class __AddFactryDialogContentState
    extends State<_AddFactryDialogContent> {

  final _formKey = GlobalKey<FormState>();

  final TextEditingController addressController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    addressController.dispose();
    nameController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  void _onSavePressed() {
    if (_formKey.currentState!.validate()) {
      final newFactryRequest = FactriysAddRequest(
        address: addressController.text,
        name: nameController.text,
        phoneNumber: phoneNumberController.text,
      );

      widget.onSavedCallback(newFactryRequest);


      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Yangi zavod qo'shish uchun yuborildi.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Zavod qo'shish"),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
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
          const Text(
            'Nomi',
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          _buildTextField(
            controller: nameController,
            hintText: 'Zavod nomini kiriting',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Iltimos, zavod nomini kiriting.';
              }
              return null;
            },
          ),

          const SizedBox(height: 20),

          const Text(
            'Manzil',
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          _buildTextField(
            controller: addressController,
            hintText: 'Manzilni kiriting',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Iltimos, manzilni kiriting.';
              }
              return null;
            },
          ),

          const SizedBox(height: 20),

          const Text(
            'Telefon raqam',
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          _buildTextField(
            controller: phoneNumberController,
            hintText: '+998 ** *** ** **',
            keyboardType: TextInputType.phone,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Iltimos, telefon raqamini kiriting.';
              }
              if (value.length < 9) {
                return 'Telefon raqami kamida 9 ta raqam boʻlishi kerak.';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    String? Function(String?)? validator,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
      ),
    );
  }
}