import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';

class RatingsPage extends StatefulWidget {
  @override
  State<RatingsPage> createState() => _RatingsPageState();
}

class _RatingsPageState extends State<RatingsPage> {
  String _filterType = 'All';

  final List<Map<String, dynamic>> reviews = [
    {
      'id': 'REV-001',
      'reviewer': 'Ahmed Hassan',
      'worker': 'Ali Mohamed',
      'rating': 4.8,
      'comment': 'Excellent service! Very professional and completed on time.',
      'service': 'Cleaning',
      'date': '2025-12-20',
      'verified': true,
      'helpful': 12,
      'reported': false,
    },
    {
      'id': 'REV-002',
      'reviewer': 'Fatima Ali',
      'worker': 'Sara Ahmed',
      'rating': 3.5,
      'comment': 'Good work but took longer than expected. Still satisfied overall.',
      'service': 'Plumbing',
      'date': '2025-12-21',
      'verified': true,
      'helpful': 5,
      'reported': false,
    },
    {
      'id': 'REV-003',
      'reviewer': 'Mohammed Salem',
      'worker': 'Karim Hassan',
      'rating': 2.0,
      'comment': 'Poor quality work. Not satisfied with the results.',
      'service': 'Electrical',
      'date': '2025-12-22',
      'verified': true,
      'helpful': 8,
      'reported': true,
    },
    {
      'id': 'REV-004',
      'reviewer': 'Layla Karim',
      'worker': 'Fatima Al-Rashid',
      'rating': 5.0,
      'comment': 'Outstanding service! Professional, punctual, and high quality.',
      'service': 'Painting',
      'date': '2025-12-23',
      'verified': true,
      'helpful': 15,
      'reported': false,
    },
    {
      'id': 'REV-005',
      'reviewer': 'Unknown User',
      'worker': 'Omar Saleh',
      'rating': 1.0,
      'comment': 'Terrible experience. Would not recommend.',
      'service': 'Repair',
      'date': '2025-12-24',
      'verified': false,
      'helpful': 3,
      'reported': true,
    },
  ];

  List<Map<String, dynamic>> get filteredReviews {
    if (_filterType == 'All') return reviews;
    if (_filterType == 'Reported') return reviews.where((r) => r['reported'] == true).toList();
    if (_filterType == 'Verified') return reviews.where((r) => r['verified'] == true).toList();
    return reviews;
  }

