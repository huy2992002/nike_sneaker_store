import 'package:flutter/material.dart';
import 'package:nike_sneaker_store/l10n/app_localizations.dart';
import 'package:nike_sneaker_store/resources/ns_color.dart';

class NSReadMore extends StatefulWidget {
  /// Creates a read more text
  /// 
  /// The [text] arguments must not be null.
  /// The default value [maxLine] arguments is 3.
  const NSReadMore({
    required this.text,
    this.maxLine = 3,
    super.key,
  });

  final String text;
  final int maxLine;

  @override
  State<NSReadMore> createState() => _NSReadMoreState();
}

class _NSReadMoreState extends State<NSReadMore> {
  /// If [_isShowAllText] is true, full text will be displayed. 
  /// If false, it will be displayed with a maxLine argument
  bool _isShowAllText = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        InkWell(
          onTap: () => setState(() => _isShowAllText = !_isShowAllText),
          hoverColor: Colors.transparent,
          child: Text(
            widget.text,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: NSColor.neutral,
                  fontWeight: FontWeight.w400,
                ),
            maxLines: _isShowAllText ? null : widget.maxLine,
            overflow: _isShowAllText ? null : TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(height: 10),
        if (!_isShowAllText)
          GestureDetector(
            onTap: () => setState(() => _isShowAllText = true),
            child: Text(
              AppLocalizations.of(context).readMore,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w400,
                  ),
              textAlign: TextAlign.right,
            ),
          ),
      ],
    );
  }
}
