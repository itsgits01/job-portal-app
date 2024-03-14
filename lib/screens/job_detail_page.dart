

import 'package:flutter/material.dart';
import 'package:apiassgn/screens/job_list_service.dart'; 

class DetailedJobPage extends StatelessWidget {
  final Job job;

  const DetailedJobPage({Key? key, required this.job}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(job.jobTitle),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Role Type: ${job.roleType}'),
            SizedBox(height: 8.0),
            Text('Hiring Type: ${job.hiringType}'),
            SizedBox(height: 8.0),
            Text('Work Location: ${job.workLocation}'),
            SizedBox(height: 8.0),
            Text('Experience: ${job.experience}'),
            SizedBox(height: 8.0),
            Text('Job Description: ${job.jobDescription}'),
            SizedBox(height: 8.0),
            Text('Contract Duration: ${job.contractDuration}'),
            SizedBox(height: 8.0),
            Text('Created At: ${job.createdAt}'),
          ],
        ),
      ),
    );
  }
}
