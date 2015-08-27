module NotesHelper
  def getNotebookName notebooks, guid
    notebooks.each do |notebook|
      if notebook.guid == guid
        return notebook.title
      end
    end
  end
end
