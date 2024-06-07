
import 'package:flutter/material.dart';

import '../utilities/dimensions.dart';

class DialogProgress extends StatelessWidget {

  final String message;

  DialogProgress(this.message);

  @override
  Widget build(BuildContext context) {

    var theme = Theme.of(context);

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular((cardRadius))),
      content: Row(
        children: <Widget>[
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(theme.primaryColor),
          ),
          SizedBox(width: standardMargin * 2),
          Expanded(child: Text(message))
        ],
      ),
    );
  }
}
