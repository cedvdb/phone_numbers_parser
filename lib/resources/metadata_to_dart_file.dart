Future writeDart(Map map) {
  var territoryStr = '';
  map['territories'].forEach((t) {
    territoryStr +=
        '  Territory.fromMap(${json.encode(t)}),\n'.replaceAll('"', '\'');
  });
  return File('metadata.dart').writeAsString('''
import '../territory.dart';

const territories = [
$territoryStr
];
  ''');
}
