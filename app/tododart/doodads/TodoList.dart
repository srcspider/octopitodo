part of tododart;

class TodoList extends Doodad {

  Element
    source;
  
  TodoList(Element entrypoint) : super(entrypoint, 'todo list');

  /**
   * Create a main element.
   */
  Future<Element> make() {
    return this.env.template('TodoList').then((e) {
      this.source = e;
      this.entrypoint.append(this.source);
    });
  }
  
} // class