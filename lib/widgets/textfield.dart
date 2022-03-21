import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:water_metering_app/models/user.dart';
import 'package:provider/provider.dart';
import 'package:water_metering_app/providers/user_provider.dart';


class TextFieldWidget extends StatefulWidget {
  final String label;
  final String text;
  final ValueChanged<String> onChanged;

  const TextFieldWidget({Key? key, required this.label, required this.text, required this.onChanged}) : super(key: key);

  @override
  _TextFieldWidgetState createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  late final TextEditingController controller;
  String? newname;

  @override
  void initState() {
    controller = TextEditingController(text: widget.text);
    super.initState();
    controller.addListener(_printLatestValue);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _printLatestValue() {
    print('Name: ${controller.text}');
  }


  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        widget.label,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height:5),
      TextField(
        controller: controller,
      ),
      TextButton(
          onPressed: (){
            newname = controller.text;
            print(newname);
          },
          child: Text('Save'),
      ),
    ],
  );
}
