import 'package:flutter/widgets.dart';

class CustomInput extends StatelessWidget {
  final String text;
  final String label;
  final TextEditingController controller;
  final bool isPassword;
  final TextInputType keyboardType;

  const CustomInput({
    super.key,
    required this.text,
    required this.label,
    required this.controller,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 4),
          child: Text(
            label,
            style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xff333333)),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
              color: const Color(0xFFF0F0F0),
              borderRadius: BorderRadius.circular(8),
              boxShadow: const [
                BoxShadow(
                  color: Color(0xFF000000),
                  offset: Offset(0, 2),
                  blurRadius: 4,
                )
              ]),
          child: EditableText(
            controller: controller,
            focusNode: FocusNode(),
            style: const TextStyle(fontSize: 16, color: Color(0xff000000)),
            cursorColor: const Color(0xff3333FF),
            backgroundCursorColor: const Color(0xff3333FF),
            keyboardType: keyboardType,
            obscureText: isPassword,
            maxLines: 1,
          ),
        )
      ],
    );
  }
}
