class NoteStoreController < ApplicationController

  private
  def authenticateToSharedNote
    client = EvernoteOAuth::Client.new(token: authtoken)
    note_store = client.note_store

    note = Evernote::EDAM::Type::Note.new
note.title = "Note"
note.content = <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE en-note SYSTEM "http://xml.evernote.com/pub/enml2.dtd">
<en-note>Content</en-note>
EOF
note.tagNames = ["Evernote API Sample"]

created_note = note_store.createNote(note)
share_key = note_store.shareNote(created_note.guid)

note_store.authenticateToSharedNote(created_note.guid, share_key)
  end

  def authenticateToSharedNotebook
    client = EvernoteOAuth::Client.new(token: authtoken)
    note_store = client.note_store
    linked_notebooks = note_store.listLinkedNotebooks

    linked_notebook = linked_notebooks.first
    share_key = linked_notebook.shareKey
    note_store.authenticateToSharedNotebook(share_key)
  end

  def createLinkedNotebook
    client = EvernoteOAuth::Client.new(token: authtoken)
    note_store = client.note_store
    user_store = client.user_store

    notebook = Evernote::EDAM::Type::Notebook.new
    notebook.name = "Notebook #{Time.now.to_i}"
    created_notebook = note_store.createNotebook(notebook)

    shared_notebook = Evernote::EDAM::Type::SharedNotebook.new
    shared_notebook.email = '#{params[:email]}'
    shared_notebook.notebookGuid = created_notebook.guid
    created_shared_notebook = note_store.createSharedNotebook(shared_notebook)

    user = user_store.getUser

    linked_notebook = Evernote::EDAM::Type::LinkedNotebook.new
    linked_notebook.shareName = "Linked Notebook"
    linked_notebook.username = user.username
    linked_notebook.shareKey = created_shared_notebook.shareKey
    linked_notebook.shardId = user.shardId

    note_store.createLinkedNotebook(linked_notebook)
  end

  def createSharedNotebook
    client = EvernoteOAuth::Client.new(token: authtoken)
    note_store = client.note_store
    user_store = client.user_store

    notebook = Evernote::EDAM::Type::Notebook.new
    notebook.name = "Notebook #{Time.now.to_i}"

    created_notebook = note_store.createNotebook(notebook)

    shared_notebook = Evernote::EDAM::Type::SharedNotebook.new
    shared_notebook.email = '#{params[:email]}'
    shared_notebook.allowPreview = false
    shared_notebook.notebookGuid = created_notebook.guid

note_store.createSharedNotebook(shared_notebook)
  end

  def updateSharedNotebook
client = EvernoteOAuth::Client.new(token: authtoken)
note_store = client.note_store
linked_notebooks = note_store.listLinkedNotebooks

linked_notebook = linked_notebooks.first
shared_note_store = client.shared_note_store(linked_notebook)
shared_notebook = shared_note_store.getSharedNotebookByAuth

note_store.updateSharedNotebook(shared_notebook)
  end

  def copyNote
    client = EvernoteOAuth::Client.new(token: authtoken)
    note_store = client.note_store

    note = Evernote::EDAM::Type::Note.new
    note.title = "Note"
    note.content = <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE en-note SYSTEM "http://xml.evernote.com/pub/enml2.dtd">
<en-note>Content</en-note>
EOF
note.tagNames = ["Evernote API Sample"]

created_note = note_store.createNote(note)

note_store.copyNote(created_note.guid, created_note.notebookGuid)
  end

  def createNote
client = EvernoteOAuth::Client.new(token: authtoken)
note_store = client.note_store

note = Evernote::EDAM::Type::Note.new
note.title = "Note"
note.content = <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE en-note SYSTEM "http://xml.evernote.com/pub/enml2.dtd">
<en-note>Content</en-note>
EOF
note.tagNames = ["Evernote API Sample"]

note_store.createNote(note)
  end

  def createNotebook
    client = EvernoteOAuth::Client.new(token: authtoken)
    note_store = client.note_store

    notebook = Evernote::EDAM::Type::Notebook.new
    notebook.name = "Notebook #{Time.now.to_i}"

    note_store.createNotebook(notebook)
  end

  def createSearch
    client = EvernoteOAuth::Client.new(token: authtoken)
    note_store = client.note_store

    saved_search = Evernote::EDAM::Type::SavedSearch.new
    saved_search.name = "SavedSearch #{Time.now.to_i}"
    saved_search.query = "created:20070704"
    saved_search.format = Evernote::EDAM::Type::QueryFormat::USER

    note_store.createSearch(saved_search)
  end

  def createTag
client = EvernoteOAuth::Client.new(token: authtoken)
note_store = client.note_store

tag = Evernote::EDAM::Type::Tag.new
tag.name = "Evernote API Sample #{Time.now.to_i}"

note_store.createTag(tag)
  end

  def deleteNote
