



class @SilentParrot
	constructor: () ->
		@websiteWindow = $(window)
		@mainWrapper   = $('.universe--wrapper')
		@pages         = @mainWrapper.find('.page')

		@mainWrapperPosition = @_getWrapperSize();

		@homePage    = @mainWrapper.find('.home--page')
		@aboutUsPage = @mainWrapper.find('.about--us--page')
		@randomPage  = @mainWrapper.find('.random--page');
		@contactPage = @mainWrapper.find('.contact--page')

		@orderOfPages = [@homePage, @aboutUsPage, @randomPage, @contactPage]

		# Default Values
		@activePage = 'home'
		@leftCounter = 0
		@mainWrapperTop  = 0


	


		# Event Binding
		# ON Load 
		@_pageSize()
		

		@websiteWindow.on('resize', @_pageSize.bind(@))

		$(window).on('mousewheel DOMMouseScroll', @_scrollEventHandler.bind(@))


	_pageSize: () ->
		# Automatically set page size on resize
		windowW = @websiteWindow.width()
		windowH = @websiteWindow.height()
		
		for page in @pages 
			page = $(page)
			
			page.height(windowH)
			page.width(windowW)
			return {windowW, windowH}
			


	_getWrapperSize: () ->
		elementPosition = @mainWrapper[0].getBoundingClientRect();
		# console.log('Main Wrapper position, ', elementPosition)

		return elementPosition #top, bottom, left, right




	

	_scrollEventHandler:(e) ->
		@mainWrapperPosition = @_getWrapperSize();
		@_getActivePage()

		if (e.originalEvent.wheelDelta > 0 || e.originalEvent.detail < 0)
			console.log "Scrolled up"
			@_scrollWrapperLeft()

		else 
			@_scrollWrapperRight()

			# console.log "scrolled down"




	_checkIfOverscroll: () ->
		height = @homePage.height

		top    = @mainWrapper[0].getBoundingClientRect().top
		right  = @mainWrapper[0].getBoundingClientRect().right
		bottom = @mainWrapper[0].getBoundingClientRect().bottom
		left   = @mainWrapper[0].getBoundingClientRect().left

		console.log "TOP, ", top, "\nRIGHT: ", right, "\nBOTTOM: ", bottom, "\nLEFT: ", left

		if(top < (-height)) 
			console.log "too high"
			return false



	
	_scrollWrapperRight:() ->
		@_checkIfOverscroll()


		@leftCounter = @leftCounter + 10
		console.log "Main Wrapper Left", @leftCounter
		console.log "Main Wrapper Left", @mainWrapper[0].getBoundingClientRect().right

		if @leftCounter <= 100
			TweenLite.to(@mainWrapper, 1, {
				left: "-#{@leftCounter}%",
				ease:   Power0.easeNone
			})
			
		else if (@leftCounter >= 100 && @leftCounter <= 200)
			TweenLite.to(@mainWrapper, 1, {
				top: "-#{@leftCounter-100}%",
				ease:  Power0.easeNone
			})

		else if (@leftCounter >= 200 && @leftCounter <= 300)
			TweenLite.to(@mainWrapper, 1, {
				left: "#{@leftCounter-300}%",
				ease:  Power0.easeNone
			})

		else if (@leftCounter >= 300 && @leftCounter <= 400)
			TweenLite.to(@mainWrapper, 1, {
				top: "#{@leftCounter-400}%",
				ease:  Power0.easeNone
			})
			
		else
			@leftCounter = 0;



	_scrollWrapperLeft:() ->
		@leftCounter = @leftCounter - 100
		# console.log "Scroll wrapper left"
		
		TweenLite.to( @mainWrapper, 0.3,  {
			y: @leftCounter,
			ease: Power1.easeInOut
		});



	_getActivePage: () ->

		height = @websiteWindow.height()
		width  = @websiteWindow.width()

		for page in @orderOfPages
			position = page[0].getBoundingClientRect()
			
			if (position.top >= 0 && position.top <= height / 2 ) && (position.left >= 0 && position.left <= width / 2) 
				name = $(page).data('page-name')
				@_setUrl(name)


	
	_setUrl: (newActivePage) ->
		console.log "NEW active page", newActivePage
		if @activePage != newActivePage
			@activePage = newActivePage

			window.location.hash = @activePage





$ -> 
	silentParrot = new SilentParrot();
	
