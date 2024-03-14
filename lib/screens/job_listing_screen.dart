import 'package:apiassgn/screens/job_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:apiassgn/screens/job_list_service.dart';


class JobListPage extends StatefulWidget {
  const JobListPage({Key? key});

  @override
  State<JobListPage> createState() => _JobListPageState();
}

class _JobListPageState extends State<JobListPage> {
  final JobService _jobService = JobService();
  List<Job>? _jobs;
  List<Job>? _filteredJobs;

  @override
  void initState() {
    super.initState();
    _fetchJobs();
  }

  Future<void> _fetchJobs() async {
    try {
      final List<Job> jobs = await _jobService.getJobs(context);
      setState(() {
        _jobs = jobs;
        _filteredJobs = List.from(_jobs!);
      });
    } catch (e) {
      print('Error fetching jobs: $e');
    }
  }

  void _filterJobs(bool isRemote) {
    setState(() {
      _filteredJobs = _jobs!.where((job) => job.workLocation == (isRemote ? 'Remote' : 'On-Site')).toList();
    });
  }

  void _searchJobs(String query) {
    setState(() {
      _filteredJobs = _jobs!.where((job) => job.jobTitle.toLowerCase().contains(query.toLowerCase())).toList();
    });
  }

  void _showJobDetails(Job job) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailedJobPage(job: job),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Job Listing'),
        actions: [
          IconButton(
            onPressed: () => _filterJobs(true),
            icon: Icon(Icons.wifi_tethering),
            tooltip: 'Show Remote Jobs',
          ),
          IconButton(
            onPressed: () => _filterJobs(false),
            icon: Icon(Icons.location_on),
            tooltip: 'Show On-Site Jobs',
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight + 20),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              onChanged: _searchJobs,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search by title',
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ),
      ),
      body: _filteredJobs == null
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _filteredJobs!.length,
              itemBuilder: (context, index) {
                final job = _filteredJobs![index];
                return GestureDetector(
                  onTap: () => _showJobDetails(job), // Navigate to detailed job page
                  child: Card(
                    margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: ListTile(
                      title: Text(
                        job.jobTitle,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 4.0),
                          Text('Role Type: ${job.roleType}'),
                          SizedBox(height: 4.0),
                          Text('Hiring Type: ${job.hiringType}'),
                          SizedBox(height: 4.0),
                          Text('Work Location: ${job.workLocation}'),
                          SizedBox(height: 4.0),
                          Text('Created At: ${job.createdAt}'),
                        ],
                      ),
                      contentPadding: EdgeInsets.all(16.0),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
