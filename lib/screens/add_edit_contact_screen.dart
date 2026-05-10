import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../models/contact.dart';
import '../providers/contact_provider.dart';
import '../utils/app_theme.dart';
import '../utils/validators.dart';

class AddEditContactScreen extends StatefulWidget {
  final Contact? contact;
  const AddEditContactScreen({super.key, this.contact});

  @override
  _AddEditContactScreenState createState() => _AddEditContactScreenState();
}

class _AddEditContactScreenState extends State<AddEditContactScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _name, _phone, _email;

  @override
  void initState() {
    _name = TextEditingController(text: widget.contact?.name ?? '');
    _phone = TextEditingController(text: widget.contact?.phone ?? '');
    _email = TextEditingController(text: widget.contact?.email ?? '');
    super.initState();
  }

  @override
  void dispose() {
    _name.dispose();
    _phone.dispose();
    _email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.contact != null;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF007AFF)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          isEdit ? 'Edit Contact' : 'Add Contact',
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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Text(
                'Full Name',
                style: AppTextStyles.sectionLabel,
              ),
              SizedBox(height: 8.h),
              TextFormField(
                controller: _name,
                decoration: _inputDecoration('Name', Icons.person),
                keyboardType: TextInputType.name,
                textCapitalization: TextCapitalization.words,
                validator: validateName,
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              SizedBox(height: 20.h),
              Text(
                'Phone Number',
                style: AppTextStyles.sectionLabel,
              ),
              SizedBox(height: 8.h),
              TextFormField(
                controller: _phone,
                decoration: _inputDecoration('Phone', Icons.phone),
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[+\d\s\-\(\)]')),
                  _LimitDigitsFormatter(10),
                ],
                validator: validatePhone,
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              SizedBox(height: 20.h),
              Text(
                'Email Address',
                style: AppTextStyles.sectionLabel,
              ),
              SizedBox(height: 8.h),
              TextFormField(
                controller: _email,
                decoration: _inputDecoration('Email', Icons.email),
                keyboardType: TextInputType.emailAddress,
                textCapitalization: TextCapitalization.none,
                validator: validateEmail,
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              SizedBox(height: 30.h),
              CustomButton(
                isEdit: isEdit,
                formKey: _formKey,
                widget: widget,
                name: _name,
                phone: _phone,
                email: _email,
              )
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint, IconData icon) {
    return InputDecoration(
      hintText: hint,
      hintStyle: AppTextStyles.fieldHint,
      prefixIcon: Icon(icon, color: AppColors.icon),
      filled: true,
      fillColor: AppColors.inputFill,
      contentPadding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 16.w),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18.r),
        borderSide: const BorderSide(color: Colors.transparent),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18.r),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18.r),
        borderSide: BorderSide(color: Colors.blue.shade400, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18.r),
        borderSide: BorderSide(color: Colors.red.shade400, width: 1.5),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18.r),
        borderSide: BorderSide(color: Colors.red.shade600, width: 2),
      ),
    );
  }
}

class _LimitDigitsFormatter extends TextInputFormatter {
  final int maxDigits;

  _LimitDigitsFormatter(this.maxDigits);

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digitsOnly = newValue.text.replaceAll(RegExp(r'[^\d]'), '');
    if (digitsOnly.length <= maxDigits) {
      return newValue;
    }
    return oldValue;
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.isEdit,
    required GlobalKey<FormState> formKey,
    required this.widget,
    required TextEditingController name,
    required TextEditingController phone,
    required TextEditingController email,
  })  : _formKey = formKey,
        _name = name,
        _phone = phone,
        _email = email;

  final bool isEdit;
  final GlobalKey<FormState> _formKey;
  final AddEditContactScreen widget;
  final TextEditingController _name;
  final TextEditingController _phone;
  final TextEditingController _email;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56.h,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryDark,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          elevation: 4,
          padding: EdgeInsets.symmetric(horizontal: 20.w),
        ),
        icon: Icon(
          isEdit ? Icons.update : Icons.add,
          color: Colors.white,
          size: 22.sp,
        ),
        label: Text(
          isEdit ? 'Update Contact' : 'Add Contact',
          style: AppTextStyles.buttonLabel,
        ),
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            final provider = context.read<ContactProvider>();
            final contact = Contact(
              id: isEdit ? widget.contact!.id : UniqueKey().toString(),
              name: _name.text.trim(),
              phone: _phone.text.trim(),
              email: _email.text.trim(),
              isFavorite: isEdit ? widget.contact!.isFavorite : false,
            );

            isEdit
                ? provider.updateContact(contact)
                : provider.addContact(contact);

            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
