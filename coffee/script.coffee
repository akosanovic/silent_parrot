
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



		@logo = @mainWrapper.find('.logo--main')
		# Default Values
		@activePage = @homePage
		@leftCounter = 0
		@topCounter  = 0
		@mainWrapperTop  = 0

		@windowW = 0;
		@windowH = 0;

			


		# Event Binding

		# load
		@_onLoadHandler()

		# hash change
		$(window).on('hashchange', @_hashHandler.bind(@))

		# resize
		@websiteWindow.on('resize', @_resizeHandler.bind(@))

		# mouse scroll
		$(window).on('mousewheel DOMMouseScroll', @_scrollHandler.bind(@))

		# hover
		$(@logo).on('mouseenter mouseleave', @_hoverHandler.bind(@))



	_onLoadHandler:() ->
		@_getWindowDimensions()		
		@_setWrapperSize()
		@_getActivePage()
		@_getHash()


	_hashHandler: (e) ->
		
		newHash = window.location.hash
		newHash = newHash.replace(/#/g, '')

		# if newHash != @activePage.getPageName
		# 	@_goToNextPageAutomatically(newHash)

		# else 
		# 	console.log "page not changed"


	_resizeHandler: () ->
		@_getWindowDimensions()
		@_setWrapperSize()



	_scrollHandler:(e) ->
		if (e.originalEvent.wheelDelta > 0 || e.originalEvent.detail < 0)
			console.log "Scrolled up"
			@_scrollUp()

		else 
			@_scrollDown()



	_removeScrollHandler: () ->
		console.log "SCROLL handler removed "
		$(window).off('mousewheel DOMMouseScroll')
		

	_addScrollHandler: () ->
		console.log "scroll handler added"
		$(window).on('mousewheel DOMMouseScroll', @_scrollHandler.bind(@))



	_hoverHandler: () ->
		logoAnimation = new LogoAnimation()
		logoAnimation.mouseInAnimation()




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


	_getActivePage: () ->
		for page in @orderOfPages
			if page.isActive()
				@_setHash(page)
				return page


	_getHash: () ->
		hash = window.location.hash

		@_setActivePage(hash)






########################
#	change this section
	_goToNextPageAutomatically: (newActivePage) ->
		oldActivePage = @activePage
		if newActivePage == "aboutUs"
		
			for page in @orderOfPages

				if page.getPageName() == newActivePage
					@activePage = page
					@_scrollRight(oldActivePage, newActivePage)
					# @_scrollToNextPage(oldActivePage, @activePage)



		else if newActivePage == "contact"
			for page in @orderOfPages 
				if page.getPageName() == newActivePage
					@activePage = page
					@_scrollBottom(oldActivePage, newActivePage)
					

	_scrollRight: (oldPage, newPage) ->
		scrollRight = oldPage.getWidth()

		scrollToNextPage = TweenLite.to(@mainWrapper, 2.5, {
			x: -scrollRight,
			ease: Power1.easeOut
		})

	_scrollBottom: (oldPage, newPage) ->
		scrollBottom = oldPage.getHeight()

		scrollToNextPage = TweenLite.to(@mainWrapper, 2.5, {
			y: -scrollBottom,
			ease: Power1.easeOut
		})


##############################







	
	_scrollDown:() ->
		activePageName = @activePage.getPageName()
		console.log "active page is ", @activePage
		mainWrapperPosition = @mainWrapper[0].getBoundingClientRect()


		if activePageName == 'home'
			
			@leftCounter = @leftCounter + 20

			if @leftCounter <= 100
				TweenLite.to( @mainWrapper, 0.4, {
					left: "-#{@leftCounter}%",
					ease:   Power0.easeOut,
					onStart   : @_removeScrollHandler.bind(@),
					onComplete: @_addScrollHandler.bind(@)
				})
			
			else 
				console.log "Go to next page activated"
				@leftCounter = 100

				TweenLite.to( @mainWrapper, 0.4, {
					left: "-#{@leftCounter}%",
					top: 0,
					ease:   Power0.easeOut,
					onComplete: @_goToNextActivePage.bind(@)
				})

		if activePageName == 'aboutUs'

			@topCounter = @topCounter + 20
			
			if @topCounter <= 100
				TweenLite.to( @mainWrapper, 0.4, {
					top: "-#{@topCounter}%",
					ease: Power0.easeOut,
					onStart   : @_removeScrollHandler.bind(@),
					onComplete: @_addScrollHandler.bind(@)
				})

			else 
				@topCounter = 100
				TweenLite.to( @mainWrapper, 0.4, {
					left: "-#{@leftCounter}%",
					top : "-#{@topCounter}%",
					ease:   Power0.easeNone,
					onComplete: @_goToNextActivePage.bind(@)
				})
				


		if activePageName == 'random'
			
			@leftCounter = @leftCounter - 20
			
			if @leftCounter >= 0
				TweenLite.to( @mainWrapper, 0.4, {
					left: "-#{@leftCounter}%",
					ease:  Power0.easeOut,
					onStart   : @_removeScrollHandler.bind(@),
					onComplete: @_addScrollHandler.bind(@)
				})
				
			
			else 
				@leftCounter = 0
				TweenLite.to( @mainWrapper, 0.4, {
					left: @leftCounter,
					top : "-#{@topCounter}%",
					ease:  Power0.easeNone,
					onComplete: @_goToNextActivePage.bind(@)
				})



		if activePageName == 'contact'
			
			@topCounter = @topCounter - 20

			if @topCounter >= 0				
				TweenLite.to( @mainWrapper, 0.4, {
					top: "-#{@topCounter}%",
					ease: Power0.easeNone
					onStart   : @_removeScrollHandler.bind(@),
					onComplete: @_addScrollHandler.bind(@)
				})
			
			else 
				# Home Page
				@topCounter = 0;
				TweenLite.to( @mainWrapper, 0.4, {
					left: 0,
					top : 0,
					ease:   Power0.easeNone,
					onComplete: @_goToNextActivePage.bind(@)
				})

		

	_scrollUp:() ->
		activePageName = @activePage.getPageName()
		mainWrapperPosition = @mainWrapper[0].getBoundingClientRect()


		if activePageName == 'home'
			
			@leftCounter = @leftCounter - 20
			
			if @leftCounter > 0
				TweenLite.to( @mainWrapper, 0.4, {
					left: "-#{@leftCounter}%",
					ease:  Power0.easeOut,
					onStart   : @_removeScrollHandler.bind(@),
					onComplete: @_addScrollHandler.bind(@)
				})
			
			else 
				@leftCounter = 0

				TweenLite.to( @mainWrapper, 0.4, {
					left: 0,
					top: 0,
					ease:   Power0.easeNone,
					onComplete: @_goToPrevActivePage.bind(@)
				})



		if activePageName == 'aboutUs'

			@topCounter = @topCounter - 20

			if @topCounter > 0
				
				TweenLite.to( @mainWrapper, 0.4, {
					top: "-#{@topCounter}%",
					ease: Power0.easeNone,
					onStart   : @_removeScrollHandler.bind(@),
					onComplete: @_addScrollHandler.bind(@)
				})
			else 
				@topCounter = 0
				
				TweenLite.to( @mainWrapper, 0.4, {
					left: "-#{@leftCounter}%",
					top : "-#{@topCounter}%",
					ease:   Power0.easeNone,
					onComplete: @_goToPrevActivePage.bind(@)
				})
				


		if activePageName == 'random'
	
			@leftCounter = @leftCounter + 20

			if @leftCounter < 100
				
				TweenLite.to( @mainWrapper, 0.4, {
					left: "-#{@leftCounter}%",
					ease:   Power0.easeNone,
					onStart   : @_removeScrollHandler.bind(@),
					onComplete: @_addScrollHandler.bind(@)
				})
			
			else 
				@leftCounter = 100;

				TweenLite.to( @mainWrapper, 0.4, {
					left: "-#{@leftCounter}%",
					top : "-#{@topCounter}%",
					ease:  Power0.easeNone,
					onComplete: @_goToPrevActivePage.bind(@)
				})



		if activePageName == 'contact'
			
			@topCounter = @topCounter + 20
			console.log "TOP COuNTER is ", @topCounter
			
			if @topCounter < 100
				
				TweenLite.to( @mainWrapper, 0.4, {
					top: "-#{@topCounter}%",
					ease:   Power0.easeNone,
					onStart   : @_removeScrollHandler.bind(@),
					onComplete: @_addScrollHandler.bind(@)
				})

			
			else 
				@topCounter = 100;

				TweenLite.to( @mainWrapper, 0.4, {
					left: 0,
					top : "-#{@topCounter}%",
					ease:   Power0.easeNone,
					onComplete: @_goToPrevActivePage.bind(@)
				})
				
				







	_goToNextActivePage: () ->
		# set the correct url
		newActivePage = null
		for page, i in @orderOfPages

			if page == @activePage 
				if (i+1 < @orderOfPages.length)
					newActivePage = @orderOfPages[i+1]
					
				else 
					newActivePage = @orderOfPages[0]
					

		if newActivePage
			@_setHash(newActivePage)
				
	

	_goToPrevActivePage: () ->

		newActivePage = null
		
		for page, i in @orderOfPages
			if page == @activePage
				if (i >= 1)
					newActivePage = @orderOfPages[i-1]
					
				else 
					numOfPages = @orderOfPages.length - 1
					newActivePage = @orderOfPages[numOfPages]
		if newActivePage
			@_setHash(newActivePage)

			

	




	_setActivePage: (hash) ->
		console.log "Set active page based on hash"




	_setHash: (newActivePage) ->

		if @activePage != newActivePage
			@activePage = newActivePage

			window.location.hash = @activePage.getPageName()
		console.log "window location hash", window.location.hash

	







$ -> 
	silentParrot = new SilentParrot();
	
