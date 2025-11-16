import 'package:flutter/material.dart';

class CustomDropdown extends StatelessWidget {
  final String value;
  final List<Map<String, dynamic>> items;
  final String label;
  final Function(String?) onChanged;

  const CustomDropdown({
    super.key,
    required this.value,
    required this.items,
    required this.label,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xFF1E293B),
          ),
        ),
        SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xFFE2E8F0)),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              underline: SizedBox(),
              onChanged: onChanged,
              items: items.map<DropdownMenuItem<String>>((
                Map<String, dynamic> item,
              ) {
                return DropdownMenuItem<String>(
                  value: item['value'],
                  child: Text(item['label']),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
