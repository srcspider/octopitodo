library octopi;

import 'dart:html';
import 'dart:collection';
import 'dart:async';

// application stack
part 'Environment.dart';
part 'Application.dart';

// structure
part 'Marionette.dart';
part 'Doodad.dart';

// function definitions
typedef Future<Element> AssetLoaderFunc(String key);
typedef Doodad ClassifierFunc(Element entrypoint);
