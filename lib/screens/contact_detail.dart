import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/contact.dart';
import '../utils/app_theme.dart';

class ContactDetailScreen extends StatelessWidget {
  final Contact contact;

  const ContactDetailScreen({super.key, required this.contact});

  Color _avatarColor(String letter) {
    if (letter.isEmpty) return Colors.blue;
    const colors = [
      Color(0xFF8BB3FF),
      Color(0xFFF6C37C),
      Color(0xFFA5F3FC),
      Color(0xFFFECACA),
      Color(0xFFBBF7D0),
      Color(0xFFD8B4FE),
      Color(0xFFFBCFE8),
      Color(0xFF93C5FD),
    ];
    final index = letter.codeUnitAt(0) % colors.length;
    return colors[index];
  }

  @override
  Widget build(BuildContext context) {
    final initial =
        contact.name.isNotEmpty ? contact.name[0].toUpperCase() : '';
    final avatarColor = _avatarColor(initial);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF007AFF)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Contact Details',
          style: TextStyle(
            fontFamily: AppFontFamily.primary,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black,
            letterSpacing: -0.5,
          ),
        ),
        centerTitle: true,
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
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: kToolbarHeight + 40.h),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: CircleAvatar(
                  radius: 65.r,
                  backgroundColor: avatarColor,
                  child: Text(
                    initial,
                    style: TextStyle(
                      fontFamily: AppFontFamily.primary,
                      color: Colors.white,
                      fontSize: 48.sp,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Text(
                contact.name,
                style: TextStyle(
                  fontFamily: AppFontFamily.primary,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 40.h),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.02),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    _buildInfoRow(
                      iconData: Icons.phone_outlined,
                      iconBackgroundColor: const Color(0xFF8CF098),
                      iconColor: Colors.black87,
                      title: contact.phone,
                      subtitle: 'Mobile',
                      trailingIcon: Icons.message_outlined,
                      onTrailingTap: () async {
                        await launchUrl(Uri.parse("sms:+91${contact.phone}"));
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 76.w, right: 16.w),
                      child: const Divider(height: 1, color: Color(0xFFF0F0F0)),
                    ),
                    _buildInfoRow(
                      iconData: Icons.mail_outline,
                      iconBackgroundColor: const Color(0xFFFDE1A9),
                      iconColor: Colors.black87,
                      title: contact.email,
                      subtitle: 'Personal',
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.h),
              SizedBox(
                width: double.infinity,
                height: 56.h,
                child: ElevatedButton(
                  onPressed: () async {
                    await launchUrl(Uri.parse("tel:+91${contact.phone}"));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0F5CC9),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    elevation: 0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.phone_outlined,
                          color: Colors.white, size: 22.sp),
                      SizedBox(width: 8.w),
                      Text(
                        'Call ${contact.name}',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData iconData,
    required Color iconBackgroundColor,
    required Color iconColor,
    required String title,
    required String subtitle,
    IconData? trailingIcon,
    VoidCallback? onTrailingTap,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
      child: Row(
        children: [
          Container(
            width: 44.w,
            height: 44.w,
            decoration: BoxDecoration(
              color: iconBackgroundColor,
              shape: BoxShape.circle,
            ),
            child: Icon(iconData, color: iconColor, size: 22.sp),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
          if (trailingIcon != null)
            IconButton(
              icon: Icon(trailingIcon,
                  color: const Color(0xFF0F5CC9), size: 24.sp),
              onPressed: onTrailingTap,
            ),
        ],
      ),
    );
  }
}
