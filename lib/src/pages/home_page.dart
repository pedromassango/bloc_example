import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_example/src/git_repository.dart';
import 'package:flutter_bloc_example/src/pages/home_page_bloc.dart';
import 'package:flutter_bloc_example/src/models.dart';
import 'package:flutter_bloc_example/src/pages/home_page_events.dart';
import 'package:flutter_bloc_example/src/pages/home_page_state.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  HomePageBloc _homeBloc;
  TextEditingController _positionController;

  double _searchElevation = 1;

  @override
  void initState() {
    _positionController = TextEditingController();

    _homeBloc = HomePageBloc(
        gitRepository: GitRepository()
    );

    super.initState();
  }

  @override
  void dispose() {
    _homeBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchMargin = 80.0;

    return BlocProvider<HomePageBloc>(
      bloc: _homeBloc,
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: searchMargin),
              child: BlocBuilder<HomePageEvent, HomePageState>(
                bloc: _homeBloc,
                builder: (BuildContext context, HomePageState state) {
                  if (state is HomePageStateDefault) {
                    return Center(
                      child: Text('Start Searching for a Job\nRight now!',
                        textAlign: TextAlign.center, style: TextStyle(
                            fontSize: 24,
                            color: Colors.blueGrey
                        ),)
                      ,);
                  }

                  if (state is HomePageStateSearching) {
                    _searchElevation = 0; // reset search bar's elevation
                    return Center(child: CircularProgressIndicator());
                  }

                  if (state is HomePageStateError) {
                    return Center(
                      child: Text('Conection Error!',
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 24
                        ),
                      ),
                    );
                  }

                  if (state is HomePageStateSearched) {
                    if (state.data.length == 0) {
                      return Center(child: Text('No Results!'),);
                    }

                    return NotificationListener(
                      onNotification: (t) {
                        if (t is ScrollUpdateNotification) {
                          print('Delta: ${t.scrollDelta}');
                          if (t.scrollDelta < 0.0 && _searchElevation != 0) {
                            setState(() => _searchElevation = 0);
                          } else
                          if (t.scrollDelta > 0.0 && _searchElevation != 8) {
                            setState(() => _searchElevation = 30);
                          }
                        }
                      },
                      child: ListView.builder(
                        itemCount: state.data.length,
                        itemBuilder: (context, index) {
                          return JobCard(
                            job: state.data.elementAt(index),
                          );
                        },
                      ),
                    );
                  }
                },
              ),
            ),

            AnimatedContainer(
              curve: Curves.fastOutSlowIn,
              duration: Duration(milliseconds: 800),
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              height: 60,
              margin: EdgeInsets.only(top: 36, left: 12, right: 12),
              padding: EdgeInsets.only(top: 4, left: 16, right: 16),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black26,
                        blurRadius: _searchElevation
                    )
                  ]
              ),
              child: TextField(
                onSubmitted: (query) {
                  var position = _positionController.text;
                  _homeBloc.dispatch(
                      HomePageEventSearch(jobPosition: position));
                },
                controller: _positionController,
                decoration: InputDecoration(
                    hintText: 'Search',
                    border: InputBorder.none
                ),
              ),
            )
          ],
        ),
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
        AnimatedContainer(
          duration: Duration(milliseconds: 1000),
          height: 200,
          width: double.maxFinite,
          margin: EdgeInsets.fromLTRB(14, 18, 12, 16),
          padding: EdgeInsets.fromLTRB(16, 85, 16, 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(16)),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                  blurRadius: 1
              )
            ]
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              Row(
                children: <Widget>[
                  Icon(Icons.card_travel, color: Colors.blueGrey,),
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Text(job.company),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Icon(Icons.place, color: Colors.blueGrey,),
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Text(job.location),
                  ),
                ],
              ),
              Spacer(),
              Row(
                children: <Widget>[
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Text(job.type, style: TextStyle(
                        color: job.type.contains("Full") ? Colors.green : Colors
                            .red
                    ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _buildIcon(),
              Flexible(
                flex: 5,
                fit: FlexFit.tight,
                child: Text(job.title, style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                ),
              ),
              Spacer(),
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
      margin: EdgeInsets.only(left: 6, top: 0, right: 16),
      decoration: BoxDecoration(
        color: Colors.white,
          shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
              blurRadius: 1
          )
        ]
      ),
      child: Image.network(job.companyLogo, width: 80, height: 80,),
    );
  }
}

