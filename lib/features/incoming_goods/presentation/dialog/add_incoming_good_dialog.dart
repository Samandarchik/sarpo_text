import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../data/request/add_incoming_good_date.dart';
import '../../data/request/factrys_add_request.dart';
import '../../data/response/factory_get_all_response.dart';
import 'add_factrys_dialog.dart';

Future<void> showIncomingGoodDialog(
  BuildContext context,
  Function(IncomingGoodsAddRequest date) onSavedCallback,
  Function(FactriysAddRequest addFactriys) addFactriys,

  List<Factory> fact,
) async {
  await showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext dialogContext) {
      return _IncomingGoodDialogContent(
        onSavedCallback: onSavedCallback,
        fact: fact,
        addFactriys: addFactriys,
      );
    },
  );
}

class _IncomingGoodDialogContent extends StatefulWidget {
  final List<Factory> fact;
  final Function(IncomingGoodsAddRequest date) onSavedCallback;
  final Function(FactriysAddRequest addFactriys) addFactriys;

  _IncomingGoodDialogContent({
    required this.onSavedCallback,
    required this.fact,
    required this.addFactriys,
  });

  @override
  State<_IncomingGoodDialogContent> createState() {
    return __IncomingGoodDialogContentState();
  }
}

class __IncomingGoodDialogContentState
    extends State<_IncomingGoodDialogContent> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  late int factriys_id = 0;

  @override
  void initState() {
    super.initState();

    timeController.text = DateFormat("HH:mm").format(DateTime.now());
  }

  @override
  void dispose() {
    dateController.dispose();
    timeController.dispose();
    super.dispose();
  }

  void _pickDate() async {
    DateTime now = DateTime.now();

    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(1990),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      dateController.text = DateFormat('yyyy-MM-dd').format(picked);
    }
  }

  void _onSavePressed() {
    if (_formKey.currentState!.validate()) {
      String onlyDigitsDate = dateController.text.replaceAll(RegExp(r'[^0-9]'), '');
      String onlyDigitsTime = timeController.text.replaceAll(RegExp(r'[^0-9]'), '');

      int numberDateController = int.parse(onlyDigitsDate);
      int numberTimeController = int.parse(onlyDigitsTime);
      final addFactriys = IncomingGoodsAddRequest(
        date: numberDateController,
        factoryId: factriys_id,
        warehouse: "Skalat",
      );
      widget.onSavedCallback(addFactriys);

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Ma'lumot kiritish"),
      content: Form(
        key: _formKey,
        child: SizedBox(
          width: 600,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _label("Sanani tanlang"),
              GestureDetector(
                onTap: _pickDate,
                child: AbsorbPointer(
                  child: _input(
                    controller: dateController,
                    hintText: "yyyy-MM-dd",
                    validator: (v) =>
                        v == null || v.isEmpty ? "Sana tanlang" : null,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              _label("Hozirgi vaqt"),
              SizedBox(height: 8,),
              _input(
                controller: timeController,
                hintText: "HH:mm",
                enabled: false,
              ),
              SizedBox(height: 16,),
              Row(children: [
                Text("Factriys kiritish "),
              ],),
              SizedBox(height: 8,),
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<int>(
                      onChanged: (int? value) {
                        if (value != null) {
                          setState(() {
                            factriys_id = value;
                          });
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
                      items: widget.fact
                          .map<DropdownMenuItem<int>>(
                            (brand) => DropdownMenuItem<int>(
                              value: brand.id,
                              child: Text(brand.name),
                            ),
                          )
                          .toList(),
                    ),
                  ),

                  const SizedBox(width: 8),

                  IconButton(
                    onPressed: () {
                      showAddFactrysDialog(context, 1, (date) {
                        widget.addFactriys(date);
                      });
                    },
                    icon: const Icon(
                      Icons.add_circle,
                      color: Colors.blue,
                      size: 32,
                    ),
                    tooltip: "Yangi Brand qo'shish",
                  ),
                ],
              ),

              const SizedBox(height: 24),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Bekor qilish"),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: _onSavePressed,
                    child: const Text("Saqlash"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _label(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.w500)),
    );
  }

  Widget _input({
    required TextEditingController controller,
    required String hintText,
    bool enabled = true,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      enabled: enabled,
      validator: validator,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
      ),
    );
  }
}
