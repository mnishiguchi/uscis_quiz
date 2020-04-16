import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

// Behaves like the TML Details Element.
// https://developer.mozilla.org/en-US/docs/Web/HTML/Element/details
class VisibilityToggle extends StatefulWidget {
  final Widget child;
  final bool isInitiallyVisible;
  final Text summary;

  const VisibilityToggle({
    Key key,
    @required this.child,
    this.isInitiallyVisible,
    this.summary,
  })  : assert(
          child != null,
        ),
        super(key: key);

  @override
  _VisibilityToggleState createState() => _VisibilityToggleState();
}

class _VisibilityToggleState extends State<VisibilityToggle> {
  bool _isVisible;

  void initState() {
    super.initState();
    _isVisible = widget.isInitiallyVisible ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        FlatButton(
          onPressed: () {
            setState(() {
              _isVisible = !_isVisible;
            });
          },
          child: Row(
            children: <Widget>[
              _isVisible
                  ? const Icon(Icons.arrow_drop_down)
                  : const Icon(Icons.arrow_right),
              widget.summary ?? Text('Details'),
            ],
          ),
        ),
        Visibility(
          child: widget.child,
          visible: _isVisible,
        ),
      ],
    );
  }
}
