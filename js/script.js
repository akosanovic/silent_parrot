// Generated by CoffeeScript 2.0.1
(function() {
  this.SilentParrot = class SilentParrot {
    constructor() {
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
      // Default Values
      this.activePage = this.homePage;
      this.leftCounter = 0;
      this.topCounter = 0;
      this.mainWrapperTop = 0;
      this.windowW = 0;
      this.windowH = 0;
      this._onLoadHandler();
      // hash change
      this.websiteWindow.on('hashchange', this._hashHandler.bind(this));
      // resize
      this.websiteWindow.on('resize', this._resizeHandler.bind(this));
      // mouse scroll
      this.websiteWindow.on('mousewheel DOMMouseScroll', this._scrollHandler.bind(this));
      
      // click
      this.mainWrapper.on('click', this._clickHandler.bind(this));
      
      // hover
      $(this.logo).on('mouseenter mouseleave', this._hoverHandler.bind(this));
    }

    _onLoadHandler() {
      this._getWindowDimensions();
      this._setWrapperSize();
      // @_getActivePage()
      return this._getHash();
    }

    _hashHandler(e) {
      var newHash, newPage;
      newHash = window.location.hash;
      newHash = newHash.replace(/#/g, '');
      if (newHash !== this.activePage.getPageName) {
        return newPage = this._findPageByName(newHash);
      }
    }

    _autoScrollToNewPage(newActivePage) {
      // scroll to new page
      // make page active
      return newActivePage.autoScrollToActivate();
    }

    _resizeHandler() {
      this._getWindowDimensions();
      return this._setWrapperSize();
    }

    _scrollHandler(e) {
      if (e.originalEvent.wheelDelta > 0 || e.originalEvent.detail < 0) {
        return this._scrollUp();
      } else {
        return this._scrollDown();
      }
    }

    _removeScrollHandler() {
      console.log("SCROLL handler removed ");
      return $(window).off('mousewheel DOMMouseScroll');
    }

    _addScrollHandler() {
      console.log("scroll handler added");
      return $(window).on('mousewheel DOMMouseScroll', this._scrollHandler.bind(this));
    }

    _clickHandler(e) {
      var $target, element, nameOfPageToActivate, pageToActivate;
      $target = $(e.target);
      element = $target.closest(this.navButtons);
      nameOfPageToActivate = null;
      if (element.length > 0) {
        nameOfPageToActivate = $(element).find('a')[0].hash.replace('#', '');
        pageToActivate = this._findPageByName(nameOfPageToActivate);
        return this._autoScrollToNewPage(pageToActivate);
      }
    }

    _hoverHandler() {
      var logoAnimation;
      logoAnimation = new LogoAnimation();
      return logoAnimation.mouseInAnimation();
    }

    _getWindowDimensions() {
      this.windowW = this.websiteWindow.width();
      return this.windowH = this.websiteWindow.height();
    }

    _setWrapperSize() {
      this.mainWrapper.css("width", this.windowW * 2);
      return this.mainWrapper.css("height", this.windowH * 2);
    }

    _getWrapperSize() {
      var wrapperSize;
      wrapperSize = this.mainWrapper[0].getBoundingClientRect();
      console.log("WRAPPER SIZE", wrapperSize);
      return wrapperSize; //top, bottom, left, right	
    }

    _getActivePage() {
      var j, len, page, ref;
      ref = this.orderOfPages;
      for (j = 0, len = ref.length; j < len; j++) {
        page = ref[j];
        if (page.isActive()) {
          // @_setHash(page)
          return page;
        }
      }
    }

    _getHash() {
      var hash;
      hash = window.location.hash;
      return this._setActivePage(hash);
    }

    _scrollDown() {
      var activePageName, nextActivePage;
      activePageName = this.activePage.getPageName();
      nextActivePage = this._goToNextActivePage();
      if (!nextActivePage.isActivePage) {
        return nextActivePage.mouseScrollToActivate();
      } else {
        nextActivePage.isActivePage = false;
        return this.activePage = nextActivePage;
      }
    }

    _scrollUp() {
      var activePageName, nextActivePage;
      activePageName = this.activePage.getPageName();
      nextActivePage = this._goToPrevActivePage();
      if (!nextActivePage.isActivePage) {
        return nextActivePage.mouseScrollToActivate();
      } else {
        nextActivePage.isActivePage = false;
        return this.activePage = nextActivePage;
      }
    }

    _findPageByName(pageName) {
      var j, len, page, ref;
      ref = this.orderOfPages;
      for (j = 0, len = ref.length; j < len; j++) {
        page = ref[j];
        if (page.getPageName() === pageName) {
          return page;
        }
      }
    }

    _goToNextActivePage() {
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
    }

    _goToPrevActivePage() {
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
    }

    _setActivePage(hash) {
      return console.log("Set active page based on hash");
    }

    _setHash(newActivePage) {
      if (this.activePage !== newActivePage) {
        this.activePage = newActivePage;
        window.location.hash = this.activePage.getPageName();
      }
      return console.log("window location hash", window.location.hash);
    }

  };

  $(function() {
    var silentParrot;
    return silentParrot = new SilentParrot();
  });

}).call(this);
