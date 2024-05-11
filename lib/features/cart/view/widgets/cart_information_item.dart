import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nike_sneaker_store/gen/assets.gen.dart';
import 'package:nike_sneaker_store/gen/fonts.gen.dart';

class CartInformationItem extends StatelessWidget {
  const CartInformationItem({
    required this.iconPath,
    required this.label,
    required this.onEdit,
    this.controller,
    this.onChanged,
    this.focusNode,
    this.keyboardType,
    this.readOnly = false,
    super.key,
  });

  final String iconPath;
  final TextEditingController? controller;
  final String label;
  final Function() onEdit;
  final Function(String)? onChanged;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            borderRadius: BorderRadius.circular(16),
          ),
          child: SvgPicture.asset(
            iconPath,
            color: Theme.of(context).colorScheme.onPrimaryContainer,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: controller,
                onChanged: onChanged,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                    fontFamily: FontFamily.poppins),
                decoration: const InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
                focusNode: focusNode,
                keyboardType: keyboardType,
                readOnly: readOnly,
              ),
              const SizedBox(height: 2),
              Text(
                label,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: onEdit,
          child: SvgPicture.asset(Assets.icons.icEdit),
        ),
      ],
    );
  }
}
