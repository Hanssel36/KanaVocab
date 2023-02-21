import 'package:flutter/material.dart';

class ParentWidget extends StatefulWidget {
  const ParentWidget({Key? key}) : super(key: key);

  @override
  _ParentWidgetState createState() => _ParentWidgetState();
}

class _ParentWidgetState extends State<ParentWidget> {
  bool _isChecked = false;

  void _handleCheckboxChanged(bool isChecked) {
    setState(() {
      _isChecked = isChecked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Parent Widget'),
      ),
      body: ChildWidget(
        isChecked: _isChecked,
        onCheckboxChanged: _handleCheckboxChanged,
      ),
    );
  }
}

class ChildWidget extends StatefulWidget {
  final bool isChecked;
  final void Function(bool) onCheckboxChanged;

  const ChildWidget({
    Key? key,
    required this.isChecked,
    required this.onCheckboxChanged,
  }) : super(key: key);

  @override
  _ChildWidgetState createState() => _ChildWidgetState();
}

class _ChildWidgetState extends State<ChildWidget> {
  bool _isChecked = false;

  @override
  void initState() {
    super.initState();
    _isChecked = widget.isChecked;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Checkbox(
          value: _isChecked,
          onChanged: (newValue) {
            setState(() {
              _isChecked = newValue!;
              widget.onCheckboxChanged(_isChecked);
            });
          },
        ),
      ),
    );
  }
}
