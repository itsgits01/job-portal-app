import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class JobService {
  Future<List<Job>> getJobs(BuildContext context) async {
    try {
      http.Response response = await http.get(
        Uri.parse('https://meithee.in/hihres/api/position/open'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(response.body);
        List<dynamic> jobsData = jsonData['data']['data'];

        List<Job> jobs = jobsData.map((jobData) {
          return Job.fromJson(jobData);
        }).toList();

        return jobs;
      } else {
        // Handle other status codes if needed
        throw Exception('Failed to load jobs');
      }
    } catch (e) {
      // Handle errors
      throw Exception('Failed to load jobs: $e');
    }
  }
}

class Job {
  final int id;
  final String roleType;
  final String hiringType;
  final String jobTitle;
  final String jobLocationCountry;
  final String jobLocationState;
  final String jobLocationCity;
  final String workLocation;
  final String experience;
  final String jobDescription;
  final String contractDuration;
  final String createdAt;

  Job({
    required this.id,
    required this.roleType,
    required this.hiringType,
    required this.jobTitle,
    required this.jobLocationCountry,
    required this.jobLocationState,
    required this.jobLocationCity,
    required this.workLocation,
    required this.experience,
    required this.jobDescription,
    required this.contractDuration,
    required this.createdAt,
  });

  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      id: json['id'],
      roleType: json['role_type'],
      hiringType: json['hiring_type'],
      jobTitle: json['job_title'],
      jobLocationCountry: json['job_location_country'],
      jobLocationState: json['job_location_state'],
      jobLocationCity: json['job_location_city'],
      workLocation: json['work_location'],
      experience: json['experience'],
      jobDescription: json['job_description'],
      contractDuration: json['contract_duration'],
      createdAt: json['created_at'],
    );
  }
}
