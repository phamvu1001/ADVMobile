import 'package:flutter/material.dart';

class PromptTab extends StatelessWidget {
  const PromptTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Enter your prompts for the assistant:',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8.0),
          Expanded(
            child: TextField(
              maxLines: null, // Allows the text field to expand vertically
              decoration: InputDecoration(
                hintText: 'Type your prompts here...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}