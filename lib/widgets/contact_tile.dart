import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../models/contact.dart';
import '../providers/contact_provider.dart';
import '../utils/app_theme.dart';

class ContactTile extends StatelessWidget {
  final Contact contact;
  const ContactTile({super.key, required this.contact});

  Color _avatarColor(String letter) {
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
    final provider = context.read<ContactProvider>();
    final initial =
        contact.name.isNotEmpty ? contact.name[0].toUpperCase() : '?';
    final avatarColor = _avatarColor(initial);

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      elevation: 1,
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 26.r,
              backgroundColor: avatarColor,
              child: Text(
                initial,
                style: AppTextStyles.headline.copyWith(
                  color: Colors.white,
                  fontSize: 20.sp,
                ),
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    contact.name,
                    style: AppTextStyles.fieldHint.copyWith(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF0F172A),
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    contact.phone,
                    style: AppTextStyles.fieldHint.copyWith(
                      fontSize: 14.sp,
                      color: const Color(0xFF6B7280),
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(
                contact.isFavorite ? Icons.star : Icons.star_border,
                color: contact.isFavorite
                    ? const Color(0xFFF59E0B)
                    : const Color(0xFF94A3B8),
                size: 24.sp,
              ),
              onPressed: () => provider.toggleFavorite(contact),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomDivider extends StatelessWidget {
  const CustomDivider({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      color: Colors.grey.shade300,
    );
  }
}
