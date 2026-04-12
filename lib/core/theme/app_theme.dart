// import 'package:flutter/material.dart';
// import '../constants/app_colors.dart';
// import '../constants/app_text_styles.dart';
// import '../constants/app_spacing.dart';
//
// class AppTheme {
//   static ThemeData lightTheme = ThemeData(
//     scaffoldBackgroundColor: AppColors.background,
//     primaryColor: AppColors.primaryBrown,
//     colorScheme: const ColorScheme.light(
//       primary: AppColors.primaryBrown,
//       secondary: AppColors.secondaryBrown,
//       surface: AppColors.surface,
//     ),
//     fontFamily: 'Sora',
//     appBarTheme: const AppBarTheme(
//       backgroundColor: AppColors.background,
//       elevation: 0,
//       centerTitle: false,
//       iconTheme: IconThemeData(color: AppColors.statusBarIcons),
//       titleTextStyle: AppTextStyles.headingSmall,
//     ),
//     inputDecorationTheme: InputDecorationTheme(
//       filled: true,
//       fillColor: AppColors.surface,
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
//         borderSide: BorderSide.none,
//       ),
//       hintStyle: AppTextStyles.bodyMedium,
//       contentPadding: const EdgeInsets.symmetric(
//         horizontal: AppSpacing.md,
//         vertical: AppSpacing.sm,
//       ),
//     ),
//     elevatedButtonTheme: ElevatedButtonThemeData(
//       style: ElevatedButton.styleFrom(
//         backgroundColor: AppColors.addButtonBg,
//         foregroundColor: Colors.white,
//         minimumSize: const Size(AppSpacing.buttonWidth, AppSpacing.buttonHeight),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
//         ),
//         textStyle: const TextStyle(
//           fontFamily: 'Sora',
//           fontWeight: FontWeight.w500,
//         ),
//       ),
//     ),
//   );
// }