import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:setlist/api/Api.dart';
import 'package:setlist/colors.dart';
import 'package:setlist/model/setlist.dart';
import 'package:setlist/model/song.dart';
import 'package:setlist/model/track_result.dart';
import 'package:setlist/songlist/songlist_bloc.dart';
import 'package:setlist/songlist/songlist_item.dart';
import 'package:setlist/widget/search_bar.dart';

import 'search_item.dart';

class SongList extends StatefulWidget {
  final SetList _setList;
  final FirebaseUser _firebaseUser;

  SongList(this._firebaseUser, this._setList);

  @override
  SongListState createState() => SongListState(_firebaseUser, _setList);
}

class SongListState extends State<SongList> {
  final SongListBloc _songListBloc;
  final SetList _setList;
  final FirebaseUser _firebaseUser;

  SearchBar searchBar;

  SongListState(this._firebaseUser, this._setList)
      : _songListBloc = SongListBloc(_firebaseUser, _setList, Api.api) {
    searchBar = SearchBar(
        setState: setState,
        hintText: "Search for Song or Artist",
        buildDefaultAppBar: _buildAppBar,
        onCleared: () => _songListBloc.clearSearch(),
        onSubmitted: (searchText) {
          searchBar.isLoading = true;
          _songListBloc.trackSearch(searchText);
        });
  }

  @override
  Widget build(BuildContext context) {
    if (searchBar.isSearching) {
      return _buildSearchScreen();
    } else {
      searchBar.controller.clear();
      return _buildSongListScreen();
    }
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(color: Colors.white70),
      actions: <Widget>[
        _getAddButton(context),
        searchBar.getSearchAction(context)
      ],
      title: Text(_setList.name),
    );
  }

  IconButton _getAddButton(BuildContext context) {
    return new IconButton(
        icon: new Icon(
          Icons.add,
        ),
        onPressed: () {
          _showAddItemDialog();
        });
  }

  _showAddItemDialog() {
    final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
    final songNameController = new TextEditingController();
    final songArtistController = new TextEditingController();

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Text(
              "Add Song",
              textAlign: TextAlign.center,
              style: TextStyle(fontFamily: 'Rubik Medium'),
            ),
            children: <Widget>[
              Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        controller: songNameController,
                        autofocus: true,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter a song name';
                          }
                        },
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.fromLTRB(16.0, 0.0, 0.0, 8.0),
                            hintStyle: TextStyle(fontFamily: 'Rubik Light'),
                            hintText: "Name"),
                      ),
                      TextFormField(
                        controller: songArtistController,
                        decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.fromLTRB(16.0, 0.0, 0.0, 8.0),
                            border: InputBorder.none,
                            hintStyle: TextStyle(fontFamily: 'Rubik Light'),
                            hintText: "Artist"),
                      ),
                      RaisedButton(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            24.0, 0.0, 24.0, 0.0),
                        child: Text(
                          "Submit",
                          style: TextStyle(
                              color: Colors.white70,
                              fontFamily: 'Rubik Medium'),
                        ),
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            Navigator.pop(
                                context,
                                Song(songNameController.text,
                                    songArtistController.text));
                          }
                        },
                      )
                    ],
                  ))
            ],
          );
        }).then((song) {
      if (song != null) {
        _songListBloc.addSong.add(song);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _songListBloc.dispose();
  }

  Widget _buildSearchScreen() {
    return StreamBuilder<SearchResult>(
        stream: _songListBloc.searchResults,
        builder: (BuildContext context, AsyncSnapshot<SearchResult> snapshot) {
          if (snapshot == null || snapshot.data == null) {
            return Scaffold(
                backgroundColor: backgroundColor,
                appBar: searchBar.build(context));
          } else {
            return Scaffold(
                backgroundColor: backgroundColor,
                appBar: searchBar.build(context),
                body: ListView.builder(
                  itemBuilder: (_, int index) {
                    return SearchItem(snapshot.data.searchItems[index],
                        (TrackResult trackResult) {
                      _songListBloc.addSong.add(Song(trackResult.name,
                          trackResult.artist, trackResult.imageUrl));
                    });
                  },
                  itemCount: snapshot.data.searchItems == null
                      ? 0
                      : snapshot.data.searchItems.length,
                ));
          }
        });
  }

  Widget _buildSongListScreen() {
    return StreamBuilder<SetListResult>(
      stream: _songListBloc.setList,
      builder: (BuildContext context, AsyncSnapshot<SetListResult> snapshot) {
        if (snapshot.data == null) {
          return Scaffold(
              backgroundColor: backgroundColor,
              appBar: searchBar.build(context),
              body: Center(child: CircularProgressIndicator()));
        } else {
          return Scaffold(
              backgroundColor: backgroundColor,
              appBar: searchBar.build(context),
              body: ListView.builder(
                itemBuilder: (_, int index) {
                  return SongListItem(
                      snapshot.data.results.songList[index],
                      () => _songListBloc.deleteSong
                          .add(snapshot.data.results.songList[index]));
                },
                itemCount: snapshot.data.results == null
                    ? 0
                    : snapshot.data.results.songList.length,
              ));
        }
      },
    );
  }
}
