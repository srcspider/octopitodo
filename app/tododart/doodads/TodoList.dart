part of tododart;

class TodoList extends Doodad {

  TodoList(Element entrypoint) : super(entrypoint, 'todo list');

  Future<Element> make() {
    this.env.template('TodoList');
  }

} // class