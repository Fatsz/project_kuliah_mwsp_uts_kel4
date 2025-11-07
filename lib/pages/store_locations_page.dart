import 'package:flutter/material.dart';
import 'package:project_kuliah_mwsp_uts_kel4/components/sidebar.dart';

class StoreLocationsPage extends StatefulWidget {
  const StoreLocationsPage({super.key});

  @override
  State<StoreLocationsPage> createState() => _StoreLocationsPageState();
}

class _StoreLocationsPageState extends State<StoreLocationsPage> {
  bool isMapView = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Store Locations",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0.8,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12),
            child: Icon(Icons.more_vert),
          ),
        ],
      ),

      body: Column(
        children: [
          // 🔹 Toggle List View / Map View
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => isMapView = false),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: !isMapView
                            ? Colors.brown.shade700
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "List View",
                        style: TextStyle(
                          color: !isMapView ? Colors.white : Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => isMapView = true),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: isMapView
                            ? Colors.brown.shade700
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "Map View",
                        style: TextStyle(
                          color: isMapView ? Colors.white : Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // 🔸 Map background + cards
          Expanded(
            child: Stack(
              children: [
                // 🗺 Static map background
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/background/map.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                // 🏪 Store Cards
                Positioned(
                  bottom: 20,
                  left: 0,
                  right: 0,
                  child: SizedBox(
                    height: 250,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      children: const [
                        _StoreCard(
                          outletName: "Outlet 01",
                          title: "Medan Plaza",
                          time: "09:00 AM - 10:00 PM",
                          distance: "3,5 Km",
                          imagePath: "assets/images/store/str1.jpg",
                          avatars: [
                            "assets/images/avatar/1.jpg",
                            "assets/images/avatar/2.jpg",
                            "assets/images/avatar/3.jpg",
                          ],
                        ),
                        SizedBox(width: 12),
                        _StoreCard(
                          outletName: "Outlet 02",
                          title: "Center Point",
                          time: "09:00 AM - 10:00 PM",
                          distance: "7,5 Km",
                          imagePath: "assets/images/store/str2.jpg",
                          avatars: [
                            "assets/images/avatar/4.jpg",
                            "assets/images/avatar/5.jpg",
                            "assets/images/avatar/1.jpg",
                          ],
                        ),
                        SizedBox(width: 12),
                        _StoreCard(
                          outletName: "Outlet 03",
                          title: "Sun Plaza",
                          time: "09:00 AM - 10:00 PM",
                          distance: "9,2 Km",
                          imagePath: "assets/images/store/str3.jpg",
                          avatars: [
                            "assets/images/avatar/2.jpg",
                            "assets/images/avatar/3.jpg",
                            "assets/images/avatar/4.jpg",
                          ],
                        ),
                        SizedBox(width: 12),
                        _StoreCard(
                          outletName: "Outlet 04",
                          title: "Ringroad City Walk",
                          time: "09:00 AM - 10:00 PM",
                          distance: "11,8 Km",
                          imagePath: "assets/images/store/str4.jpg",
                          avatars: [
                            "assets/images/avatar/5.jpg",
                            "assets/images/avatar/1.jpg",
                            "assets/images/avatar/2.jpg",
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// 🔸 Store Card Component
class _StoreCard extends StatelessWidget {
  final String outletName;
  final String title;
  final String time;
  final String distance;
  final String imagePath;
  final List<String> avatars;

  const _StoreCard({
    required this.outletName,
    required this.title,
    required this.time,
    required this.distance,
    required this.imagePath,
    required this.avatars,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🖼 Outlet image
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            child: Image.asset(
              imagePath,
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          // 🏷 Outlet details
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade300,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    outletName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  time,
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 18, color: Colors.blue),
                    const SizedBox(width: 4),
                    Text(
                      distance,
                      style: const TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Spacer(),
                    // 👥 Avatar list
                    for (var avatar in avatars) ...[
                      CircleAvatar(
                        radius: 10,
                        backgroundImage: AssetImage(avatar),
                      ),
                      const SizedBox(width: 4),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
