part of octopi;

/**
 * @copyright 2013, Ibidem Team
 * @license BSD-2
 */
class Marionette {

  String
    singular,
    plural;

  Marionette(String this.singular, [String plural]) {
    if (?plural) {
      this.plural = "${singular}s";
    }
  }

} // class
