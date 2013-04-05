part of octopi;

/**
 * @copyright 2013, Ibidem Team
 * @license BSD-2
 */
class Doodad extends Marionette {

  String
    name, group;

  Element
    entrypoint;

  bool
    persistent;

  Environment
    env;

  Doodad(Element this.entrypoint, String name, [String group]) : super(name, group);

  /**
   * Create a root element.
   */
  Future<Element> make() {
    return new Future.of(() => new Element.html('<span>[${this.singular} placeholder]</span>'));
  }

  // --------------------------------------------------------------------------
  // State

  void environment(Environment env) {
    this.env = env;
  }

  void enable_persistence() {
    this.persistent = true;
  }

  void disable_persistence() {
    this.persistent = false;
  }

} // class
