import 'package:flutter/material.dart';
import 'package:possystem/features/auth/login/views/login.dart';
import 'package:possystem/features/auth/login/views/widgets/dropdown.dart';
import 'package:possystem/utils/appHelper.dart';

class CustomLoginDropdown extends StatefulWidget {
  final String? imagePath;
  final List<DropdownModel> items;
  final ValueChanged<String>? onItemSelected;

  const CustomLoginDropdown({
    Key? key,
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
        surfaceTintColor: Colors.white,
        onSelected: (value) {
          if (value == 'Add Account') {
            // Navigate to the login page
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
            );
          } else if (widget.onItemSelected != null) {
            setState(() {
              selectedValue = widget.items.firstWhere(
                (item) => item.title == value,
                orElse: () => widget.items.first,
              );
              widget.onItemSelected!(value);
            });
          }
        },
        constraints: BoxConstraints.tightFor(
          width: MediaQuery.of(context).size.width * 0.36,
        ),
        itemBuilder: (context) {
          return [
            // Wrap your dropdown items in a scrollable container
            PopupMenuItem<String>(
              enabled: false, // Disable the container itself as a menu item
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: 200,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: widget.items
                        .map((item) => ListTile(
                              contentPadding: EdgeInsets.zero,
                              title: Text(
                                item.title,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                              subtitle: item.description != null
                                  ? Text(
                                      item.description!,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: AppColors.secondary,
                                      ),
                                    )
                                  : null,
                              onTap: () {
                                Navigator.pop(context);
                                setState(() {
                                  selectedValue = item;
                                });
                                if (widget.onItemSelected != null) {
                                  widget.onItemSelected!(item.title);
                                }
                              },
                            ))
                        .toList(),
                  ),
                ),
              ),
            ),
            // Add the 'Add Account' item
            PopupMenuItem<String>(
              value: 'Add Account',
              child: Row(
                children: [
                  Icon(Icons.add),
                  SizedBox(width: 8),
                  Text(
                    'Add Account',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ];
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
                // Selected value
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      selectedValue?.title ??
                          (widget.items.isNotEmpty
                              ? widget.items.first.title
                              : 'Add Account'),
                      style: AppTexts.medium(size: 16, color: Colors.black),
                    ),
                    widget.items.isNotEmpty &&
                            widget.items.first.description != null &&
                            widget.items.first.description!.isNotEmpty
                        ? Text(
                            selectedValue?.description ??
                                (widget.items.isNotEmpty
                                    ? widget.items.first.description!
                                    : ''),
                            style: AppTexts.medium(
                                size: 16, color: AppColors.secondary),
                          )
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
