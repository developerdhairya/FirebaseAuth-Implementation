import 'package:flutter/material.dart';

class PromptService {
  late BuildContext _buildContext;

  static PromptService instance = PromptService();

  PromptService() {}

  set buildContext(_context) {
    _buildContext = _context;
  }

  void showExitPrompt() {
    showDialog(
      context: _buildContext,
      builder: (_buildContext) => AlertDialog(
        title: Text("IEEE Chitkara"),
        content: Text("Do want want to Exit the App?"),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text("Yes"),
          ),
          TextButton(
            onPressed: () {},
            child: Text("No"),
          )
        ],
      ),
    );
  }
}
