class @GlobalAnimation
	constructor: () ->
		@mainWrapper = $('.main--wrapper')
		
		@universeWrapper = @mainWrapper.find('.universe--wrapper')

		@homePage    = @mainWrapper.find('.home--page')
		@aboutUsPage = @mainWrapper.find('.about--us--page')
		@randomPage  = @mainWrapper.find('.random--page');
		@contactPage = @mainWrapper.find('.contact--page')

		@_onPageLoad()


	

	_onPageLoad: () ->


		controler = new ScrollMagic.Controller(
			# container: @universeWrapper;
			vertical: false # horizontal scrolling
		);
		

		scene1 = new ScrollMagic.Scene({
				triggerElement: @aboutUsPage
		})
		.on('start', ()->
			window.location.hash = 'aboutUs'
			console.log ('ayooo')
			)
		.addTo(controler)
		


		scene2 = new ScrollMagic.Scene({
				triggerElement: @randomPage
		})
		.on('enter', ()->
			console.log ("Triggered first")
		)
		.addTo(controler)

	_aboutUsAnimation: () ->
		



$ ->
	animation = new GlobalAnimation();
