import 'package:adstacks/models/page_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => PageProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
  title: Consumer<PageProvider>(
    builder: (context, pageProvider, child) {
      String pageTitle;
      switch (pageProvider.currentPage) {
        case 'Employees':
          pageTitle = 'Employees';
          break;
        case 'Attendance':
          pageTitle = 'Attendance';
          break;
        case 'Summary':
          pageTitle = 'Summary';
          break;
        case 'Information':
          pageTitle = 'Information';
          break;
        case 'Settings':
          pageTitle = 'Settings';
          break;
        default:
          pageTitle = 'Home'; // Default title
      }
      return Text(pageTitle);
    },
  ),
  backgroundColor: Colors.white,
  elevation: 0,
  actions: [
    IconButton(
            icon: const Icon(Icons.calendar_month),
            onPressed: () {
              // Handle Calender action
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Calender button pressed'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
          ),
    IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Handle notifications action
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Notification button pressed'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.power_settings_new),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Logged out successfully'),
                  duration: Duration(seconds: 2),
                ),
              );
              // Implement logout functionality here if needed
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            children: <Widget>[
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: SizedBox(
                  height: 150,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        radius: 40.0,
                        backgroundImage: NetworkImage(
                          'https://imgs.search.brave.com/YnPE-VUjKKLIkaZxWmb4-kSXFe5uN80YsXuDz79QNbQ/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly9pbWFn/ZXMuY3RmYXNzZXRz/Lm5ldC9vZ2dhZDZz/dnV6a3YvbHZYOEtT/UklqWXFnMDZZNlM0/U1lhLzE4YTdiMjU1/Y2M5YTU1Y2IwMzJh/ZGQyYjk3YmFkN2Ex/L0Fsd2F5c19EaXNj/cmVldC5wbmc_Zm09/d2VicA',
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Pooja Mishra',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const Text(
                        'Admin',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Main Menu Items
              ListTile(
                leading: const Icon(Icons.home),
                title: const Text('Home'),
                onTap: () {
                  context.read<PageProvider>().setCurrentPage('Home');
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.people),
                title: const Text('Employees'),
                  onTap: () {
                  // Navigate to EmployeesPage
                     Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const EmployeesPage()),
                     );
                    },
                ),
              ListTile(
                leading: const Icon(Icons.check_circle_outline),
                title: const Text('Attendance'),
                onTap: () {
                  context.read<PageProvider>().setCurrentPage('Attendance');
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.calendar_today),
                title: const Text('Summary'),
                onTap: () {
                  context.read<PageProvider>().setCurrentPage('Summary');
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.info),
                title: const Text('Information'),
                onTap: () {
                  context.read<PageProvider>().setCurrentPage('Information');
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
        // Bottom Menu Items
        ListTile(
          leading: const Icon(Icons.settings),
          title: const Text('Settings'),
          onTap: () {
            context.read<PageProvider>().setCurrentPage('Settings');
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: const Icon(Icons.logout),
          title: const Text('Logout'),
          onTap: () {
            // Show a SnackBar when the logout button is pressed
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('Logged out successfully'),
                duration: const Duration(seconds: 2),
              ),
            );
            // Add logout functionality
            Navigator.pop(context);
          },
        ),
      ],
    ),
  ),
),


      // BODY
      body: Consumer<PageProvider>(
        builder: (context, pageProvider, child) {
          switch (pageProvider.currentPage) {
            case 'Employees':
              return const EmployeesPage();
            case 'Attendance':
              return const AttendancePage();
            case 'Summary':
              return const SummaryPage();
            case 'Information':
              return const InformationPage();
            case 'Settings':
              return const SettingsPage();
            default:
              return const HomeContent(); // Default home content
          }
        },
      ),
    );
  }
}