client = EvernoteOAuth::Client.new(token: authtoken)
note_store = client.note_store

note = Evernote::EDAM::Type::Note.new
note.title = "Note"
note.content = <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE en-note SYSTEM "http://xml.evernote.com/pub/enml2.dtd">
<en-note>Content</en-note>
EOF
note.tagNames = ["Evernote API Sample"]

created_note = note_store.createNote(note)

note_store.deleteNote(created_note.guid)
  end

  def emailNote
    @note = 'This function is not available to third party applications. Calls will result in an EDAMUserException with the error code PERMISSION_DENIED.'
  end

  def expungeInactiveNotes; end
  def expungeLinkedNotebook; end
  def expungeNote; end
  def expungeNotebook; end
  def expungeNotes; end
  def expungeSearch; end
  def expungeSharedNotebooks; end
  def expungeTag; end

  def findNoteCounts
client = EvernoteOAuth::Client.new(token: authtoken)
note_store = client.note_store

note_filter = Evernote::EDAM::NoteStore::NoteFilter.new
note_store.findNoteCounts(note_filter, false)
  end

  def findNoteOffset
    client = EvernoteOAuth::Client.new(token: authtoken)
    note_store = client.note_store

    note = Evernote::EDAM::Type::Note.new
    note.title = "Note"
    note.content = <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE en-note SYSTEM "http://xml.evernote.com/pub/enml2.dtd">
<en-note>Content</en-note>
EOF
note.tagNames = ["Evernote API Sample"]

created_note = note_store.createNote(note)

note_filter = Evernote::EDAM::NoteStore::NoteFilter.new
note_store.findNoteOffset(note_filter, created_note.guid)
end

def findNotesMetadata
  client = EvernoteOAuth::Client.new(token: authtoken)
  note_store = client.note_store

  note_filter = Evernote::EDAM::NoteStore::NoteFilter.new
  notes_metadata_result_spec = Evernote::EDAM::NoteStore::NotesMetadataResultSpec.new
  note_store.findNotesMetadata(note_filter, 0, 100, notes_metadata_result_spec)
end

  def findNotes
    client = EvernoteOAuth::Client.new(token: authtoken)
    note_store = client.note_store

    note_filter = Evernote::EDAM::NoteStore::NoteFilter.new
    note_store.findNotes(note_filter, 0, 10)
  end

  def findRelated
    client = EvernoteOAuth::Client.new(token: authtoken)
    note_store = client.note_store

    related_query = Evernote::EDAM::NoteStore::RelatedQuery.new
    related_query.plainText = 'content'
    related_result_spec = Evernote::EDAM::NoteStore::RelatedResultSpec.new
    related_result_spec.maxNotes = 10
    related_result_spec.maxNotebooks = 10
    related_result_spec.maxTags = 10
    note_store.findRelated(related_query, related_result_spec)
  end

  def getDefaultNotebook
    client = EvernoteOAuth::Client.new(token: authtoken)
    note_store = client.note_store

    note_store.getDefaultNotebook
  end

  def getFilteredSyncChunk
    client = EvernoteOAuth::Client.new(token: authtoken)
    note_store = client.note_store

    sync_chunk_filter = Evernote::EDAM::NoteStore::SyncChunkFilter.new
    sync_chunk_filter.includeNotes = true
    note_store.getFilteredSyncChunk(0, 1, sync_chunk_filter)
  end

  def getLinkedNotebookSyncChunk
    client = EvernoteOAuth::Client.new(token: authtoken)
    note_store = client.note_store
    linked_notebooks = note_store.listLinkedNotebooks

    linked_notebook = linked_notebooks.first
    shared_note_store = client.shared_note_store(linked_notebook)

    shared_note_store.getLinkedNotebookSyncChunk(authtoken, linked_notebook, 0, 1, true)
  end

  def getLinkedNotebookSyncState
    client = EvernoteOAuth::Client.new(token: authtoken)
    note_store = client.note_store
    linked_notebooks = note_store.listLinkedNotebooks

    linked_notebook = linked_notebooks.first
    shared_note_store = client.shared_note_store(linked_notebook)

    shared_note_store.getLinkedNotebookSyncState(authtoken, linked_notebook)
  end

  def getNote
    client = EvernoteOAuth::Client.new(token: authtoken)
    note_store = client.note_store

    note = Evernote::EDAM::Type::Note.new
    note.title = "Note"
note.content = <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE en-note SYSTEM "http://xml.evernote.com/pub/enml2.dtd">
<en-note>Content</en-note>
EOF
note.tagNames = ["Evernote API Sample"]

created_note = note_store.createNote(note)

note_store.getNote(created_note.guid, true, false, false, false)
  end

  def getNoteApplicationData
    client = EvernoteOAuth::Client.new(token: authtoken)
    note_store = client.note_store

    note = Evernote::EDAM::Type::Note.new
    note.title = "Note"
    note.content = <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE en-note SYSTEM "http://xml.evernote.com/pub/enml2.dtd">
