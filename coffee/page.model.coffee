class @Page
	constructor: (htmlElement, parentContext) ->
		@element = htmlElement
		@page = $(htmlElement)

		@_setPageSize()

		$(window).on('resize', @_setPageSize.bind(@))



	_getWindowDimensions: () ->
		@windowW = $(window).width()
		@windowH = $(window).height()



	_setPageSize: () ->
		@_getWindowDimensions()

		@page.height(@windowH)
		@page.width(@windowW)


	top:() ->
		return @element.getBoundingClientRect().top
	
	bottom: () ->
		return @element.getBoundingClientRect().bottom

	left: () ->
		return @element.getBoundingClientRect().left

	right: ()->
		return @element.getBoundingClientRect().right


	isActive: () ->
		if @top() == 0 && @left() == 0
			return true;
		else 
			return false;


	getPageName: () ->
		name = @page.data('page-name')
		return String(name)


	getWidth: () ->
		@page.width()


	getHeight: () ->
		@page.height()






		


	
