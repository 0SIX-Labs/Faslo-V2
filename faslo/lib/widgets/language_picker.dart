import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LanguagePicker extends StatefulWidget {
  final List<Map<String, String>> languages;
  final String selectedCode;
  final void Function(String code) onSelected;

  const LanguagePicker({
    super.key,
    required this.languages,
    required this.selectedCode,
    required this.onSelected,
  });

  @override
  State<LanguagePicker> createState() => _LanguagePickerState();
}

class _LanguagePickerState extends State<LanguagePicker> {
  late FixedExtentScrollController _scrollController;
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.languages.indexWhere(
      (lang) => lang['code'] == widget.selectedCode,
    );
    if (_selectedIndex < 0) _selectedIndex = 0;
    _scrollController = FixedExtentScrollController(
      initialItem: _selectedIndex,
    );
  }

  @override
  void didUpdateWidget(covariant LanguagePicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    final newIndex = widget.languages.indexWhere(
      (lang) => lang['code'] == widget.selectedCode,
    );
    if (newIndex >= 0 && newIndex != _selectedIndex) {
      _selectedIndex = newIndex;
      _scrollController.jumpToItem(_selectedIndex);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _confirmSelection() {
    final index = _scrollController.selectedItem;
    widget.onSelected(widget.languages[index]['code']!);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
