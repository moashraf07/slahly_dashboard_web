import 'package:flutter/material.dart';
import 'package:salhly_dashboard/dash.dart';
import 'package:salhly_dashboard/users.dart';
import 'package:salhly_dashboard/workers.dart';
import 'package:salhly_dashboard/requests.dart';
import 'package:salhly_dashboard/financials.dart';
import 'package:salhly_dashboard/subscriptions.dart';
import 'package:salhly_dashboard/ratings.dart';
import 'package:salhly_dashboard/settings.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Salhly Dashboard',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: SamplePage(),
      routes: {
        '/users': (context) => UsersPage(),
      },
      onGenerateRoute: (settings) {
        // Handle routes that aren't defined in the routes table
        switch (settings.name) {
          case '/workers':
            return MaterialPageRoute(builder: (_) => WorkersPage());
          case '/requests':
            return MaterialPageRoute(builder: (_) => RequestsPage());
          case '/financials':
            return MaterialPageRoute(builder: (_) => FinancialsPage());
          case '/subscriptions':
            return MaterialPageRoute(builder: (_) => SubscriptionsPage());
          case '/ratings':
            return MaterialPageRoute(builder: (_) => RatingsPage());
          case '/settings':
            return MaterialPageRoute(builder: (_) => SettingsPage());
          default:
            return MaterialPageRoute(builder: (_) => PlaceholderPage('Page Not Found'));
        }
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('Route ${settings.name} not found'),
            ),
          ),
        );
      },
    );
  }
}

class PlaceholderPage extends StatelessWidget {
  final String title;

  const PlaceholderPage(this.title, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            Text('Coming Soon...', style: TextStyle(fontSize: 16, color: Colors.grey)),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}
