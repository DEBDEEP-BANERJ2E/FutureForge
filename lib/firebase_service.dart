import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseService {
  static final _firestore = FirebaseFirestore.instance;
  static final _storage = FirebaseStorage.instance;
  static final _auth = FirebaseAuth.instance;

  static String? get userId => _auth.currentUser?.uid;

  static Future<void> saveUserProfile(
    Map<String, dynamic> data, File? resumeFile) async {
    final uid = userId;
    if (uid == null) return;

    if (resumeFile != null) {
      String resumeUrl = await uploadResume(resumeFile);
      data['resumeUrl'] = resumeUrl;
    }

    await _firestore.collection('user_profiles').doc(uid).set(data);
  }


  static Future<Map<String, dynamic>?> fetchUserProfile() async {
    DocumentSnapshot doc =
        await _firestore.collection('user_profiles').doc(userId).get();
    return doc.exists ? doc.data() as Map<String, dynamic> : null;
  }

  static Future<String> uploadResume(File resume) async {
    final ref =
        _storage.ref().child("resumes/$userId/${resume.path.split('/').last}");
    await ref.putFile(resume);
    return await ref.getDownloadURL();
  }
}
