import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:math';

// Dummy data for commuters
final List<Map<String, dynamic>> commuters = [
  {'name': 'Jane Doe', 'latitude': 33.80208087320501, 'longitude': -84.36066555094622, 'direction': 'Going'},
  {'name': 'John Smith', 'latitude': 33.7540, 'longitude': -84.4000, 'direction': 'Leaving'},
  {'name': 'Emily Brown', 'latitude': 33.7480, 'longitude': -84.3950, 'direction': 'Going'},
  {'name': 'Michael Johnson', 'latitude': 33.7400, 'longitude': -84.3800, 'direction': 'Leaving'},
];

class CarpoolScreen extends StatefulWidget {
  const CarpoolScreen({super.key});

  @override
  _CarpoolScreenState createState() => _CarpoolScreenState();
}

class _CarpoolScreenState extends State<CarpoolScreen> {
  Position? _userLocation;
  List<Map<String, dynamic>> _sortedCommuters = [];
  String? _selectedFilter; // filter (Going or Leaving)

  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  // Fetch user's current location
  Future<void> _getUserLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Location services are disabled.')),
      );
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Location permissions are denied.')),
        );
        return;
      }
    }

    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      _userLocation = position;
      _calculateDistances();
    });
  }

  // Calculate distances and sort commuters
  void _calculateDistances() {
    if (_userLocation == null) return;

    List<Map<String, dynamic>> updatedCommuters = commuters.map((commuter) {
      double distance = _calculateDistance(
        _userLocation!.latitude,
        _userLocation!.longitude,
        commuter['latitude'],
        commuter['longitude'],
      );

      return {
        ...commuter,
        'distance': distance,
      };
    }).toList();

    updatedCommuters.sort((a, b) => a['distance'].compareTo(b['distance']));

    setState(() {
      _sortedCommuters = updatedCommuters;
    });
  }


  double _calculateDistance(
      double lat1, double lon1, double lat2, double lon2) {
    const double earthRadius = 6371; 
    double dLat = _degreesToRadians(lat2 - lat1);
    double dLon = _degreesToRadians(lon2 - lon1);

    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_degreesToRadians(lat1)) *
            cos(_degreesToRadians(lat2)) *
            sin(dLon / 2) *
            sin(dLon / 2);

    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return earthRadius * c * 0.621371; 
  }

  double _degreesToRadians(double degrees) {
    return degrees * pi / 180;
  }

  @override
  Widget build(BuildContext context) {
    // Apply the filter
    final filteredCommuters = _selectedFilter == null
        ? _sortedCommuters
        : _sortedCommuters
            .where((commuter) => commuter['direction'] == _selectedFilter)
            .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Carpool'),
        backgroundColor: Colors.blue,
        actions: [
          // Filter Dropdown
          DropdownButton<String>(
            value: _selectedFilter,
            hint: const Text('Filter', style: TextStyle(color: Colors.white)),
            icon: const Icon(Icons.filter_alt, color: Colors.white),
            dropdownColor: Colors.blue[200],
            items: ['Going', 'Leaving']
                .map((filter) => DropdownMenuItem(
                      value: filter,
                      child: Text(filter),
                    ))
                .toList(),
            onChanged: (value) {
              setState(() {
                _selectedFilter = value;
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Request Carpool',
            onPressed: () {
              Navigator.pushNamed(context, '/carpoolRequest');
            },
          ),
          IconButton(
            icon: const Icon(Icons.list_alt),
            tooltip: 'View Requests',
            onPressed: () {
              Navigator.pushNamed(context, '/carpoolRequests');
            },
          ),
        ],
      ),
      body: _userLocation == null
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: filteredCommuters.length,
                itemBuilder: (context, index) {
                  final commuter = filteredCommuters[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    elevation: 3,
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Text(commuter['name']![0]), 
                        backgroundColor: Colors.blueAccent,
                        foregroundColor: Colors.white,
                      ),
                      title: Text(commuter['name']),
                      subtitle: Text(
                        '${commuter['distance'].toStringAsFixed(1)} miles away • ${commuter['direction']}'),
                      trailing: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 109, 192, 99),
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Joined ${commuter['name']}!'),
                            ),
                          );
                        },
                        child: const Text('Join'),
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}