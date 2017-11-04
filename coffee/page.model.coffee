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
		
		@scrollOffset = 400


		@_setPageSize()

		# value changes on each scroll - have to set observables/subscribe
		# Sub
		# @pageTop  = @getPageTop()
		# @pageLeft = @getPageLeft()

		$(window).on('resize', @_setPageSize.bind(@))




	_getWindowDimensions: () ->
		@windowW = $(window).width()
		@windowH = $(window).height()



	_setPageSize: () ->
		@_getWindowDimensions()

		@jqueryElment.height(@windowH)
		@jqueryElment.width(@windowW)
		@checkIfActive()


	getWidth: () ->
		@jqueryElment.width()


	getHeight: () ->
		@jqueryElment.height()



	_getMainContainerTop: () ->
		return @mainContainer[0].getBoundingClientRect().top

	_getMainContainerLeft: () ->
		return @mainContainer[0].getBoundingClientRect().left




	getPageTop: () ->
		return @htmlElement.getBoundingClientRect().top
	
	getPageBottom: () ->
		return @htmlElement.getBoundingClientRect().bottom

	getPageLeft: () ->
		return @htmlElement.getBoundingClientRect().left

	getPageRight: ()->
		return @htmlElement.getBoundingClientRect().right



	checkIfActive: () ->
		if @getPageTop() == 0 && @getPageLeft() == 0
			return true;
		else 
			return false;



	getPageName: () ->
		name = @jqueryElment.data('page-name')
		return String(name)


	





	autoScrollToActivate: () ->
		pageTop  = @getPageTop()
		pageLeft = @getPageLeft()

		console.log "Page Position ", @htmlElement.getBoundingClientRect()
		console.log "Main Container position ", @mainContainer[0].getBoundingClientRect()


		if pageTop > 0
			TweenLite.to( @mainContainer, 1, {
				top: -pageTop,
				ease: Power0.ease,
				onComplete: @_activateAnimation()
			})
			return;

		else if pageTop < 0 
			TweenLite.to( @mainContainer, 1, {
				top:  0,
				ease: Power0.ease,
				onComplete: @_activateAnimation()
			})
			return;

		else if pageLeft > 0 
			TweenLite.to( @mainContainer, 1, {
				left: -pageLeft,
				ease: Power0.ease,
				onComplete: @_activateAnimation()
			})
			return;

		else if pageLeft < 0 
			TweenLite.to( @mainContainer, 1, {
				left: 0,
				ease: Power0.ease,
				onComplete: @_activateAnimation()
			})
			return;




	mouseScrollToActivate: () ->
		mainContainerTop  = @_getMainContainerTop()
		mainContainerLeft = @_getMainContainerLeft()
		
		pageTop  = @getPageTop()
		pageLeft = @getPageLeft()


		console.log "Better solution for page animation trigger"
		if pageTop == 0 & pageLeft == 0 & @hasAnimation
			@isActivePage = true
			@_activateAnimation()
		
		else if pageTop == 0 & pageLeft == 0 & !@hasAnimation
			@isActivePage = true;



		if pageLeft != 0 
			mainContainerLeft = @_getMainContainerLeft()

			if pageLeft >= @scrollOffset
				mainContainerLeft = mainContainerLeft - @scrollOffset

			else if pageLeft > 0
				mainContainerLeft = mainContainerLeft - pageLeft

			else if pageLeft <= -@scrollOffset
				mainContainerLeft = mainContainerLeft + @scrollOffset

			else if pageLeft < 0
				mainContainerLeft = mainContainerLeft + (-pageLeft)

			@mouseScrollAnimation( 'left', mainContainerLeft )



		else if pageTop !=0
			mainContainerTop = @_getMainContainerTop()

			if pageTop >= @scrollOffset
				mainContainerTop = mainContainerTop - @scrollOffset


			else if pageTop > 0
				mainContainerTop = mainContainerTop - pageTop
			

			else if pageTop <= -@scrollOffset
				mainContainerTop = mainContainerTop + @scrollOffset

			else
				mainContainerTop = mainContainerTop + (-pageTop)
			
			@mouseScrollAnimation( 'top', mainContainerTop )
	


	scrollPageTopTo0: () ->
		mainContainerTop = @_getMainContainerTop()
		pageTop = @getPageTop()

		
		if pageTop > @scrollOffset			
			mainContainerTop = mainContainerTop - @scrollOffset

		else if pageTop > 0
			mainContainerTop = mainContainerTop - pageTop

		else if pageTop < -@scrollOffset
			mainContainerTop = mainContainerTop + @scrollOffset

		else if pageTop < 0
			mainContainerTop = mainContainerTop + (-pageTop)
		
		@mouseScrollAnimation( 'top', mainContainerTop )



	scrollPageLeftTo0: () ->
		mainContainerLeft = @_getMainContainerLeft()
		pageLeft = @getPageLeft()


		
		if pageLeft > @scrollOffset			
			mainContainerLeft = mainContainerLeft - @scrollOffset

		else if pageLeft > 0
			mainContainerLeft = mainContainerLeft - pageLeft

		else if pageLeft < -@scrollOffset
			mainContainerLeft = mainContainerLeft + @scrollOffset

		else if pageLeft < 0
			mainContainerLeft = mainContainerLeft + (-pageLeft)

		@mouseScrollAnimation( 'left', mainContainerLeft )




	mouseScrollAnimation: ( position, amount ) ->
		scrollPosition = position
		scrollAmount   = amount
		
		if scrollPosition == 'left'

			TweenLite.to( @mainContainer, 1, {
				left: scrollAmount,
				ease: Power0.ease,
				# onComplete: @_activateAnimation()
			})


		else if scrollPosition == 'top'

			TweenLite.to( @mainContainer, 1, {
				top: scrollAmount,
				ease: Power0.ease,
				# onComplete: @_activateAnimation()
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



		


	
