import 'package:flutter/material.dart';

import '../design.dart';
import '../models/doctor.dart';
import '../models/health_service.dart';
import '../widgets/appointment_card_widget.dart';
import '../widgets/design_assets.dart';
import '../widgets/doctor_list_item.dart';
import '../widgets/health_service_card.dart';
import 'appointment_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _search = TextEditingController();
  bool _favoritesOnly = false;
  ServiceType? _service;
  final List<HealthService> _healthServices = const [
    HealthService(id: '1', name: 'Tooth', type: ServiceType.tooth),
    HealthService(id: '2', name: 'Eye', type: ServiceType.eye),
    HealthService(id: '3', name: 'Lungs', type: ServiceType.lungs),
    HealthService(id: '4', name: 'Ear', type: ServiceType.ear),
  ];
  final List<Doctor> _nearbyDoctors = [
    const Doctor(
      id: '1',
      name: 'Dr. Emmly Lestiryno',
      specialty: 'General Practitioner',
      imageUrl: 'assets/images/doctor-emmly.png',
      location: '3167 Durgan Shores',
      distance: '500M from you',
    ),
    const Doctor(
      id: '2',
      name: 'Dr. Sonja Littel',
      specialty: 'Dental Specialist',
      imageUrl: 'assets/images/doctor-sonja.png',
      location: '950 Sigrid Port',
      distance: '753M from you',
    ),
  ];

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  void _toggleFavorite(Doctor doc) {
    setState(() {
      final index = _nearbyDoctors.indexWhere((item) => item.id == doc.id);
      _nearbyDoctors[index] = Doctor(
        id: doc.id,
        name: doc.name,
        specialty: doc.specialty,
        imageUrl: doc.imageUrl,
        location: doc.location,
        distance: doc.distance,
        rating: doc.rating,
        isFavorite: !doc.isFavorite,
      );
    });
  }

  void _navigateToDetails([Doctor? doctor]) => Navigator.push(
    context,
    MaterialPageRoute<void>(
      builder: (context) => AppointmentDetailsScreen(doctor: doctor),
    ),
  );

  void _resetFilters() => setState(() {
    _search.clear();
    _favoritesOnly = false;
    _service = null;
  });

  void _showServices() {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (sheetContext) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Health Services', style: outfit(18, weight: FontWeight.w600)),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: _healthServices
                  .map(
                    (service) => HealthServiceCard(
                      service: service,
                      onTap: () {
                        setState(() => _service = service.type);
                        Navigator.pop(sheetContext);
                      },
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final query = _search.text.trim().toLowerCase();
    final doctors = _nearbyDoctors
        .where(
          (doc) =>
              ('${doc.name} ${doc.specialty} ${doc.location}')
                  .toLowerCase()
                  .contains(query) &&
              (!_favoritesOnly || doc.isFavorite) &&
              (_service == null ||
                  (_service == ServiceType.tooth &&
                      doc.specialty == 'Dental Specialist')),
        )
        .toList();
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Column(
              children: [
                const PreviewStatusBar(),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(24, 16, 24, 42),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            ClipOval(
                              child: SizedBox(
                                width: 44,
                                height: 44,
                                child: Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    Image.asset(
                                      'assets/images/avatar-base.png',
                                      fit: BoxFit.cover,
                                    ),
                                    Image.asset(
                                      'assets/images/avatar.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Hi, Jonathan',
                                    style: outfit(14, weight: FontWeight.w600),
                                  ),
                                  Text(
                                    'May you always be healthy',
                                    style: outfit(
                                      10,
                                      color: AppColors.muted,
                                      height: 1.8,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            AssetAction(
                              label: 'Notifications',
                              onTap: () {
                                showDialog<void>(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text('Notifications'),
                                    content: const Text(
                                      'Your appointment is on 22 October, 2023, 08:00 AM - 10.30 AM.',
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text('Close'),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              child: const SizedBox(
                                width: 44,
                                height: 44,
                                child: Stack(
                                  children: [
                                    Positioned(
                                      left: 11,
                                      top: 11,
                                      child: DesignIcon('notification'),
                                    ),
                                    Positioned(
                                      left: 23,
                                      top: 13,
                                      child: DesignIcon('notification-dot'),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        Container(
                          height: 52,
                          padding: const EdgeInsets.only(left: 15, right: 5),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFBFBFD),
                            border: Border.all(color: AppColors.tile),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Row(
                            children: [
                              const DesignIcon('search'),
                              const SizedBox(width: 15),
                              Expanded(
                                child: TextField(
                                  controller: _search,
                                  onChanged: (_) => setState(() {}),
                                  style: outfit(14),
                                  decoration: InputDecoration(
                                    hintText: 'Search something',
                                    hintStyle: outfit(
                                      14,
                                      color: const Color(0xFFA7A9BF),
                                      height: 1.8,
                                    ),
                                    border: InputBorder.none,
                                    isDense: true,
                                    contentPadding: EdgeInsets.zero,
                                  ),
                                ),
                              ),
                              AssetAction(
                                label: 'Filter favorite doctors',
                                onTap: () => setState(
                                  () => _favoritesOnly = !_favoritesOnly,
                                ),
                                child: const DesignIcon('filter'),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        AppointmentCardWidget(
                          onTap: _navigateToDetails,
                          onEditTap: _navigateToDetails,
                          onChatTap: () => showContact(
                            context,
                            'Chat',
                            'Dr. Richar Kandowen',
                          ),
                        ),
                        const SizedBox(height: 24),
                        _section('Health Services', _showServices),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: _healthServices
                              .map(
                                (service) => HealthServiceCard(
                                  service: service,
                                  onTap: () => setState(
                                    () => _service = _service == service.type
                                        ? null
                                        : service.type,
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                        const SizedBox(height: 24),
                        _section('Nearby Doctor', _resetFilters),
                        const SizedBox(height: 16),
                        if (_service != null || _favoritesOnly)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: Wrap(
                              spacing: 8,
                              children: [
                                if (_service != null)
                                  InputChip(
                                    label: Text(
                                      _healthServices
                                          .firstWhere((s) => s.type == _service)
                                          .name,
                                    ),
                                    onDeleted: () =>
                                        setState(() => _service = null),
                                  ),
                                if (_favoritesOnly)
                                  InputChip(
                                    label: const Text('Favorites'),
                                    onDeleted: () =>
                                        setState(() => _favoritesOnly = false),
                                  ),
                              ],
                            ),
                          ),
                        if (doctors.isEmpty)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: Text(
                              'No doctors match your search.',
                              style: outfit(14, color: AppColors.muted),
                            ),
                          ),
                        for (
                          int index = 0;
                          index < doctors.length;
                          index++
                        ) ...[
                          DoctorListItem(
                            doctor: doctors[index],
                            onTap: () => _navigateToDetails(doctors[index]),
                            onFavoriteTap: () =>
                                _toggleFavorite(doctors[index]),
                          ),
                          if (index < doctors.length - 1)
                            const SizedBox(height: 16),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _section(String title, VoidCallback onSeeAll) => SizedBox(
    height: 23,
    child: Row(
      children: [
        Expanded(
          child: Text(title, style: outfit(18, weight: FontWeight.w600)),
        ),
        TextButton(
          onPressed: onSeeAll,
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Text(
            'See All',
            style: outfit(12, color: AppColors.homePrimary, height: 1.8),
          ),
        ),
      ],
    ),
  );
}
