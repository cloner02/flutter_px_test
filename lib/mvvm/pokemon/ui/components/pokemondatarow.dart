import 'package:flutter/material.dart';

class PokemonDataRow extends StatelessWidget {
  final String label;
  final String value;
  const PokemonDataRow({
    Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.white // set the border radius
        ),
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Expanded(
            child: Text(label, textAlign: TextAlign.end, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 20)),
          ),
          Expanded(
            child: Padding(
            padding: const EdgeInsets.only(left: 8.0), // Add left padding here
            child: Text(value, textAlign: TextAlign.start, style: const TextStyle(fontSize: 20)),
            ),
          ),
          ],
              )
        ),
      )
    );
  }

}
