part of octopi;

/**
 * @copyright 2013, Ibidem Team
 * @license BSD-2
 */
class Application {

  Environment
    env;

  Element
    context;

  Application.from(Environment this.env, Element this.context);

  /**
   * Initialize application.
   */
  void start() {
    List<Element> contexts = this.context.queryAll('.Octopi-context');

    // find all top level subject entities
    for (final Element i in contexts) {
      String subject = i.attributes['data-octopi-context'];
      Doodad doodad = this.env.classifiers[subject]();
      doodad.env = this.env;

      if (i.classes.contains('persistent')) {
        doodad.enable_persistence();
      }

      doodad.make().then((Element e) {
        i.append(e);
      });
    }
  }

} // class
