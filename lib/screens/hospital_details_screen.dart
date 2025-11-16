import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mus3if/models/hospitals_model.dart';
import 'package:mus3if/services/location_service.dart';

class HospitalDetailsScreen {
  static void show({
    required BuildContext context,
    required Hospital hospital,
    required Position? currentPosition,
    required VoidCallback onOpenInGoogleMaps,
    required Function(String) onCallHospital,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        minChildSize: 0.4,
        maxChildSize: 0.9,
        expand: false,
        builder: (context, scrollController) => SingleChildScrollView(
          controller: scrollController,
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Color(0xFFFEE2E2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.local_hospital,
                        color: Color(0xFFDC2626),
                        size: 32,
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            hospital.name,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (hospital.specialty != null)
                            Text(
                              hospital.specialty!,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.blue.shade700,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                _buildInfoRow(Icons.location_on, hospital.address, Colors.red),
                if (hospital.distance != null) ...[
                  const SizedBox(height: 12),
                  _buildInfoRow(
                    Icons.straighten,
                    LocationService.getDistanceDescription(hospital.distance!),
                    Colors.green,
                  ),
                ],
                if (hospital.phone != null) ...[
                  SizedBox(height: 12),
                  _buildInfoRow(Icons.phone, hospital.phone!, Colors.orange),
                ],
                if (hospital.alternatePhone != null) ...[
                  SizedBox(height: 12),
                  _buildInfoRow(
                    Icons.phone_android,
                    hospital.alternatePhone!,
                    Colors.orange,
                  ),
                ],
                SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                          onOpenInGoogleMaps();
                        },
                        icon: Icon(Icons.directions),
                        label: Text('Directions'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFDC2626),
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    if (hospital.phone != null) ...[
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () => onCallHospital(hospital.phone!),
                          icon: Icon(Icons.phone),
                          label: Text('Call'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.green,
                            side: BorderSide(color: Colors.green, width: 2),
                            padding: EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                if (hospital.alternatePhone != null) ...[
                  SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () => onCallHospital(hospital.alternatePhone!),
                      icon: Icon(Icons.phone_android),
                      label: Text('Call: ${hospital.alternatePhone}'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.orange,
                        side: BorderSide(color: Colors.orange, width: 2),
                        padding: EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  static Widget _buildInfoRow(IconData icon, String text, Color color) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: color),
        SizedBox(width: 12),
        Expanded(child: Text(text, style: TextStyle(fontSize: 15))),
      ],
    );
  }
}
