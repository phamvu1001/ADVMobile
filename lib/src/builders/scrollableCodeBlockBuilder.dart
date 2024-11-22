import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:highlight/highlight.dart';
import 'package:markdown/markdown.dart' as md;

class ScrollableCodeblockbuilder extends MarkdownElementBuilder {
  final TextStyle codeStyle;

  ScrollableCodeblockbuilder({required this.codeStyle});

  @override
  Widget visitElementAfter(md.Element element, TextStyle? preferredStyle) {
    final String textContent = element.textContent;  
    final language = element.attributes['class']?.split('-').last ?? '';

    final highlighted = highlight.parse(
      textContent,
      language: language.isNotEmpty ? language : 'dart',
      autoDetection: true,
    );

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        width: double.infinity,
        color: Colors.grey[900],
        padding: const EdgeInsets.all(8.0),
        child: Text.rich(
          TextSpan(
            style: codeStyle,
            children: highlighted.nodes?.map((node) {
              return TextSpan(
                text: node.value,
                style: TextStyle(color: _getColorForHighlight(node.className))
              );
            }).toList()
          )
        )
      ),
    );
  }

  Color? _getColorForHighlight(String? className) {
    // Map highlight.js classes to colors
    switch (className) {
      case 'keyword':
        return Colors.purple;
      case 'string':
        return Colors.green;
      case 'comment':
        return Colors.grey;
      // Add more cases as needed
      default:
        return Colors.white;
    }
  }
}