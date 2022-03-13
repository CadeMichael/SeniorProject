import 'package:flutter/material.dart';
import 'package:the_crypt/main.dart';

class AddPersonalKeyDialog extends StatefulWidget {
  const AddPersonalKeyDialog({
    Key? key,
    required this.keyFunc,
    required this.title,
  }) : super(key: key);

  // fields
  final String title;
  final Function keyFunc;
  @override
  State<AddPersonalKeyDialog> createState() => _AddPersonalKeyDialogState();
}

class _AddPersonalKeyDialogState extends State<AddPersonalKeyDialog> {
  final nameController = TextEditingController();
  final keyController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  dialogBody(context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.title,
              style: const TextStyle(color: lightPurp),
            ),
          ),
          TextField(
            controller: nameController,
            decoration: const InputDecoration(
              hintText: "name...",
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: IconButton(
              icon: const Icon(
                Icons.add,
                color: green,
              ),
              onPressed: () {
                setState(() {
                  widget.keyFunc(
                    nameController.text,
                  );
                  Navigator.of(context).pop();
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: dialogBody(context),
    );
  }
}