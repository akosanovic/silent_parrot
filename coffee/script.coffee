



class @SilentParrot
	constructor: () ->
		@websiteWindow = $(window)
		@mainWrapper   = $('.universe--wrapper')
		@pages         = @mainWrapper.find('.page')
		
		@mainWrapperPosition = @_getWrapperSize();

		@homePage    = new Page(@pages[0], this);
		@aboutUsPage = new Page(@pages[1], this);
		@randomPage  = new Page(@pages[2], this);
		@contactPage = new Page(@pages[3], this);
		


		@orderOfPages = [@homePage, @aboutUsPage, @randomPage, @contactPage]

		# Default Values
		@activePage = 
		@leftCounter = 0
		@mainWrapperTop  = 0

		@windowW = 0;
		@windowH = 0;

			


		# Event Binding
		# ON Load 
		@_onLoadHandler()

		# on resize
		@websiteWindow.on('resize', @_resizeHandler.bind(@))

		# on mouse scroll
		$(window).on('mousewheel DOMMouseScroll', @_scrollHandler.bind(@))



	_onLoadHandler:() ->
		@_getWindowDimensions()		
		@_setWrapperSize()
		@_getActivePage()
		@_getHash()




	_resizeHandler: () ->
		@_getWindowDimensions()
		@_setWrapperSize()
		

	
	_scrollHandler:(e) ->
		if (e.originalEvent.wheelDelta > 0 || e.originalEvent.detail < 0)
			console.log "Scrolled up"
			@_scrollUp()

		else 
			@_scrollDown()

			



	_getWindowDimensions: () ->
		@windowW = @websiteWindow.width()
		@windowH = @websiteWindow.height()


	_setWrapperSize: ()->
		@mainWrapper.css("width", @windowW*2)
		@mainWrapper.css("height", @windowH*2)



	_getWrapperSize: () ->
		wrapperSize = @mainWrapper[0].getBoundingClientRect();
		console.log "WRAPPER SIZE", wrapperSize
		return wrapperSize #top, bottom, left, right	






	_checkIfOverscroll: () ->
		
		top    = @mainWrapper[0].getBoundingClientRect().top
		right  = @mainWrapper[0].getBoundingClientRect().right
		bottom = @mainWrapper[0].getBoundingClientRect().bottom
		left   = @mainWrapper[0].getBoundingClientRect().left
		

		if(top > 0 ) 
			console.log "too high"
			return true
		else if (left > 0)
			console.log "too left"
			return true
		else if (right < 0)
			console.log "too right"
			return true
		else if (bottom < 0)
			console.log "too low"
			return true
		else 
			return false



	
	_scrollDown:() ->
		console.log "SCROLL DOWN"
				
		if @activePage.top() == 0 && @activePage.left() == 0
			@_goToNextActivePage()
			@_scrollDown()

		if !@_checkIfOverscroll()		
		
			TweenLite.to( @mainWrapper, 1, {
				left: "-#{@leftCounter}%",
				ease:   Power0.easeNone
			})


		# if @activePage.right() != 0 && @activePage.bottom != 0
		# 	TweenLite.to( @mainWrapper, 1, {
		# 		left: "-#{@leftCounter}%",
		# 		ease:   Power0.easeNone
		# 	})

		@leftCounter = @leftCounter + 20
			

		


	_goToNextActivePage: () ->

		for page, i in @orderOfPages
			if page == @activePage 
				if (i < @orderOfPages.length)
					@activePage = @orderOfPages[i+1]
					return @activePage
				else 
					@activePage = @orderOfPages[0]
					return @activePage



	

	_goToPrevActivePage: () ->
		for page, i in @orderOfPages
			if page == @activePage
				if (i > 0)
					@activePage = @orderOfPages[i-1]
					return @activePage
				else 
					i = @orderOfPages.length
					@activePage = @orderOfPages[i]

				



	_scrollUp:() ->
		@leftCounter = @leftCounter - 100
		# console.log "Scroll wrapper left"
		
		TweenLite.to( @mainWrapper, 0.3,  {
			y: @leftCounter,
			ease: Power1.easeInOut
		});



	_getActivePage: () ->
		for page in @orderOfPages
			if page.isActive()
				@_setHash(page)
				return page



	_setActivePage: (hash) ->
		console.log "Set active page based on hash"




	_setHash: (newActivePage) ->

		if @activePage != newActivePage
			@activePage = newActivePage

			window.location.hash = @activePage.getPageName()
		console.log "window location hash", window.location.hash

	

	_getHash: () ->
		hash = window.location.hash

		@_setActivePage(hash)






$ -> 
	silentParrot = new SilentParrot();
	
