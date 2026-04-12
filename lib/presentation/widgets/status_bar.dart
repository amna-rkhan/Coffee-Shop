// import 'package:flutter/material.dart';
// import '../../core/constants/app_colors.dart';
// import '../../core/constants/app_spacing.dart';
//
// class StatusBar extends StatelessWidget {
//   const StatusBar({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           const Text(
//             '9:41',
//             style: TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.w600,
//               color: AppColors.statusBarIcons,
//             ),
//           ),
//           Row(
//             mainAxisSize: MainAxisSize.min,
//             children: [  // Removed 'const' from this list
//               const Icon(
//                 Icons.notifications_none,
//                 size: 20,
//                 color: AppColors.statusBarIcons,
//               ),
//               const SizedBox(width: AppSpacing.sm),
//               const Icon(
//                 Icons.signal_cellular_alt,
//                 size: 14,
//                 color: AppColors.statusBarIcons,
//               ),
//               const SizedBox(width: AppSpacing.xs),
//               const Icon(
//                 Icons.wifi,
//                 size: 14,
//                 color: AppColors.statusBarIcons,
//               ),
//               const SizedBox(width: AppSpacing.xs),
//               const Icon(
//                 Icons.battery_full,
//                 size: 18,
//                 color: AppColors.statusBarIcons,
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }