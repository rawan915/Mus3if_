import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mus3if/models/hospitals_model.dart';
import 'package:mus3if/data/hospitals_data.dart';
import 'package:mus3if/screens/hospital_details_screen.dart';
import 'package:mus3if/services/location_service.dart';
import 'package:mus3if/widgets/hospital_card.dart';
import 'package:url_launcher/url_launcher.dart';

class HospitalsScreen extends StatefulWidget {
  HospitalsScreen({super.key});

  @override
  State<HospitalsScreen> createState() => _HospitalsScreenState();
}

class _HospitalsScreenState extends State<HospitalsScreen> {
  Position? _currentPosition;
  List<Hospital> _hospitals = [];
  bool _isLoading = true;
  String _locationStatus = 'Getting your location...';
  String _locationCoordinates = '';
  bool _locationError = false;

  @override
  void initState() {
    super.initState();
    _loadHospitals();
  }

  Future<void> _loadHospitals() async {
    setState(() {
      _isLoading = true;
      _locationError = false;
      _locationStatus = 'Getting your location...';
      _hospitals = [];
    });

    _currentPosition = await LocationService.getCurrentLocation();

    if (_currentPosition == null) {
      setState(() {
        _isLoading = false;
        _locationError = true;
        _locationStatus = 'Unable to get your location';
      });
      return;
    }

    _hospitals = localHospitals.map((hospital) {
      double distance = LocationService.calculateDistance(
        _currentPosition!.latitude,
        _currentPosition!.longitude,
        hospital.latitude,
        hospital.longitude,
      );
      return hospital.copyWith(distance: distance);
    }).toList()..sort((a, b) => (a.distance ?? 0).compareTo(b.distance ?? 0));

    setState(() => _isLoading = false);
  }

  void _openInGoogleMaps(Hospital hospital) async {
    if (_currentPosition == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Location not available')));
      return;
    }

    final url =
        'https://www.google.com/maps/dir/?api=1'
        '&origin=${_currentPosition!.latitude},${_currentPosition!.longitude}'
        '&destination=${hospital.latitude},${hospital.longitude}'
        '&travelmode=driving';

    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not open maps app')),
        );
      }
    }
  }

  void _callHospital(String phone) async {
    final url = 'tel:$phone';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Could not call $phone')));
      }
    }
  }

  void _showHospitalDetails(Hospital hospital) {
    HospitalDetailsScreen.show(
      context: context,
      hospital: hospital,
      currentPosition: _currentPosition,
      onOpenInGoogleMaps: () => _openInGoogleMaps(hospital),
      onCallHospital: _callHospital,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nearby Hospitals'),
        backgroundColor: Color(0xFFDC2626),
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadHospitals,
            tooltip: 'Refresh Location',
          ),
        ],
      ),
      body: _isLoading
          ? _buildLoadingState()
          : _locationError
          ? _buildLocationErrorState()
          : _hospitals.isEmpty
          ? _buildEmptyState()
          : _buildHospitalList(),
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(color: Color(0xFFDC2626)),
          SizedBox(height: 16),
          Text(
            _locationStatus,
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationErrorState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.location_off, size: 64, color: Colors.grey[400]),
          const SizedBox(height: 16),
          const Text(
            'Location Access Required',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              'Please enable location services to find hospitals near you',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ),
          SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: _loadHospitals,
            icon: Icon(Icons.refresh),
            label: Text('Try Again'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFDC2626),
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
          ),
          SizedBox(height: 12),
          TextButton(
            onPressed: () {
              Geolocator.openLocationSettings();
            },
            child: Text('Open Location Settings'),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.local_hospital, size: 64, color: Colors.grey[400]),
          SizedBox(height: 16),
          Text(
            'No hospitals found in your area',
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildHospitalList() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.green.shade50,
            border: Border(bottom: BorderSide(color: Colors.green.shade100)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.check_circle,
                    color: Colors.green.shade700,
                    size: 16,
                  ),
                  SizedBox(width: 8),
                  Text(
                    _locationStatus,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.green.shade800,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4),
              Text(
                _locationCoordinates,
                style: TextStyle(fontSize: 12, color: Colors.green.shade600),
              ),
              SizedBox(height: 4),
            ],
          ),
        ),
        Expanded(
          child: RefreshIndicator(
            onRefresh: _loadHospitals,
            color: const Color(0xFFDC2626),
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _hospitals.length,
              itemBuilder: (context, index) => HospitalCard(
                hospital: _hospitals[index],
                onTap: () => _showHospitalDetails(_hospitals[index]),
                onOpenInGoogleMaps: () => _openInGoogleMaps(_hospitals[index]),
                onCallHospital: _callHospital,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
