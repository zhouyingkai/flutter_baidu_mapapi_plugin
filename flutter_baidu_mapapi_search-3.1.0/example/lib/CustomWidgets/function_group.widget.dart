import 'package:flutter/material.dart';

class FunctionGroup extends StatelessWidget {
  const FunctionGroup({
    Key? key,
    required this.headLabel,
    this.children = const [],
  }) : super(key: key);

  final String headLabel;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(headLabel,
                    strutStyle: StrutStyle(fontSize: 16),
                    style: Theme.of(context).textTheme.headline5),
              ),
              Divider(height: 1, indent: 16),
            ],
          ),
        ]..addAll(children),
      ),
    );
  }
}
