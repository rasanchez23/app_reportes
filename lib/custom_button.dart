import 'package:flutter/widgets.dart';

class  CustomButton extends StatelessWidget {
  final String texto;
  final VoidCallback? onPressed;
  final Color? colorFondo;
  final Color? colorTexto;

  const CustomButton({
    super.key,
    required this.texto,
    this.onPressed,
    this.colorFondo = const Color.fromARGB(255, 107, 6, 107),
    this.colorTexto = const Color(0xFFFFFFFF),
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: colorFondo,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              // ignore: deprecated_member_use
              color: const Color(0xFF000000).withOpacity(0.2),
              offset: const Offset(0, 4),
              blurRadius: 6,
            ),
          ],
        ),
        child: Text(
          texto,
          style: TextStyle(
            color: colorTexto,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
