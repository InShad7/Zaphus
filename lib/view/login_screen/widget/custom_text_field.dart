import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../utils/color.dart';



class MyTextField extends StatelessWidget {
  MyTextField({
    super.key,
    required this.title,
    required this.myControler,
    this.verify = false,
    this.readOnly = false,
    this.validator,
    this.isEditable,
    this.isNumber = false,
  });
  String title;
  var myControler;
  final verify;
  final readOnly;
  final validator;
  final isEditable;
  final isNumber;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(left: 10),
              margin: const EdgeInsets.all(7),
              // height: 60,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: TextFormField(
                  textAlign: TextAlign.justify,
                  enabled: isEditable,
                  maxLength: isNumber ? 10 : 25,
                  inputFormatters: [
                    isNumber
                        ? FilteringTextInputFormatter.allow(RegExp(r"[0-9]"))
                        : FilteringTextInputFormatter.allow(
                            RegExp(r"[a-z A-Z]"),
                          ),
                  ],
                  validator: validator,
                  keyboardType:
                      isNumber ? TextInputType.number : TextInputType.text,
                  controller: myControler,
                  cursorColor: blue,
                  style: TextStyle(color: black),
                  decoration: InputDecoration(
                    border:
                        const OutlineInputBorder(borderSide: BorderSide.none),
                    contentPadding: const EdgeInsets.all(5),
                    hintText: title,
                    hintStyle: TextStyle(fontSize: 22, color: grey),
                    counterText: '',
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
