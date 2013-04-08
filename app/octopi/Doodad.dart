part of octopi;

/**
 * @copyright 2013, Ibidem Team
 * @license BSD-2
 */
class Doodad extends Marionette {

  String
    name, group;

  Element
    source;

  bool
    persistent;

  Environment
    env;

  Doodad(String name, [String group]) : super(name, group);

  /**
   * Create a main element.
   */
  Future<Element> make() {
    return this.env.template(this.ccsingular()).then((Element e) {
      this.source = e;
      this.install();

      return this.source;
    });
  }

  /**
   * ...
   */
  void install() {
    // do nothing
  }

  /**
   * ...
   */
  void uninstall() {
    this.source.remove();
  }

  /**
   * ...
   */
  void render() {

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