<en-note>Content</en-note>
EOF
note.tagNames = ["Evernote API Sample"]
application_data = Evernote::EDAM::Type::LazyMap.new
application_data.fullMap = {'key' => 'value'}
note_attributes = Evernote::EDAM::Type::NoteAttributes.new
note_attributes.applicationData = application_data
note.attributes = note_attributes

created_note = note_store.createNote(note)

note_store.getNoteApplicationData(created_note.guid)
  end

  def getNoteApplicationDataEntry
    client = EvernoteOAuth::Client.new(token: authtoken)
    note_store = client.note_store

    note = Evernote::EDAM::Type::Note.new
    note.title = "Note"
    note.content = <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE en-note SYSTEM "http://xml.evernote.com/pub/enml2.dtd">
<en-note>Content</en-note>
EOF
note.tagNames = ["Evernote API Sample"]
application_data = Evernote::EDAM::Type::LazyMap.new
application_data.fullMap = {'key' => 'value'}
note_attributes = Evernote::EDAM::Type::NoteAttributes.new
note_attributes.applicationData = application_data
note.attributes = note_attributes

created_note = note_store.createNote(note)

note_store.getNoteApplicationDataEntry(created_note.guid, 'key')
  end

  def getNoteContent
    client = EvernoteOAuth::Client.new(token: authtoken)
    note_store = client.note_store

    note = Evernote::EDAM::Type::Note.new
    note.title = "Note"
    note.content = <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE en-note SYSTEM "http://xml.evernote.com/pub/enml2.dtd">
<en-note>Content</en-note>
EOF
note.tagNames = ["Evernote API Sample"]

created_note = note_store.createNote(note)

note_store.getNoteContent(created_note.guid)
  end
=begin





=end
  def getNoteSearchText
    client = EvernoteOAuth::Client.new(token: authtoken)
    note_store = client.note_store

    note = Evernote::EDAM::Type::Note.new
    note.title = "Note"
    note.content = <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE en-note SYSTEM "http://xml.evernote.com/pub/enml2.dtd">
<en-note>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</en-note>
EOF
note.tagNames = ["Evernote API Sample"]

created_note = note_store.createNote(note)

note_store.getNoteSearchText(created_note.guid, false, true)
  end

  def getNoteTagNames
    client = EvernoteOAuth::Client.new(token: authtoken)
    note_store = client.note_store

    note = Evernote::EDAM::Type::Note.new
    note.title = "Note"
note.content = <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE en-note SYSTEM "http://xml.evernote.com/pub/enml2.dtd">
<en-note>Content</en-note>
EOF
note.tagNames = ["Evernote API Sample"]

created_note = note_store.createNote(note)

note_store.getNoteTagNames(created_note.guid)
  end

  def getNoteVersion
    client = EvernoteOAuth::Client.new(token: authtoken)
    note_store = client.note_store

    note = Evernote::EDAM::Type::Note.new
note.title = "Note Version 1"
note.content = <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE en-note SYSTEM "http://xml.evernote.com/pub/enml2.dtd">
<en-note>Version 1</en-note>
EOF
note.tagNames = ["Evernote API Sample"]

created_note = note_store.createNote(note)

created_note.title = "Note Version 2"
created_note.content = <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE en-note SYSTEM "http://xml.evernote.com/pub/enml2.dtd">
<en-note>Version 2</en-note>
EOF

updated_note = note_store.updateNote(created_note)

note_store.getNoteVersion(updated_note.guid, created_note.updateSequenceNum, false, false, false)
  end

  def getNotebook
    client = EvernoteOAuth::Client.new(token: authtoken)
    note_store = client.note_store

    notebook = Evernote::EDAM::Type::Notebook.new
    notebook.name = "Notebook #{Time.now.to_i}"

    created_notebook = note_store.createNotebook(notebook)

    note_store.getNotebook(created_notebook.guid)
  end

  def getPublicNotebook
    client = EvernoteOAuth::Client.new(token: authtoken)
    user_store = client.user_store
    note_store = client.note_store

    public_user_info = user_store.getPublicUserInfo('evernotedev')

    note_store.getPublicNotebook(public_user_info.userId, 'cooking_notes')
  end

  def getResource
    client = EvernoteOAuth::Client.new(token: authtoken)
    note_store = client.note_store

    note = Evernote::EDAM::Type::Note.new
    note.title = "Note"

    filename = "enlogo.png"
    image = File.open(File.join(Rails.root, 'public', filename), "rb") { |io| io.read }
    hash_func = Digest::MD5.new

    data = Evernote::EDAM::Type::Data.new
    data.size = image.size
    data.bodyHash = hash_func.digest(image)
    data.body = image

    resource = Evernote::EDAM::Type::Resource.new
    resource.mime = "image/png"
    resource.data = data
    resource.attributes = Evernote::EDAM::Type::ResourceAttributes.new
    resource.attributes.fileName = filename

    note.resources = [resource]

