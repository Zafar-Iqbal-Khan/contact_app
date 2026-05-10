import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/app_theme.dart';
import 'contacts_screen.dart';
import 'favourites_screen.dart';
import 'add_edit_contact_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final screens = [const ContactsScreen(), const FavoritesScreen()];

  Widget _navigationItem(IconData icon, String label, bool active) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 4.h),
      color: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: active ? const Color(0xFF007AFF) : const Color(0xFF999999),
            size: 26.sp,
          ),
          SizedBox(height: 4.h),
          Text(
            label,
            style: TextStyle(
              fontFamily: AppFontFamily.primary,
              fontSize: 10.sp,
              fontWeight: active ? FontWeight.w600 : FontWeight.w500,
              color: active ? const Color(0xFF007AFF) : const Color(0xFF999999),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: screens[_currentIndex],
      bottomNavigationBar: ClipRect(
        child: BackdropFilter(
          filter: ui.ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.85),
              border: Border(
                top: BorderSide(
                  color: Colors.black.withOpacity(0.15),
                  width: 0.5,
                ),
              ),
            ),
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).padding.bottom > 0
                  ? MediaQuery.of(context).padding.bottom
                  : 10.h,
              top: 6.h,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => setState(() => _currentIndex = 0),
                  child: _navigationItem(
                    _currentIndex == 0
                        ? Icons.contacts_rounded
                        : Icons.contacts_outlined,
                    'Contacts',
                    _currentIndex == 0,
                  ),
                ),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => setState(() => _currentIndex = 1),
                  child: _navigationItem(
                    _currentIndex == 1
                        ? Icons.star_rounded
                        : Icons.star_border_rounded,
                    'Favorites',
                    _currentIndex == 1,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: _currentIndex == 0
          ? FloatingActionButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AddEditContactScreen()),
              ),
              backgroundColor: const Color(0xFF007AFF),
              child: const Icon(Icons.add, color: Colors.white),
            )
          : null,
    );
  }
}
