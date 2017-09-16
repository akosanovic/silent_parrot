// Generated by CoffeeScript 1.9.3
(function() {
  this.SilentParrot = (function() {
    function SilentParrot() {
      this.websiteWindow = $(window);
      this.mainWrapper = $('.universe--wrapper');
      this.pages = this.mainWrapper.find('.page');
      this.mainWrapperPosition = this._getWrapperSize();
      this.homePage = new Page(this.pages[0], this);
      this.aboutUsPage = new Page(this.pages[1], this);
      this.randomPage = new Page(this.pages[2], this);
      this.contactPage = new Page(this.pages[3], this);
      this.orderOfPages = [this.homePage, this.aboutUsPage, this.randomPage, this.contactPage];
      this.logo = this.mainWrapper.find('.logo--main');
      this.activePage = this.leftCounter = 0;
      this.mainWrapperTop = 0;
      this.windowW = 0;
      this.windowH = 0;
      this._onLoadHandler();
      this.websiteWindow.on('resize', this._resizeHandler.bind(this));
      $(window).on('mousewheel DOMMouseScroll', this._scrollHandler.bind(this));
      $(this.logo).on('mouseenter', this._hoverHandler.bind(this));
    }

    SilentParrot.prototype._onLoadHandler = function() {
      this._getWindowDimensions();
      this._setWrapperSize();
      this._getActivePage();
      return this._getHash();
    };

    SilentParrot.prototype._resizeHandler = function() {
      this._getWindowDimensions();
      return this._setWrapperSize();
    };

    SilentParrot.prototype._hoverHandler = function() {
      var logoAnimation;
      logoAnimation = new LogoAnimation();
      console.log(logoAnimation);
      return logoAnimation.mouseInAnimation();
    };

    SilentParrot.prototype._scrollHandler = function(e) {
      if (e.originalEvent.wheelDelta > 0 || e.originalEvent.detail < 0) {
        console.log("Scrolled up");
        return this._scrollUp();
      } else {
        return this._scrollDown();
      }
    };

    SilentParrot.prototype._getWindowDimensions = function() {
      this.windowW = this.websiteWindow.width();
      return this.windowH = this.websiteWindow.height();
    };

    SilentParrot.prototype._setWrapperSize = function() {
      this.mainWrapper.css("width", this.windowW * 2);
      return this.mainWrapper.css("height", this.windowH * 2);
    };

    SilentParrot.prototype._getWrapperSize = function() {
      var wrapperSize;
      wrapperSize = this.mainWrapper[0].getBoundingClientRect();
      console.log("WRAPPER SIZE", wrapperSize);
      return wrapperSize;
    };

    SilentParrot.prototype._checkIfOverscroll = function() {
      var bottom, left, right, top;
      top = this.mainWrapper[0].getBoundingClientRect().top;
      right = this.mainWrapper[0].getBoundingClientRect().right;
      bottom = this.mainWrapper[0].getBoundingClientRect().bottom;
      left = this.mainWrapper[0].getBoundingClientRect().left;
      if (top > 0) {
        console.log("too high");
        return true;
      } else if (left > 0) {
        console.log("too left");
        return true;
      } else if (right < 0) {
        console.log("too right");
        return true;
      } else if (bottom < 0) {
        console.log("too low");
        return true;
      } else {
        return false;
      }
    };

    SilentParrot.prototype._scrollDown = function() {
      console.log("SCROLL DOWN");
      if (this.activePage.top() === 0 && this.activePage.left() === 0) {
        this._goToNextActivePage();
        this._scrollDown();
      }
      if (!this._checkIfOverscroll()) {
        TweenLite.to(this.mainWrapper, 1, {
          left: "-" + this.leftCounter + "%",
          ease: Power0.easeNone
        });
      }
      return this.leftCounter = this.leftCounter + 20;
    };

    SilentParrot.prototype._goToNextActivePage = function() {
      var i, j, len, page, ref;
      ref = this.orderOfPages;
      for (i = j = 0, len = ref.length; j < len; i = ++j) {
        page = ref[i];
        if (page === this.activePage) {
          if (i < this.orderOfPages.length) {
            this.activePage = this.orderOfPages[i + 1];
            return this.activePage;
          } else {
            this.activePage = this.orderOfPages[0];
            return this.activePage;
          }
        }
      }
    };

    SilentParrot.prototype._goToPrevActivePage = function() {
      var i, j, len, page, ref;
      ref = this.orderOfPages;
      for (i = j = 0, len = ref.length; j < len; i = ++j) {
        page = ref[i];
        if (page === this.activePage) {
          if (i > 0) {
            this.activePage = this.orderOfPages[i - 1];
            return this.activePage;
          } else {
            i = this.orderOfPages.length;
            this.activePage = this.orderOfPages[i];
          }
        }
      }
    };

    SilentParrot.prototype._scrollUp = function() {
      this.leftCounter = this.leftCounter - 100;
      return TweenLite.to(this.mainWrapper, 0.3, {
        y: this.leftCounter,
        ease: Power1.easeInOut
      });
    };

    SilentParrot.prototype._getActivePage = function() {
      var j, len, page, ref;
      ref = this.orderOfPages;
      for (j = 0, len = ref.length; j < len; j++) {
        page = ref[j];
        if (page.isActive()) {
          this._setHash(page);
          return page;
        }
      }
    };

    SilentParrot.prototype._setActivePage = function(hash) {
      return console.log("Set active page based on hash");
    };

    SilentParrot.prototype._setHash = function(newActivePage) {
      if (this.activePage !== newActivePage) {
        this.activePage = newActivePage;
        window.location.hash = this.activePage.getPageName();
      }
      return console.log("window location hash", window.location.hash);
    };

    SilentParrot.prototype._getHash = function() {
      var hash;
      hash = window.location.hash;
      return this._setActivePage(hash);
    };

    return SilentParrot;

  })();

  $(function() {
    var silentParrot;
    return silentParrot = new SilentParrot();
  });

}).call(this);
