import 'package:flutter/material.dart';

enum ServiceType { tooth, eye, lungs, ear }

class HealthService {
  final String id;
  final String name;
  final ServiceType type;
  final Color backgroundColor;

  const HealthService({
    required this.id,
    required this.name,
    required this.type,
    this.backgroundColor = const Color(0xFFF8FAFC),
  });
}