note.content = <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE en-note SYSTEM "http://xml.evernote.com/pub/enml2.dtd">
<en-note>Content<br/>
  <en-media type="image/png" hash="\#{hash_func.hexdigest(image)}"/>
</en-note>
EOF
note.tagNames = ["Evernote API Sample"]

created_note = note_store.createNote(note)
resource_guid = created_note.resources.first.guid

note_store.getResource(resource_guid, false, false, false, false)
  end

  def getResourceAlternateData
    client = EvernoteOAuth::Client.new(token: authtoken)
    note_store = client.note_store

    note = Evernote::EDAM::Type::Note.new
    note.title = "Note"

    filename = "enlogo.png"
    image = File.open(File.join(Rails.root, 'public', filename), "rb") { |io| io.read }
    hash_func = Digest::MD5.new

    data = Evernote::EDAM::Type::Data.new
    data.size = image.size
    data.bodyHash = hash_func.digest(image)
    data.body = image

    alternate_filename = "rails.png"
    alternate_image = File.open(File.join(Rails.root, 'public', filename), "rb") { |io| io.read }

    alternate_data = Evernote::EDAM::Type::Data.new
    alternate_data.size = alternate_image.size
    alternate_data.bodyHash = hash_func.digest(alternate_image)
    alternate_data.body = alternate_image

    resource = Evernote::EDAM::Type::Resource.new
    resource.mime = "image/png"
    resource.data = data
    resource.alternateData = alternate_data
    resource.attributes = Evernote::EDAM::Type::ResourceAttributes.new
    resource.attributes.fileName = filename

    note.resources = [resource]

note.content = <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE en-note SYSTEM "http://xml.evernote.com/pub/enml2.dtd">
<en-note>Content<br/>
  <en-media type="image/png" hash="\#{hash_func.hexdigest(image)}"/>
</en-note>
EOF
note.tagNames = ["Evernote API Sample"]

created_note = note_store.createNote(note)
resource_guid = created_note.resources.first.guid

note_store.getResourceAlternateData(resource_guid)
  end

  def getResourceApplicationData
    client = EvernoteOAuth::Client.new(token: authtoken)
    note_store = client.note_store

    note = Evernote::EDAM::Type::Note.new
    note.title = "Note"

    filename = "enlogo.png"
    image = File.open(File.join(Rails.root, 'public', filename), "rb") { |io| io.read }
    hash_func = Digest::MD5.new

    data = Evernote::EDAM::Type::Data.new
    data.size = image.size
    data.bodyHash = hash_func.digest(image)
    data.body = image

    resource = Evernote::EDAM::Type::Resource.new
    resource.mime = "image/png"
    resource.data = data
    resource.attributes = Evernote::EDAM::Type::ResourceAttributes.new
    resource.attributes.fileName = filename

    application_data = Evernote::EDAM::Type::LazyMap.new
    application_data.fullMap = {'key' => 'value'}
    resource_attributes = Evernote::EDAM::Type::ResourceAttributes.new
    resource_attributes.applicationData = application_data
    resource.attributes = resource_attributes

    note.resources = [resource]

note.content = <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE en-note SYSTEM "http://xml.evernote.com/pub/enml2.dtd">
<en-note>Content<br/>
  <en-media type="image/png" hash="\#{hash_func.hexdigest(image)}"/>
</en-note>
EOF
note.tagNames = ["Evernote API Sample"]

created_note = note_store.createNote(note)
resource_guid = created_note.resources.first.guid

note_store.getResourceApplicationData(resource_guid)
  end

  def getResourceApplicationDataEntry
    client = EvernoteOAuth::Client.new(token: authtoken)
    note_store = client.note_store

    note = Evernote::EDAM::Type::Note.new
    note.title = "Note"

    filename = "enlogo.png"
    image = File.open(File.join(Rails.root, 'public', filename), "rb") { |io| io.read }
    hash_func = Digest::MD5.new

    data = Evernote::EDAM::Type::Data.new
    data.size = image.size
    data.bodyHash = hash_func.digest(image)
    data.body = image

    resource = Evernote::EDAM::Type::Resource.new
    resource.mime = "image/png"
    resource.data = data
    resource_attributes = Evernote::EDAM::Type::ResourceAttributes.new
    resource_attributes.fileName = filename

    application_data = Evernote::EDAM::Type::LazyMap.new
    application_data.fullMap = {'key' => 'value'}
    resource_attributes.applicationData = application_data
    resource.attributes = resource_attributes

note.resources = [resource]

note.content = <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE en-note SYSTEM "http://xml.evernote.com/pub/enml2.dtd">
<en-note>Content<br/>
  <en-media type="image/png" hash="\#{hash_func.hexdigest(image)}"/>
