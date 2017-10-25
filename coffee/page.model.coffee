class @Page

	@pageAnimation = null;
	@pageName      = null;	

	constructor: (htmlElement, hasAnimation, parentContainer) ->
		@mainContainer = parentContainer

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
			TweenLite.to( @mainContainer, 1, {
				top: -pageTop,
				ease: Power0.easeNone,
				onComplete: @_activateAnimation()
			})
			return;

		else if pageTop < 0 
			TweenLite.to( @mainContainer, 1, {
				top:  0,
				ease: Power0.easeNone,
				onComplete: @_activateAnimation()
			})
			return;

		else if pageLeft > 0 
			TweenLite.to( @mainContainer, 1, {
				left: -pageLeft,
				ease: Power0.easeNone,
				onComplete: @_activateAnimation()
			})
			return;

		else if pageLeft < 0 
			TweenLite.to( @mainContainer, 1, {
				left: 0,
				ease: Power0.easeNone,
				onComplete: @_activateAnimation()
			})
			return;




	mouseScrollToActivate: () ->
		mainContainerTop  = @mainContainer[0].getBoundingClientRect().top
		mainContainerLeft = @mainContainer[0].getBoundingClientRect().left

		scrollOffset = 200
		pageTop  = @top()
		pageLeft = @left()


		console.log "Better solution for page animation trigger"
		if pageTop == 0 & pageLeft == 0 & @hasAnimation
			@isActivePage = true
			@_activateAnimation()
		
		else if pageTop == 0 & pageLeft == 0 & !@hasAnimation
			@isActivePage = true;



		
		if pageLeft >= scrollOffset
			mainContainerLeft = mainContainerLeft - scrollOffset
			@mainContainer.css('left', mainContainerLeft)

		else if pageLeft > 0
			mainContainerLeft = mainContainerLeft - pageLeft
			@mainContainer.css('left', mainContainerLeft)


		else if pageTop >= scrollOffset
			mainContainerTop = mainContainerTop - scrollOffset
			@mainContainer.css('top', mainContainerTop)
		
		else if pageTop > 0
			mainContainerTop = mainContainerTop - pageTop
			@mainContainer.css('top', mainContainerTop)
	

		else if pageLeft <= -scrollOffset
			mainContainerLeft = mainContainerLeft + scrollOffset
			@mainContainer.css('left', mainContainerLeft)

		else if pageLeft < 0
			mainContainerLeft = mainContainerLeft + (-pageLeft)
			@mainContainer.css('left', mainContainerLeft)

		else if pageTop <= -scrollOffset
			mainContainerTop = mainContainerTop + scrollOffset
			@mainContainer.css('top', mainContainerTop)

		else
			mainContainerTop = mainContainerTop + (-pageTop)
			@mainContainer.css('top', mainContainerTop)

		


	_activateAnimation: () ->
		
		if (@hasAnimation)
			@pageAnimation = new PageAnimation();
			console.log "PAGE animation is #{@pageAnimation}"
			pa = @pageAnimation.lineAniamtion()
			pa.play()



	_destroyAnimation: () ->
		if (@pageAnimation)
			@pageAnimation.destroyAnimation();



		


	
