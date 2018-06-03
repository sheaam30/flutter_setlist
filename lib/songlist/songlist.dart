import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:setlist/api/Api.dart';
import 'package:setlist/colors.dart';
import 'package:setlist/model/setlist.dart';
import 'package:setlist/model/song.dart';
import 'package:setlist/model/track_result.dart';
import 'package:setlist/songlist/addsong_item.dart';
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
      return StreamBuilder<SearchResult>(
          stream: _songListBloc.searchResults,
          builder:
              (BuildContext context, AsyncSnapshot<SearchResult> snapshot) {
            if (snapshot == null || snapshot.data == null) {
              return Scaffold(
                  backgroundColor: backgroundColor,
                  appBar: searchBar.build(context));
            } else {
              return _searchList(snapshot.data.searchItems);
            }
          });
    } else {
      searchBar.controller.clear();

      return StreamBuilder<SetListResult>(
        stream: _songListBloc.setList,
        builder: (BuildContext context, AsyncSnapshot<SetListResult> snapshot) {
          if (snapshot.data == null) {
            return Scaffold(
                backgroundColor: backgroundColor,
                appBar: searchBar.build(context),
                body: Center(child: CircularProgressIndicator()));
          } else {
            return _songList(snapshot.data.results);
          }
        },
      );
    }
  }

  Widget _songList(SetList setList) {
    return Scaffold(
        backgroundColor: backgroundColor,
        appBar: searchBar.build(context),
        body: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            if (setList == null || setList.songList.length == 0) {
              return AddSongItem(_songListBloc);
            } else {
              return SongListItem(setList.songList[index],
                  () => _songListBloc.deleteSong.add(setList.songList[index]));
            }
          },
          itemCount: setList == null ? 0 : setList.songList.length,
        ));
  }

  Widget _searchList(List<TrackResult> searchItems) {
    return Scaffold(
        backgroundColor: backgroundColor,
        appBar: searchBar.build(context),
        body: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            if (searchItems == null || searchItems.length == 0) {
            } else {
              return SearchItem(searchItems[index], (TrackResult trackResult) {
                _songListBloc.addSong.add(Song(trackResult.name,
                    trackResult.artist, trackResult.imageUrl));
              });
            }
          },
          itemCount: searchItems == null ? 0 : searchItems.length,
        ));
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      actions: <Widget>[
        _getAddButton(context),
        searchBar.getSearchAction(context)
      ],
      backgroundColor: primaryColor,
      title: Text(_setList.name),
    );
  }

  IconButton _getAddButton(BuildContext context) {
    return new IconButton(
        icon: new Icon(Icons.add),
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
                                EdgeInsets.fromLTRB(16.0, 0.0, 0.0, 16.0),
                            hintText: "Name"),
                      ),
                      TextFormField(
                        controller: songArtistController,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.fromLTRB(16.0, 0.0, 0.0, 16.0),
                            hintText: "Artist"),
                      ),
                      RaisedButton(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            24.0, 0.0, 24.0, 0.0),
                        child: Text(
                          "Submit",
                          style: TextStyle(color: Colors.white70),
                        ),
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            Navigator.pop(
                                context,
                                Song(songNameController.text,
                                    songArtistController.text));
                            songNameController.dispose();
                            songArtistController.dispose();
                          }
                        },
                        color: primaryColor,
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
}
