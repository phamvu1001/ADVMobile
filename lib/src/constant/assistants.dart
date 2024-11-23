import 'package:flutter/material.dart';
import 'package:jarvis/src/models/chat/assistant_model.dart';

class Assistants {
  static Map<String, Assistant> assistants = {
    'gpt-4o-mini': Assistant(id: 'gpt-4o-mini', name: 'GPT-4o mini'),
    'gpt-4o': Assistant(id: 'gpt-4o', name: 'GPT-4o'),
    'gemini-1.5-pro-latest':
        Assistant(id: 'gemini-1.5-pro-latest', name: 'Gemini 1.5 Pro'),
    'gemini-1.5-flash-latest':
        Assistant(id: 'gemini-1.5-flash-latest', name: 'Gemini 1.5 Flash'),
    'claude-3-5-sonnet-20240620':
        Assistant(id: 'claude-3-5-sonnet-20240620', name: 'Claude 3.5 Sonnet'),
    'claude-3-haiku-20240307':
        Assistant(id: 'claude-3-haiku-20240307', name: 'Claude 3 Haiku')
  };

  static Map<String, Widget> assistantIcons = {
    'claude-3-haiku-20240307': ClipOval(
        child: Image.asset('assets/claude_3_haiku.png',
            width: 30, height: 30, fit: BoxFit.cover)),
    'claude-3-5-sonnet-20240620': ClipOval(
        child: Image.asset('assets/claude_3_haiku.png',
            width: 30, height: 30, fit: BoxFit.cover)),
    'gemini-1.5-flash-latest': ClipOval(
        child: Image.asset('assets/gemini.png',
            width: 30, height: 30, fit: BoxFit.cover)),
    'gemini-1.5-pro-latest': ClipOval(
        child: Image.asset('assets/gemini_15_pro.png',
            width: 30, height: 30, fit: BoxFit.cover)),
    'gpt-4o': ClipOval(
        child: Image.asset('assets/gpt-4.webp',
            width: 30, height: 30, fit: BoxFit.cover)),
    'gpt-4o-mini': ClipOval(
        child: Image.asset('assets/gpt_4o_mini.jpg',
            width: 30, height: 30, fit: BoxFit.cover)),
  };

  static List<Map<Assistant, Widget>> menuItems = [
    {
      Assistant(id: 'claude-3-haiku-20240307', name: 'Claude 3 Haiku'):
          ClipOval(
              child: Image.asset('assets/claude_3_haiku.png',
                  width: 30, height: 30, fit: BoxFit.cover)),
    },
    {
      Assistant(id: 'claude-3-5-sonnet-20240620', name: 'Claude 3.5 Sonnet'):
          ClipOval(
              child: Image.asset('assets/claude_3_haiku.png',
                  width: 30, height: 30, fit: BoxFit.cover)),
    },
    {
      Assistant(id: 'gemini-1.5-flash-latest', name: 'Gemini 1.5 Flash'):
          ClipOval(
              child: Image.asset('assets/gemini.png',
                  width: 30, height: 30, fit: BoxFit.cover)),
    },
    {
      Assistant(id: 'gemini-1.5-pro-latest', name: 'Gemini 1.5 Pro'): ClipOval(
          child: Image.asset('assets/gemini_15_pro.png',
              width: 30, height: 30, fit: BoxFit.cover)),
    },
    {
      Assistant(id: 'gpt-4o', name: 'GPT-4o'): ClipOval(
          child: Image.asset('assets/gpt-4.webp',
              width: 30, height: 30, fit: BoxFit.cover)),
    },
    {
      Assistant(id: 'gpt-4o-mini', name: 'GPT-4o mini'): ClipOval(
          child: Image.asset('assets/gpt_4o_mini.jpg',
              width: 30, height: 30, fit: BoxFit.cover)),
    },
  ];
}