part of tododart;

///
/// Wrapper doodad. This class must be mentioned in the classifiers to allow it
/// to be autoloaded into a context. The class must also have a default
/// constructor. You may treat this as a non-wrapper in other parts of the
/// application.
///

/**
 * @copyright 2013, Ibidem Team
 * @license BSD-2
 */
class TodoList extends Doodad {

  // --------------------------------------------------------------------------
  // Handlers

  /// !! Handlers should not be touched outside of [install], [uninstall], and
  /// [render]. During install parts of the html will be read in as template
  /// messages, these are equivalent to handlers and should not be touched
  /// either in the internals.

  Element // handlers
    header,
    footer,
    toggle_all,
    input,
    main,
    items,
    todocount,
    clearcomplete,
    show_all,
    show_active,
    show_completed;

  String // messages
    singular_clearcompleted,
    plural_clearcompleted,
    singular_x_items_left,
    plural_x_items_left;

  // --------------------------------------------------------------------------
  // Internals

  Todo
    editable_todo;

  List<Todo>
    todos;

  String
    filter;

  // --------------------------------------------------------------------------
  // Factory

  TodoList() : super('todo list') {
    this.todos = new List<Todo>();
    this.filter = 'all';
  }

  /**
   * [make] will create the html template Element and pass it into the object's
   * source. During [install] we simply connect parts of the html to handlers
   * and bind appropriate listeners. All listeners should simply pass control
   * to a method in a class and process only as much as is needed to avoid
   * passing and event object.
   *
   * Hint: if you're not using the (e) => ... syntax when binding events you
   * may be overdoing the install logic.
   */
  void install() {
    // input
    this.input = this.source.query('#new-todo');
    this.input.onKeyPress.listen((KeyboardEvent e) { if (e.keyCode == KeyCode.ENTER) this.new_todo(); });

    // check all
    this.toggle_all = this.source.query('.o-toggle-all');
    this.toggle_all.onClick.listen((MouseEvent e) => this.masstoggle());

    // main
    this.main = this.source.query('#main');

    // items
    this.items = this.main.query('#todo-list');

    // footer
    this.footer = this.source.query('#footer');
    this.todocount = this.footer.query('#todo-count');
    this.clearcomplete = this.footer.query('#clear-completed');
    this.clearcomplete.onClick.listen((MouseEvent e) => this.remove_complete());
    this.singular_clearcompleted = this.clearcomplete.attributes['data-singular'];
    this.plural_clearcompleted = this.clearcomplete.attributes['data-plural'];
    this.show_all = this.footer.query('.o-show-all');
    this.show_all.onClick.listen((MouseEvent e) => this.show_all_todos());
    this.show_active = this.footer.query('.o-show-active');
    this.show_active.onClick.listen((MouseEvent e) => this.show_active_todos());
    this.show_completed = this.footer.query('.o-show-completed');
    this.show_completed.onClick.listen((MouseEvent e) => this.show_completed_todos());

    this.render();
  }

  /// [uninstall] is inherited from doodad and simply removes the element

  // --------------------------------------------------------------------------
  // Render

  /**
   * Rendering takes the current state and computes the correct view. The
   * reason everything should be done in rendering though a translation of
   * state into the view is to ensure the interface mains consistency.
   *
   * If it's desirable to re-render only small bits of a very large interface
   * the functionality should be implemented though state that tells render
   * that it can get away with rendering just that one part. This ensures the
   * interface is easy to debug, maintainable and can be easily extended to
   * interact with some other Doodad; it also ensures that if we add
   * functionality to the interface we don't risk it becoming inconsistent due
   * to past behaviour being hard coded into the interface. In the case of this
   * Todo application consider the interaction of the toggle_all functionality
   * in conjunction to the editable state of Todos and filters, if the
   * interface is hardcoded the entire codebase (this potentially includes the
   * Todo class) needs to be inspected and analyzed for potentialy
   * consequences, subsequently the problem spots need to be hardcoded to deal
   * with it with the new state. Alternatively we can just examine render, or
   * render_* method called by render for display problems and since display is
   * done in one method it's generally done though clear loops and branching,
   * making any additions more intuitive.
   *
   * It's also cleaner to have state logic be simply internal state logic.
   */
  void render() {
    this.render_filter_menu();
    this.render_footer();

    int visible = 0;
    int completed = 0;
    if (this.filter == 'all') {
      for (final Todo todo in this.todos) {
        todo.editable = false;
        todo.visible = true;
        todo.render();

        visible++;
        completed += todo.state == 'completed' ? 1 : 0;
      }
    }
    else { // this.filter != 'all'
      for (final Todo todo in this.todos) {
        todo.editable = false;
        todo.visible = todo.state == filter;
        todo.render();

        visible += todo.state == filter ? 1 : 0;
        completed += todo.state == 'completed' ? 1 : 0;
      }
    }

    if (this.editable_todo != null) {
      this.editable_todo.editable = true;
      this.editable_todo.render();
    }

    if (visible == 0) {
      this.main.style.display = 'none';
    }
    else { // some elements are visible
      this.main.style.display = 'block';
    }

    if (this.todos.length > 0) {
      this.toggle_all.style.visibility = 'visible';
    }
    else { // todos.length == 0
      this.toggle_all.style.visibility = 'hidden';
    }

    if (completed > 0) {
      this.clearcomplete.style.display = 'block';
      if (completed == 1) {
        this.clearcomplete.text = this.singular_clearcompleted.replaceAll(':in', '1');
      }
      else { // plural or 0
        this.clearcomplete.text = this.plural_clearcompleted.replaceAll(':in', completed.toString());
      }
    }
    else { // no completed todos
      this.clearcomplete.style.display = 'none';
    }

    if (completed == this.todos.length) {
      this.toggle_all.checked = true;
    }
    else {
      this.toggle_all.checked = false;
    }
  }

