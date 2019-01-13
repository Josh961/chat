require "shrine" # core
require "shrine/storage/file_system" # plugin to save files using file system

Shrine.storages = {
    cache: Shrine::Storage::FileSystem.new("public", prefix: "uploads/cache"), 
    store: Shrine::Storage::FileSystem.new("public", prefix: "uploads/store"),
}

Shrine.plugin :activerecord # enable ActiveRecord support
Shrine.plugin :determine_mime_type,  analyzer: :mimemagic # check MIME TYPE
Shrine.plugin :validation_helpers, default_messages: {
    mime_type_inclusion: ->(whitelist) { # you may use whitelist variable to display allowed types
      "isn't of allowed type. It must be a valid file type:\n.txt, .pdf, .docx, .xlsx, .java, .c, .cs, .js, .py, .rb, .html, .css, .cpp, .pptx."
    }
}

Shrine::Attacher.validate do
  validate_mime_type_inclusion [ # whitelist only these MIME types
                                   'image/jpeg',
                                   'image/png',
                                   'image/gif',
                                   'application/pdf',
                                   'application/vnd.openxmlformats-officedocument.wordprocessingml.document', # .docx
                                   'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet', # .xlsx
                                   'application/vnd.openxmlformats-officedocument.presentationml.presentation', # .pptx
                                   'application/vnd.ms-powerpoint',
                                   'text/plain',
                                   'text/css',
                                   'application/zip',
                                   'text/x-c++src', # accounts for C and C++ files
                                   'text/x-csharp',
                                   'text/x-java',
                                   'application/javascript',
                                   'text/x-python',
                                   'application/x-ruby',
                                   'text/html'
                               ]
  validate_max_size 1.megabyte # limit file size to 1MB
end