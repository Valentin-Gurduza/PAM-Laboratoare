import 'package:flutter/material.dart';

import '../design.dart';
import '../models/doctor.dart';
import 'design_assets.dart';

class DoctorListItem extends StatelessWidget {
  final Doctor doctor;
  final VoidCallback? onTap, onFavoriteTap;
  const DoctorListItem({
    super.key,
    required this.doctor,
    this.onTap,
    this.onFavoriteTap,
  });

  @override
  Widget build(BuildContext context) => SizedBox(
    height: 68,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: onTap,
          child: ClipOval(
            child: Image.asset(
              doctor.imageUrl,
              width: 46,
              height: 46,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: InkWell(
            onTap: onTap,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  doctor.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: outfit(14, weight: FontWeight.w600),
                ),
                Text(
                  doctor.specialty,
                  style: outfit(12, color: AppColors.muted, height: 1.8),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const DesignIcon('location'),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        '${doctor.location} - ${doctor.distance}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: outfit(12, height: 1.8),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        // Keep the Figma icon's 20px geometry; grow only its touch target.
        SizedBox(
          width: 25,
          height: 44,
          child: OverflowBox(
            alignment: Alignment.topRight,
            maxWidth: 44,
            maxHeight: 44,
            child: Transform.translate(
              offset: const Offset(12, -12),
              child: AssetAction(
                label: 'Favorite ${doctor.name}',
                onTap: onFavoriteTap,
                child: doctor.isFavorite
                    ? const Icon(Icons.favorite, size: 20, color: Colors.red)
                    : const DesignIcon('heart'),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
