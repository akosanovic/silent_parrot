class @PageAnimation

	constructor: () ->
		@mainContainer = $('.main--content--wrapper');
		
		@aboutUsPage   = @mainContainer.find('.aboutUs--page');
		
		
		@animatedLineH = null;
		@animatedLineV = null;
		@lineAnimationTimeline = null;

	destroyAnimation: () ->
		@animatedLineH = null;
		@animatedLineV = null;
		

		@lineAnimationTimeline.clear();
		@lineAnimationTimeline.kill();
		@lineAnimationTimeline = null;
		
	lineAniamtion: () ->
		@animatedLineH  = @mainContainer.find('.animated--line--horizontal');
		@animatedLineV  = @mainContainer.find('.animated--line--vertical');
		
		horizontalLineDuration = 0.5



		@lineAnimationTimeline = new TimelineLite(
			{
				paused: true,
				onComplete: "ayoo"
			}
		);

		@lineAnimationTimeline
			.set( @animatedLineH, {left: '100%', top: '50%', height: '3px', width: 0})
			.set( @animatedLineV, {left: "100%", left: "60%"})
			
			.add( "horizontalLine" )
			.fromTo( @animatedLineH, 0.7, 
				{ width: 0}, { width: '30%', left: "50%", ease: Power1.easeOut })

			
			.add( "verticalLine" )
			.fromTo( @animatedLineV, 0.7,
					{left: "100%"}, { left: "50%", ease: Power1.easeOut }, "horizontalLine" )
			.fromTo( @animatedLineV, 0.8, 
					{height: 0}, {height: "60%"}, "horizontalLine+=0.2")


			.to( @animatedLineH, 0.3, { width: 0, left: "50%", ease: Power1.easeOut }, "verticalLine" )
			.set( @animatedLineV, {left: "50%", height: '60%',} )


		
		return @lineAnimationTimeline
		
	


