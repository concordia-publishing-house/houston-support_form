@Houston.SupportForm = Houston.SupportForm || {}
class Houston.SupportForm.View extends Backbone.View
  el: '#support_form'

  events:
    'shown a[data-toggle="tab"]': 'tabSelected'
    'click #create_feedback': 'createComment'
    'click #clear_feedback': 'clearComment'
    'keydown #new_feedback_text': 'keydownNewFeedback'
    'keydown #new_feedback_tags': 'keydownNewFeedback'
    'click #create_itsm': 'createITSM'
    'click #clear_itsm': 'clearITSM'
    'keydown #new_itsm_text': 'keydownNewITSM'

  initialize: ->
    @project = @options.project
    @tags = @options.tags

  render: ->
    $('#new_feedback_tags').autocompleteTags(@tags)
    @$el.find('[data-toggle="tooltip"]').tooltip()
    $('#new_feedback_form .uploader').supportImages()
    $('#new_itsm_form .uploader').supportImages()
    $('#new_itsm_summary').val("[#{@project.slug}] ").putCursorAtEnd()
    window.setTimeout ->
        $('.tab-pane.active input:first').focus().select()
      , 0

  tabSelected: (e)->
    $a = $(e.target)
    $tab = $ $a.attr('href')
    $tab.find('input:first').focus()

  keydownNewFeedback: (e)->
    if e.keyCode is 13 and (e.metaKey or e.ctrlKey)
      @createComment(e)

  createComment: (e)->
    e.preventDefault() if e

    params = $('#new_feedback_form').serializeObject()
    params.tags = $('#new_feedback_tags').selectedTags()
    $.post "/feedback/by_project/#{@project.slug}", params
      .success =>
        alertify.success "Comment created"
        $('#new_feedback_tags').val('')
        $('#new_feedback_text').val('').focus()
      .error ->
        console.log 'error', arguments

  clearComment: (e)->
    e.preventDefault() if e
    $('#new_feedback_form').reset()
    $('#new_feedback_customer').focus().select()



  keydownNewITSM: (e)->
    if e.keyCode is 13 and (e.metaKey or e.ctrlKey)
      @createITSM(e)

  createITSM: (e)->
    e.preventDefault() if e

    params = $('#new_itsm_form').serializeObject()
    params.text = App.mdown(params.text)

    [_, projectSlug, summary] = params.summary.match(/^\s*\[([^\]]+)\]\s*(.*)$/) || [null, null, params.summary]
    if summary.length is 0
      alertify.error "Please write a summary for your ITSM"
      return

    $buttons = $('#create_itsm, #clear_itsm')
    $buttons.prop('disabled', true)
    $.post "/support_form/itsm", params
      .success (response)=>
        $buttons.prop('disabled', false)
        alertify.success "ITSM created"
        @clearITSM()
      .error ->
        $buttons.prop('disabled', false)
        console.log 'error', arguments

  clearITSM: (e)->
    e.preventDefault() if e
    $('#new_itsm_form').reset()
    $('#new_itsm_summary').val("[#{@project.slug}] ").putCursorAtEnd()
