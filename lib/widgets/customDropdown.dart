import 'package:flutter/material.dart';
import 'package:possystem/utils/appHelper.dart';
import 'package:possystem/features/auth/login/views/widgets/dropdown.dart';

class CustomLoginDropdown extends StatefulWidget {
  final String title;
  final String? subtitle;
  final String? imagePath;
  final List<DropdownModel> items;
  final ValueChanged<String>? onItemSelected;

  const CustomLoginDropdown({
    Key? key,
    required this.title,
    this.subtitle,
    this.imagePath,
    required this.items,
    this.onItemSelected,
  }) : super(key: key);

  @override
  _CustomLoginDropdownState createState() => _CustomLoginDropdownState();
}

class _CustomLoginDropdownState extends State<CustomLoginDropdown> {
  DropdownModel? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.36,
      decoration: BoxDecoration(
        color: AppColors.orangeDark50,
        borderRadius: BorderRadius.circular(6),
      ),
      child: PopupMenuButton<String>(
        surfaceTintColor: Colors.yellow,
        onSelected: (value) {
          setState(() {
            selectedValue = widget.items.firstWhere(
              (item) => item.title == value,
              orElse: () => widget.items.first,
            );
          });
          if (widget.onItemSelected != null) {
            widget.onItemSelected!(value);
          }
        },
        constraints: BoxConstraints.tightFor(
          width: MediaQuery.of(context).size.width * 0.36,
        ),
        itemBuilder: (context) {
          return widget.items
              .map((item) => PopupMenuItem<String>(
                    value: item.title,
                    child: Container(
                      width: double.infinity,
                      // color: AppColors.orangeDark50,
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.title,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            item.description,
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColors.secondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ))
              .toList();
        },
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
                    : SizedBox(),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(selectedValue?.title ?? widget.title,
                        style: AppTexts.medium(size: 16, color: Colors.black)),
                    widget.subtitle != null && widget.subtitle!.isNotEmpty
                        ? Text(selectedValue?.description ?? widget.subtitle!,
                            style: AppTexts.medium(
                                size: 16, color: AppColors.secondary))
                        : SizedBox(),
                  ],
                ),
              ],
            ),
            Icon(
              Icons.keyboard_arrow_down_outlined,
              size: 32,
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
