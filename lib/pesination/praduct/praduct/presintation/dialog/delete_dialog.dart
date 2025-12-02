import 'package:flutter/material.dart';


void showSimpleDeleteConfirmDialog(BuildContext context, VoidCallback onConfirm) {
  showDialog(

    context: context,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        title: const Text('O\'chirish?'),

        content: const Text('Haqiqatan ham o\'chirmoqchimisiz?'),

        actions: <Widget>[
          TextButton(
            child: const Text('YO\'Q'),
            onPressed: () {
              Navigator.of(dialogContext).pop();
            },
          ),

          TextButton(
            child: const Text(
              'HA',
              style: TextStyle(color: Colors.red),
            ),
            onPressed: () {
              Navigator.of(dialogContext).pop();
              onConfirm();
            },
          ),
        ],
      );
    },
  );
}