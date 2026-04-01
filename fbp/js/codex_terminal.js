(function () {
	"use strict";

	var sessions = {};

	function setStatus(root, text) {
		var node = root.querySelector(".codex-terminal-status");
		if (node) {
			node.textContent = text;
		}
	}

	function setFocusMask(root, focused) {
		var mask = root.querySelector(".codex-terminal-focus-mask");
		if (!mask) {
			return;
		}
		mask.style.opacity = focused ? "0" : "1";
		mask.style.pointerEvents = focused ? "none" : "auto";
	}

	function hideInjectButton(root) {
		var button = root.querySelector(".codex-terminal-inject");
		if (!button) {
			return;
		}
		button.style.display = "none";
	}

	function buildWsUrl(path, token) {
		if (path.indexOf("ws://") === 0 || path.indexOf("wss://") === 0) {
			return path + (path.indexOf("?") >= 0 ? "&" : "?") + "token=" + encodeURIComponent(token);
		}
		var proto = window.location.protocol === "https:" ? "wss://" : "ws://";
		return proto + window.location.host + path + "?token=" + encodeURIComponent(token);
	}

	function closeSession(session) {
		if (!session) {
			return;
		}
		if (session.ws) {
			try {
				session.ws.close();
			} catch (e) {
				// noop
			}
		}
		if (session.term) {
			try {
				session.term.dispose();
			} catch (e2) {
				// noop
			}
		}
	}

	function focusTerminal(root, term) {
		try {
			term.focus();
		} catch (e) {
			// noop
		}
		var helper = root.querySelector(".xterm-helper-textarea, .xterm textarea");
		if (helper && typeof helper.focus === "function") {
			try {
				helper.focus({preventScroll: true});
			} catch (e2) {
				helper.focus();
			}
		}
	}

	function injectPrompt(session) {
		if (!session || !session.initialInput || session.initialInputSent) {
			return true;
		}
		if (!session.ws || session.ws.readyState !== WebSocket.OPEN) {
			return false;
		}
		var payload = String(session.initialInput || "");
		// HTMLエンティティが混ざる場合に備えて投入直前にデコードする。
		if (payload.indexOf("&") >= 0) {
			payload = payload
				.replace(/&gt;/g, ">")
				.replace(/&lt;/g, "<")
				.replace(/&amp;/g, "&")
				.replace(/&quot;/g, "\"")
				.replace(/&#039;/g, "'");
		}
		payload = payload.replace(/\r\n/g, "\n");
		// 安全策: まず現在行をクリア(Ctrl+U)し、その後に一括投入する。
		var wrapped = "\u0015" + "\u001b[200~" + payload + "\u001b[201~\r";
		session.ws.send(JSON.stringify({type: "input", data: wrapped}));
		session.initialInputSent = true;
		return true;
	}

	function connect(root, session) {
		var token = root.getAttribute("data-ws-token") || "";
		var path = root.getAttribute("data-ws-path") || "/codex-terminal-ws";
		if (!token) {
			setStatus(root, "connection token not found");
			return;
		}

		var proto = window.location.protocol === "https:" ? "wss://" : "ws://";
		var directBase = proto + window.location.hostname + ":18080";
		var candidates = [buildWsUrl(path, token)];
		if (path === "/codex-terminal-ws") {
			candidates.push(buildWsUrl(directBase + path, token));
		}

		var index = 0;
		var connected = false;

		function tryConnect(url) {
			setStatus(root, "connecting...");
			var ws = new WebSocket(url);
			session.ws = ws;
			var connectTimer = setTimeout(function () {
				if (!connected && ws.readyState !== WebSocket.OPEN) {
					try {
						ws.close();
					} catch (e0) {
						// noop
					}
				}
			}, 5000);

			ws.onopen = function () {
				clearTimeout(connectTimer);
				connected = true;
				setStatus(root, "connected");
				if (session.fitAddon) {
					session.fitAddon.fit();
				}
				if (session.term) {
					ws.send(JSON.stringify({
						type: "resize",
						cols: session.term.cols,
						rows: session.term.rows
					}));
				}
				if (session.pendingInjectFromButton && !session.initialInputSent) {
					if (injectPrompt(session)) {
						session.pendingInjectFromButton = false;
						focusTerminal(root, session.term);
						setStatus(root, "prompt injected");
					}
				}
			};

			ws.onmessage = function (event) {
				var message = null;
				try {
					message = JSON.parse(event.data);
				} catch (e) {
					message = null;
				}
				if (!message) {
					return;
				}
				if (message.type === "output" && session.term) {
					session.term.write(String(message.data || ""));
				} else if (message.type === "status") {
					setStatus(root, String(message.message || ""));
				}
			};

			ws.onclose = function () {
				clearTimeout(connectTimer);
				session.ws = null;
				if (!connected) {
					index += 1;
					if (index < candidates.length) {
						tryConnect(candidates[index]);
						return;
					}
				}
				setStatus(root, "disconnected");
			};

			ws.onerror = function () {
				clearTimeout(connectTimer);
				setStatus(root, "connection error");
			};
		}

		tryConnect(candidates[index]);
	}

	function setup(root) {
		var box = root.querySelector(".codex-terminal-box");
		if (!box || !window.Terminal || !window.FitAddon || !window.FitAddon.FitAddon) {
			setStatus(root, "terminal library load failed");
			return null;
		}

		var fontFamily = root.getAttribute("data-font-family") || "Cascadia Mono, Fira Code, Menlo, Consolas, monospace";
		var fontSize = parseInt(root.getAttribute("data-font-size") || "12", 10);
		var lineHeight = parseFloat(root.getAttribute("data-line-height") || "1.2");
		if (!(fontSize > 0)) {
			fontSize = 14;
		}
		if (!(lineHeight > 0)) {
			lineHeight = 1.2;
		}

		var term = new window.Terminal({
			convertEol: true,
			cursorBlink: true,
			scrollback: 2000,
			fontFamily: fontFamily,
			fontSize: fontSize,
			lineHeight: lineHeight,
			theme: {
				background: "#f7f9fc",
				foreground: "#1f2937",
				cursor: "#2563eb",
				selectionBackground: "#bfdbfe"
			}
		});
		var fitAddon = new window.FitAddon.FitAddon();
		term.loadAddon(fitAddon);
		term.open(box);
		fitAddon.fit();
		setFocusMask(root, false);

		var session = {
			root: root,
			term: term,
			fitAddon: fitAddon,
			ws: null,
			initialInput: root.getAttribute("data-initial-input") || "",
			initialInputSent: false,
			pendingInjectFromButton: false
		};

		term.onData(function (data) {
			if (session.ws && session.ws.readyState === WebSocket.OPEN) {
				session.ws.send(JSON.stringify({type: "input", data: data}));
			}
		});

		term.onResize(function (size) {
			if (session.ws && session.ws.readyState === WebSocket.OPEN) {
				session.ws.send(JSON.stringify({type: "resize", cols: size.cols, rows: size.rows}));
			}
		});

		var focusMask = root.querySelector(".codex-terminal-focus-mask");
		if (focusMask) {
			focusMask.addEventListener("mousedown", function (event) {
				event.preventDefault();
			});
			focusMask.addEventListener("click", function () {
				setFocusMask(root, true);
				focusTerminal(root, term);
			});
		}

		var injectBtn = root.querySelector(".codex-terminal-inject");
		if (injectBtn) {
			injectBtn.addEventListener("click", function () {
				hideInjectButton(root);
				session.pendingInjectFromButton = true;
				if (!session.ws || session.ws.readyState !== WebSocket.OPEN) {
					setStatus(root, "接続待機中... 接続後に投入します");
					return;
				}
				if (injectPrompt(session)) {
					session.pendingInjectFromButton = false;
					focusTerminal(root, term);
					setStatus(root, "prompt injected");
				}
			});
		}

		var reconnectBtn = root.querySelector(".codex-terminal-reconnect");
		if (reconnectBtn) {
			reconnectBtn.addEventListener("click", function () {
				if (session.ws) {
					try {
						session.ws.close();
					} catch (e) {
						// noop
					}
				}
				connect(root, session);
			});
		}

		var clearBtn = null;
		var dialog = root.closest(".multi_dialog");
		if (dialog) {
			clearBtn = dialog.querySelector(".codex-terminal-clear");
		}
		if (!clearBtn) {
			clearBtn = root.querySelector(".codex-terminal-clear");
		}
		if (clearBtn) {
			clearBtn.addEventListener("click", function () {
				term.clear();
			});
		}

		connect(root, session);
		return session;
	}

	function initIn(dialogSelector) {
		var scope = document;
		if (dialogSelector) {
			scope = document.querySelector(dialogSelector) || document;
		}
		var roots = scope.querySelectorAll(".codex-terminal-root");
		for (var i = 0; i < roots.length; i++) {
			var root = roots[i];
			var id = root.getAttribute("data-codex-terminal-id");
			if (!id) {
				id = "ct-" + Date.now() + "-" + i;
				root.setAttribute("data-codex-terminal-id", id);
			}
			if (sessions[id]) {
				closeSession(sessions[id]);
				delete sessions[id];
			}
			sessions[id] = setup(root);
		}
	}

	function registerMultiDialogHook() {
		if (typeof window.multi_dialog_functions === "object") {
			window.multi_dialog_functions["codex_terminal"] = function (dialog_id) {
				initIn((dialog_id || "").trim());
			};
			return true;
		}
		return false;
	}

	document.addEventListener("DOMContentLoaded", function () {
		if (!registerMultiDialogHook()) {
			var retry = 0;
			var timer = setInterval(function () {
				retry += 1;
				if (registerMultiDialogHook() || retry > 80) {
					clearInterval(timer);
				}
			}, 100);
		}
		initIn("");
	});
})();