// Home Content Widget
class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                color: Colors.deepPurple[900], // Background color similar to the image
                borderRadius: BorderRadius.circular(30.0), // Rounded corners
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    hintStyle: TextStyle(
                      color: Colors.grey[300], // Placeholder color
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: const BorderSide(),
                    ),
                    suffixIcon: Icon(Icons.search,
                    color: Colors.grey[300],),
                  ),
                ),
              ),
                        ),
            ),
            // Top Rating Project Section
            Stack(
          children: [
            // Background Image
            Positioned.fill(
              child: Image.network(
                'https://imgs.search.brave.com/YnPE-VUjKKLIkaZxWmb4-kSXFe5uN80YsXuDz79QNbQ/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly9pbWFn/ZXMuY3RmYXNzZXRz/Lm5ldC9vZ2dhZDZz/dnV6a3YvbHZYOEtT/UklqWXFnMDZZNlM0/U1lhLzE4YTdiMjU1/Y2M5YTU1Y2IwMzJh/ZGQyYjk3YmFkN2Ex/L0Fsd2F5c19EaXNj/cmVldC5wbmc_Zm09/d2VicA', // Replace with your image URL
                fit: BoxFit.cover,
              ),
            ),
            // Container with Decoration
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.purpleAccent.withOpacity(0.7), // Optional: add opacity
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Ethereum 2.0',
                    style: TextStyle(color: Colors.white),
                  ),
                  const Text(
                    'Top Rating Project',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  const Text(
                    'Trending project and high rating project created by team.',
                    style: TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      // Show a SnackBar when the button is pressed
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Button Pressed'),
        duration: const Duration(seconds: 1), // Duration for which the SnackBar is visible
      ),
    );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    child: const Text(
                      'Learn More',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
            const SizedBox(height: 24.0),
            // All Projects Section
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.blueGrey[900],
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'All Projects',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  projectItem('Technology behind the Blockchain'),
                  const SizedBox(height: 8.0),
                  projectItem('Project 2'),
                  const SizedBox(height: 8.0),
                  projectItem('Project 3'),
                  const SizedBox(height: 24.0),
                ],
              ),
            ),
            const SizedBox(height: 24.0),
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.blueGrey[900],
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Top Creators',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16.0),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'NAME',
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          'ARTWORK',
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          'RATING',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    creatorItem('@madison_c21', 9821, 4.9),
                    const SizedBox(height: 8.0),
                    creatorItem('@karl_wil02', 7032, 4.7),
                    const SizedBox(height: 8.0),
                    creatorItem('@anna_smith', 8921, 4.8),
                  ],
                ),
              ),
            const SizedBox(height: 24.0),
              // Performance Chart Section (Placeholder)
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      blurRadius: 8.0,
                      spreadRadius: 2.0,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Over All Performance',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    const Text('Pending Done vs. Project Done'),
                    const SizedBox(height: 16.0),
                    // Placeholder for chart
                    Container(
                      height: 150,
                      color: Colors.blue[100],
                      alignment: Alignment.center,
                      child: const Text('Graph/Chart Placeholder'),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  // Project item widget
  Widget projectItem(String title) {
    return Container(
      child: ElevatedButton(
        onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueGrey[900],
              shape: RoundedRectangleBorder(
               borderRadius: BorderRadius.circular(12.0),
          ),
        ),
        child: ListTile(
          enabled: true,
          onTap: (){
          },
          minLeadingWidth: 4,
          contentPadding: EdgeInsets.all(4),
          leading: const CircleAvatar(
                   radius: 18.0,
                    backgroundImage: NetworkImage(
                      'https://imgs.search.brave.com/YnPE-VUjKKLIkaZxWmb4-kSXFe5uN80YsXuDz79QNbQ/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly9pbWFn/ZXMuY3RmYXNzZXRz/Lm5ldC9vZ2dhZDZz/dnV6a3YvbHZYOEtT/UklqWXFnMDZZNlM0/U1lhLzE4YTdiMjU1/Y2M5YTU1Y2IwMzJh/ZGQyYjk3YmFkN2Ex/L0Fsd2F5c19EaXNj/cmVldC5wbmc_Zm09/d2VicA',
                    ),
                  ),
          title: Text(
            title,
            style: const TextStyle(color: Colors.white,fontSize: 12),
          ),
          trailing:
              IconButton(
                icon: const Icon(Icons.edit),
                color: Colors.white,
                onPressed: () {},
              ),
        ),
      ),
    );
  }

  // Creator item widget
  Widget creatorItem(String name, int score, double rate) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          name,
          style: const TextStyle(color: Colors.white),
        ),
        Text(
          '$score',
          style: const TextStyle(color: Colors.white),
        ),
        Text(
          rate.toStringAsFixed(1),
          style: const TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}

// Employees Page Widget
class EmployeesPage extends StatelessWidget {
  const EmployeesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: const Text('Employees Page'));
  }
}

// Attendance Page Widget
class AttendancePage extends StatelessWidget {
  const AttendancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: const Text('Attendance Page'));
  }
}

// Summary Page Widget
class SummaryPage extends StatelessWidget {
  const SummaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: const Text('Summary Page'));
  }
}

// Information Page Widget
class InformationPage extends StatelessWidget {
  const InformationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: const Text('Information Page'));
  }
}

// Settings Page Widget
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: const Text('Settings Page'));
  }
}
