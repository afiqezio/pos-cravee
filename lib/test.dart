import 'package:flutter/material.dart';
import 'package:possystem/utils/appHelper.dart';

class CustomDropdown extends StatefulWidget {
  final String title;
  final String? subtitle;
  final String? imagePath;
  final List<String> items;
  final ValueChanged<String>? onItemSelected;

  const CustomDropdown({
    Key? key,
    required this.title,
    this.subtitle,
    this.imagePath,
    required this.items,
    this.onItemSelected,
  }) : super(key: key);

  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.36,
      decoration: BoxDecoration(
        color: AppColors.orangeDark50,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              widget.imagePath != null && widget.imagePath!.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        radius: 25,
                        backgroundImage: AssetImage(widget.imagePath!),
                      ),
                    )
                  : SizedBox.shrink(),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    selectedValue ?? widget.title,
                    style: AppTexts.medium(size: 18, color: Colors.black),
                  ),
                  widget.subtitle != null && widget.subtitle!.isNotEmpty
                      ? Text(
                          widget.subtitle!,
                          style: AppTexts.medium(
                              size: 18, color: AppColors.secondary),
                        )
                      : SizedBox.shrink(),
                ],
              ),
            ],
          ),
          PopupMenuButton<String>(
            icon: Icon(
              Icons.arrow_drop_down_outlined,
              size: 32,
              color: Colors.black,
            ),
            onSelected: (value) {
              setState(() {
                selectedValue = value;
              });
              if (widget.onItemSelected != null) {
                widget.onItemSelected!(value);
              }
            },
            itemBuilder: (context) {
              return widget.items
                  .map((item) => PopupMenuItem<String>(
                        value: item,
                        child: Text(item),
                      ))
                  .toList();
            },
          ),
        ],
      ),
    );
  }
}
