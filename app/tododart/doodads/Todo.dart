part of tododart;

///
/// Internal doodad. Other then extending Doodad this class can be structured
/// any way you like.
///

/**
 * @copyright 2013, Ibidem Team
 * @license BSD-2
 */
class Todo extends Doodad {

  // --------------------------------------------------------------------------
  // Handlers

  /// !! Handlers should not be touched outside of [install], [uninstall], and
  /// [render]. During install parts of the html will be read in as template
  /// messages, these are equivalent to handlers and should not be touched
  /// either in the internals.

  Element // handlers
    label,
    toggle,
    delete,
    input;

  // --------------------------------------------------------------------------
  // Internals

  TodoList
    todolist;

  int
    id;

  String
    text;

  String
    state;

  bool
    visible,
    _editable,
    _editabletrigger;

  // --------------------------------------------------------------------------
  // Factory

  Todo.from(TodoList todolist) : super('todo') {
    this.env = todolist.env;
    this.todolist = todolist;
    this.state = 'active';
    this.visible = true;
    this.editable = false;
    this.text = '';
  }

  /**
   * ...
   */
  void install() {
    // label
    this.label = this.source.query('label');
    // toggle
    this.toggle = this.source.query('.toggle');
    this.toggle.onClick.listen((e) => this.mark());

    // delete
    this.delete = this.source.query('.destroy');
    this.delete.onClick.listen((MouseEvent e) => this.todolist.remove_todo(this));

    // input
    this.input = this.source.query('input.edit');
    this.label.onDoubleClick.listen((MouseEvent e) => this.todolist.edit_todo(this));
    this.input.onBlur.listen((FocusEvent e) => this.todolist.close_edit());
    this.input.onKeyPress.listen((KeyboardEvent e) { if (e.keyCode == KeyCode.ENTER) this.exit_editmode(); });

    this.render();
  }

  /**
   * ...
   */
  void uninstall() {
    super.uninstall();
  }

  // --------------------------------------------------------------------------
  // Render

  /**
   * See in context explanation on [render] in the TodoList class.
   */
  void render() {
    this.label.text = this.text;

    // is the Todo visible?
    if (this.visible) {
      this.source.style.display = 'block';
    }
    else { // this.visible == false
      this.source.style.display = 'none';
    }

    // resolve editable status
    if (this._editabletrigger) {
      this._editabletrigger = false;
      if (this.editable) {
        // from non-editable to editable
        this.input.value = this.text;
        this.source.classes.add('editing');
        this.input
          ..select()
          ..focus();
      }
      else { // non-editable
        // from editable to non-editable
        if (this.input.value.trim().length == 0) {
          // empty value, remove todo
          this.uninstall();
        }
        else { // value is not empty
          this.label.text = this.text = this.input.value.trim();
          this.source.classes.remove('editing');
          this._editable = false;
        }
      }
    }

    // resolve state
    if (this.state == 'active') {
      this.toggle.checked = false;
      this.source.classes.remove('completed');
    }
    else { // completed
      this.toggle.checked = true;
      this.source.classes.add('completed');
    }
  }

  // --------------------------------------------------------------------------
  // State Operations

  /**
   * Changes to the editable state are stored in [_editabletrigger], if the
   * state change is not different then the operation is ignored when rendering
   * to avoid potential interface misbehaviour.
   */
  void set editable(bool value) {
    if (value != this._editable) {
      this._editabletrigger = true;
      this._editable = value;
    }
  }

  bool get editable {
    return this._editable;
  }

  /**
   * Mark an item as completed or active.
   */
  void mark() {
    if (this.state == 'completed') {
      this.state = 'active';
    }
    else { // status == active
      this.state = 'completed';
    }

    this.todolist.render();
  }

  /**
   * ...
   */
  void exit_editmode() {
    this.editable = false;
    this.render();
  }

} // class