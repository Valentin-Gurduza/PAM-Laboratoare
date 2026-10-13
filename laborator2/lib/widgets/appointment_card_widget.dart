import 'package:flutter/material.dart';

import '../design.dart';
import 'design_assets.dart';

class AppointmentCardWidget extends StatelessWidget {
  final VoidCallback? onTap, onEditTap, onChatTap;
  const AppointmentCardWidget({
    super.key,
    this.onTap,
    this.onEditTap,
    this.onChatTap,
  });

  @override
  Widget build(BuildContext context) => SizedBox(
    height: 198,
    child: Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          left: 0,
          right: 0,
          top: 0,
          height: 173,
          child: Material(
            color: AppColors.homePrimary,
            borderRadius: BorderRadius.circular(8),
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(8),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(22, 23, 22, 0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Appointment',
                          style: outfit(
                            12,
                            weight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                        const DesignIcon('arrow-right'),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              _schedule('calendar', '22 October, 2023'),
                              const SizedBox(height: 12),
                              _schedule('clock', '08:00 AM - 10.30 AM'),
                            ],
                          ),
                        ),
                        AssetAction(
                          label: 'Edit appointment',
                          onTap: onEditTap,
                          child: Transform.translate(
                            offset: const Offset(2, 0),
                            child: const SizedBox(
                              width: 40,
                              height: 40,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  DesignIcon('edit-background'),
                                  DesignIcon('edit'),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 131,
          left: 22,
          right: 22,
          height: 67,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: .11),
                  blurRadius: 80,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            padding: const EdgeInsets.fromLTRB(13, 12, 14, 12),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    'assets/images/doctor-richar.png',
                    width: 43,
                    height: 43,
                    fit: BoxFit.cover,
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
                          'Dr. Richar Kandowen',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: outfit(16, weight: FontWeight.w600),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Child Specialist',
                          style: outfit(
                            12,
                            weight: FontWeight.w500,
                            color: AppColors.muted,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                AssetAction(
                  label: 'Chat with Dr. Richar',
                  onTap: onChatTap,
                  child: const SizedBox(
                    width: 44,
                    height: 44,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: DesignIcon('message'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );

  Widget _schedule(String icon, String label) => Transform.translate(
    offset: const Offset(-1, 0),
    child: Row(
      children: [
        SizedBox(width: 20, height: 20, child: Center(child: DesignIcon(icon))),
        const SizedBox(width: 8),
        Flexible(
          child: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: outfit(14, weight: FontWeight.w500, color: Colors.white),
          ),
        ),
      ],
    ),
  );
}
