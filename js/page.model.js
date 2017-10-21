// Generated by CoffeeScript 1.9.3
(function() {
  this.Page = (function() {
    Page.pageAnimation = null;

    Page.pageName = null;

    function Page(htmlElement, hasAnimation) {
      this.mainContainer = $('.main--content--wrapper');
      this.htmlElement = htmlElement;
      this.jqueryElment = $(htmlElement);
      this.hasAnimation = hasAnimation;
      this.pageName = this.getPageName();
      this._setPageSize();
      $(window).on('resize', this._setPageSize.bind(this));
    }

    Page.prototype._getWindowDimensions = function() {
      this.windowW = $(window).width();
      return this.windowH = $(window).height();
    };

    Page.prototype._setPageSize = function() {
      this._getWindowDimensions();
      this.jqueryElment.height(this.windowH);
      this.jqueryElment.width(this.windowW);
      return this.checkIfActive();
    };

    Page.prototype.top = function() {
      return this.htmlElement.getBoundingClientRect().top;
    };

    Page.prototype.bottom = function() {
      return this.htmlElement.getBoundingClientRect().bottom;
    };

    Page.prototype.left = function() {
      return this.htmlElement.getBoundingClientRect().left;
    };

    Page.prototype.right = function() {
      return this.htmlElement.getBoundingClientRect().right;
    };

    Page.prototype.checkIfActive = function() {
      if (this.top() === 0 && this.left() === 0) {
        return true;
      } else {
        return false;
      }
    };

    Page.prototype.getPageName = function() {
      var name;
      name = this.jqueryElment.data('page-name');
      return String(name);
    };

    Page.prototype.getWidth = function() {
      return this.jqueryElment.width();
    };

    Page.prototype.getHeight = function() {
      return this.jqueryElment.height();
    };

    Page.prototype.autoScrollToActivate = function() {
      var pageLeft, pageTop;
      pageTop = this.top();
      pageLeft = this.left();
      console.log("Page Position ", this.htmlElement.getBoundingClientRect());
      console.log("Main Container position ", this.mainContainer[0].getBoundingClientRect());
      if (pageTop > 0) {
        return TweenLite.to(this.mainContainer, 0.5, {
          top: -pageTop,
          ease: Power0.easeOut,
          onComplete: this._activateAnimation.bind(this)
        });
      } else if (pageTop < 0) {
        return TweenLite.to(this.mainContainer, 0.5, {
          top: 0,
          ease: Power0.easeOut,
          onComplete: this._activateAnimation.bind(this)
        });
      } else if (pageLeft > 0) {
        return TweenLite.to(this.mainContainer, 0.5, {
          left: -pageLeft,
          ease: Power0.easeOut,
          onComplete: this._activateAnimation.bind(this)
        });
      } else if (pageLeft < 0) {
        return TweenLite.to(this.mainContainer, 0.5, {
          left: 0,
          ease: Power0.easeOut,
          onComplete: this._activateAnimation.bind(this)
        });
      }
    };

    Page.prototype.scrollToActivate = function() {
      var mainContainerLeft, mainContainerTop, pageLeft, pageTop, scrollOffset;
      mainContainerTop = this.mainContainer[0].getBoundingClientRect().top;
      mainContainerLeft = this.mainContainer[0].getBoundingClientRect().left;
      scrollOffset = 200;
      console.log("main container top", this.mainContainer);
      pageTop = this.top();
      pageLeft = this.left();
      if (pageTop === 0 & pageLeft === 0 & this.hasAnimation) {
        this._activateAnimation();
      }
      if (pageTop >= scrollOffset) {
        mainContainerTop = mainContainerTop - scrollOffset;
        this.mainContainer.css('top', mainContainerTop);
      } else if (pageTop > 0) {
        mainContainerTop = mainContainerTop - pageTop;
        this.mainContainer.css('top', mainContainerTop);
      }
      if (pageLeft >= scrollOffset) {
        mainContainerLeft = mainContainerLeft - scrollOffset;
        return this.mainContainer.css('left', mainContainerLeft);
      } else if (pageLeft > 0) {
        mainContainerLeft = mainContainerLeft - pageLeft;
        return this.mainContainer.css('left', mainContainerLeft);
      }
    };

    Page.prototype._activateAnimation = function() {
      var pa;
      if (this.hasAnimation) {
        this.pageAnimation = new PageAnimation();
        console.log("PAGE animation is " + this.pageAnimation);
        pa = this.pageAnimation.lineAniamtion();
        return pa.play();
      }
    };

    Page.prototype._destroyAnimation = function() {
      if (this.pageAnimation) {
        return this.pageAnimation.destroyAnimation();
      }
    };

    return Page;

  })();

}).call(this);
