(function (window, document) {
  if (window.EmbedApp) {
    return;
  }

  function normalizeAppUrl(appUrl) {
    return String(appUrl || '').replace(/\/?$/, '');
  }

  function buildRouteUrl(appUrl, embedKey) {
    var base = normalizeAppUrl(appUrl);
    var url = base + '?class=embed_app_runtime&function=route';
    if (embedKey) {
      url = appendParam(url, 'embed_key', embedKey);
    }
    return url;
  }

  function appendParam(url, key, value) {
    var sep = '?';
    if (url.indexOf('?') >= 0 || url.indexOf('&') >= 0) {
      sep = '&';
    }
    return url + sep + encodeURIComponent(key) + '=' + encodeURIComponent(value);
  }

  function postHeight(iframe) {
    if (!iframe || !iframe.contentWindow) {
      return;
    }
    iframe.contentWindow.postMessage({ type: 'embed_app:request_height' }, '*');
  }

  function mount(options) {
    options = options || {};
    var target = document.querySelector(options.target || '');
    if (!target) {
      return;
    }

    var appUrl = String(options.appUrl || '');
    var bootUrl = String(options.bootUrl || '');
    var embedKey = options.embedKey || '';
    if (!bootUrl) {
      if (!appUrl) {
        target.innerHTML = 'appUrl or bootUrl is required.';
        return;
      }
      bootUrl = buildRouteUrl(appUrl, embedKey);
    }
    if (!bootUrl) {
      target.innerHTML = 'bootUrl is required.';
      return;
    }

    var origin = options.origin || window.location.origin || '';
    var src = bootUrl;
    var canAppendQuery = src.indexOf('?') >= 0;
    if (origin && canAppendQuery) {
      src = appendParam(src, 'origin', origin);
    }
    if (embedKey && src.indexOf('embed_key=') < 0 && canAppendQuery) {
      src = appendParam(src, 'embed_key', embedKey);
    }

    var iframe = document.createElement('iframe');
    iframe.src = src;
    iframe.style.width = '100%';
    iframe.style.border = '0';
    iframe.style.minHeight = '180px';
    iframe.loading = 'lazy';
    iframe.referrerPolicy = 'strict-origin-when-cross-origin';

    target.innerHTML = '';
    target.appendChild(iframe);

    iframe.addEventListener('load', function () {
      postHeight(iframe);
    });

    window.addEventListener('message', function (event) {
      var data = event.data || {};
      if (data.type !== 'embed_app:height') {
        return;
      }
      if (!data.height) {
        return;
      }
      iframe.style.height = Math.max(180, parseInt(data.height, 10) || 180) + 'px';
    });
  }

  window.EmbedApp = {
    mount: mount
  };

  function autoMountFromCurrentScript() {
    var script = document.currentScript;
    if (!script || !script.dataset) {
      return;
    }
    var embedKey = script.dataset.embedKey || '';
    var target = script.dataset.target || '';
    var appUrl = script.dataset.appUrl || '';
    var bootUrl = script.dataset.bootUrl || '';
    var origin = script.dataset.origin || window.location.origin || '';
    if (!target) {
      return;
    }
    mount({
      target: target,
      appUrl: appUrl,
      bootUrl: bootUrl,
      embedKey: embedKey,
      origin: origin
    });
  }

  autoMountFromCurrentScript();
})(window, document);
