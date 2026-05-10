import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../models/contact.dart';
import '../models/pending_action.dart';
import '../services/local_db_service.dart';
import '../services/firebase_service.dart';
import 'auth_provider.dart';

class ContactProvider with ChangeNotifier {
  List<Contact> _contacts = [];
  final List<PendingAction> _pendingActions = [];

  AuthProvider? _authProvider;

  ContactProvider() {
    _monitorConnectivity();
  }

  List<Contact> get contacts => _contacts;
  List<Contact> get favorites => _contacts.where((c) => c.isFavorite).toList();

  void updateAuth(AuthProvider authProvider) {
    _authProvider = authProvider;
    if (_authProvider?.user != null) {
      init();
    } else {
      _contacts = [];
      notifyListeners();
    }
  }

  Future<void> init() async {
    await LocalDbService.initDb();
    if (_authProvider?.user != null) {
      await loadLocalContacts();
      await syncFromFirebase();
    }
  }

  Future<void> loadLocalContacts() async {
    _contacts = await LocalDbService.getAllContacts();
    notifyListeners();
  }

  Future<void> syncFromFirebase() async {
    if (!await _isConnected() || _authProvider?.user == null) return;

    try {
      final firebaseContacts =
          await FirebaseService.fetchContacts(_authProvider!.user!.uid);
      _contacts = firebaseContacts;

      await LocalDbService.clearAllContacts();
      for (final contact in firebaseContacts) {
        await LocalDbService.insertContact(contact);
      }

      notifyListeners();
    } catch (e) {
      debugPrint("Sync failed: $e");
    }
  }

  Future<void> addContact(Contact contact) async {
    if (_authProvider?.user == null) return;

    if (await _isConnected()) {
      await FirebaseService.addContact(_authProvider!.user!.uid, contact);
    } else {
      _pendingActions.add(PendingAction(action: 'add', contact: contact));
    }

    await LocalDbService.insertContact(contact);
    _contacts.add(contact);
    notifyListeners();
  }

  Future<void> updateContact(Contact contact) async {
    if (_authProvider?.user == null) return;

    if (await _isConnected()) {
      await FirebaseService.updateContact(_authProvider!.user!.uid, contact);
    } else {
      _pendingActions.add(PendingAction(action: 'update', contact: contact));
    }

    await LocalDbService.updateContact(contact);
    final index = _contacts.indexWhere((c) => c.id == contact.id);
    if (index != -1) _contacts[index] = contact;
    notifyListeners();
  }

  Future<void> deleteContact(String id) async {
    if (_authProvider?.user == null) return;

    final contact = _contacts.firstWhere((c) => c.id == id);

    if (await _isConnected()) {
      await FirebaseService.deleteContact(_authProvider!.user!.uid, id);
    } else {
      _pendingActions.add(PendingAction(action: 'delete', contact: contact));
    }

    await LocalDbService.deleteContact(id);
    _contacts.removeWhere((c) => c.id == id);
    notifyListeners();
  }

  Future<void> toggleFavorite(Contact contact) async {
    if (_authProvider?.user == null) return;

    final updatedContact = Contact(
      id: contact.id,
      name: contact.name,
      phone: contact.phone,
      email: contact.email,
      isFavorite: !contact.isFavorite,
    );

    if (await _isConnected()) {
      await FirebaseService.updateContact(
          _authProvider!.user!.uid, updatedContact);
    } else {
      _pendingActions
          .add(PendingAction(action: 'update', contact: updatedContact));
    }

    await LocalDbService.updateContact(updatedContact);

    final index = _contacts.indexWhere((c) => c.id == contact.id);
    if (index != -1) {
      _contacts[index] = updatedContact;
      notifyListeners();
    }
  }

  Future<bool> _isConnected() async {
    final result = await Connectivity().checkConnectivity();
    return result != ConnectivityResult.none;
  }

  void _monitorConnectivity() {
    Connectivity().onConnectivityChanged.listen((result) {
      if (result != ConnectivityResult.none) {
        _syncPendingActions();
      }
    });
  }

  Future<void> _syncPendingActions() async {
    if (_authProvider?.user == null) {
      debugPrint('[Sync] Skipped: User is null');
      return;
    }

    if (_pendingActions.isEmpty) {
      debugPrint('[Sync] Skipped: No pending actions');
      return;
    }

    debugPrint('[Sync] Started syncing ${_pendingActions.length} actions');

    final actions = List<PendingAction>.from(_pendingActions);
    _pendingActions.clear();

    for (final action in actions) {
      try {
        debugPrint(
            '[Sync] Processing action: ${action.action} for contact: ${action.contact.id}');
        if (action.action == 'add') {
          await FirebaseService.addContact(
              _authProvider!.user!.uid, action.contact);
          debugPrint('[Sync] Add successful for: ${action.contact.id}');
        } else if (action.action == 'update') {
          await FirebaseService.updateContact(
              _authProvider!.user!.uid, action.contact);
          debugPrint('[Sync] Update successful for: ${action.contact.id}');
        } else if (action.action == 'delete') {
          await FirebaseService.deleteContact(
              _authProvider!.user!.uid, action.contact.id);
          debugPrint('[Sync] Delete successful for: ${action.contact.id}');
        } else {
          debugPrint('[Sync] Unknown action: ${action.action}');
        }
      } catch (e) {
        debugPrint(
            '[Sync] Failed for action: ${action.action} on contact: ${action.contact.id}, error: $e');
        _pendingActions.add(action);
      }
    }

    debugPrint('[Sync] Completed');
  }
}
