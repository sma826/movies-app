import 'package:flutter/material.dart';
import '../../../shared/constants/apptheme.dart';

Widget buildGenresRow({
  required Set<String> allUniqueGenres,
  required String selectedGenre,
  required Function(String) onGenreSelected,
}) {
  final List<String> genreList = allUniqueGenres.toList()..sort();
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    child: Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: genreList.map((genre) {
        final isSelected = selectedGenre == genre;
        return ElevatedButton(
          onPressed: () => onGenreSelected(genre),
          style: ElevatedButton.styleFrom(
            backgroundColor: isSelected ? AppTheme.yellow : Colors.transparent,
            foregroundColor: isSelected ? AppTheme.black : AppTheme.yellow,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: const BorderSide(color: AppTheme.yellow, width: 1),
            ),
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          ),
          child: Text(
            genre,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: isSelected ? AppTheme.black : AppTheme.yellow,
            ),
          ),
        );
      }).toList(),
    ),
  );
}
