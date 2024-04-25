import 'package:flutter/material.dart';

import '../../../components/appbar.dart';

class CollectionWidget extends StatefulWidget {
  const CollectionWidget({super.key});

  @override
  State<StatefulWidget> createState() {
    return _CollectionState();
  }
}

class _CollectionState extends State<CollectionWidget> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(
        title: 'Collection',
      ),
      body: Center(
        child: Text('collection'),
      )
    );
  }
}