</en-note>
EOF
note.tagNames = ["Evernote API Sample"]

created_note = note_store.createNote(note)
resource_guid = created_note.resources.first.guid

note_store.getResourceApplicationDataEntry(resource_guid, 'key')
  end

  def getResourceAttributes
    client = EvernoteOAuth::Client.new(token: authtoken)
    note_store = client.note_store

    note = Evernote::EDAM::Type::Note.new
    note.title = "Note"

    filename = "enlogo.png"
    image = File.open(File.join(Rails.root, 'public', filename), "rb") { |io| io.read }
    hash_func = Digest::MD5.new

    data = Evernote::EDAM::Type::Data.new
    data.size = image.size
    data.bodyHash = hash_func.digest(image)
    data.body = image

    resource = Evernote::EDAM::Type::Resource.new
    resource.mime = "image/png"
    resource.data = data
    resource_attributes = Evernote::EDAM::Type::ResourceAttributes.new
    resource_attributes.fileName = filename
    resource.attributes = resource_attributes

    note.resources = [resource]

note.content = <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE en-note SYSTEM "http://xml.evernote.com/pub/enml2.dtd">
<en-note>Content<br/>
  <en-media type="image/png" hash="\#{hash_func.hexdigest(image)}"/>
</en-note>
EOF
note.tagNames = ["Evernote API Sample"]

created_note = note_store.createNote(note)
resource_guid = created_note.resources.first.guid

note_store.getResourceAttributes(resource_guid)
  end

  def getResourceByHash
    client = EvernoteOAuth::Client.new(token: authtoken)
    note_store = client.note_store

    note = Evernote::EDAM::Type::Note.new
    note.title = "Note"
    filename = "enlogo.png"
    image = File.open(File.join(Rails.root, 'public', filename), "rb") { |io| io.read }
    hash_func = Digest::MD5.new

    data = Evernote::EDAM::Type::Data.new
    data.size = image.size
    body_hash = hash_func.digest(image)
    data.bodyHash = body_hash
    data.body = image

    resource = Evernote::EDAM::Type::Resource.new
    resource.mime = "image/png"
    resource.data = data
    resource_attributes = Evernote::EDAM::Type::ResourceAttributes.new
    resource_attributes.fileName = filename
    resource.attributes = resource_attributes

    note.resources = [resource]

note.content = <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE en-note SYSTEM "http://xml.evernote.com/pub/enml2.dtd">
<en-note>Content<br/>
  <en-media type="image/png" hash="\#{hash_func.hexdigest(image)}"/>
</en-note>
EOF
note.tagNames = ["Evernote API Sample"]

created_note = note_store.createNote(note)
resource_guid = created_note.resources.first.guid

note_store.getResourceByHash(created_note.guid, body_hash, false, false, false)
  end

  def getResourceData
    client = EvernoteOAuth::Client.new(token: authtoken)
    note_store = client.note_store

    note = Evernote::EDAM::Type::Note.new
    note.title = "Note"

    filename = "enlogo.png"
    image = File.open(File.join(Rails.root, 'public', filename), "rb") { |io| io.read }
    hash_func = Digest::MD5.new

    data = Evernote::EDAM::Type::Data.new
    data.size = image.size
    data.bodyHash = hash_func.digest(image)
    data.body = image

    resource = Evernote::EDAM::Type::Resource.new
    resource.mime = "image/png"
    resource.data = data
    resource_attributes = Evernote::EDAM::Type::ResourceAttributes.new
    resource_attributes.fileName = filename
    resource.attributes = resource_attributes

    note.resources = [resource]

note.content = <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE en-note SYSTEM "http://xml.evernote.com/pub/enml2.dtd">
<en-note>Content<br/>
  <en-media type="image/png" hash="\#{hash_func.hexdigest(image)}"/>
</en-note>
EOF
note.tagNames = ["Evernote API Sample"]

created_note = note_store.createNote(note)
resource_guid = created_note.resources.first.guid

note_store.getResourceData(resource_guid)
  end

  def getResourceRecognition
    client = EvernoteOAuth::Client.new(token: authtoken)
    note_store = client.note_store

    note = Evernote::EDAM::Type::Note.new
    note.title = "Note"

    filename = "enlogo.png"
    image = File.open(File.join(Rails.root, 'public', filename), "rb") { |io| io.read }
    hash_func = Digest::MD5.new

    data = Evernote::EDAM::Type::Data.new
    data.size = image.size
    data.bodyHash = hash_func.digest(image)
    data.body = image

    resource = Evernote::EDAM::Type::Resource.new
    resource.mime = "image/png"
    resource.data = data
    resource_attributes = Evernote::EDAM::Type::ResourceAttributes.new
    resource_attributes.fileName = filename
    resource.attributes = resource_attributes

    note.resources = [resource]

