import 'package:delivery_app/utils/colors.dart';
import 'package:delivery_app/utils/dimensions.dart';
import 'package:delivery_app/widgets/big_text.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.icon,
    required this.label,
    this.obscure = false,
    this.maxlines = false,
  });

  final TextEditingController controller;
  final String hintText;
  final IconData icon;
  final String label;
  final bool obscure; // Changed to final as it's a StatelessWidget
  final bool maxlines; // Changed to final as it's a StatelessWidget

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: Dimensions.height20),
        BigText(
          text: label,
          fontWeight: FontWeight.bold,
          size: Dimensions.font26,
          color: Theme.of(context).canvasColor,
        ),
        Container(
          margin: const EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          child: TextFormField(
            maxLines: maxlines ? 3 : 1,
            controller: controller,
            obscureText: obscure,
            // ADD THIS STYLE BLOCK
            style: const TextStyle(
              color: Colors.black, // Forces typed text to be black
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: Theme.of(context).cardColor,
              hintText: hintText,
              // Optional: If you want the hint text to also be a specific color
              hintStyle: TextStyle(color: Colors.grey[600]),
              prefixIcon: Icon(
                icon,
                color: AppColors.mainColor,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                    width: 1.0,
                    color: Theme.of(context).scaffoldBackgroundColor),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                    width: 1.0,
                    color: Theme.of(context).scaffoldBackgroundColor),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
      ],
    );
  }
}