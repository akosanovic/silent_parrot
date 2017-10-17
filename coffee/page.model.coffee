class @Page
	constructor: (htmlElement, hasAnimation) ->
		@mainContainer = $('.main--content--wrapper')

		@element = htmlElement
		@page    = $(htmlElement)
		@hasAnimation = hasAnimation;

		@pageAnimation = null;

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





	autoScrollToActivate: () ->
		pageTop = @top()
		pageLeft = @left()

		console.log "TOP ", pageTop
		console.log "left", pageLeft
		console.log "Main Container position ", @mainContainer[0].getBoundingClientRect()
		@_destroyAnimation();

		if pageTop > 0
			TweenLite.to( @mainContainer, 0.5, {
				top: -pageTop,
				ease: Power0.easeOut,
				onComplete: @_activateAnimation.bind(@)
			})

		else if pageTop < 0 
			TweenLite.to( @mainContainer, 0.5, {
				top:  0,
				ease: Power0.easeOut,
				onComplete: @_activateAnimation.bind(@)
			})

		else if pageLeft > 0 
			TweenLite.to( @mainContainer, 0.5, {
				left: -pageLeft,
				ease: Power0.easeOut,
				onComplete: @_activateAnimation.bind(@)
			})

		else if pageLeft < 0 
			TweenLite.to( @mainContainer, 0.5, {
				left: 0,
				ease: Power0.easeOut,
				onComplete: @_activateAnimation.bind(@)
			})

		


	_activateAnimation: () ->
		
		if (@hasAnimation)
			
			@pageAnimation = new PageAnimation();
			console.log "PAGE animation is #{@pageAnimation}"
			pa = @pageAnimation.lineAniamtion()
			pa.play()



	_destroyAnimation: () ->
		if (@pageAnimation)
			@pageAnimation.destroyAnimation();



		


	
