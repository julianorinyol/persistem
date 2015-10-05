
// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

// ************************ Display & HTML generating functions ********************************* \\


function displayNotes(notes, notebooks) {
  $('#private-notes-list tbody').html('');
  for(var i = 0; i < notes.length; i++) {
    note = notes[i];
    notebook = getNotebookFromNote(note, notebooks);
    var trInnards = generateRow([note.title, notebook.title], ["class", "clickable-tr"], ["data-link",'/notes/' + note.id] );
    tr = $(trInnards);
    tr.appendTo($('#private-notes-list tbody'));
  }
}

function displayNotebooks(notes, notebooks) {
  for(var i = 0; i < notebooks.length; i++) {
    notebook = notebooks[i];
    var trInnards = generateRow([notebook.title, getNumberOfNotesInNotebook(notes,notebook)], ['class', 'bla-class'], ['id','bla'+i], ["data-link", "''"]);
    tr = $(trInnards);
    tr.appendTo($('#private-notes-list tbody'));

    $("#bla" + i).on('click',function(){
      var id = $(this).attr('id').slice(3, $(this).attr('id').length + 1); 
      displayNotesForNotebook(myNotes, notebooks[id]);
    })
  }

  $(".bla-class").on('mouseenter', function() {
    $(this).css({"background":"purple", 'color':'white'});
  })
  $(".bla-class").on('mouseleave', function() {
    $(this).css({"background":"white",'color':'black'});
  })
} 

function displayNotesForNotebook(notes, notebook){
  $('#private-notes-list tbody').html('');
  notebooksNotes = getNotesForNotebook(notes, notebook);
  for(var i = 0; i < notebooksNotes.length; i++) {
    note = notebooksNotes[i];
    var trInnards = generateRow([note.title, notebook.title], ['class', 'clickable-tr'], ['data-link','/notes/' + note.id]);
    tr = $(trInnards);
    tr.appendTo($('#private-notes-list tbody'));
  }
  setUpBindings();
}

//display takes  optional extra args... which create element attributes.  ex. ['class', 'testClass'] ---becomes---> class='testClass'
// function display(objArray, rowContentArr) {
//    $('#private-notes-list tbody').html('');
//    var trInnards;
//    for(var i = 2; i < objArray.length; i++) {
//     //using optional extra args...
//     trInnards = generateRow(rowContentArr, arguments[i]);
//     tr = $(trInnards);
//     tr.appendTo($('#private-notes-list tbody'));
//    }
//    setUpBindings();
// }


function displayQuizzes(quizzes) {
   $('#private-notes-list tbody').html('');
  for(var i = 0; i < quizzes.length; i++) {
    quiz = quizzes[i];
    var trInnards = generateRow([timeSince(convertDate(quiz.created_at)) + ' ago', '% answered'], ["class", "clickable-tr"], ["data-link",'/quiz/' + quiz.id] );
    tr = $(trInnards);
    tr.appendTo($('#private-notes-list tbody'));
  }
  setTableHeaders('Date Created', '% Finished');

  setUpBindings();
}


 function generateRow(contentArray) {
   //takes an array of objects {attr: 'class' val: 'my-class'}
   var tr ="<tr";
   var innards = buildInnards(contentArray);
   //using optional extra args...
   for(var i = 1; i < arguments.length; i++) {
    argument = arguments[i];
    tr += " " + argument[0] + "='" + argument[1] + "'";
   }

   tr += ">" + innards + "</tr>";
   return tr;
 
 }
  function buildInnards(contentArray) {
    var content;
    var output = ""
    for(var i = 0; i < contentArray.length; i++) {
      content = contentArray[i];
      output += "<td>"+ content +"</td>"
    }
    return output;
  }


function setCorrectTabActive() {
  if(window.location.href.indexOf('quiz') > 0) {
    getQuizzes();
  } else if(window.location.href.indexOf('notes') > 0) {
    // console.log('hey');
    // displayWelcomePage();
    displayNotes(myNotes, notebooks);
  } else {
    displayNotes(myNotes, notebooks);
  }
}



function setTableHeaders() {
  for(var i = 0; i < arguments.length; i++) {
    var arg = arguments[i];
     $('#table-header' + (i + 1)).text(arg);
  }
}

function convertDate(unixDateString) {
  return new Date(unixDateString);
}

function timeSince(date) {

    var seconds = Math.floor((new Date() - date) / 1000);

    var interval = Math.floor(seconds / 31536000);

    if (interval > 1) {
        return interval + " years";
    }
    interval = Math.floor(seconds / 2592000);
    if (interval > 1) {
        return interval + " months";
    }
    interval = Math.floor(seconds / 86400);
    if (interval > 1) {
        return interval + " days";
    }
    interval = Math.floor(seconds / 3600);
    if (interval > 1) {
        return interval + " hours";
    }
    interval = Math.floor(seconds / 60);
    if (interval > 1) {
        return interval + " minutes";
    }
    return Math.floor(seconds) + " seconds";
}
function setUpBindings(){
  $("tr[data-link].clickable-tr").click(function() {
    window.location = $(this).data("link")
  })
  $(".clickable-tr").on('mouseenter', function() {
    $(this).css({"background":"purple", 'color':'white'});
  })
  $(".clickable-tr").on('mouseleave', function() {
    $(this).css({"background":"white",'color':'black'});
  })
}

