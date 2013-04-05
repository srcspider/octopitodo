import 'dart:html';
import 'dart:async';
import 'dart:http';

import 'octopi/lib.dart';
import 'tododart/app.dart';

/**
 * Given keys loads Templates from server. May load multiple in a single
 * request. In this case our loader searches and loads all assets from an
 * assets directory on the root
 *
 * !! this assets loader is designed to be crude for use in TodoMVC and should
 * not be taken as anything more then that.
 */
Future<Element> static_assets(String key) {
  return HttpRequest
    .getString("assets/${key}")
    .then((String rawtemplate) => new Element.html(rawtemplate));
}

/**
 * ...
 */
void main() {

  Environment env = new Environment.from(
    // assets loader
    assets: static_assets,
    // classifiers
    classifiers: {
      'TodoList' : (Element e) => new TodoList(e),
      'Todo'     : (Element e) => new Todo(e),
    }
  );

  Application app = new Application.from(env, query('body'));
  app.start();

} // func
