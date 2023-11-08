import 'package:logger/logger.dart';
export 'package:ltss/remote/utils/utils.dart';

mixin BaseRepository<T>{
  var logger = Logger(
    filter: null, // Use the default LogFilter (-> only log in debug mode)
    printer: PrettyPrinter(), // Use the PrettyPrinter to format and print log
    output: null, // Use the default LogOutput (-> send everything to console)
  );

}