  double get averageRating => reviews.fold(0.0, (sum, r) => sum + (r['rating'] as num)) / reviews.length;

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      backgroundColor: Colors.white,
      sideBar: SideBar(
        backgroundColor: Colors.white,
        textStyle: const TextStyle(color: Color.fromARGB(255, 102, 100, 100)),
        items: const [
          AdminMenuItem(title: 'Dashboard', route: '/', icon: Icons.dashboard),
          AdminMenuItem(
            title: 'Sections',
            icon: Icons.file_copy,
            children: [
              AdminMenuItem(title: 'Users', route: '/users'),
              AdminMenuItem(title: 'Workers', route: '/workers'),
              AdminMenuItem(title: 'Requests', route: '/requests'),
              AdminMenuItem(title: 'Financials', route: '/financials'),
              AdminMenuItem(title: 'Settings', route: '/settings'),
            ],
          ),
        ],
        selectedRoute: '/ratings',
        onSelected: (item) {
          if (item.route != null) Navigator.of(context).pushNamed(item.route!);
        },
        header: Container(
          height: 50,
          width: double.infinity,
          color: const Color(0xff444444),
          child: const Center(child: Text('Service Admin', style: TextStyle(color: Colors.white))),
        ),
        footer: Container(
          height: 50,
          width: double.infinity,
          color: const Color(0xff444444),
          child: const Center(child: Text('Mohamed Ashraf © 2026', style: TextStyle(color: Colors.white))),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('التقييمات', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 36, color: Colors.black)),
            const SizedBox(height: 24),
            // Summary Stats
            GridView.count(
              crossAxisCount: 4,
              shrinkWrap: true,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              physics: NeverScrollableScrollPhysics(),
              children: [
                _buildStatCard('Total Reviews', '${reviews.length}', Colors.blue, Icons.comment),
                _buildStatCard('Average Rating', '${averageRating.toStringAsFixed(1)} ⭐', Colors.orange, Icons.star),
                _buildStatCard('Reported', '${reviews.where((r) => r['reported']).length}', Colors.red, Icons.flag),
                _buildStatCard('Verified', '${reviews.where((r) => r['verified']).length}', Colors.green, Icons.verified),
              ],
            ),
            const SizedBox(height: 24),
            // Filter
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Reviews List', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(8)),
                  child: DropdownButton<String>(
                    value: _filterType,
                    underline: SizedBox(),
                    items: ['All', 'Verified', 'Reported']
                        .map((type) => DropdownMenuItem(value: type, child: Text(type)))
                        .toList(),
                    onChanged: (val) => setState(() => _filterType = val!),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Reviews List
            ...filteredReviews.map((review) => _buildReviewCard(review)),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String label, String value, Color color, IconData icon) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        border: Border.all(color: color.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: TextStyle(color: Colors.black54, fontSize: 12)),
              Icon(icon, color: color, size: 18),
            ],
          ),
          SizedBox(height: 8),
          Text(value, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color)),
        ],
      ),
    );
  }

  Widget _buildReviewCard(Map<String, dynamic> review) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: review['reported'] ? Border.all(color: Colors.red, width: 2) : Border.all(color: Colors.grey.withOpacity(0.2)),
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 4, offset: Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(review['reviewer'], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  SizedBox(height: 4),
                  Text('→ ${review['worker']} | ${review['service']}', style: TextStyle(color: Colors.black54, fontSize: 12)),
                ],
              ),
              Row(
                children: [
                  if (review['verified'])
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(color: Colors.green.withOpacity(0.1), borderRadius: BorderRadius.circular(4)),
                      child: Row(
                        children: [
                          Icon(Icons.verified, size: 14, color: Colors.green),
                          SizedBox(width: 4),
                          Text('Verified', style: TextStyle(color: Colors.green, fontSize: 11, fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ),
                  if (review['reported'])
                    Container(
                      margin: EdgeInsets.only(left: 8),
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(color: Colors.red.withOpacity(0.1), borderRadius: BorderRadius.circular(4)),
                      child: Row(
                        children: [
                          Icon(Icons.flag, size: 14, color: Colors.red),
                          SizedBox(width: 4),
                          Text('Reported', style: TextStyle(color: Colors.red, fontSize: 11, fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ),
                ],
              ),
            ],
          ),
          SizedBox(height: 12),
          // Rating Stars
          Row(
            children: [
              ...List.generate(5, (index) {
                return Icon(
                  index < review['rating'].toInt() ? Icons.star : Icons.star_border,
                  color: Colors.orange,
                  size: 16,
                );
              }),
              SizedBox(width: 8),
              Text('${review['rating']}/5', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.orange)),
              SizedBox(width: 16),
              Text(review['date'], style: TextStyle(color: Colors.black54, fontSize: 12)),
            ],
          ),
          SizedBox(height: 12),
          Text(review['comment'], style: TextStyle(color: Colors.black87, height: 1.5)),
          SizedBox(height: 12),
          Divider(),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('${review['helpful']} people found this helpful', style: TextStyle(color: Colors.black54, fontSize: 12)),
              Row(
                children: [
                  TextButton.icon(
                    onPressed: () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Review hidden'))),
                    icon: Icon(Icons.visibility_off, size: 16),
                    label: Text('Hide'),
                    style: TextButton.styleFrom(foregroundColor: Colors.grey),
                  ),
                  if (review['reported'])
                    TextButton.icon(
                      onPressed: () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Review removed'))),
                      icon: Icon(Icons.delete, size: 16),
                      label: Text('Remove'),
                      style: TextButton.styleFrom(foregroundColor: Colors.red),
                    ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
