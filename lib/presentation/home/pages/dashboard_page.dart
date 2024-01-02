import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cbt_tpa_app/data/datasources/auth_lokal_datasource.dart';
import 'package:flutter_cbt_tpa_app/presentation/auth/pages/login_page.dart';
import 'package:flutter_cbt_tpa_app/presentation/home/pages/home_page.dart';
import 'package:flutter_cbt_tpa_app/core.dart';

// import '../../../data/datasources/auth_lokal_datasource.dart';
import '../../auth/bloc/logout/logout_bloc.dart';
// import '../../auth/pages/login_page.dart';
import '../../materi/pages/materi_page.dart';
import '../../profile/pages/profile_page.dart';
import '../widgets/nav_menu.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const MateriPage(),
    const Center(
      child: Text('Notif'),
    ),
    const ProfilePage(),
  ];

  void _onItemTapped(int index) {
    _selectedIndex = index;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.0)),
          color: AppColors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            NavMenu(
              iconPath: Assets.icons.home.path,
              label: 'Home',
              isActive: _selectedIndex == 0,
              onPressed: () => _onItemTapped(0),
            ),
            NavMenu(
              iconPath: Assets.icons.message.path,
              label: 'Materi',
              isActive: _selectedIndex == 1,
              onPressed: () => _onItemTapped(1),
            ),
            NavMenu(
              iconPath: Assets.icons.bell.path,
              label: 'Notification',
              isActive: _selectedIndex == 2,
              onPressed: () => _onItemTapped(2),
            ),
            NavMenu(
              iconPath: Assets.icons.user.path,
              label: 'Profile',
              isActive: _selectedIndex == 3,
              onPressed: () => _onItemTapped(3),
            ),
          ],
        ),
      ),
    );
  }
}

class LogoutWidget extends StatefulWidget {
  const LogoutWidget({
    super.key,
  });

  @override
  State<LogoutWidget> createState() => _LogoutWidgetState();
}

class _LogoutWidgetState extends State<LogoutWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
          onPressed: () {
            context.read<LogoutBloc>().add(const LogoutEvent.logout());
            AuthLocalDatasource().removeAuthData();
            context.pushReplacement(const LoginPage());
          },
          child: const Text('Logout')),
    );
  }
}