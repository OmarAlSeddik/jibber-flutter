import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jibber/core/constants/typography.dart';

class CustomTextfield extends StatelessWidget {
  const CustomTextfield(
      {super.key,
      this.focusNode,
      this.controller,
      this.hintText,
      this.onChanged,
      this.onTap,
      this.isChatText = false,
      this.isSearch = false});

  final void Function(String)? onChanged;
  final String? hintText;
  final FocusNode? focusNode;
  final bool isSearch;
  final bool isChatText;
  final TextEditingController? controller;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: isChatText ? 35.h : null,
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        focusNode: focusNode,
        decoration: InputDecoration(
          contentPadding:
              isChatText ? EdgeInsets.symmetric(horizontal: 12.w) : null,
          hintText: hintText,
          hintStyle: body,
          suffixIcon: isSearch
              ? Container(
                  height: 55,
                  width: 55,
                  padding: const EdgeInsets.all(12),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(12.r)),
                  child: Icon(
                    Icons.search_rounded,
                    color: Theme.of(context).colorScheme.primary,
                    size: 24.0,
                    semanticLabel: 'Search',
                  ),
                )
              : isChatText
                  ? InkWell(onTap: onTap, child: const Icon(Icons.send))
                  : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(isChatText ? 25.r : 10.r),
            borderSide: BorderSide(
              color:
                  Theme.of(context).colorScheme.primary, // Primary border color
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(isChatText ? 25.r : 10.r),
            borderSide: BorderSide(
              color:
                  Theme.of(context).colorScheme.primary, // Primary border color
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(isChatText ? 25.r : 10.r),
            borderSide: BorderSide(
              color:
                  Theme.of(context).colorScheme.primary, // Primary border color
              width: 2.0, // Slightly thicker border on focus
            ),
          ),
        ),
      ),
    );
  }
}
