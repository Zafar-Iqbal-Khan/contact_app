import 'dart:ui' as ui;
import 'package:contacts_app/screens/contact_detail.dart';
import 'package:contacts_app/widgets/contact_tile.dart';
import 'package:contacts_app/widgets/custom_slidable_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart' as my_auth;
import '../providers/contact_provider.dart';
import '../screens/login_screen.dart';
import '../utils/app_theme.dart';
import '../models/contact.dart';

class ContactsScreen extends StatefulWidget {
  const ContactsScreen({super.key});

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  @override
  Widget build(BuildContext context) {
    final contacts = context.watch<ContactProvider>().contacts;
    final provider = Provider.of<ContactProvider>(context, listen: false);
    final authProvider =
        Provider.of<my_auth.AuthProvider>(context, listen: false);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.search_rounded, color: Color(0xFF007AFF)),
          onPressed: () {
            showSearch<Contact?>(
              context: context,
              delegate: ContactSearchDelegate(contacts),
            );
          },
        ),
        title: Text(
          'Contacts',
          style: TextStyle(
            fontFamily: AppFontFamily.primary,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black,
            letterSpacing: -0.5,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout_rounded, color: Color(0xFF007AFF)),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  backgroundColor: const Color(0xFFEAEAEA),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24.r),
                  ),
                  title: Text(
                    'Logout',
                    style: TextStyle(
                      fontFamily: AppFontFamily.primary,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.black87,
                    ),
                  ),
                  content: Text(
                    'Are you sure you want to logout?',
                    style: TextStyle(
                      fontFamily: AppFontFamily.primary,
                      fontSize: 15.sp,
                      color: Colors.black87,
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          color: Color(0xFF007AFF),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        Navigator.pop(context);
                        await authProvider.signOut();
                        if (!mounted) return;
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const LoginScreen()),
                        );
                      },
                      child: const Text(
                        'Logout',
                        style: TextStyle(
                          color: Color(0xFF007AFF),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white.withOpacity(0.8),
        surfaceTintColor: Colors.transparent,
        flexibleSpace: ClipRect(
          child: BackdropFilter(
            filter: ui.ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: Container(color: Colors.transparent),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(0.5),
          child: Container(
            color: Colors.black.withOpacity(0.1),
            height: 0.5,
          ),
        ),
      ),
      body: SafeArea(
        child: contacts.isEmpty
            ? Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.contact_page_outlined,
                      size: 80.sp,
                      color: Colors.grey.shade400,
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      'No contacts yet',
                      style: AppTextStyles.headline.copyWith(
                        fontSize: 18.sp,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Tap + to add your first contact',
                      style: AppTextStyles.fieldHint.copyWith(
                        fontSize: 14.sp,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
              )
            : SlidableAutoCloseBehavior(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.only(top: 10.h, bottom: 100.h),
                  itemCount: contacts.length,
                  itemBuilder: (context, i) => GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              ContactDetailScreen(contact: contacts[i]),
                        ),
                      );
                    },
                    child: CustomSlidableContactTile(
                      contact: contacts[i],
                      provider: provider,
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}

class ContactSearchDelegate extends SearchDelegate<Contact?> {
  final List<Contact> allContacts;

  ContactSearchDelegate(this.allContacts);

  @override
  String get searchFieldLabel => 'Search contacts';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            query = '';
            showSuggestions(context);
          },
        ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back_rounded),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = _filterContacts();
    return _buildResultList(results);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = _filterContacts();
    return _buildResultList(suggestions);
  }

  List<Contact> _filterContacts() {
    if (query.isEmpty) return allContacts;
    final lowerQuery = query.toLowerCase();
    return allContacts.where((contact) {
      return contact.name.toLowerCase().contains(lowerQuery) ||
          contact.phone.contains(lowerQuery) ||
          contact.email.toLowerCase().contains(lowerQuery);
    }).toList();
  }

  Widget _buildResultList(List<Contact> results) {
    if (results.isEmpty) {
      return Center(
        child: Text(
          'No contacts found',
          style: AppTextStyles.headline.copyWith(
            fontSize: 18.sp,
            color: Colors.grey.shade600,
          ),
        ),
      );
    }

    return ListView.builder(
      itemCount: results.length,
      padding: EdgeInsets.only(top: 8.h),
      itemBuilder: (context, index) {
        return ContactTile(contact: results[index]);
      },
    );
  }
}
