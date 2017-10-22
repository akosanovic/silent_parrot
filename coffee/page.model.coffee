class @Page
	@pageAnimation = null;
	@pageName      = null;
	

	constructor: (htmlElement, hasAnimation) ->
		@mainContainer = $('.main--content--wrapper')

		@htmlElement  = htmlElement
		@jqueryElment = $(htmlElement)
		@hasAnimation = hasAnimation;
		@pageName     = @getPageName();
		@isActivePage = false;
		


		@_setPageSize()

		$(window).on('resize', @_setPageSize.bind(@))




	_getWindowDimensions: () ->
		@windowW = $(window).width()
		@windowH = $(window).height()



	_setPageSize: () ->
		@_getWindowDimensions()

		@jqueryElment.height(@windowH)
		@jqueryElment.width(@windowW)
		@checkIfActive()


	top:() ->
		return @htmlElement.getBoundingClientRect().top
	
	bottom: () ->
		return @htmlElement.getBoundingClientRect().bottom

	left: () ->
		return @htmlElement.getBoundingClientRect().left

	right: ()->
		return @htmlElement.getBoundingClientRect().right





	checkIfActive: () ->
		if @top() == 0 && @left() == 0
			return true;
		else 
			return false;



	getPageName: () ->
		name = @jqueryElment.data('page-name')
		return String(name)


	getWidth: () ->
		@jqueryElment.width()


	getHeight: () ->
		@jqueryElment.height()





	autoScrollToActivate: () ->
		pageTop  = @top()
		pageLeft = @left()

		console.log "Page Position ", @htmlElement.getBoundingClientRect()
		console.log "Main Container position ", @mainContainer[0].getBoundingClientRect()

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




	scrollToActivate: () ->
		mainContainerTop = @mainContainer[0].getBoundingClientRect().top
		mainContainerLeft = @mainContainer[0].getBoundingClientRect().left

		scrollOffset = 200

		console.log "main container top", @mainContainer

		pageTop  = @top()
		pageLeft = @left()

		
		if pageTop == 0 & pageLeft == 0 & @hasAnimation
			console.log "Page is active ", @pageName
			@_activateAnimation()
			@isActivePage = true;



		if pageTop >= scrollOffset
			mainContainerTop = mainContainerTop - scrollOffset
			@mainContainer.css('top', mainContainerTop)
		
		else if pageTop > 0
			mainContainerTop = mainContainerTop - pageTop
			@mainContainer.css('top', mainContainerTop)
		
		
		if pageLeft >= scrollOffset
			mainContainerLeft = mainContainerLeft - scrollOffset
			@mainContainer.css('left', mainContainerLeft)

		else if pageLeft > 0
			mainContainerLeft = mainContainerLeft - pageLeft
			@mainContainer.css('left', mainContainerLeft)


		


	_activateAnimation: () ->
		
		if (@hasAnimation)
			
			@pageAnimation = new PageAnimation();
			console.log "PAGE animation is #{@pageAnimation}"
			pa = @pageAnimation.lineAniamtion()
			pa.play()



	_destroyAnimation: () ->
		if (@pageAnimation)
			@pageAnimation.destroyAnimation();



		


	
