import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../design.dart';

class DesignIcon extends StatelessWidget {
  final String name;
  const DesignIcon(this.name, {super.key});

  @override
  Widget build(BuildContext context) {
    final dimensions = _dimensions[name]!;
    return SvgPicture.asset(
      'assets/icons/$name.svg',
      width: dimensions[0],
      height: dimensions[1],
    );
  }

  static const Map<String, List<double>> _dimensions = {
    'message': [24.0, 24.0],
    'notification': [22.0, 22.0],
    'notification-dot': [8.0, 8.0],
    'location': [18.0, 18.0],
    'heart': [20.0, 20.0],
    'filter': [24.0, 24.0],
    'search': [24.0, 24.0],
    'arrow-right': [14.0, 14.0],
    'calendar': [20.0, 20.0],
    'clock': [16.5, 16.5],
    'edit-background': [40.0, 40.0],
    'edit': [24.0, 24.0],
    'home-battery': [24.5, 11.5],
    'home-reception': [17.0996, 10.7002],
    'home-wifi': [15.4, 11.0572],
    'details-wifi': [18.0, 13.0],
    'details-battery': [26.6026, 12.5],
    'details-reception': [18.1504, 11.0],
    'back': [40.0, 40.0],
    'chat-action': [30.0, 30.0],
    'phone-action': [30.0, 30.0],
    'video-action': [30.0, 30.0],
  };
}

class AssetAction extends StatelessWidget {
  final String label;
  final Widget child;
  final VoidCallback? onTap;
  const AssetAction({
    super.key,
    required this.label,
    required this.child,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) => Semantics(
    button: true,
    label: label,
    child: Tooltip(
      message: label,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(30),
        child: SizedBox(width: 44, height: 44, child: Center(child: child)),
      ),
    ),
  );
}

// Phones use their system status bar. Desktop/web previews use the Figma bar.
class PreviewStatusBar extends StatelessWidget {
  final bool appointment;
  const PreviewStatusBar({super.key, this.appointment = false});

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.paddingOf(context).top > 0) return const SizedBox.shrink();
    final prefix = appointment ? 'details' : 'home';
    return ExcludeSemantics(
      child: SizedBox(
        height: 44,
        child: Padding(
          padding: EdgeInsets.only(
            left: appointment ? 40 : 31,
            right: appointment ? 26.3974 : 14.5,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                appointment ? '19:02' : '9:41',
                style: TextStyle(
                  fontSize: appointment ? 18 : 15,
                  fontFamily: appointment ? 'Poppins' : 'Outfit',
                  fontWeight: appointment ? FontWeight.w500 : FontWeight.w600,
                  color: appointment ? Colors.black : AppColors.ink,
                  height: 1,
                ),
              ),
              Transform.translate(
                offset: Offset(0, appointment ? 1.5 : .91),
                child: Row(
                  children: [
                    DesignIcon('$prefix-reception'),
                    const SizedBox(width: 5),
                    DesignIcon('$prefix-wifi'),
                    const SizedBox(width: 5),
                    if (appointment)
                      const DesignIcon('details-battery')
                    else
                      const SizedBox(
                        width: 24.5,
                        height: 11.5,
                        child: Stack(
                          children: [
                            DesignIcon('home-battery'),
                            Positioned(
                              left: 2,
                              top: 1.9,
                              width: 18,
                              height: 7.667,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(1.6),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void showContact(BuildContext context, String action, String doctor) {
  showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('$action · $doctor'),
      content: const Text(
        'This laboratory app demonstrates the interface. A communication service is not connected.',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Close'),
        ),
      ],
    ),
  );
}
