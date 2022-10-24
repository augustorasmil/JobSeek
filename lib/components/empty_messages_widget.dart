import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class EmptyMessagesWidget extends StatefulWidget {
  const EmptyMessagesWidget({
    Key? key,
    this.title,
    this.bodyText,
  }) : super(key: key);

  final String? title;
  final String? bodyText;

  @override
  _EmptyMessagesWidgetState createState() => _EmptyMessagesWidgetState();
}

class _EmptyMessagesWidgetState extends State<EmptyMessagesWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          children: [
            if (Theme.of(context).brightness == Brightness.dark)
              Image.asset(
                'assets/images/noMessagesDark@2x.png',
                width: 230,
                height: 230,
                fit: BoxFit.cover,
              ),
            if (!(Theme.of(context).brightness == Brightness.dark))
              Image.asset(
                'assets/images/noMessages_Light@2x.png',
                width: 230,
                height: 230,
                fit: BoxFit.cover,
              ),
          ],
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                valueOrDefault<String>(
                  widget.title,
                  'No Messages',
                ),
                textAlign: TextAlign.center,
                style: FlutterFlowTheme.of(context).title3,
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(12, 4, 12, 0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  valueOrDefault<String>(
                    widget.bodyText,
                    'Body Text',
                  ),
                  textAlign: TextAlign.center,
                  style: FlutterFlowTheme.of(context).subtitle2,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
