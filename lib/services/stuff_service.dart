import 'dart:convert';
import 'package:http/http.dart' as http;

class StaffService {
  static Future<List<dynamic>> fetchStaffList() async {
    final response = await http.get(Uri.parse('http://10.202.7.251/staff'));
    if (response.statusCode == 200) {
      return List<dynamic>.from(json.decode(response.body));
    } else {
      throw Exception('Failed to load staff list');
    }
  }

  static Future<void> addStaff(Map<String, dynamic> staffData) async {
    final response = await http.post(
      Uri.parse('http://10.202.7.251/staff'),
      body: staffData,
    );
    if (response.statusCode != 201) {
      throw Exception('Failed to add staff member');
    }
  }

  static Future<void> deleteStaff(String staffId) async {
    final response = await http.delete(
      Uri.parse('http://10.202.7.251/staff/$staffId'),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to delete staff member');
    }
  }
}