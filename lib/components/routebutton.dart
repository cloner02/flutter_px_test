import 'package:flutter/material.dart';


class RouteButton extends StatelessWidget {
  final BuildContext context;
  final Widget route;
  final String value;

  const RouteButton({
    Key? key,
    required this.context,
    required this.route,
    required this.value
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
    style: ElevatedButton.styleFrom(
      shape: const CircleBorder(),
      padding: const EdgeInsets.all(64),
    ),
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 150),
      child: Text(value, textAlign: TextAlign.center),
    ),
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => route),
      );
    },
    );
  }

}
