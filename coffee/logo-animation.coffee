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

		start      = TweenLite.to( @logoMain, 1, 
						{
							autoAlpha: 1,
							ease: Power0
						})
		
		sceneOne   = TweenLite.fromTo( @logoScene1, 1, 
						{ 
							autoAlpha: 1
						}, 
						{
							autoAlpha: 0,
							ease: Power1.easeOut
						});

		sceneTwo   = TweenLite.fromTo( @logoScene2, 1, 
			{ 
							autoAlpha: 1
						}, 
						{
							autoAlpha: 0,
							ease: Power1.easeOut
						});

		sceneThree = TweenLite.fromTo( @logoScene3, 1, { 
							autoAlpha: 1
						}, 
						{
							autoAlpha: 0,
							ease: Power1.easeOut
						});
		sceneFour = TweenLite.fromTo( @logoScene3, 1, { 
							autoAlpha: 1
						}, 
						{
							autoAlpha: 0,
							ease: Power1.easeOut
						});

		sceneFive = TweenLite.to (@logoMain, 1,
						{
							autoAlpha: 1;
						})

		
		
		

		logoTitmeline = new TimelineLite();

		
		logoTitmeline 
			.add(sceneFour)
			.add(sceneOne)
			.add(sceneTwo)
			.add(sceneThree)

		



