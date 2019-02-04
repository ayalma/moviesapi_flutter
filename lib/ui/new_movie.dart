import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:moviesapi_flutter/config/localizations.dart';
import 'package:moviesapi_flutter/datasource/model/new_movie_request.dart';
import 'package:moviesapi_flutter/main.dart';
import 'package:moviesapi_flutter/ui/movie_list_bloc.dart';

class NewMoviePage extends StatefulWidget {
  @override
  _NewMoviePageState createState() => _NewMoviePageState();
}

class _NewMoviePageState extends State<NewMoviePage> {
  final _formKey = GlobalKey<FormState>(debugLabel: "new_movie");
  final MovieListBloc bloc = getIt.get();
  bool _isSaving = false;
  File posterFile;

  final TextEditingController movieNameCtrl = TextEditingController();
  final TextEditingController imdbIdCtrl = TextEditingController();
  final TextEditingController countryCtrl = TextEditingController();
  final TextEditingController yearCtrl = TextEditingController();
  final TextEditingController directorCtrl = TextEditingController();
  final TextEditingController imdbRateCtrl = TextEditingController();
  final TextEditingController imdbVoteCtrl = TextEditingController();
  final TextEditingController posterCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).newMovie),
      ),
      body: Builder(builder: (context) {
        return Column(
          children: <Widget>[
            _isSaving ? LinearProgressIndicator() : Container(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Form(
                      key: _formKey,
                      child: ListView(
                        children: <Widget>[
                          TextFormField(
                            controller: movieNameCtrl,
                            decoration: getTextFieldDecoration(
                                AppLocalizations.of(context).movieName,  AppLocalizations.of(context).movieNameHint, Icons.movie),
                            validator: (value) {
                              if (value == null || value.length == 0) {
                                return AppLocalizations.of(context).movieIsRequired;
                              }
                            },
                          ),
                          SizedBox(
                            height: 16.0,
                          ),
                          TextFormField(
                            controller: imdbIdCtrl,
                            decoration: getTextFieldDecoration(AppLocalizations.of(context).imdbId,
                                AppLocalizations.of(context).imdbIdHint, Icons.edit_attributes),
                            validator: (value) {
                              if (value == null || value.length == 0) {
                                return AppLocalizations.of(context).imdbIdIsRequired;
                              }
                            },
                          ),
                          SizedBox(
                            height: 16.0,
                          ),
                          TextFormField(
                            controller: countryCtrl,
                            decoration: getTextFieldDecoration(AppLocalizations.of(context).country,
                                AppLocalizations.of(context).countryHint, Icons.movie),
                            validator: (value) {
                              if (value == null || value.length == 0) {
                                return AppLocalizations.of(context).countryIsRequired;
                              }
                            },
                          ),
                          SizedBox(
                            height: 16.0,
                          ),
                          TextFormField(
                            controller: yearCtrl,
                            decoration: getTextFieldDecoration(AppLocalizations.of(context).year,
                                AppLocalizations.of(context).yearHint, Icons.movie),
                            validator: (value) {
                              if (value == null || value.length == 0) {
                                return AppLocalizations.of(context).yearIsRequired;
                              }
                            },
                          ),
                          SizedBox(
                            height: 16.0,
                          ),
                          TextFormField(
                            controller: directorCtrl,
                            decoration: getTextFieldDecoration(AppLocalizations.of(context).director,
                                AppLocalizations.of(context).directorHint, Icons.movie),
                          ),
                          SizedBox(
                            height: 16.0,
                          ),
                          TextFormField(
                            controller: imdbRateCtrl,
                            decoration: getTextFieldDecoration(AppLocalizations.of(context).imdbRate,
                                AppLocalizations.of(context).imdbRateHint, Icons.movie),
                          ),
                          SizedBox(
                            height: 16.0,
                          ),
                          TextFormField(
                            controller: imdbVoteCtrl,
                            decoration: getTextFieldDecoration(AppLocalizations.of(context).imdbVote,
                                AppLocalizations.of(context).imdbVoteHint, Icons.movie),
                          ),
                          SizedBox(
                            height: 16.0,
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                  child: Text(
                                    AppLocalizations.of(context).poster,
                                style: Theme.of(context).textTheme.title,
                              )),
                              IconButton(
                                icon: Icon(Icons.add_a_photo),
                                onPressed: () {
                                  imageSelectorCamera();
                                },
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 16.0,
                          ),
                          (posterFile != null)
                              ? Stack(
                                  alignment: Alignment.bottomCenter,
                                  children: <Widget>[
                                    Image.file(
                                      posterFile,
                                      width: 96,
                                      fit: BoxFit.fitWidth,
                                    ),
                                    Container(
                                      width: 96,
                                      color: Colors.black.withOpacity(0.4),
                                      child: IconButton(
                                        color: Colors.white,
                                        icon: Icon(Icons.cancel),
                                        onPressed: () {
                                          setState(() {
                                            posterFile = null;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                )
                              : Container(),
                          Padding(
                            padding: const EdgeInsets.only(left: 32, right: 32),
                            child: RaisedButton.icon(
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  setState(() {
                                    _isSaving = true;
                                  });
                                  //todo send request
                                  bloc
                                      .saveMove(
                                    NewMovieRequest(
                                        movieNameCtrl.value.text,
                                        imdbIdCtrl.value.text,
                                        countryCtrl.value.text,
                                        int.parse(yearCtrl.text),
                                        directorCtrl.value.text,
                                        imdbRateCtrl.value.text,
                                        imdbVoteCtrl.value.text,
                                        base64Encode(
                                            posterFile.readAsBytesSync())),
                                  )
                                      .then((NewMovieRequest item) {
                                    setState(() {
                                      _isSaving = false;
                                    });

                                    SnackBar msg = SnackBar(content: Text("movie with ${item.id} creted!"),);
                                    Scaffold.of(context).showSnackBar(msg);

                                  }).catchError((error) {
                                    setState(() {
                                      _isSaving = false;
                                    });

                                    SnackBar msg = SnackBar(content: Text("movie with cuz ${error.toString()}!"),);
                                    Scaffold.of(context).showSnackBar(msg);

                                  });
                                } else {}
                              },
                              icon: Icon(Icons.send),
                              label: Text(AppLocalizations.of(context).saveMovie),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              color: Theme.of(context).accentColor,
                              textColor: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  getTextFieldDecoration(String label, String hint, IconData icon) {
    return InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(32.0),
      ),
      labelText: label,
      hintText: hint,
      icon: Icon(icon),
    );
  }

  imageSelectorGallery() async {
    posterFile = await ImagePicker.pickImage(
      source: ImageSource.gallery,
      // maxHeight: 50.0,
      // maxWidth: 50.0,
    );
    print("You selected gallery image : " + posterFile.path);
    setState(() {});
  }

  //display image selected from camera
  imageSelectorCamera() async {
    posterFile = await ImagePicker.pickImage(
      source: ImageSource.camera,
      //maxHeight: 50.0,
      //maxWidth: 50.0,
    );
    print("You selected camera image : " + posterFile.path);
    setState(() {});
  }
}
