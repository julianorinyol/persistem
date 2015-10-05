function attributeTracker() {
  this.usn = 0;
  this.user_id = 0;
  this.notebook_id = 0;
  this.note_id = 0;
  var n = 100;
  this.note_guid = 'fc4e4c10-ee4e-' + n +'c-8d4e-94ba5b40e7bd';
  this.notebook_guid = "2b576fa6-4078-" + n + "d-86f0-ba08cc124720";
  this.note_title = 'myNoteTitle' + n;
  this.notebook_title = "MyNotebookTitle" + n;
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
    n++;
    return this.note_guid; 
  };
  this.get_notebook_guid = function(){
    n++;
    return this.notebook_guid; 
  };
  this.get_note_title = function() {
    n++;
    return this.note_title;
  };
  this.get_notebook_title = function() {
    n++;
    return this.notebook_title;
  }
}
  var attributeTracker = new attributeTracker();

  function sampleUser(id, notes, notebooks, questions) {
    this.id = id || attributeTracker.get_user_id();
    this.notes = notes || [];
    this.notebooks = notebooks || [];
    this.questions = questions || [];
  }

  function sampleNotebook(id, guid, title, user_id, update_sequence_number) {
    this.id = id || attributeTracker.get_notebook_id();
    this.guid = guid || attributeTracker.get_notebook_guid();
    this.title = title || attributeTracker.get_notebook_title();
    this.user_id = user_id || getOrCreateRandomUser();
    this.update_sequence_number = update_sequence_number || attributeTracker.get_usn();
  }

  function sampleNote(id, created_at, updated_at, user_id, content, notebook_guid, notebook_id, public, subject_id, title, update_sequence_number) {
    this.id = attributeTracker.get_note_id();
    this.created_at = created_at || new Date().toISOSting();
    this.updated_at = update_at || new Date().toISOSting();
    this.user_id = user_id;
    this.content = 'blablaContent'
    this.notebook_guid = notebook_guid || 
    this.notebook_id = 
    this.public
    this.subject_id
    this.title = title || 'blablaTitle'
    this.update_sequence_number = update_sequence_number || Math.floor((Math.random() * 100) + 1);
  }
  function getExistingAttrs(input, attr) {
    var attrs = [];
    for(var i=0; i < input.length; i++) {
      attrs.push(input[i][attr])
    }
    return attrs;
  }
  function getOrCreateRandomUser(){
    if(users) {
      result = sampleFromArray(users);
    } else {
      result = new sampleUser();
    } 
    return result;
  }
  function getRandomOrCreateNotebook() {
    if(notebooks) {
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