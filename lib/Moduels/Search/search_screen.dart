


import 'package:flutter/material.dart';
import 'package:socialapp3/Shared/Style/icon_broken.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(IconBroken.arrowLeft2),
          onPressed: ()
          {
            Navigator.pop(context);
          },
        ),
        title: const Text('Search'),
        titleSpacing: 0,
      ),
      body: const Center(
        child: Text(
          'Search Screen',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
    );
  }
}
