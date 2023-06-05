import 'package:flutter/material.dart';
import '../values/app.colors.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.onPressed,
    required this.label,
    required this.width,
    this.isActive = true,
  });
  final VoidCallback? onPressed;
  final String? label;
  final double? width;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onPressed,
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        child: Container(
          width: width,
          height: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: isActive ? AppColors.secondaryColor : AppColors.greyColor,
              borderRadius: const BorderRadius.all(
                Radius.circular(50),
              )),
          child: Text(
            label!,
            style: const TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ));
  }
}
