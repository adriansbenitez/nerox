import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppDropdownItem extends StatelessWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final GestureTapCallback? onTap;
  final ValueChanged<String?>? onChanged;
  final ValueChanged<String?>? onSubmitted;
  final bool? autofocus;
  final bool? enabled;
  final List<String> items;
  final String selected;

  const AppDropdownItem(
      {Key? key,
      this.controller,
      this.focusNode,
      this.onTap,
      this.onChanged,
      this.onSubmitted,
      this.autofocus = false,
      this.enabled = true,
      this.items = const [
        'male',
        'female'
      ], //TODO internacionalizar esto!
      this.selected = 'Masculino'})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).dividerColor.withOpacity(.07),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: <Widget>[
          Row(
            children: [
              Expanded(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: DropdownButton<String>(
                          underline: SizedBox(),
                          value: selected,
                          items: items.map((String value) {
                            return DropdownMenuItem<String>(
                                value: value, child: Text(value));
                          }).toList(),
                          isExpanded: true,
                          onChanged: onChanged)))
            ],
          ),
        ],
      ),
    );
  }
}
