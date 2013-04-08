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

  /**
   * Retrieve the camelcase version of the singular name.
   */
  String ccsingular() {
    List<String> parts =  this.singular.split(' ');
    String ccsingular = '';
    for (final String part in parts) {
      ccsingular += part.substring(0, 1).toUpperCase() + part.substring(1);
    }

    return ccsingular;
  }

  /**
   * Retrieve the camelcase version of the plural name.
   */
  String ccplural() {
    List<String> parts =  this.plural.split(' ');
    String ccplural = '';
    for (final String part in parts) {
      ccplural += part.substring(0, 1).toUpperCase() + part.substring(1);
    }

    return ccplural;
  }

} // class
