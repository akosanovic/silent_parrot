class @LogoAnimation
	constructor: () ->
		console.log "ayoooo"
		@logoContainer = $('.logo--container')
		@logoMain = @logoContainer.find('.logo--main')
		@logoScene1 = @logoContainer.find('.logo--scene--1')
		@logoScene2 = @logoContainer.find('.logo--scene--2')
		@logoScene3 = @logoContainer.find('.logo--scene--3')
		@logoScene4 = @logoContainer.find('.logo--scene--4')

		console.log "Logo Container", @logoContainer

		
	

	mouseInAnimation: ()->
		
		console.log "WHY YOU NO WORK?"

	
		
		

		logoTitmeline = new TimelineLite(
				
						
			onComplete: (e) ->
				logoTitmeline.reverse()
				animationOn = false;
		);

		
		logoTitmeline 
			.fromTo( @logoMain, 0.1, { opacity: "0.72", visibility: "visible" },
									{ opacity: "0", visibility: "hidden",  ease: Power1.easeOut }, '=-0.025')

			.fromTo( @logoScene1, 0.1, { opacity: "0.79", visibility: "visible" },
									{ opacity: "0", visibility: "hidden",  ease: Power1.easeOut }, '=-0.025')

			.fromTo( @logoScene2, 0.1, { opacity: "0.79", visibility: "visible" },
									{ opacity: "0", visibility: "hidden",  ease: Power1.easeOut }, '=-0.025')

			.fromTo( @logoScene3, 0.1, { opacity: "0.86", visibility: "visible" },
										{ opacity: "0", visibility: "hidden",  ease: Power1.easeOut }, '=-0.025')

			.fromTo( @logoScene4, 0.1, { opacity: "0.72", visibility: "visible" },
									{ opacity: "0.3", visibility: "visible",  ease: Power1.easeOut }, '=-0.025' )





			


		



