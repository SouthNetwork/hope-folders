(function (e) {
    function t(t) {
       for (var n, a, o = t[0], r = t[1], h = t[2], l = 0, d = []; l < o.length; l++) a = o[l], Object.prototype.hasOwnProperty.call(c, a) && c[a] && d.push(c[a][0]), c[a] = 0;
       for (n in r) Object.prototype.hasOwnProperty.call(r, n) && (e[n] = r[n]);
       u && u(t);
       while (d.length) d.shift()();
       return i.push.apply(i, h || []), s()
    }
 
    function s() {
       for (var e, t = 0; t < i.length; t++) {
          for (var s = i[t], n = !0, o = 1; o < s.length; o++) {
             var r = s[o];
             0 !== c[r] && (n = !1)
          }
          n && (i.splice(t--, 1), e = a(a.s = s[0]))
       }
       return e
    }
    var n = {},
       c = {
          app: 0
       },
       i = [];
 
    function a(t) {
       if (n[t]) return n[t].exports;
       var s = n[t] = {
          i: t,
          l: !1,
          exports: {}
       };
       return e[t].call(s.exports, s, s.exports, a), s.l = !0, s.exports
    }
    a.m = e, a.c = n, a.d = function (e, t, s) {
       a.o(e, t) || Object.defineProperty(e, t, {
          enumerable: !0,
          get: s
       })
    }, a.r = function (e) {
       "undefined" !== typeof Symbol && Symbol.toStringTag && Object.defineProperty(e, Symbol.toStringTag, {
          value: "Module"
       }), Object.defineProperty(e, "__esModule", {
          value: !0
       })
    }, a.t = function (e, t) {
       if (1 & t && (e = a(e)), 8 & t) return e;
       if (4 & t && "object" === typeof e && e && e.__esModule) return e;
       var s = Object.create(null);
       if (a.r(s), Object.defineProperty(s, "default", {
             enumerable: !0,
             value: e
          }), 2 & t && "string" != typeof e)
          for (var n in e) a.d(s, n, function (t) {
             return e[t]
          }.bind(null, n));
       return s
    }, a.n = function (e) {
       var t = e && e.__esModule ? function () {
          return e["default"]
       } : function () {
          return e
       };
       return a.d(t, "a", t), t
    }, a.o = function (e, t) {
       return Object.prototype.hasOwnProperty.call(e, t)
    }, a.p = "";
    var o = window["webpackJsonp"] = window["webpackJsonp"] || [],
       r = o.push.bind(o);
    o.push = t, o = o.slice();
    for (var h = 0; h < o.length; h++) t(o[h]);
    var u = r;
    i.push([0, "chunk-vendors"]), s()
 })({
    0: function (e, t, s) {
       e.exports = s("56d7")
    },
    "24b6": function (e, t, s) {
       "use strict";
       s("3240")
    },
    3240: function (e, t, s) {},
    "56d7": function (e, t, s) {
       "use strict";
       s.r(t);
       s("e260"), s("e6cf"), s("cca6"), s("a79d");
       var n = s("7a23"),
          c = s("e768"),
          i = s.n(c),
          a = s("e141"),
          o = s.n(a),
          r = {
             id: "app"
          },
          h = {
             id: "chat-area"
          },
          u = {
             class: "message-type"
          },
          l = {
             class: "message-content"
          },
          d = {
             class: "message-sendedBy"
          },
          p = {
             key: 1,
             id: "input-area"
          },
          f = {
             class: "input-box"
          },
          g = {
             class: "commandPrompt"
          },
          m = ["src"],
          b = {
             key: 2,
             class: "filter-types-area"
          },
          O = ["onClick"],
          j = {
             class: "emoji-area"
          },
          y = ["onClick"];
 
       function v(e, t, c, a, v, w) {
          return Object(n["i"])(), Object(n["d"])("div", r, [Object(n["e"])("div", h, [v.chatOpened ? (Object(n["i"])(), Object(n["d"])("div", {
             key: 0,
             class: "messages-area",
             style: Object(n["h"])({
                "overflow-y": v.showInput ? "auto" : "hidden"
             }),
             ref: "messagesRef"
          }, [(Object(n["i"])(!0), Object(n["d"])(n["a"], null, Object(n["l"])(w.filteredMessages, (function (e, t) {
             return Object(n["i"])(), Object(n["d"])("div", {
                class: "message",
                key: t
             }, [Object(n["e"])("span", u, Object(n["m"])(e.type), 1), Object(n["e"])("div", l, [Object(n["e"])("span", d, Object(n["m"])(e.author) + ":", 1), Object(n["f"])(" " + Object(n["m"])(e.content), 1)])])
          })), 128))], 4)) : Object(n["c"])("", !0), v.showInput ? (Object(n["i"])(), Object(n["d"])("div", p, [Object(n["e"])("div", f, [Object(n["e"])("div", g, [Object(n["p"])(Object(n["e"])("input", {
             type: "text",
             maxlength: "250",
             spellcheck: "false",
             class: "input",
             "onUpdate:modelValue": t[0] || (t[0] = function (e) {
                return v.message = e
             }),
             autofocus: "",
             onKeypress: t[1] || (t[1] = Object(n["q"])(Object(n["r"])((function () {
                return w.send && w.send.apply(w, arguments)
             }), ["prevent"]), ["enter"])),
             ref: "input",
             placeholder: "Digite sua mensagem aqui..."
          }, null, 544), [
             [n["n"], v.message]
          ])]), Object(n["e"])("img", {
             src: i.a,
             style: Object(n["h"])({
                opacity: v.emojiPickerOpened ? "1" : ".5"
             }),
             onClick: t[2] || (t[2] = function (e) {
                return v.emojiPickerOpened = !v.emojiPickerOpened
             }),
             class: "emoji"
          }, null, 4), Object(n["e"])("img", {
             src: o.a,
             onClick: t[3] || (t[3] = function () {
                return w.send && w.send.apply(w, arguments)
             }),
             class: "send"
          })]), Object(n["e"])("div", {
             class: "notify-box",
             onClick: t[4] || (t[4] = function () {
                return w.changeNotify && w.changeNotify.apply(w, arguments)
             })
          }, [Object(n["e"])("img", {
             style: Object(n["h"])({
                width: v.notifyToggled ? "0.833vw" : "1.146vw"
             }),
             src: v.notifyToggled ? s("bd07") : s("a9ca")
          }, null, 12, m)])])) : Object(n["c"])("", !0), v.showInput ? (Object(n["i"])(), Object(n["d"])("div", b, [Object(n["e"])("button", {
             class: Object(n["g"])(["chatTypeBackground", {
                selected: "all" === v.selectedChatType
             }]),
             onClick: t[5] || (t[5] = function () {
                return w.changeChatType("all")
             })
          }, "GERAL", 2), Object(n["e"])("button", {
             class: Object(n["g"])(["chatTypeBackground", {
                selected: "ooc" === v.selectedChatType
             }]),
             onClick: t[6] || (t[6] = function () {
                return w.changeChatType("ooc")
             })
          }, "OOC", 2), (Object(n["i"])(!0), Object(n["d"])(n["a"], null, Object(n["l"])(v.chatTypes, (function (e, t) {
             return Object(n["i"])(), Object(n["d"])("button", {
                class: Object(n["g"])(["chatTypeBackground", {
                   selected: v.selectedChatType === e
                }]),
                key: t,
                onClick: function () {
                   return w.changeChatType(e)
                }
             }, Object(n["m"])(e), 11, O)
          })), 128)), Object(n["p"])(Object(n["e"])("div", j, [(Object(n["i"])(!0), Object(n["d"])(n["a"], null, Object(n["l"])(v.emojiList, (function (e, t) {
             return Object(n["i"])(), Object(n["d"])("div", {
                class: "emoji-item",
                onClick: function () {
                   return w.selectEmoji(e)
                },
                key: t
             }, Object(n["m"])(e), 9, y)
          })), 128))], 512), [
             [n["o"], v.emojiPickerOpened]
          ])])) : Object(n["c"])("", !0)])])
       }
       s("ac1f"), s("1276"), s("4de4"), s("d81d"), s("159b"), s("caad"), s("2532");
       var w = s("9007"),
          T = s("1da1"),
          k = (s("96cf"), s("d3b7"), s("99af"), function () {
             var e = Object(T["a"])(regeneratorRuntime.mark((function e(t, s, n) {
                var c, i, a;
                return regeneratorRuntime.wrap((function (e) {
                   while (1) switch (e.prev = e.next) {
                      case 0:
                         return c = {
                            method: "POST",
                            headers: {
                               "Content-type": "application/json; charset=UTF-8"
                            },
                            body: JSON.stringify(s || {})
                         }, i = window.GetParentResourceName ? window.GetParentResourceName() : "chat", e.next = 4, fetch("https://".concat(i, "/").concat(t), c);
                      case 4:
                         return a = e.sent, e.next = 7, a.json();
                      case 7:
                         return e.abrupt("return", e.sent);
                      case 8:
                      case "end":
                         return e.stop()
                   }
                }), e)
             })));
             return function (t, s, n) {
                return e.apply(this, arguments)
             }
          }()),
          C = {
             data: function () {
                return {
                   emojiPickerOpened: !1,
                   emojiList: w[1].split(" "),
                   blockedMessages: [],
                   chatOpened: !1,
                   showInput: !1,
                   chatTypes: [],
                   selectedChatType: "all",
                   listener: null,
                   input: null,
                   notifyToggled: !0,
                   message: "",
                   messages: [],
                   messagesRef: null,
                   cachedMessages: [],
                   currCachedMsg: 1
                }
             },
             watch: {
                messages: {
                   handler: function () {
                      if (this.showChatTimer && clearTimeout(this.showChatTimer), this.notifyToggled) {
                         this.chatOpened = !0;
                         var e = this.$refs.messagesRef;
                         this.chatOpened && this.$nextTick((function () {
                            e.scrollTop = e.scrollHeight
                         }))
                      }
                      this.resetShowChatTimer()
                   },
                   deep: !0
                }
             },
             computed: {
                filteredMessages: function () {
                   var e = this;
                   return "all" !== this.selectedChatType ? this.messages.filter((function (t) {
                      return t.type === e.selectedChatType
                   })) : this.messages
                }
             },
             methods: {
                changeChatType: function (e) {
                   this.selectedChatType = e;
                   var t = this.$refs.messagesRef;
                   this.$nextTick((function () {
                      t.scrollTop = t.scrollHeight
                   }))
                },
                isCommand: function () {
                   return "/" === this.message[0]
                },
                changeNotify: function () {
                   this.notifyToggled = !this.notifyToggled
                },
                checkBlockedMessages: function () {
                   var e = this,
                      t = !1;
                   return this.message.split(" ").map((function (s) {
                      e.blockedMessages.forEach((function (s) {
                         e.message.includes(s) && (t = !0)
                      }))
                   })), !t
                },
                send: function () {
                   "" !== this.message ? this.checkBlockedMessages() && (this.cachedMessages.length > 5 && this.cachedMessages.shift(), this.cachedMessages.push(this.message), k("ChatSubmit", {
                      message: this.message,
                      tag: "all" == this.selectedChatType ? "ooc" : this.selectedChatType
                   }), this.message = "", this.hideInput()) : this.hideInput()
                },
                keyUp: function () {
                   this.currCachedMsg > 5 || this.currCachedMsg > this.cachedMessages.length || (this.message = this.cachedMessages[this.cachedMessages.length - this.currCachedMsg], this.currCachedMsg++)
                },
                keyDown: function () {
                   this.currCachedMsg <= 1 || (this.currCachedMsg--, this.message = this.cachedMessages[this.cachedMessages.length - this.currCachedMsg])
                },
                clear: function () {
                   this.messages = []
                },
                selectEmoji: function (e) {
                   this.message += e, this.emojiPickerOpened = !1
                },
                clearShowChatTimer: function () {
                   clearTimeout(this.showChatTimer)
                },
                resetShowChatTimer: function () {
                   var e = this;
                   this.clearShowChatTimer(), this.showChatTimer = setTimeout((function () {
                      e.showInput || (e.chatOpened = !1)
                   }), 7e3)
                },
                hideInput: function () {
                   this.message = "", this.showInput = !1, this.resetShowChatTimer(), k("close")
                }
             },
             destroyed: function () {
                clearInterval(this.focusTimer), window.removeEventListener("message", this.listener)
             },
             mounted: function () {
                var e = this;
                this.listener = window.addEventListener("message", (function (t) {
                   var s = t.data || t.detail;
                   switch (s.Action) {
                      case "Chat":
                         e.chatOpened = !0, e.showInput = !0, e.currCachedMsg = 1, e.chatTypes = s.Data, e.blockedMessages = s.Block, setTimeout((function () {
                            e.$nextTick((function () {
                               e.$refs.input.focus(), e.$refs.messagesRef.scrollTop = e.$refs.messagesRef.scrollHeight
                            }))
                         }), 125);
                         break;
                      case "Message":
                         e.messages.push({
                            type: s.Type,
                            author: s.Author,
                            content: s.Message
                         });
                         break;
                      default:
                         break
                   }
                })), window.addEventListener("keydown", (function (t) {
                   "Escape" == t.code ? e.hideInput() : "ArrowUp" == t.code ? e.keyUp() : "ArrowDown" == t.code && e.keyDown()
                }))
             }
          },
          M = (s("24b6"), s("6b0d")),
          x = s.n(M);
       const P = x()(C, [
          ["render", v],
          ["__scopeId", "data-v-67c09b78"]
       ]);
       var S = P;
       Object(n["b"])(S).mount("#app")
    },
    9007: function (e) {
       e.exports = JSON.parse('{"1":"😀 😃 😄 😁 😆 😅 😂 🤣 😊 😇 🙂 🙃 😉 😌 😍 🥰 😘 😗 😙 😚 😋 😛 😝 😜 🤪 🤨 🧐 🤓 😎 🤩 🥳 😏 😒 😞 😔 😟 😕 🙁 ☹️ 😣 😖 😫 😩 🥺 😢 😭 😮‍💨 😤 😠 😡 🤬 🤯 😳 🥵 🥶 😱 😨 😰 😥 😓 🤗 🤔 🤭 🤫 🤥 😶 😶 😐 😑 😬 🙄 😯 😦 😧 😮 😲 🥱 😴 🤤 😪 😵 😵‍💫 🤐 🥴 🤢 🤮 🤧 😷 🤒 🤕 🤑 🤠 😈 👿 👹 👺 🤡 💩 👻 💀 ☠️ 👽 👾 🤖 🎃 😺 😸 😹 😻 😼 😽 🙀 😿 😾 👋 🤚 🖐 ✋ 🖖 👌 🤏 ✌️ 🤞 🤟 🤘 🤙 👈 👉 👆 🖕 👇 ☝️ 👍 👎 ✊ 👊 🤛 🤜 👏 🙌 👐 🤲 🤝 🙏 ✍️ 💅 🤳 💪 🦾 🦵 🦿 🦶 👣 👂 🦻 👃 🧠 🦷 🦴 👀 👁 👅 👄 💋 🩸 🍏 🍎 🍐 🍊 🍋 🍌 🍉 🍇 🍓 🫐 🍈 🍒 🍑 🥭 🍍 🥥 🥝 🍅 🍆 🥑 🥦 🥬 🥒 🌶 🫑 🌽 🥕 🫒 🧄 🧅 🥔 🍠 🫘 🥐 🥯 🍞 🥖 🥨 🧀 🥚 🍳 🧈 🥞 🧇 🥓 🥩 🍗 🍖 🦴 🌭 🍔 🍟 🍕 🫓 🥪 🥙 🧆 🌮 🌯 🫔 🥗 🥘 🫕 🥫 🍝 🍜 🍲 🍛 🍣 🍱 🥟 🦪 🍤 🍙 🍚 🍘 🍥 🥠 🥮 🍢 🍡 🍧 🍨 🍦 🥧 🧁 🍰 🎂 🍮 🍭 🍬 🍫 🍿 🍩 🍪 🌰 🥜 🍯 🥛 🍼 ☕️ 🍵 🧃 🥤 🍶 🍺 🍻 🥂 🍷 🥃 🍸 🍹 🧉 🍾 🧊 🥄 🍴 🍽 🥣 🥡 🥢 🧂 🚓 🚑 🚒 🚐"}')
    },
    a9ca: function (e, t, s) {
       e.exports = s.p + "img/notify_off.9f647f02.svg"
    },
    bd07: function (e, t, s) {
       e.exports = s.p + "img/notify_on.b9340a3e.svg"
    },
    e141: function (e, t, s) {
       e.exports = s.p + "img/send.24265015.svg"
    },
    e768: function (e, t, s) {
       e.exports = s.p + "img/emoji.1f0a1a78.svg"
    }
 });
 //# sourceMappingURL=app.64615c20.js.map