import 'package:flutter/material.dart';

class SafeImage extends StatelessWidget {
  const SafeImage({
    Key? key,
    this.url,
  }) : super(key: key);

  final String? url;

  @override
  Widget build(BuildContext context) {
    return url == null
        ? Container(
            width: 50,
            height: 50,
            color: Colors.green,
          )
        : Image.network(
            url!,
            width: 50,
            height: 50,
          );
  }
}
