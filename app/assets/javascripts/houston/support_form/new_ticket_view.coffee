@Houston.SupportForm = Houston.SupportForm || {}
class @Houston.SupportForm.NewTicketView extends Backbone.View
  el: '#new_ticket_view'
  
  BUG_DESCRIPTION: '''
### Steps to Test
 - 

### What happens
 - 

### What should happen
 - 
  '''
  
  events:
    'click #reset_ticket': 'resetNewTicket'
    'click #create_ticket': 'createNewTicket'
  
  initialize: ->
    @$el.html HandlebarsTemplates['houston/support_form/new_ticket']()
    @project = @options.project
    @tickets = new Tickets(@options.tickets)
    @renderSuggestion = HandlebarsTemplates['new_ticket/suggestion']
    @$suggestions = @$el.find('#ticket_suggestions > ol')
    @$summary = @$el.find('#ticket_summary')
    @lastSearch = ''
    Mousetrap.bindScoped '#ticket_summary, #ticket_description', 'mod+enter', (e)=>
      @$el.find('#create_ticket').click() if @$el.find(':focus').length > 0
  
  render: ->
    onTicketSummaryChange = _.bind(@onTicketSummaryChange, @)
    @$summary.keydown (e)=>
      if e.keyCode is 13
        e.preventDefault()
        @showNewTicket()
        $('#ticket_description').focus()
      if e.keyCode is 9
        e.preventDefault()
        @$summary.putCursorAtEnd()
    @$summary.keyup onTicketSummaryChange
    @$summary.change onTicketSummaryChange
    $('#ticket_description').focus =>
      @$el.attr('data-mode', 'description')
    
    view = @
    
    @$summary
      .attr('autocomplete', 'off')
      .focus()
      .putCursorAtEnd()
    @onTicketSummaryChange()
  
  
  onTicketSummaryChange: ->
    @nextSearch = @$summary.val()
    @updateSuggestions()
  
  updateSuggestions: ->
    unless @lastSearch is @nextSearch
      @$el.find('#ticket_summary_fill').html @nextSearch
      @lastSearch = @nextSearch
      if @nextSearch
        results = @tickets.search(@nextSearch)
        list = (@renderSuggestion(ticket.toJSON()) for ticket in results)
        $('#ticket_suggestions').show()
        @$suggestions.empty().append list
      else
        $('#ticket_suggestions').hide()
  
  
  
  resetNewTicket: (e)->
    e?.preventDefault()
    @$summary.val ''
    @$suggestions.empty()
    $('#ticket_description').val ''
    @hideNewTicket()
    @$summary.focus()
  
  createNewTicket: (e)->
    e?.preventDefault()
    attributes = @$el.serializeObject()
    attributes['ticket[summary]'] = '[bug] ' + attributes['ticket[summary]']
    $('#new_feedback_tags')
    @$el.disable()
    
    xhr = $.post "/projects/#{@project.slug}/tickets", attributes
    xhr.complete => @$el.enable()
    
    xhr.success (ticket)=>
      @tickets.push(ticket)
      @resetNewTicket()
      alertify.success "Ticket <a href=\"#{ticket.ticketUrl}\" target=\"_blank\">##{ticket.number}</a> was created"
      @$el.enable()
      @options.onCreate(ticket) if @options.onCreate
      $(document).trigger 'ticket:create', [ticket]
    
    xhr.error (response)=>
      errors = Errors.fromResponse(response)
      if errors.missingCredentials or errors.invalidCredentials
        App.promptForCredentialsTo @project.ticketTrackerName
      else if errors.oauthLocation
        App.oauth(errors.oauthLocation)
      else
        errors.renderToAlert()



  showNewTicket: (options)->
    options ?= {}
    animate = options.animate ? true
    $('#ticket_suggestions').hide()
    
    unless $('#ticket_description').val()
      $('#ticket_description').val(@BUG_DESCRIPTION)
    
    if animate
      $('.new-ticket-full').slideDown 200, ->
        $('#ticket_description').autosize()
    else
      $('.new-ticket-full').show()
      $('#ticket_description').autosize()

  hideNewTicket: ->
    $('.new-ticket-full').slideUp 200, =>
      @lastSearch = null
      @nextSearch = null
      @updateSuggestions()
