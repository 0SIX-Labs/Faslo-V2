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

    return Column(
      children: [
        Expanded(
          child: ListWheelScrollView.useDelegate(
            itemExtent: 50,
            perspective: 0.005,
            diameterRatio: 1.5,
            physics: const FixedExtentScrollPhysics(),
            controller: _scrollController,
            onSelectedItemChanged: (index) {
              setState(() => _selectedIndex = index);
            },
            childDelegate: ListWheelChildBuilderDelegate(
              childCount: widget.languages.length,
              builder: (context, index) {
                final lang = widget.languages[index];
                final isVisible = index == _selectedIndex;

                return AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeOutCubic,
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  decoration: BoxDecoration(
                    color: isVisible
                        ? colorScheme.primary.withValues(alpha: 0.12)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Text(
                      lang['name']!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.lexend(
                        fontSize: isVisible ? 18 : 16,
                        fontWeight:
                            isVisible ? FontWeight.w600 : FontWeight.w400,
                        color: isVisible
                            ? colorScheme.primary
                            : colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 16),
        Align(
          alignment: Alignment.center,
          child: GestureDetector(
            onTap: _confirmSelection,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 48,
                vertical: 14,
              ),
              decoration: BoxDecoration(
                color: colorScheme.primary,
                borderRadius: BorderRadius.circular(9999),
              ),
              child: Text(
                'Change Language',
                style: TextStyle(
                  color: colorScheme.onPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
