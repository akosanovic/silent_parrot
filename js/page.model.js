// Generated by CoffeeScript 1.9.3
(function() {
  this.Page = (function() {
    Page.pageAnimation = null;

    Page.pageName = null;

    function Page(htmlElement, hasAnimation, parentContainer) {
      this.mainContainer = parentContainer;
      this.htmlElement = htmlElement;
      this.jqueryElment = $(htmlElement);
      this.hasAnimation = hasAnimation;
      this.pageName = this.getPageName();
      this.isActivePage = false;
      this.scrollOffset = 200;
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

    Page.prototype.getWidth = function() {
      return this.jqueryElment.width();
    };

    Page.prototype.getHeight = function() {
      return this.jqueryElment.height();
    };

    Page.prototype._getMainContainerTop = function() {
      return this.mainContainer[0].getBoundingClientRect().top;
    };

    Page.prototype._getMainContainerLeft = function() {
      return this.mainContainer[0].getBoundingClientRect().left;
    };

    Page.prototype.getPageTop = function() {
      return this.htmlElement.getBoundingClientRect().top;
    };

    Page.prototype.getPageBottom = function() {
      return this.htmlElement.getBoundingClientRect().bottom;
    };

    Page.prototype.getPageLeft = function() {
      return this.htmlElement.getBoundingClientRect().left;
    };

    Page.prototype.getPageRight = function() {
      return this.htmlElement.getBoundingClientRect().right;
    };

    Page.prototype.checkIfActive = function() {
      if (this.getPageTop() === 0 && this.getPageLeft() === 0) {
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

    Page.prototype.autoScrollToActivate = function() {
      var pageLeft, pageTop;
      pageTop = this.getPageTop();
      pageLeft = this.getPageLeft();
      console.log("Page Position ", this.htmlElement.getBoundingClientRect());
      console.log("Main Container position ", this.mainContainer[0].getBoundingClientRect());
      if (pageTop > 0) {
        TweenLite.to(this.mainContainer, 1, {
          top: -pageTop,
          ease: Power0.ease,
          onComplete: this._activateAnimation()
        });
      } else if (pageTop < 0) {
        TweenLite.to(this.mainContainer, 1, {
          top: 0,
          ease: Power0.ease,
          onComplete: this._activateAnimation()
        });
      } else if (pageLeft > 0) {
        TweenLite.to(this.mainContainer, 1, {
          left: -pageLeft,
          ease: Power0.ease,
          onComplete: this._activateAnimation()
        });
      } else if (pageLeft < 0) {
        TweenLite.to(this.mainContainer, 1, {
          left: 0,
          ease: Power0.ease,
          onComplete: this._activateAnimation()
        });
      }
    };

    Page.prototype.mouseScrollToActivate = function() {
      var mainContainerLeft, mainContainerTop, pageLeft, pageTop;
      mainContainerTop = this._getMainContainerTop();
      mainContainerLeft = this._getMainContainerLeft();
      pageTop = this.getPageTop();
      pageLeft = this.getPageLeft();
      console.log("Better solution for page animation trigger");
      if (pageTop === 0 & pageLeft === 0 & this.hasAnimation) {
        this.isActivePage = true;
        this._activateAnimation();
      } else if (pageTop === 0 & pageLeft === 0 & !this.hasAnimation) {
        this.isActivePage = true;
      }
      if (pageLeft >= this.scrollOffset) {
        mainContainerLeft = mainContainerLeft - this.scrollOffset;
        return this.mainContainer.css('left', mainContainerLeft);
      } else if (pageLeft > 0) {
        mainContainerLeft = mainContainerLeft - pageLeft;
        return this.mainContainer.css('left', mainContainerLeft);
      } else if (pageTop >= this.scrollOffset) {
        mainContainerTop = mainContainerTop - this.scrollOffset;
        return this.mainContainer.css('top', mainContainerTop);
      } else if (pageTop > 0) {
        mainContainerTop = mainContainerTop - pageTop;
        return this.mainContainer.css('top', mainContainerTop);
      } else if (pageLeft <= -this.scrollOffset) {
        mainContainerLeft = mainContainerLeft + this.scrollOffset;
        return this.mainContainer.css('left', mainContainerLeft);
      } else if (pageLeft < 0) {
        mainContainerLeft = mainContainerLeft + (-pageLeft);
        return this.mainContainer.css('left', mainContainerLeft);
      } else if (pageTop <= -this.scrollOffset) {
        mainContainerTop = mainContainerTop + this.scrollOffset;
        return this.mainContainer.css('top', mainContainerTop);
      } else {
        mainContainerTop = mainContainerTop + (-pageTop);
        return this.mainContainer.css('top', mainContainerTop);
      }
    };

    Page.prototype.scrollPageTopTo0 = function() {
      var mainContainerTop, pageTop;
      mainContainerTop = this._getMainContainerTop();
      pageTop = this.getPageTop();
      if (pageTop > this.scrollOffset) {
        mainContainerTop = mainContainerTop - this.scrollOffset;
        return this.mainContainer.css('top', mainContainerTop);
      } else if (pageTop > 0) {
        mainContainerTop = mainContainerTop - pageTop;
        return this.mainContainer.css('top', mainContainerTop);
      } else if (pageTop < -this.scrollOffset) {
        mainContainerTop = mainContainerTop + this.scrollOffset;
        return this.mainContainer.css('top', mainContainerTop);
      } else if (pageTop < 0) {
        mainContainerTop = mainContainerTop + (-pageTop);
        return this.mainContainer.css('top', mainContainerTop);
      }
    };

    Page.prototype.scrollPageLeftTo0 = function() {
      var mainContainerLeft, pageLeft;
      mainContainerLeft = this._getMainContainerLeft();
      pageLeft = this.getPageLeft();
      if (pageLeft > this.scrollOffset) {
        mainContainerLeft = mainContainerLeft - this.scrollOffset;
        return this.mainContainer.css('left', mainContainerLeft);
      } else if (pageLeft > 0) {
        mainContainerLeft = mainContainerLeft - pageLeft;
        return this.mainContainer.css('left', mainContainerLeft);
      } else if (pageLeft < -this.scrollOffset) {
        mainContainerLeft = mainContainerLeft + this.scrollOffset;
        return this.mainContainer.css('left', mainContainerLeft);
      } else if (pageLeft < 0) {
        console.log("no way");
        mainContainerLeft = mainContainerLeft + (-pageLeft);
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
