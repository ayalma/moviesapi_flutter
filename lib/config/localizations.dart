import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moviesapi_flutter/config/l10n/messages_all.dart';

class AppLocalizations{

  static Future<AppLocalizations> load(Locale locale) {

    final String name =
    locale.countryCode == null ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((bool _) {
      Intl.defaultLocale = localeName;
      return new AppLocalizations();
    });

  }
  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }


  String get title {
    return Intl.message('Hello world App',
        name: 'title', desc: 'The application title');
  }

  String get hello {
    return Intl.message('Hello', name: 'hello');
  }

  String get newMovie => Intl.message("New Movie",name: "newMovie");
  String get movieApi => Intl.message("Movie Api",name: "movieApi");
  String get searchLabel => Intl.message("Enter the movie name",name: "searchLabel");
  String get noInternet => Intl.message("No internet connection",name: "noInternet");
  String get retry => Intl.message("Retry",name: "retry");

  String get movieName => Intl.message("Movie name",name:"movieName");
  String get movieNameHint => Intl.message("Enter movie name",name:"movieNameHint");
  String get movieIsRequired => Intl.message("Movie name is required",name:"movieIsRequired");

  String get imdbId => Intl.message("Imdb Id",name:"imdbId");
  String get imdbIdHint => Intl.message("Enter Imdb id of film",name:"imdbIdHint");
  String get imdbIdIsRequired => Intl.message("Imdb id is required",name:"imdbIdIsRequired");

  String get country => Intl.message("Country",name:"country");
  String get countryHint => Intl.message("Enter Country of film",name:"countryHint");
  String get countryIsRequired => Intl.message("Country is required",name:"countryIsRequired");

  String get year => Intl.message("Year",name:"year");
  String get yearHint => Intl.message("Enter year of film",name:"yearHint");
  String get yearIsRequired => Intl.message("Year is required",name:"yearIsRequired");

  String get director => Intl.message("Director",name:"director");
  String get directorHint => Intl.message("Enter director of film",name:"directorHint");
  String get directorIsRequired => Intl.message("Director is required",name:"directorIsRequired");

  String get imdbRate => Intl.message("Imdb rate",name:"imdbRate");
  String get imdbRateHint => Intl.message("Enter imdb rate of film",name:"imdbRateHint");
  String get imdbRateIsRequired => Intl.message("Imdb rate is required",name:"imdbRateIsRequired");

  String get imdbVote => Intl.message("Imdb vote",name:"imdbVote");
  String get imdbVoteHint => Intl.message("Enter imdb vote of film",name:"imdbVoteHint");
  String get imdbVoteIsRequired => Intl.message("Imdb vote is required",name:"imdbVoteIsRequired");

  String get poster => Intl.message("Poster",name:"poster");
  String get saveMovie => Intl.message("Save Movie",name:"saveMovie");


}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations>{
  @override
  bool isSupported(Locale locale) {
    return ['fa', 'en'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) {
    return AppLocalizations.load(locale);
  }

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalizations> old) {
    return false;
  }

}