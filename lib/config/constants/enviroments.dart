
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Enviroments {
  static String movieDBApiKey = dotenv.env['THE_MOVIEDB_APIKEY'] ?? 'No hay API KEY';
}