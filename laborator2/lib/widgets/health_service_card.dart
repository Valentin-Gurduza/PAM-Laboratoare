import 'package:flutter/material.dart';

import '../design.dart';
import '../models/health_service.dart';
import 'category_icons.dart';

class HealthServiceCard extends StatelessWidget {
  final HealthService service;
  final VoidCallback? onTap;
  const HealthServiceCard({super.key, required this.service, this.onTap});

  @override
  Widget build(BuildContext context) => Semantics(
    button: true,
    label: service.name,
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 64,
            height: 64,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.tile,
              borderRadius: BorderRadius.circular(10),
            ),
            child: switch (service.type) {
              ServiceType.tooth => const ToothIconWidget(),
              ServiceType.eye => const EyeIconWidget(),
              ServiceType.lungs => const LungsIconWidget(),
              ServiceType.ear => const EarIconWidget(),
            },
          ),
          const SizedBox(height: 8),
          Text(
            service.name,
            style: outfit(14, weight: FontWeight.w500, color: AppColors.muted),
          ),
        ],
      ),
    ),
  );
}
