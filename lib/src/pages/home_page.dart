import 'package:flutter/material.dart';
import 'package:flutter_bloc_example/src/home_page_bloc.dart';
import 'package:flutter_bloc_example/src/models.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  HomePageBloc _bloc = HomePageBloc();

  @override
  void initState() {
    super.initState();

    _bloc.searchJobs('python', 'new york');
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 4,
      ),
      body: StreamBuilder<List<JobPositionModel>>(
        stream: _bloc.jobs,
        initialData: null,
        builder: (BuildContext context, shot){
          return !shot.hasData || shot.connectionState == ConnectionState.waiting ?
          Center( child: CircularProgressIndicator(),)
              : ListView.builder(
              itemBuilder: (BuildContext context, int index){
                return JobCard(
                  job: shot.data.elementAt(index),
                );
              }
          );
        },
      ),
    );
  }
}

class JobCard extends StatelessWidget {
  final JobPositionModel job;
  const JobCard({Key key, this.job}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: 200,
          width: double.maxFinite,
          margin: EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(16)),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 3
              )
            ]
          ),
        ),
        Container(
          height: 200,
          width: double.maxFinite,
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  _buildIcon(),
                  Text(job.title, style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  ),
                ],
              ),
              Text(job.company),
              Text(job.location),
              Text(job.type),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildIcon(){
    return Container(
      width: 85,
      height: 85,
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.only(left: 12, top: 16, right:  16),
      decoration: BoxDecoration(
        color: Colors.white,
          shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 2
          )
        ]
      ),
      child: Image.network(job.companyLogo, width: 80, height: 80,),
    );
  }
}

