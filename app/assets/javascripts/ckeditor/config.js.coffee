CKEDITOR.editorConfig = (config) ->
  config.language = "ru"
  config.defaultLanguage = 'ru'
#  config.uiColor = '#AADC6E'
  config.toolbar_Basic =
    [
      ['Source','-','Preview'],
      ['Cut','Copy','Paste','PasteText','PasteFromWord'],
      ['Undo','Redo','-','SelectAll','RemoveFormat'],
      ['Bold', 'Italic', '-', 'NumberedList', 'BulletedList', '-', 'Link', 'Unlink','-','About']
    ]

  config.toolbar_My =
    [
      { name: 'document', items : [ 'Source','-','NewPage','Preview', 'Maximize','-','Templates' ] },
      { name: 'clipboard', items : [ 'Undo','Redo', '-', 'Cut','Copy','Paste','PasteText','PasteFromWord' ] },
      { name: 'editing', items : [ 'Find','Replace'] },
      { name: 'basicstyles', items : [ 'Bold','Italic','Underline','Strike','Subscript','Superscript' ] },
      { name: 'paragraph', items : [ 'NumberedList','BulletedList','-','Outdent','Indent',
        '-','JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock' ] },
      '/',
      { name: 'styles', items : [ 'Styles','Format','Font','FontSize' ] },
      { name: 'colors', items : [ 'TextColor','BGColor' ] },
      { name: 'insert', items : [ 'Image','Table','HorizontalRule','SpecialChar','PageBreak' ] },
      { name: 'links', items : [ 'Link','Unlink' ] }
    ]

  config.enterMode = CKEDITOR.ENTER_BR
  true