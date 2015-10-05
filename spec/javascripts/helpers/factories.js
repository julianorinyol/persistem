function attributeTracker() {
  this.usn = 0;
  this.user_id = 0;
  this.notebook_id = 0;
  this.note_id = 0;
  this.title_number = 100;
  var n = 100;
  this.note_guid = 'fc4e4c10-ee4e-' + this.title_number +'c-8d4e-94ba5b40e7bd';
  this.notebook_guid = "2b576fa6-4078-" + this.title_number + "d-86f0-ba08cc124720";
  this.note_title = 'myNoteTitle' + this.title_number;
  this.notebook_title = "MyNotebookTitle" + this.title_number;
  this.get_usn = function(){
    return ++this.usn;
  };
  this.get_user_id = function(){
    return ++this.user_id;
  };
  this.get_notebook_id = function(){
    return ++this.notebook_id;
  };
  this.get_note_id = function(){
    return ++this.note_id;
  };
  this.get_note_guid = function(){
    this.title_number ++;
    this.note_guid = 'fc4e4c10-ee4e-' + this.title_number +'c-8d4e-94ba5b40e7bd';
    return this.note_guid; 
  };
  this.get_notebook_guid = function(){
    this.title_number ++;
    this.notebook_guid = "2b576fa6-4078-" + this.title_number + "d-86f0-ba08cc124720";
    return this.notebook_guid; 
  };
  this.get_note_title = function() {
    this.title_number ++;
    this.note_title = 'myNoteTitle' + this.title_number;
    return this.note_title;
  };
  this.get_notebook_title = function() {
    this.title_number ++;
    this.notebook_title = "MyNotebookTitle" + this.title_number;
    return this.notebook_title;
  }
}
  var attributeTracker = new attributeTracker();
  var users = [];
  var notebooks = [];
  var notes = [];
  var questions = [];
  var answers = [];

  function sampleUser(id, notes, notebooks, questions) {
    this.id = id || attributeTracker.get_user_id();
    this.notes = notes || [];
    this.notebooks = notebooks || [];
    this.questions = questions || [];
    users.push(this);
  }

  function sampleNotebook(id, guid, title, user_id, update_sequence_number) {
    this.id = id || attributeTracker.get_notebook_id();
    this.guid = guid || attributeTracker.get_notebook_guid();
    this.title = title || attributeTracker.get_notebook_title();
    this.user_id = user_id || getOrCreateRandomUser().id;
    this.update_sequence_number = update_sequence_number || attributeTracker.get_usn();
    notebooks.push(this);
  }

    function sampleNote(id, created_at, updated_at, user_id, content, notebook, publico, subject_id, title, update_sequence_number) {
      this.id = id || attributeTracker.get_note_id();
      this.created_at = created_at || new Date().toISOString();
      this.updated_at = updated_at || new Date().toISOString();
      this.content = 'blablaContent note: ' + this.id;
      if(!notebook) {
        var notebook = getOrCreateRandomNotebook();
      }
      this.notebook_guid = notebook.guid;
      this.notebook_id = notebook.id;
      this.user_id = notebook.user_id;
      this.public = publico || false;
      this.title = title || attributeTracker.get_note_title();
      this.update_sequence_number = update_sequence_number || attributeTracker.get_usn();
      notes.push(this);
    }
  function getExistingAttrs(input, attr) {
    var attrs = [];
    for(var i=0; i < input.length; i++) {
      attrs.push(input[i][attr])
    }
    return attrs;
  }
  function getOrCreateRandomUser(){
    if(users.length > 0) {
      result = sampleFromArray(users);
    } else {
      result = new sampleUser();
    } 
    return result;
  }
  function getOrCreateRandomNotebook() {
    if(notebooks.length > 0) {
      result = sampleFromArray(notebooks);
    } else {
      result = new sampleNotebook();
    } 
    return result;
  }
  function sampleFromArray(array) {
    var rand =  Math.floor((Math.random() * array.length));
    return array[rand];
  }