  /**
   * ...
   */
  void render_filter_menu() {
    this.show_all.classes.remove('selected');
    this.show_active.classes.remove('selected');
    this.show_completed.classes.remove('selected');

    switch (this.filter) {
      case 'all':
        this.show_all.classes.add('selected');
        break;
      case 'active':
        this.show_active.classes.add('selected');
        break;
      case 'completed':
        this.show_completed.classes.add('selected');
        break;
      default:
        throw new Exception('Unknown filter.');
    }
  }

  /**
   * ...
   */
  void render_footer() {
    if (this.todos.length > 0) {
      this.footer.style.display = 'block';

      int uncompleted = 0,
          completed = 0;

      for (final Todo todo in this.todos) {
        if (todo.state == 'active') {
          uncompleted += 1;
        }
        else { // todo completed
          completed += 1;
        }
      }

      if (uncompleted != 1) {
        this.todocount.innerHtml = "<strong>${uncompleted}</strong> items left";
      }
      else { // 1 item left
        this.todocount.innerHtml = "<strong>1</strong> item left";
      }

      if (completed > 0) {
        this.clearcomplete.text = "Clear completed (${completed})";
        this.clearcomplete.style.display = 'block';
      }
      else { // reset
        this.clearcomplete.text = "Clear completed (0)";
        this.clearcomplete.style.display = 'none';
      }
    }
    else { // no todos
      this.footer.style.display = 'none';
    }
  }

  // --------------------------------------------------------------------------
  // State Operations

  /**
   * New todo from current field state.
   */
  void new_todo() {
    Todo todo = new Todo.from(this);
    todo.make().then((Element e) {
      this.add_todo(todo);
    });

    this.render();
  }

  /**
   * ...
   */
  void add_todo(Todo todo) {
    if (this.input.value.trim().length != 0) {
      this.todos.add(todo);
      this.items.append(todo.source);
      todo.text = this.input.value;
      this.input.value = '';

      this.render();
    }
  }

  /**
   * When [toggle_all] is clicked we eighter have to toggle all on or toggle
   * all of if all are currently on.
   */
  void masstoggle() {
    bool all_complete = true;
    for (final Todo todo in this.todos) {
      if (todo.state != 'completed') {
        all_complete = false;
        break;
      }
    }

    if (all_complete) {
      for (final Todo todo in this.todos) {
        todo.state = 'active';
      }
    }
    else { // ! all_complete
      for (final Todo todo in this.todos) {
        todo.state = 'completed';
      }
    }

    this.render();
  }

  /**
   * ...
   */
  void remove_todo(Todo todo) {
    this.todos.remove(todo);
    this.render();
  }

  /**
   * ...
   */
  void remove_complete() {
    List<Todo> completed = new List<Todo>();
    for (final Todo todo in this.todos) {
      if (todo.state == 'completed') {
        completed.add(todo);
      }
    }

    for (final Todo todo in completed) {
      todo.uninstall();
    }

    this.render();
  }

  /**
   * ...
   */
  void edit_todo(Todo todo) {
    if (this.editable_todo != null) {
      this.editable_todo.editable = false;
    }
    this.editable_todo = todo;
    this.render();
  }

  void close_edit() {
    if (this.editable_todo != null) {
      this.editable_todo.editable = false;
    }
    this.editable_todo = null;
    this.render();
  }

  /**
   * ...
   */
  void show_all_todos() {
    if (this.filter != 'all') {
      this.filter = 'all';
      this.editable_todo = null;
      this.render();
    }
  }

  /**
   * ...
   */
  void show_active_todos() {
    if (this.filter != 'active') {
      this.filter = 'active';
      this.editable_todo = null;
      this.render();
    }
  }

  /**
   * ...
   */
  void show_completed_todos() {
    if (this.filter != 'completed') {
      this.filter = 'completed';
      this.editable_todo = null;
      this.render();
    }
  }

} // class