function displayNotebookOptions() {
     var options = "<option value=''>All Notebooks</option>";
    for(var i = 0; i < notebooks.length; i++) {
      var notebook = notebooks[i];
      options += "<option value='" + notebook.id + "''>" + notebook.title +"</option>"
    }
    $('#notebook-select-dropdown').html(options);
  }

  function displayWelcomePage() {
    $(function() {
      $('.right-side-container').html(" \
        <div class='welcome-page'> \
          <h1>Welcome!</h1> \
          <h3>Get Started...</h3> \
           <ol id='welcome-list'> \
            <li>Select A Note<ul><li>Write some questions to help you review and remember it</li></ul></li> \
            <li>Generate a quiz and answer questions to test your knowledge of your knowledge.</li> \
           </ol> \
       </div> \
        ");
    });
  }

    function createQuizInputEventBindings() {
      $('#notebook-select-dropdown').on('change', function(){
        var value = $(this).val();
          if(value == '') {
          $('#notebook-string').val('');
          $('#included-notebooks-list > p').html('');
      }

      var submitValue = "";
      if($('#notebook-string').val()) {
        if($('#notebook-string').val().indexOf(value) == -1 ) {
          submitValue = $('#notebook-string').val(); 
          submitValue += ", " + value;
          $('#notebook-string').val(submitValue);
          var notebookName = $("#notebook-select-dropdown option[value='"+ value + "']").text();
          $('#included-notebooks-list > p').append('<p>' + notebookName + '</p>');
        }
      } else {
        submitValue = value;
        $('#notebook-string').val(submitValue);
        var notebookName = $("#notebook-select-dropdown option[value='"+ value + "']").text();
        $('#included-notebooks-list > p').append('<p>' + notebookName + '</p>'); 
        }
      })

      $('#new_quiz input[name="quiz[popular]"], #new_quiz input[name="quiz[time_ago]"] ').on('click', function() {
        $(this).siblings().attr('checked', false);
      })
      $('#uncheck').on('click', function(){
        $('.date > input[name="quiz[time_ago]"]').attr('checked', false);
      })
  }

// ************************Sorting and Retrieval Functions********************************* \\
function getNotebookFromNote(note, notebooks) {
  for(var i = 0; i < notebooks.length; i++) {
    notebook = notebooks[i];
    if(notebook.guid == note.notebook_guid) {
      return notebook;
    }
  }
}
function getNotesForNotebook(notes, notebook) {
  notebooksNotes =[];
  for(var i = 0; i < notes.length; i++) {
    var note = notes[i];
    if( note.notebook_guid == notebook.guid ){
      notebooksNotes.push(note);
    }
  }
  return notebooksNotes;
}
function getNumberOfNotesInNotebook(notes, notebook) {
  return getNotesForNotebook(notes, notebook).length;
}

// ************************AJAX Functions********************************* \\
function getQuizzes() {
  $.ajax({
    url: '/quizzes/sync',
    method: 'GET',
    dataType: 'json',
    success: function(res) {
      displayQuizzes(res);
    },
    error: function(err, message) {
      console.log('notebook get ajax failed' + message);
    }
  });
}
function initialSync() {
  $.ajax({
    url: '/notebooks/list',
    method: 'GET',
    dataType: 'json',
    success: function(res) {
      notebooks = res;
      callForNotes(res);
    },
    error: function(err, message) {
      console.log('notebook get ajax failed' + message);
    }
  }); 
}
function normalSync() {
  $.ajax({
    url: '/notes/sync/evernote',
    method: 'GET',
    dataType: 'json',
    success: function(res) {
      notebooks = res;
      callForNotes(res);
    },
    error: function(err, message) {
      console.log('notebook get ajax failed' + message);
    }
  }); 
}

function callForNotes(notebooks){
  $.ajax({
        url: '/notes/sync/initial',
        method: 'GET',
        dataType: 'json',
        success: function(notes) {
          console.log('ajax success!');
          myNotes = notes;
          initialCallForContent();
          displayNotes(myNotes, notebooks);
          setUpBindings();
        },
        error: function(phase, message){
          console.log('ajax post failed', message);
          console.log('ajax post failed');
        }
      });
}

function initialCallForContent() {
   $.ajax({
        url: '/notes/sync/content',
        method: 'GET',
        dataType: 'json',
        success: function(notes) {
          console.log('content fetch success!');
          myNotes = notes;
        },
        error: function(phase, message){
          console.log('ajax post failed', message);
        }
      });
}
  
  // $('#generate_quiz_btn').on('click',function(){
  //   console.log('gen quizzzz');
  //   getLeastAnsweredQuiz();
  // })


// function getLeastAnsweredQuiz() {
//     $.ajax({
//       url: '/quiz/generate/new_least_answered/',
//       method: 'GET',
//       dataType: 'json',
//       success: function(res) {
//         debugger;
//       },
//       error: function(err, message) {
//         console.log('notebook get ajax failed', err, message);
//       }
//   });
// }


