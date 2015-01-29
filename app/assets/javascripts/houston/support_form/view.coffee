@Houston.SupportForm = Houston.SupportForm || {}
class Houston.SupportForm.View extends Backbone.View
  el: '#support_form'
  
  events:
    'shown a[data-toggle="tab"]': 'tabSelected'
    'click #create_feedback': 'createComment'
    'click #clear_feedback': 'clearComment'
    'keydown #new_feedback_form input': 'keydownNewFeedback'
  
  initialize: ->
    @project = @options.project
    @tags = @options.tags
  
  render: ->
    $('#new_feedback_tags').autocompleteTags(@tags)
    @$el.find('[data-toggle="tooltip"]').tooltip()
  
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
        @clearComment()
        alertify.success "Comment created"
      .error ->
        console.log 'error', arguments

  clearComment: (e)->
    e.preventDefault() if e
    $('#new_feedback_form').reset()

