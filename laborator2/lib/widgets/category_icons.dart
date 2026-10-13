import 'package:flutter/material.dart';

class ToothIconWidget extends StatelessWidget {
  final double size;
  const ToothIconWidget({super.key, this.size = 32});
  @override
  Widget build(BuildContext context) =>
      Image.asset('assets/images/tooth.png', width: size, height: size);
}

class EyeIconWidget extends StatelessWidget {
  final double size;
  const EyeIconWidget({super.key, this.size = 32});
  @override
  Widget build(BuildContext context) =>
      Image.asset('assets/images/eye.png', width: size, height: size);
}

class LungsIconWidget extends StatelessWidget {
  final double size;
  const LungsIconWidget({super.key, this.size = 32});
  @override
  Widget build(BuildContext context) =>
      Image.asset('assets/images/lungs.png', width: size, height: size);
}

class EarIconWidget extends StatelessWidget {
  final double size;
  const EarIconWidget({super.key, this.size = 32});
  @override
  Widget build(BuildContext context) =>
      Image.asset('assets/images/ear.png', width: size, height: size);
}
