import 'package:belts_test/app/theme/belts_theme.dart';
import 'package:flutter/material.dart';

class CustomTextFieldWidget extends StatelessWidget {
  const CustomTextFieldWidget({
    Key? key,
    required this.onChange,
    required this.placeholder,
  }) : super(key: key);

  final String placeholder;
  final ValueChanged<String> onChange;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 195,
      height: 40,
      child: TextField(
        style: BeltsTheme.themeData.textTheme.labelSmall,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(8),
          filled: true,
          fillColor: Colors.white,
          counterText: '',
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
          hintText: placeholder,
          hintStyle: const TextStyle(color: Colors.black26),
        ),
        maxLength: 9,
        onChanged: onChange,
      ),
    );
  }
}
