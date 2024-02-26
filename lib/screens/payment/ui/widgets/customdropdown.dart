import 'package:flutter/material.dart';
import 'package:persing/screens/payment/provider/payment_provider.dart';
import 'package:provider/provider.dart';

class CustomDropButton extends StatefulWidget {
  const CustomDropButton({
    required this.items,
    required this.controller,
    this.page = '',
    required this.style,
    Key? key,
  }) : super(key: key);

  final List<String> items;
  final TextEditingController controller;
  final String page;
  final TextStyle style;

  @override
  State<CustomDropButton> createState() => _CustomDropButtonState();
}

class _CustomDropButtonState extends State<CustomDropButton> {
  late String value;

  @override
  void initState() {
    value = widget.items[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final paymentProvider = Provider.of<PaymentProvider>(context);
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: DropdownButton(
              items: getOpciones(),
              value: value,
              style: widget.style,
              onChanged: (value) async {
                widget.controller.text = value.toString();
                paymentProvider.setBankPseSelect = value!;
              },
            ),
          ),
        ),
      ],
    );
  }

  List<DropdownMenuItem<String>> getOpciones() {
    final List<DropdownMenuItem<String>> list = [];
    for (final item in widget.items) {
      list.add(
        DropdownMenuItem(
          value: item,
          child: Text(item),
        ),
      );
    }

    return list;
  }
}
