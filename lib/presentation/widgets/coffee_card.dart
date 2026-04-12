// import 'package:flutter/material.dart';
// import '../../core/constants/app_colors.dart';
// import '../../core/constants/app_spacing.dart';
// import '../../data/models/coffee_model.dart';
//
// class CoffeeCard extends StatelessWidget {
//   final CoffeeModel coffee;
//
//   const CoffeeCard({super.key, required this.coffee});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: AppSpacing.md),
//       decoration: BoxDecoration(
//         color: AppColors.cardBackground,
//         borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 8,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Coffee image placeholder
//           Container(
//             width: 100,
//             height: 100,
//             decoration: BoxDecoration(
//               color: AppColors.lightBrown,
//               borderRadius: const BorderRadius.only(
//                 topLeft: Radius.circular(AppSpacing.radiusLarge),
//                 bottomLeft: Radius.circular(AppSpacing.radiusLarge),
//               ),
//             ),
//             child: const Icon(
//               Icons.coffee,
//               size: 40,
//               color: AppColors.primaryBrown,
//             ),
//           ),
//           // Coffee details
//           Expanded(
//             child: Padding(
//               padding: const EdgeInsets.all(AppSpacing.sm),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Row(
//                     children: [
//                       const Icon(
//                         Icons.star,
//                         size: 14,
//                         color: AppColors.starColor,
//                       ),
//                       const SizedBox(width: 4),
//                       Text(
//                         coffee.rating.toString(),
//                         style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
//                       ),
//                       const SizedBox(width: 4),
//                       Text(
//                         '(${coffee.reviews})',
//                         style: const TextStyle(fontSize: 10, color: AppColors.textSecondary),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     coffee.name,
//                     style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                   const SizedBox(height: 2),
//                   Text(
//                     coffee.description,
//                     style: const TextStyle(fontSize: 11, color: AppColors.textSecondary),
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                   const SizedBox(height: 8),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           const Text(
//                             'Price',
//                             style: TextStyle(fontSize: 10, color: AppColors.textSecondary),
//                           ),
//                           Text(
//                             '\$${coffee.price.toStringAsFixed(2)}',
//                             style: const TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.w600,
//                               color: AppColors.primaryBrown,
//                             ),
//                           ),
//                         ],
//                       ),
//                       Container(
//                         decoration: BoxDecoration(
//                           color: AppColors.addButtonBg,
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         child: const Padding(
//                           padding: EdgeInsets.all(8.0),
//                           child: Icon(
//                             Icons.add,
//                             size: 18,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../data/models/coffee_model.dart';

class CoffeeCard extends StatelessWidget {
  final Coffee coffee;
  const CoffeeCard({super.key, required this.coffee});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(coffee.imagePath, fit: BoxFit.cover, height: 130, width: double.infinity),
              ),
              Positioned(
                top: 8, left: 8,
                child: Row(
                  children: [
                    const Icon(Icons.star, color: Colors.orange, size: 14),
                    Text(' ${coffee.rating}', style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(coffee.name, style: AppTextStyles.heading.copyWith(fontSize: 16)),
          Text(coffee.description, style: AppTextStyles.subHeading),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('\$ ${coffee.price}', style: AppTextStyles.price),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(10)),
                child: const Icon(Icons.add, color: Colors.white, size: 20),
              ),
            ],
          )
        ],
      ),
    );
  }
}