// Generated by CoffeeScript 2.0.1
(function() {
  this.Page = (function() {
    class Page {
      constructor(htmlElement, hasAnimation) {
        this.mainContainer = $('.main--content--wrapper');
        this.htmlElement = htmlElement;
        this.jqueryElment = $(htmlElement);
        this.hasAnimation = hasAnimation;
        this.pageName = this.getPageName();
        this.isActivePage = false;
        this._setPageSize();
        $(window).on('resize', this._setPageSize.bind(this));
      }

      _getWindowDimensions() {
        this.windowW = $(window).width();
        return this.windowH = $(window).height();
      }

      _setPageSize() {
        this._getWindowDimensions();
        this.jqueryElment.height(this.windowH);
        this.jqueryElment.width(this.windowW);
        return this.checkIfActive();
      }

      top() {
        return this.htmlElement.getBoundingClientRect().top;
      }

      bottom() {
        return this.htmlElement.getBoundingClientRect().bottom;
      }

      left() {
        return this.htmlElement.getBoundingClientRect().left;
      }

      right() {
        return this.htmlElement.getBoundingClientRect().right;
      }

      checkIfActive() {
        if (this.top() === 0 && this.left() === 0) {
          return true;
        } else {
          return false;
        }
      }

      getPageName() {
        var name;
        name = this.jqueryElment.data('page-name');
        return String(name);
      }

      getWidth() {
        return this.jqueryElment.width();
      }

      getHeight() {
        return this.jqueryElment.height();
      }

      autoScrollToActivate() {
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
      }

      scrollToActivate() {
        var mainContainerLeft, mainContainerTop, pageLeft, pageTop, scrollOffset;
        mainContainerTop = this.mainContainer[0].getBoundingClientRect().top;
        mainContainerLeft = this.mainContainer[0].getBoundingClientRect().left;
        scrollOffset = 200;
        pageTop = this.top();
        pageLeft = this.left();
        console.log("main container top", mainContainerTop);
        console.log("page top is", pageTop);
        console.log("page left is ", pageLeft);
        if (pageTop === 0 & pageLeft === 0 & this.hasAnimation) {
          this.isActivePage = true;
          this._activateAnimation();
        } else if (pageTop === 0 & pageLeft === 0 & !this.hasAnimation) {
          this.isActivePage = true;
        }
        if (pageLeft >= scrollOffset) {
          mainContainerLeft = mainContainerLeft - scrollOffset;
          return this.mainContainer.css('left', mainContainerLeft);
        } else if (pageLeft > 0) {
          mainContainerLeft = mainContainerLeft - pageLeft;
          return this.mainContainer.css('left', mainContainerLeft);
        } else if (pageTop >= scrollOffset) {
          mainContainerTop = mainContainerTop - scrollOffset;
          return this.mainContainer.css('top', mainContainerTop);
        } else if (pageTop > 0) {
          mainContainerTop = mainContainerTop - pageTop;
          return this.mainContainer.css('top', mainContainerTop);
        } else if (pageLeft <= -scrollOffset) {
          mainContainerLeft = mainContainerLeft + scrollOffset;
          return this.mainContainer.css('left', mainContainerLeft);
        } else if (pageLeft < 0) {
          mainContainerLeft = mainContainerLeft + (-pageLeft);
          return this.mainContainer.css('left', mainContainerLeft);
        } else if (pageTop <= -scrollOffset) {
          mainContainerTop = mainContainerTop + scrollOffset;
          return this.mainContainer.css('top', mainContainerTop);
        } else {
          mainContainerTop = mainContainerTop + (-pageTop);
          return this.mainContainer.css('top', mainContainerTop);
        }
      }

      _activateAnimation() {
        var pa;
        if (this.hasAnimation) {
          this.pageAnimation = new PageAnimation();
          console.log(`PAGE animation is ${this.pageAnimation}`);
          pa = this.pageAnimation.lineAniamtion();
          return pa.play();
        }
      }

      _destroyAnimation() {
        if (this.pageAnimation) {
          return this.pageAnimation.destroyAnimation();
        }
      }

    };

    Page.pageAnimation = null;

    Page.pageName = null;

    return Page;

  })();

}).call(this);
