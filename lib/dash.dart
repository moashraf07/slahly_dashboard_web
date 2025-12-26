import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';

class SamplePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
       
      backgroundColor: Colors.white,
      
      sideBar: SideBar(
         backgroundColor: Colors.white,
         textStyle: const TextStyle(color: Color.fromARGB(255, 102, 100, 100)),
 
        items: const [
          AdminMenuItem(
            title: 'Dashboard',
            route: '/',
            icon: Icons.dashboard,

          ),
          AdminMenuItem(
            title: 'Sections',
            icon: Icons.file_copy,
            children: [
              AdminMenuItem(
                title: 'Users',
                route: '/users',
                
              ),
              AdminMenuItem(
                title: 'Workers',
                route: '/workers',
              ),
              AdminMenuItem(
                title: 'Requests',
                route: '/requests',
              ),
              AdminMenuItem(
                title: 'Financials',
                route: '/financials',
              ),
              AdminMenuItem(
                title: 'Settings',
                route: '/settings',
              ),
            ],
          ),
        ],
        selectedRoute: '/',
        onSelected: (item) {
          if (item.route != null) {
            Navigator.of(context).pushNamed(item.route!);
          }
        },
        header: Container(
          height: 50,
          width: double.infinity,
          color: const Color(0xff444444),
          child: const Center(
            child: Text(
              'Service Admin',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
        footer: Container(
          height: 50,
          width: double.infinity,
          color: const Color(0xff444444),
          child: const Center(
            child: Text(
              'Mohamed Ashraf © 2026',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: const Text(
                'Dashboard Overview',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 36,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 16),
            LayoutBuilder(
              builder: (context, constraints) {
                int crossAxisCount = 4;
                if (constraints.maxWidth < 1200) crossAxisCount = 3;
                if (constraints.maxWidth < 900) crossAxisCount = 2;
                if (constraints.maxWidth < 600) crossAxisCount = 1;
                return GridView.count(
                  crossAxisCount: crossAxisCount,
                  shrinkWrap: true,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  physics: const NeverScrollableScrollPhysics(),
                  children: const [
                    StatCard(title: 'Total Users', value: '1,234', change: '+12.5%', icon: Icons.people, color: Colors.blue),
                    StatCard(title: 'Total Workers', value: '256', change: '+8.2%', icon: Icons.work, color: Colors.green),
                    StatCard(title: 'Total Requests', value: '3,456', change: '+24.8%', icon: Icons.request_page, color: Colors.orange),
                    StatCard(title: 'Completed Jobs', value: '2,890', change: '+15.3%', icon: Icons.check_circle, color: Colors.teal),
                    StatCard(title: 'Total Revenue', value: '\$12,345', change: '+32.1%', icon: Icons.attach_money, color: Colors.purple),
                    StatCard(title: 'Commission Earned', value: '\$1,234', change: '+18.9%', icon: Icons.money_off, color: Colors.red),
                    StatCard(title: 'Active Subscriptions', value: '98', change: '+5.4%', icon: Icons.subscriptions, color: Colors.indigo),
                  ],
                );
              },
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.15), blurRadius: 6, offset: Offset(0, 4))],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Revenue Trend', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                        const SizedBox(height: 16),
                        SizedBox(
                          height: 300,
                          child: LineChart(
                            LineChartData(
                              gridData: FlGridData(show: true, drawVerticalLine: true),
                              titlesData: FlTitlesData(show: true),
                              borderData: FlBorderData(show: true),
                              minX: 0,
                              maxX: 6,
                              minY: 0,
                              maxY: 4,
                              lineBarsData: [
                                LineChartBarData(
                                  spots: [
                                    FlSpot(0, 1),
                                    FlSpot(1, 1.5),
                                    FlSpot(2, 1.4),
                                    FlSpot(3, 3),
                                    FlSpot(4, 2),
                                    FlSpot(5, 2.8),
                                    FlSpot(6, 3.5),
                                  ],
                                  isCurved: true,
                                  color: Colors.blue,
                                  barWidth: 3,
                                  isStrokeCapRound: true,
                                  dotData: FlDotData(show: true),
                                  belowBarData: BarAreaData(
                                    show: true,
                                    color: Colors.blue.withOpacity(0.1),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.15), blurRadius: 6, offset: Offset(0, 4))],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Request Breakdown', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                        const SizedBox(height: 16),
                        SizedBox(
                          height: 300,
                          child: PieChart(
                            PieChartData(
                              sections: [
                                PieChartSectionData(value: 40, title: 'Pending\n40%', color: Colors.blue, radius: 60),
                                PieChartSectionData(value: 35, title: 'Completed\n35%', color: Colors.green, radius: 60),
                                PieChartSectionData(value: 25, title: 'Cancelled\n25%', color: Colors.red, radius: 60),
                              ],
                            ),
                            duration: const Duration(seconds: 1),
                            curve: Curves.easeInOut,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.15), blurRadius: 6, offset: Offset(0, 4))],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Recent Activity', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  const SizedBox(height: 16),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columns: const [
                        DataColumn(label: Text('Request ID')),
                        DataColumn(label: Text('User')),
                        DataColumn(label: Text('Worker')),
                        DataColumn(label: Text('Amount')),
                        DataColumn(label: Text('Status')),
                        DataColumn(label: Text('Date')),
                      ],
                      rows: [
                        DataRow(cells: [
                          DataCell(Text('#REQ-001')),
                          DataCell(Text('Ahmed Hassan')),
                          DataCell(Text('Ali Mohamed')),
                          DataCell(Text('\$150.00')),
                          DataCell(Container(
                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.green.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text('Completed', style: TextStyle(color: Colors.green, fontSize: 12)),
                          )),
                          DataCell(Text('2025-12-25')),
                        ]),
                        DataRow(cells: [
                          DataCell(Text('#REQ-002')),
                          DataCell(Text('Fatima Ali')),
                          DataCell(Text('Sara Ahmed')),
                          DataCell(Text('\$200.00')),
                          DataCell(Container(
                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.blue.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text('Pending', style: TextStyle(color: Colors.blue, fontSize: 12)),
                          )),
                          DataCell(Text('2025-12-26')),
                        ]),
                        DataRow(cells: [
                          DataCell(Text('#REQ-003')),
                          DataCell(Text('Mohammed Salem')),
                          DataCell(Text('Layla Karim')),
                          DataCell(Text('\$175.00')),
                          DataCell(Container(
                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.green.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text('Completed', style: TextStyle(color: Colors.green, fontSize: 12)),
                          )),
                          DataCell(Text('2025-12-26')),
                        ]),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StatCard extends StatefulWidget {
  final String title;
  final String value;
  final String? change;
  final IconData icon;
  final Color color;

  const StatCard({
    Key? key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    this.change,
  }) : super(key: key);

  @override
  State<StatCard> createState() => _StatCardState();
}

class _StatCardState extends State<StatCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final bool isPositive = widget.change != null && widget.change!.startsWith('+');
    
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: _isHovered ? widget.color.withOpacity(0.2) : Colors.grey.withOpacity(0.08),
              blurRadius: _isHovered ? 12 : 6,
              offset: Offset(0, _isHovered ? 6 : 4),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: widget.color.withOpacity(0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(widget.icon, color: widget.color, size: 22),
                ),
                if (widget.change != null)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: isPositive ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      widget.change!,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: isPositive ? Colors.green : Colors.red,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 10),
            Text(widget.title, style: const TextStyle(fontSize: 14, color: Colors.black54)),
            const SizedBox(height: 6),
            Text(widget.value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}