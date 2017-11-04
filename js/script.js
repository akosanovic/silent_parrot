// Generated by CoffeeScript 1.9.3
(function() {
  var bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  this.SilentParrot = (function() {
    function SilentParrot() {
      this._scrollToPrevPage = bind(this._scrollToPrevPage, this);
      this._scrollToNextPage = bind(this._scrollToNextPage, this);
      this._scrollCurrentPageLeftTo0 = bind(this._scrollCurrentPageLeftTo0, this);
      this._scrollCurrentPageTopTo0 = bind(this._scrollCurrentPageTopTo0, this);
      this.websiteWindow = $(window);
      this.mainWrapper = $('.main--content--wrapper');
      this.mainWrapperPosition = this._getWrapperSize();
      this.navButtons = this.mainWrapper.find('.nav--button');
      this.logo = this.mainWrapper.find('.logo--main');
      this.pages = this.mainWrapper.find('.page');
      this.homePage = new Page(this.pages[0], false, this.mainWrapper);
      this.aboutUsPage = new Page(this.pages[1], true, this.mainWrapper);
      this.randomPage = new Page(this.pages[2], false, this.mainWrapper);
      this.contactPage = new Page(this.pages[3], false, this.mainWrapper);
      this.orderOfPages = [this.homePage, this.aboutUsPage, this.randomPage, this.contactPage];
      this.activePage = this.homePage;
      this.leftCounter = 0;
      this.topCounter = 0;
      this.mainWrapperTop = 0;
      this.windowW = 0;
      this.windowH = 0;
      this.scrollLeft = 0;
      this._onLoadHandler();
      this.websiteWindow.on('hashchange', this._hashHandler.bind(this));
      this.websiteWindow.on('resize', this._resizeHandler.bind(this));
      this.websiteWindow.on('mousewheel DOMMouseScroll', this._scrollHandler.bind(this));
      this.mainWrapper.on('click', this._clickHandler.bind(this));
      $(this.logo).on('mouseenter mouseleave', this._hoverHandler.bind(this));
    }

    SilentParrot.prototype._onLoadHandler = function() {
      this._getWindowDimensions();
      this._setWrapperSize();
      return this._getHash();
    };

    SilentParrot.prototype._hashHandler = function(e) {
      var newHash, newPage;
      newHash = window.location.hash;
      newHash = newHash.replace(/#/g, '');
      if (newHash !== this.activePage.getPageName) {
        return newPage = this._findPageByName(newHash);
      }
    };

    SilentParrot.prototype._autoScrollToNewPage = function(newActivePage) {
      return newActivePage.autoScrollToActivate();
    };

    SilentParrot.prototype._resizeHandler = function() {
      this._getWindowDimensions();
      return this._setWrapperSize();
    };

    SilentParrot.prototype._scrollHandler = function(e) {
      if (e.originalEvent.wheelDelta > 0 || e.originalEvent.detail < 0) {
        return this._scrollUp();
      } else {
        return this._scrollDown();
      }
    };

    SilentParrot.prototype._removeScrollHandler = function() {
      console.log("SCROLL handler removed ");
      return $(window).off('mousewheel DOMMouseScroll');
    };

    SilentParrot.prototype._addScrollHandler = function() {
      console.log("scroll handler added");
      return $(window).on('mousewheel DOMMouseScroll', this._scrollHandler.bind(this));
    };

    SilentParrot.prototype._clickHandler = function(e) {
      var $target, element, nameOfPageToActivate, pageToActivate;
      $target = $(e.target);
      element = $target.closest(this.navButtons);
      nameOfPageToActivate = null;
      if (element.length > 0) {
        nameOfPageToActivate = $(element).find('a')[0].hash.replace('#', '');
        pageToActivate = this._findPageByName(nameOfPageToActivate);
        return this._autoScrollToNewPage(pageToActivate);
      }
    };

    SilentParrot.prototype._hoverHandler = function() {
      var logoAnimation;
      logoAnimation = new LogoAnimation();
      return logoAnimation.mouseInAnimation();
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

    SilentParrot.prototype._getActivePage = function() {
      var j, len, page, ref;
      ref = this.orderOfPages;
      for (j = 0, len = ref.length; j < len; j++) {
        page = ref[j];
        if (page.isActive()) {
          return page;
        }
      }
    };

    SilentParrot.prototype._getHash = function() {
      var hash;
      hash = window.location.hash;
      return this._setActivePage(hash);
    };

    SilentParrot.prototype._scrollCurrentPageTopTo0 = function() {
      return this.activePage.scrollPageTopTo0();
    };

    SilentParrot.prototype._scrollCurrentPageLeftTo0 = function() {
      return this.activePage.scrollPageLeftTo0();
    };

    SilentParrot.prototype._scrollToNextPage = function() {
      var nextActivePage;
      nextActivePage = this._goToNextActivePage();
      if (!nextActivePage.checkIfActive()) {
        return nextActivePage.mouseScrollToActivate();
      } else {
        return this.activePage = nextActivePage;
      }
    };

    SilentParrot.prototype._scrollToPrevPage = function() {
      var nextActivePage;
      nextActivePage = this._goToPrevActivePage();
      if (!nextActivePage.checkIfActive()) {
        return nextActivePage.mouseScrollToActivate();
      } else {
        return this.activePage = nextActivePage;
      }
    };

    SilentParrot.prototype._scrollDown = function() {
      var currentPageLeft, currentPageTop, nextActivePage, nextPageLeft, nextPageTop;
      currentPageTop = this.activePage.getPageTop();
      currentPageLeft = this.activePage.getPageLeft();
      nextActivePage = this._goToNextActivePage();
      nextPageTop = nextActivePage.getPageTop();
      nextPageLeft = nextActivePage.getPageLeft();
      if (currentPageTop === nextPageTop) {
        if (currentPageTop === 0) {
          return this._scrollToNextPage();
        } else {
          return this._scrollCurrentPageTopTo0();
        }
      } else if (currentPageLeft === nextPageLeft) {
        if (currentPageLeft === 0) {
          return this._scrollToNextPage();
        } else {
          return this._scrollCurrentPageLeftTo0();
        }
      }
    };

    SilentParrot.prototype._scrollUp = function() {
      var currentPageLeft, currentPageTop, nextActivePage, nextPageLeft, nextPageTop;
      nextActivePage = this._goToPrevActivePage();
      nextPageTop = nextActivePage.getPageTop();
      nextPageLeft = nextActivePage.getPageLeft();
      currentPageTop = this.activePage.getPageTop();
      currentPageLeft = this.activePage.getPageLeft();
      if (currentPageTop === nextPageTop) {
        if (currentPageTop === 0) {
          return this._scrollToPrevPage();
        } else {
          return this._scrollCurrentPageTopTo0();
        }
      } else if (currentPageLeft === nextPageLeft) {
        if (currentPageLeft === 0) {
          return this._scrollToPrevPage();
        } else {
          return this._scrollCurrentPageLeftTo0();
        }
      }
    };

    SilentParrot.prototype._findPageByName = function(pageName) {
      var j, len, page, ref;
      ref = this.orderOfPages;
      for (j = 0, len = ref.length; j < len; j++) {
        page = ref[j];
        if (page.getPageName() === pageName) {
          return page;
        }
      }
    };

    SilentParrot.prototype._goToNextActivePage = function() {
      var i, j, len, newActivePage, page, ref;
      newActivePage = null;
      ref = this.orderOfPages;
      for (i = j = 0, len = ref.length; j < len; i = ++j) {
        page = ref[i];
        if (page === this.activePage) {
          if (i + 1 < this.orderOfPages.length) {
            newActivePage = this.orderOfPages[i + 1];
          } else {
            newActivePage = this.orderOfPages[0];
          }
        }
      }
      return newActivePage;
    };

    SilentParrot.prototype._goToPrevActivePage = function() {
      var i, j, len, newActivePage, numOfPages, page, ref;
      newActivePage = null;
      ref = this.orderOfPages;
      for (i = j = 0, len = ref.length; j < len; i = ++j) {
        page = ref[i];
        if (page === this.activePage) {
          if (i >= 1) {
            newActivePage = this.orderOfPages[i - 1];
          } else {
            numOfPages = this.orderOfPages.length - 1;
            newActivePage = this.orderOfPages[numOfPages];
          }
        }
      }
      return newActivePage;
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

    return SilentParrot;

  })();

  $(function() {
    var silentParrot;
    return silentParrot = new SilentParrot();
  });

}).call(this);
