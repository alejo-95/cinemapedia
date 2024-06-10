import 'package:cinemapedia/infrastructure/models/moviedb/credits_response.dart';

import '../../domain/entities/actor.dart';

class ActorMapper{

  static Actor castToEntity(Cast cast) => 
  Actor(
    id: cast.id, 
    name: cast.name, 
    profilePath: cast.profilePath != null 
    ?'https://image.tmdb.org/t/p/w500/${cast.profilePath}'
    : 'https://www.movienewz.com/img/films/poster-holder.jpg',
    character: cast.character);

}