note.content = <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE en-note SYSTEM "http://xml.evernote.com/pub/enml2.dtd">
<en-note>Content<br/>
  <en-media type="image/png" hash="\#{hash_func.hexdigest(image)}"/>
</en-note>
EOF
note.tagNames = ["Evernote API Sample"]

created_note = note_store.createNote(note)
resource_guid = created_note.resources.first.guid

note_store.getResourceRecognition(resource_guid)
  end

  def getResourceSearchText
    client = EvernoteOAuth::Client.new(token: authtoken)
    note_store = client.note_store

    note = Evernote::EDAM::Type::Note.new
    note.title = "Note"

    filename = "evernote_logo_center.png"
    image = File.open(File.join(Rails.root, 'public', filename), "rb") { |io| io.read }
    hash_func = Digest::MD5.new

    data = Evernote::EDAM::Type::Data.new
    data.size = image.size
    data.bodyHash = hash_func.digest(image)
    data.body = image

    resource = Evernote::EDAM::Type::Resource.new
    resource.mime = "image/png"
    resource.data = data
    resource_attributes = Evernote::EDAM::Type::ResourceAttributes.new
    resource_attributes.fileName = filename
    resource.attributes = resource_attributes

    note.resources = [resource]

note.content = <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE en-note SYSTEM "http://xml.evernote.com/pub/enml2.dtd">
<en-note>Content<br/>
  <en-media type="image/png" hash="\#{hash_func.hexdigest(image)}"/>
</en-note>
EOF
note.tagNames = ["Evernote API Sample"]

created_note = note_store.createNote(note)
resource_guid = created_note.resources.first.guid

note_store.getResourceSearchText(resource_guid)
  end

  def getSearch
    client = EvernoteOAuth::Client.new(token: authtoken)
    note_store = client.note_store

    saved_search = Evernote::EDAM::Type::SavedSearch.new
    saved_search.name = "SavedSearch #{Time.now.to_i}"
    saved_search.query = "created:20070704"
    saved_search.format = Evernote::EDAM::Type::QueryFormat::USER

    created_search = note_store.createSearch(saved_search)

    note_store.getSearch(created_search.guid)
  end

  def getSharedNotebookByAuth
    client = EvernoteOAuth::Client.new(token: authtoken)
    note_store = client.note_store
    linked_notebooks = note_store.listLinkedNotebooks

    linked_notebook = linked_notebooks.first
    shared_note_store = client.shared_note_store(linked_notebook)

    shared_note_store.getSharedNotebookByAuth
  end

  def getSyncChunk
    client = EvernoteOAuth::Client.new(token: authtoken)
    note_store = client.note_store

    note_store.getSyncChunk(0, 1, true)
  end

  def getSyncState
    client = EvernoteOAuth::Client.new(token: authtoken)
    note_store = client.note_store

    note_store.getSyncState
  end

  def getSyncStateWithMetrics
    client = EvernoteOAuth::Client.new(token: authtoken)
    note_store = client.note_store

    client_usage_metrics = Evernote::EDAM::NoteStore::ClientUsageMetrics.new
    client_usage_metrics.sessions = 0

    note_store.getSyncStateWithMetrics(client_usage_metrics)
  end

  def getTag
    client = EvernoteOAuth::Client.new(token: authtoken)
    note_store = client.note_store

    tag = Evernote::EDAM::Type::Tag.new
    tag.name = "Evernote API Sample #{Time.now.to_i}"

    created_tag = note_store.createTag(tag)

    note_store.getTag(created_tag.guid)
  end

  def listLinkedNotebooks
    client = EvernoteOAuth::Client.new(token: authtoken)
    note_store = client.note_store

    note_store.listLinkedNotebooks
  end

  def listNotebooks
    client = EvernoteOAuth::Client.new(token: authtoken)
    note_store = client.note_store

    note_store.listNotebooks
  end

  def listNoteVersions
client = EvernoteOAuth::Client.new(token: authtoken)
note_store = client.note_store

note = Evernote::EDAM::Type::Note.new
note.title = "Note Version 1"
note.content = <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE en-note SYSTEM "http://xml.evernote.com/pub/enml2.dtd">
<en-note>Version 1</en-note>
EOF
note.tagNames = ["Evernote API Sample"]

created_note = note_store.createNote(note)

created_note.title = "Note Version 2"
created_note.content = <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE en-note SYSTEM "http://xml.evernote.com/pub/enml2.dtd">
<en-note>Version 2</en-note>
EOF

updated_note = note_store.updateNote(created_note)

