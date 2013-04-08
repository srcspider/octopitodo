part of octopi;

/**
 * @copyright 2013, Ibidem Team
 * @license BSD-2
 */
class Environment {

  AssetLoaderFunc
    _assets;

  LinkedHashMap<String, ClassifierFunc>
    classifiers;

  LinkedHashMap<String, Element>
    templatecache;

  Environment.from({AssetLoaderFunc assets, LinkedHashMap<String, ClassifierFunc> this.classifiers}) {
    this._assets = assets;
    this.templatecache = new LinkedHashMap<String, Element>();
  }

  // --------------------------------------------------------------------------
  // Retrieval

  /**
   * Retrieve a template from cache or using the AssetLoaderFunc.
   */
  Future<Element> template(String key) {
    Future<Element> future;

    if (this.templatecache[key] != null) {
      future = new Future.of(() => this.templatecache[key].clone(true));
    }
    else { // not cached
      future = this._assets(key).then((Element e) {
        this.templatecache[key] = e;
        return e.clone(true);
      });
    }

    return future;
  }

} // class
