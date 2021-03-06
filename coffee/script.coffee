
class @SilentParrot
	constructor: () ->
		
		@websiteWindow = $(window)
		@mainWrapper   = $('.main--content--wrapper')
		@mainWrapperPosition = @_getWrapperSize();

		@navButtons = @mainWrapper.find('.nav--button')
		@logo  = @mainWrapper.find('.logo--main')
		@pages = @mainWrapper.find('.page')
		

		@homePage    = new Page(@pages[0], false, @mainWrapper);
		@aboutUsPage = new Page(@pages[1], true, @mainWrapper);
		@randomPage  = new Page(@pages[2], false, @mainWrapper);
		@contactPage = new Page(@pages[3], false, @mainWrapper);

		@orderOfPages = [@homePage, @aboutUsPage, @randomPage, @contactPage]


		# Default Values
		@activePage = @homePage

		@leftCounter    = 0
		@topCounter     = 0
		@mainWrapperTop = 0


		@windowW = 0;
		@windowH = 0;

		@scrollLeft  = 0 
		


		# Event Binding

		# load
		@_onLoadHandler()

		# hash change
		@websiteWindow.on('hashchange', @_hashHandler.bind(@))

		# resize
		@websiteWindow.on('resize', @_resizeHandler.bind(@))

		# mouse scroll
		@websiteWindow.on('mousewheel DOMMouseScroll', @_scrollHandler.bind(@))
		
		# click
		@mainWrapper.on('click', @_clickHandler.bind(@))		

		# hover
		$(@logo).on('mouseenter mouseleave', @_hoverHandler.bind(@))



	_onLoadHandler:() ->
		@_getWindowDimensions()		
		@_setWrapperSize()
		# @_getActivePage()
		@_getHash()




	_hashHandler: (e) ->
		
		newHash = window.location.hash
		newHash = newHash.replace(/#/g, '')
		
		if newHash != @activePage.getPageName
			newPage = @_findPageByName(newHash)
		




	_autoScrollToNewPage:(newActivePage) ->
		# scroll to new page
		# make page active
		newActivePage.autoScrollToActivate();





	_resizeHandler: () ->
		@_getWindowDimensions()
		@_setWrapperSize()





	_scrollHandler:(e) ->
		if (e.originalEvent.wheelDelta > 0 || e.originalEvent.detail < 0)
			@_scrollUp()
		else 
			@_scrollDown()




	_removeScrollHandler: () ->
		console.log "SCROLL handler removed "
		$(window).off('mousewheel DOMMouseScroll')
		
	_addScrollHandler: () ->
		console.log "scroll handler added"
		$(window).on('mousewheel DOMMouseScroll', @_scrollHandler.bind(@))




	_clickHandler: (e) ->
		$target = $(e.target)
		
		element = $target.closest(@navButtons)
		nameOfPageToActivate = null
		if (element.length > 0) 
			nameOfPageToActivate = $(element).find('a')[0].hash.replace('#', '')
			pageToActivate = @_findPageByName(nameOfPageToActivate)

			@_autoScrollToNewPage(pageToActivate)
			

			


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


	# _getActivePage: () ->
	# 	for page in @orderOfPages
	# 		if page.checkIfActive()
	# 			console.log "active page is ", page.getPageName()
	# 			return page


	_getHash: () ->
		hash = window.location.hash

		@_setActivePage(hash)


		
	



	_scrollToNextPage: () =>
		nextActivePage = @_goToNextActivePage()
		

		if !nextActivePage.checkIfActive()
			nextActivePage.mouseScrollToActivate()
			# console.log "Scroll To Next Page "
		else 
			@activePage = nextActivePage
			# console.log "next page is current active page"


	_scrollToPrevPage: () =>
		nextActivePage = @_goToPrevActivePage()

		if !nextActivePage.checkIfActive()
			nextActivePage.mouseScrollToActivate()
			# console.log "Scroll To Next Page "
		else 
			@activePage = nextActivePage
			# console.log "next page is current active page"



	_scrollCurrentPageTopTo0: () =>
		@activePage.scrollPageTopTo0()
				

	_scrollCurrentPageLeftTo0: () =>
		@activePage.scrollPageLeftTo0()




	_scrollDown:() ->
		currentPageTop  = @activePage.getPageTop()
		currentPageLeft = @activePage.getPageLeft()

		nextActivePage = @_goToNextActivePage()
		nextPageTop    = nextActivePage.getPageTop()
		nextPageLeft   = nextActivePage.getPageLeft()

		
		if currentPageTop == nextPageTop
			if currentPageTop == 0
				@_scrollToNextPage()
			else 
				@_scrollCurrentPageTopTo0()
				


		else if currentPageLeft == nextPageLeft
			if currentPageLeft == 0
				@_scrollToNextPage()
			else 
				@_scrollCurrentPageLeftTo0()




	_scrollUp:() ->

		nextActivePage = @_goToPrevActivePage()
		nextPageTop    = nextActivePage.getPageTop()
		nextPageLeft   = nextActivePage.getPageLeft()

		currentPageTop  = @activePage.getPageTop()
		currentPageLeft = @activePage.getPageLeft()

		


		if currentPageTop == nextPageTop

			if currentPageTop == 0
				@_scrollToPrevPage()
			else 
				@_scrollCurrentPageTopTo0()


		else if currentPageLeft == nextPageLeft
			if currentPageLeft == 0
				@_scrollToPrevPage()
			else
				@_scrollCurrentPageLeftTo0()
				


		




	_findPageByName: (pageName) ->
		for page in @orderOfPages
			if page.getPageName() == pageName
				return page




	_goToNextActivePage: () ->
		newActivePage = null
		
		for page, i in @orderOfPages
			if page == @activePage 
				if (i+1 < @orderOfPages.length)
					newActivePage = @orderOfPages[i+1]
				else 
					newActivePage = @orderOfPages[0]
				
		return newActivePage

	

	_goToPrevActivePage: () ->
		newActivePage = null
		
		for page, i in @orderOfPages
			if page == @activePage
				if (i >= 1)
					newActivePage = @orderOfPages[i-1]
					
				else 
					numOfPages = @orderOfPages.length - 1
					newActivePage = @orderOfPages[numOfPages]
		
		return newActivePage
			

	




	_setActivePage: (hash) ->
		console.log "Set active page based on hash"




	_setHash: (newActivePage) ->

		if @activePage != newActivePage
			@activePage = newActivePage

			window.location.hash = @activePage.getPageName()
		console.log "window location hash", window.location.hash

	







$ -> 
	silentParrot = new SilentParrot();
	