note_store.listNoteVersions(updated_note.guid)
  end

  def listSearches
    client = EvernoteOAuth::Client.new(token: authtoken)
    note_store = client.note_store

    note_store.listSearches
  end

  def listTags
    client = EvernoteOAuth::Client.new(token: authtoken)
    note_store = client.note_store

    note_store.listTags
  end

  def listSharedNotebooks
    client = EvernoteOAuth::Client.new(token: authtoken)
    note_store = client.note_store

    note_store.listSharedNotebooks
  end

  def listTagsByNotebook
    client = EvernoteOAuth::Client.new(token: authtoken)
    note_store = client.note_store

    default_notebook = note_store.getDefaultNotebook

    note_store.listTagsByNotebook(default_notebook.guid)
  end

  def sendMessageToSharedNotebookMembers
    client = EvernoteOAuth::Client.new(token: authtoken)
    note_store = client.note_store

    shared_notebook = note_store.listSharedNotebooks.first

    note_store.sendMessageToSharedNotebookMembers(shared_notebook.notebookGuid, "This is a test.", [])
  end

  def setNoteApplicationDataEntry
client = EvernoteOAuth::Client.new(token: authtoken)
note_store = client.note_store

note = Evernote::EDAM::Type::Note.new
note.title = "Note"
note.content = <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE en-note SYSTEM "http://xml.evernote.com/pub/enml2.dtd">
<en-note>Content</en-note>
EOF
note.tagNames = ["Evernote API Sample"]

created_note = note_store.createNote(note)

note_store.setNoteApplicationDataEntry(created_note.guid, 'key', 'value')
  end

  def setResourceApplicationDataEntry
    client = EvernoteOAuth::Client.new(token: authtoken)
    note_store = client.note_store

    note = Evernote::EDAM::Type::Note.new
    note.title = "Note"

    filename = "enlogo.png"
    image = File.open(File.join(Rails.root, 'public', filename), "rb") { |io| io.read }
    hash_func = Digest::MD5.new

    data = Evernote::EDAM::Type::Data.new
    data.size = image.size
    data.bodyHash = hash_func.digest(image)
    data.body = image

    resource = Evernote::EDAM::Type::Resource.new
    resource.mime = "image/png"
    resource.data = data
    resource.attributes = Evernote::EDAM::Type::ResourceAttributes.new
    resource.attributes.fileName = filename

    note.resources = [resource]

note.content = <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE en-note SYSTEM "http://xml.evernote.com/pub/enml2.dtd">
<en-note>Content<br/>
  <en-media type="image/png" hash="\#{hash_func.hexdigest(image)}"/>
</en-note>
EOF
note.tagNames = ["Evernote API Sample"]

created_note = note_store.createNote(note)
resource_guid = created_note.resources.first.guid

note_store.setResourceApplicationDataEntry(resource_guid, 'key', 'value')
  end

  def shareNote
    client = EvernoteOAuth::Client.new(token: authtoken)
    note_store = client.note_store

    note = Evernote::EDAM::Type::Note.new
    note.title = "Note"
    note.content = <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE en-note SYSTEM "http://xml.evernote.com/pub/enml2.dtd">
<en-note>Content</en-note>
EOF
note.tagNames = ["Evernote API Sample"]

created_note = note_store.createNote(note)

note_store.shareNote(created_note.guid)
  end

  def stopSharingNote
    client = EvernoteOAuth::Client.new(token: authtoken)
    note_store = client.note_store

    note = Evernote::EDAM::Type::Note.new
    note.title = "Note"
    note.content = <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE en-note SYSTEM "http://xml.evernote.com/pub/enml2.dtd">
<en-note>Content</en-note>
EOF
note.tagNames = ["Evernote API Sample"]

created_note = note_store.createNote(note)

note_store.shareNote(created_note.guid)

note_store.stopSharingNote(created_note.guid)
end

  def unsetNoteApplicationDataEntry
    client = EvernoteOAuth::Client.new(token: authtoken)
    note_store = client.note_store

    note = Evernote::EDAM::Type::Note.new
    note.title = "Note"
    note.content = <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE en-note SYSTEM "http://xml.evernote.com/pub/enml2.dtd">
<en-note>Content</en-note>
EOF
note.tagNames = ["Evernote API Sample"]

created_note = note_store.createNote(note)

note_store.setNoteApplicationDataEntry(created_note.guid, 'key', 'value')

note_store.unsetNoteApplicationDataEntry(created_note.guid, 'key')
end

  def unsetResourceApplicationDataEntry
    client = EvernoteOAuth::Client.new(token: authtoken)
    note_store = client.note_store

    note = Evernote::EDAM::Type::Note.new
    note.title = "Note"

    filename = "enlogo.png"
    image = File.open(File.join(Rails.root, 'public', filename), "rb") { |io| io.read }
    hash_func = Digest::MD5.new

    data = Evernote::EDAM::Type::Data.new
    data.size = image.size
    data.bodyHash = hash_func.digest(image)
    data.body = image

    resource = Evernote::EDAM::Type::Resource.new
    resource.mime = "image/png"
    resource.data = data
    resource.attributes = Evernote::EDAM::Type::ResourceAttributes.new
    resource.attributes.fileName = filename

    note.resources = [resource]

    note.content = <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE en-note SYSTEM "http://xml.evernote.com/pub/enml2.dtd">
