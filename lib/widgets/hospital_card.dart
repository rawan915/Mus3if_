import 'package:flutter/material.dart';
import 'package:mus3if/models/hospitals_model.dart';
import 'package:mus3if/services/location_service.dart';

class HospitalCard extends StatelessWidget {
  final Hospital hospital;
  final VoidCallback onTap;
  final VoidCallback onOpenInGoogleMaps;
  final Function(String) onCallHospital;

  HospitalCard({
    super.key,
    required this.hospital,
    required this.onTap,
    required this.onOpenInGoogleMaps,
    required this.onCallHospital,
  });

  Color _getDistanceColor(double distance) {
    if (distance < 5) return Colors.green;
    if (distance < 15) return Colors.orange;
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                      size: 28,
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
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        if (hospital.specialty != null)
                          Text(
                            hospital.specialty!,
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.blue.shade700,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                      ],
                    ),
                  ),
                  if (hospital.distance != null)
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: _getDistanceColor(hospital.distance!),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        LocationService.getDistanceDescription(
                          hospital.distance!,
                        ),
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  Icon(Icons.location_on, size: 16, color: Colors.grey),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      hospital.address,
                      style: TextStyle(color: Colors.grey, fontSize: 13),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              if (hospital.phone != null) ...[
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.phone, size: 16, color: Colors.grey),
                    SizedBox(width: 8),
                    Text(
                      hospital.phone!,
                      style: TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                  ],
                ),
              ],
              SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: onOpenInGoogleMaps,
                      icon: Icon(Icons.directions, size: 18),
                      label: Text('Directions'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Color(0xFFDC2626),
                        side: BorderSide(color: Color(0xFFDC2626)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  if (hospital.phone != null) ...[
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () => onCallHospital(hospital.phone!),
                        icon: Icon(Icons.phone, size: 18),
                        label: Text('Call'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
