describe("Application", function() {
  // var player;
  // var song;

  beforeEach(function() {
    // player = new Player();
    // song = new Song();
  });

  it("should fail", function() {
    // player.play(song);
    // expect(player.currentlyPlayingSong).toEqual(song);
    // expect(true).toBe(false);
    pending();
    // //demonstrates use of custom matcher
    // expect(player).toBePlaying(song);
  });

  // **Html generation/display**
  // displayNotes(notes, notebooks)
  // displayNotebooks(notes, notebooks)
  // displayNotesForNotebook(notes, notebook)
  // displayQuizzes(quizzes)
  // generateRow(contentArray)
  // buildInnards(contentArray)
  // setCorrectTabActive()
  // setTableHeaders()
  // convertDate(unixDateString)
  // timeSince(date)
  // setUpTableRowBindings()
  // displayNotebookOptions()
  // displayWelcomePage()
  //createQuizInputEventBindings()

  // **Sorting & Retrieval**
  // getNotesForNotebook(notes,notebook)  // not ajax
  //getNotebookFromNote(note, notebooks)

  
  //getNumberOfNotesInNotebook(notes, notebook)
  it("returns the number of notes in a notebook", function() {
    // Note.new(title, content, id, notebook) // notebook can be a nested object...
    notes = [new sampleNote(), new sampleNote(), new sampleNote(), new sampleNote() ]
    var result = getNumberOfNotesInNotebook(notes, notebooks[0])
    expect(result).toEqual(4);
  });

  // **AJAX**
  //getQuizzes() 
  // initialSync()
  // normalSync()
  // callForNotes(notebooks)
  //initialCallForContent()
  //

});
