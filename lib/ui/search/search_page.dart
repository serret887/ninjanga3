import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ninjanga3/blocs/search/bloc.dart';
import 'package:ninjanga3/ui/components/poster_item.dart';

import '../../service_locator.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _controller = TextEditingController();

  Widget _buildSearchText(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10.0),
      child: TextField(
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.search,
        controller: _controller,
        cursorColor: Theme.of(context).accentColor,
        autofocus: true,
        enabled: true,
        maxLines: 1,
        decoration: InputDecoration(
          labelText: "Search",
          focusColor: Theme.of(context).primaryColor,
        ),
        onSubmitted: (val) {
          FocusScope.of(context).requestFocus(new FocusNode());
          sl.get<SearchBloc>().dispatch(FetchSearchEvent(_controller.text));
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: Container(
            margin: EdgeInsets.only(
              top: 20.0,
            ),
            child: CustomScrollView(slivers: <Widget>[
              SliverAppBar(
                expandedHeight: 80.0,
                backgroundColor: Theme.of(context).backgroundColor,
                title: _buildSearchText(context),
                automaticallyImplyLeading: true,
                actions: <Widget>[
                  IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        if (_controller.text.isEmpty) return;
                        FocusScope.of(context).requestFocus(new FocusNode());
                        sl
                            .get<SearchBloc>()
                            .dispatch(FetchSearchEvent(_controller.text));
                      }),
                ],
              ),
              BlocBuilder(
                bloc: sl.get<SearchBloc>(),
                builder: (BuildContext context, state) {
                  if (state is SearchLoaded)
                    return SliverFillRemaining(
                        child: GridView.builder(
                            gridDelegate:
                                new SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                            ),
                            itemCount: state.movies.length,
                            itemBuilder: (context, index) {
                              return Container(
//                                padding: EdgeInsets.only(
//                                    right: 5,
//                                    left: 5.0,
//                                    bottom: 10.0,
//                                    top: 5.0),
                                child: PosterItem(model: state.movies[index]),
                              );
                            },
                            padding: EdgeInsets.only(left: 14.0),
                            scrollDirection: Axis.vertical,
                            physics: BouncingScrollPhysics()));
                  else if (state is SearchLoading)
                    return SliverFillRemaining(
                        child: Center(
                      child: CircularProgressIndicator(),
                    ));
                  else if (state is SearchError)
                    return SliverFillRemaining(
                        child: Center(child: Text(state.error.toString())));
                  return SliverFillRemaining(
                      child: Center(child: Text("enter a term to search")));
                },
              )
            ])));
  }
}