<en-note>Content<br/>
  <en-media type="image/png" hash="\#{hash_func.hexdigest(image)}"/>
</en-note>
EOF
note.tagNames = ["Evernote API Sample"]

created_note = note_store.createNote(note)
resource_guid = created_note.resources.first.guid

note_store.setResourceApplicationDataEntry(resource_guid, 'key', 'value')

note_store.unsetResourceApplicationDataEntry(resource_guid, 'key')
  end

  def untagAll
client = EvernoteOAuth::Client.new(token: authtoken)
note_store = client.note_store

note = Evernote::EDAM::Type::Note.new
note.title = "Note"
note.content = <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE en-note SYSTEM "http://xml.evernote.com/pub/enml2.dtd">
<en-note>Content</en-note>
EOF
note.tagNames = ["Evernote API Sample #{Time.now.to_i}"]

created_note = note_store.createNote(note)
created_tag_guid = created_note.tagGuids.first

note_store.untagAll(created_tag_guid)
  end

  def updateLinkedNotebook
    client = EvernoteOAuth::Client.new(token: authtoken)
    note_store = client.note_store

    linked_notebook = note_store.listLinkedNotebooks.first
    if linked_notebook.shareName.index('[Updated] ')
      linked_notebook.shareName = linked_notebook.shareName.gsub('[Updated] ', '')
    else
      linked_notebook.shareName = "[Updated] " + linked_notebook.shareName
    end

    note_store.updateLinkedNotebook(linked_notebook)
  end

  def updateNote
client = EvernoteOAuth::Client.new(token: authtoken)
note_store = client.note_store

note = Evernote::EDAM::Type::Note.new
note.title = "Note"
note.content = <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE en-note SYSTEM "http://xml.evernote.com/pub/enml2.dtd">
<en-note>Content</en-note>
EOF
note.tagNames = ["Evernote API Sample"]

created_note = note_store.createNote(note)
created_note.title = "[Updated] " + created_note.title

note_store.updateNote(created_note)
  end

  def updateNotebook
    client = EvernoteOAuth::Client.new(token: authtoken)
    note_store = client.note_store

    notebook = Evernote::EDAM::Type::Notebook.new
    notebook.name = "Notebook #{Time.now.to_i}"

    created_notebook = note_store.createNotebook(notebook)
    created_notebook.name = "[Updated] " + created_notebook.name

    note_store.updateNotebook(created_notebook)
  end

  def updateResource
    client = EvernoteOAuth::Client.new(token: authtoken)
    note_store = client.note_store

    note = Evernote::EDAM::Type::Note.new
    note.title = "Note"

    filename = "enlogo.png"
    image = File.open(File.join(Rails.root, 'public', filename), "rb") { |io| io.read }
    hash_func = Digest::MD5.new

    data = Evernote::EDAM::Type::Data.new
    data.size = image.size
    data.bodyHash = hash_func.digest(image)
    data.body = image

    resource = Evernote::EDAM::Type::Resource.new
    resource.mime = "image/png"
    resource.data = data
    resource.attributes = Evernote::EDAM::Type::ResourceAttributes.new
    resource.attributes.fileName = filename

    note.resources = [resource]

note.content = <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE en-note SYSTEM "http://xml.evernote.com/pub/enml2.dtd">
<en-note>Content<br/>
  <en-media type="image/png" hash="\#{hash_func.hexdigest(image)}"/>
</en-note>
EOF
note.tagNames = ["Evernote API Sample"]

created_note = note_store.createNote(note)
resource_guid = created_note.resources.first.guid

created_resource = note_store.getResource(resource_guid, false, false, false, false)
created_resource.width = 300
created_resource.height = 300

note_store.updateResource(created_resource)
end

  def updateSearch
    client = EvernoteOAuth::Client.new(token: authtoken)
    note_store = client.note_store

    saved_search = Evernote::EDAM::Type::SavedSearch.new
    saved_search.name = "SavedSearch #{Time.now.to_i}"
    saved_search.query = "created:20070704"
    saved_search.format = Evernote::EDAM::Type::QueryFormat::USER

    created_saved_search = note_store.createSearch(saved_search)
    created_saved_search.name = "[Updated] " + created_saved_search.name
    created_saved_search.query = "created:20201231"

    note_store.updateSearch(created_saved_search)
  end

  def updateTag
    client = EvernoteOAuth::Client.new(token: authtoken)
    note_store = client.note_store

    tag = Evernote::EDAM::Type::Tag.new
    tag.name = "Evernote API Sample #{Time.now.to_i}"

    created_tag = note_store.createTag(tag)
    created_tag.name = "[Updated] " + created_tag.name

    note_store.updateTag(created_tag)
  end

end