import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../design.dart';
import '../models/doctor.dart';
import '../widgets/design_assets.dart';

class AppointmentDetailsScreen extends StatefulWidget {
  final Doctor? doctor;
  const AppointmentDetailsScreen({super.key, this.doctor});
  @override
  State<AppointmentDetailsScreen> createState() =>
      _AppointmentDetailsScreenState();
}

class _AppointmentDetailsScreenState extends State<AppointmentDetailsScreen> {
  int _selectedTimeIndex = 1;
  int _selectedDateIndex = 0;
  bool _allTimes = false, _allDates = false;
  final _timeSlots = [
    '10.00 AM',
    '11.00 AM',
    '12.00 PM',
    '01.00 PM',
    '02.00 PM',
  ];
  final _dates = [
    'Sun 4',
    'Mon 5',
    'Tue 6',
    'Wed 7',
    'Thu 8',
    'Fri 9',
    'Sat 10',
  ];
  String get _doctorName => widget.doctor?.name ?? 'Dr.Upul';

  void _bookAppointment() => showDialog<void>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      title: const Text('Appointment Booked!'),
      content: Text(
        'Your appointment with ${widget.doctor?.name ?? 'Dr. Upul'} is set for ${_dates[_selectedDateIndex]} at ${_timeSlots[_selectedTimeIndex]}.',
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(dialogContext);
            Navigator.pop(context);
          },
          child: const Text('OK'),
        ),
      ],
    ),
  );

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: Column(
            children: [
              const PreviewStatusBar(appointment: true),
              Padding(
                padding: const EdgeInsets.fromLTRB(24.723, 24, 24.723, 0),
                child: SizedBox(
                  height: 40,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Text(
                        'Appointment',
                        style: openSans(
                          26,
                          weight: FontWeight.w700,
                          color: AppColors.primary,
                          spacing: -.52,
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: AssetAction(
                          label: 'Back',
                          onTap: () => Navigator.pop(context),
                          child: const DesignIcon('back'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(26.72, 28.5, 26.72, 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _doctorInfo(),
                        const SizedBox(height: 44),
                        Text(
                          'Details',
                          style: openSans(
                            22,
                            weight: FontWeight.w600,
                            spacing: -.44,
                          ),
                        ),
                        const SizedBox(height: 17),
                        ConstrainedBox(
                          constraints: const BoxConstraints(minHeight: 120),
                          child: Text(
                            'Worem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero et velit interdum, ac aliquet odio mattis. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Curabitur tempus urna at turpis condimentum lobortis. Ut commodo efficitur neque. Ut diam quam, semper iaculis condimentum ac, vestibulum eu nisl.',
                            style: openSans(
                              13,
                              color: AppColors.gray,
                              height: 1.32,
                            ),
                          ),
                        ),
                        const SizedBox(height: 44),
                        _section(
                          'Working Hours',
                          () => setState(() => _allTimes = !_allTimes),
                        ),
                        const SizedBox(height: 26),
                        _options(
                          _allTimes ? _timeSlots : _timeSlots.take(3).toList(),
                          _selectedTimeIndex,
                          (index) => setState(() => _selectedTimeIndex = index),
                          times: true,
                        ),
                        const SizedBox(height: 29),
                        _section(
                          'Date',
                          () => setState(() => _allDates = !_allDates),
                        ),
                        const SizedBox(height: 26),
                        _options(
                          _allDates ? _dates : _dates.take(3).toList(),
                          _selectedDateIndex,
                          (index) => setState(() => _selectedDateIndex = index),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(26.72, 12, 26.72, 39.12),
                child: SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: _bookAppointment,
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        'Book an Appointment',
                        style: openSans(
                          22,
                          weight: FontWeight.w700,
                          color: Colors.white,
                          spacing: -.44,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );

  Widget _doctorInfo() => LayoutBuilder(
    builder: (context, constraints) {
      final photoSize = constraints.maxWidth >= 350
          ? 132.0
          : math.min(132.0, constraints.maxWidth * .35);
      final small = constraints.maxWidth < 350;
      final actions = Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (final entry in [
            ('Chat', 'chat-action'),
            ('Call', 'phone-action'),
            ('Video call', 'video-action'),
          ]) ...[
            if (entry.$2 != 'chat-action') const SizedBox(width: 17),
            SizedBox(
              width: 30,
              height: 30,
              child: OverflowBox(
                minWidth: 0,
                minHeight: 0,
                maxWidth: 44,
                maxHeight: 44,
                child: AssetAction(
                  label: entry.$1,
                  onTap: () => showContact(context, entry.$1, _doctorName),
                  child: DesignIcon(entry.$2),
                ),
              ),
            ),
          ],
        ],
      );
      final row = Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              widget.doctor?.imageUrl ?? 'assets/images/doctor-upul.png',
              width: photoSize,
              height: photoSize,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 21),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (small || widget.doctor != null) ...[
                  Text(
                    _doctorName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: openSans(22, weight: FontWeight.w700, spacing: -.44),
                  ),
                  const SizedBox(height: 10),
                  actions,
                ] else
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          _doctorName,
                          style: openSans(
                            22,
                            weight: FontWeight.w700,
                            spacing: -.44,
                          ),
                        ),
                      ),
                      actions,
                    ],
                  ),
                const SizedBox(height: 10),
                Text(
                  widget.doctor?.specialty ?? 'Denteeth',
                  style: openSans(
                    16,
                    weight: FontWeight.w600,
                    color: AppColors.secondary,
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        'Payment',
                        style: openSans(
                          small ? 17 : 20,
                          weight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '\$120.00',
                      style: openSans(
                        small ? 17 : 20,
                        weight: FontWeight.w700,
                        color: AppColors.secondary,
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      );
      if (small || widget.doctor != null) return row;
      // The doctor row in Figma is slightly wider than the text sections.
      final rowWidth = constraints.maxWidth + 2.44;
      return Transform.translate(
        offset: const Offset(-.36, 0),
        child: SizedBox(
          height: 132,
          child: OverflowBox(
            minWidth: rowWidth,
            maxWidth: rowWidth,
            minHeight: 132,
            maxHeight: 132,
            child: row,
          ),
        ),
      );
    },
  );

  Widget _section(String title, VoidCallback onTap) => SizedBox(
    height: 22,
    child: Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: openSans(22, weight: FontWeight.w600, spacing: -.44),
          ),
        ),
        TextButton(
          onPressed: onTap,
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Text('See All', style: openSans(16, spacing: -.32)),
        ),
      ],
    ),
  );

  Widget _options(
    List<String> options,
    int selected,
    ValueChanged<int> onChanged, {
    bool times = false,
  }) => SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    clipBehavior: Clip.none,
    child: Row(
      children: [
        for (int index = 0; index < options.length; index++) ...[
          if (index > 0) const SizedBox(width: 15),
          Semantics(
            button: true,
            selected: index == selected,
            child: InkWell(
              onTap: () => onChanged(index),
              borderRadius: BorderRadius.circular(10),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                height: 56,
                width: times
                    ? (index == 1 ? 129 : 133)
                    : ([127.0, 118.0, 122.0][index % 3]),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: index == selected
                      ? AppColors.primary
                      : AppColors.appointmentTile,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  options[index],
                  style: openSans(
                    20,
                    color: index == selected ? Colors.white : Colors.black,
                    spacing: -.4,
                  ),
                ),
              ),
            ),
          ),
        ],
      ],
    ),
  );
}
