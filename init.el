(when (require 'package nil t)
 (add-to-list 'package-archives
       '("melpa" . "https://melpa.org/packages/"))
 (add-to-list 'package-archives
       '("melpa-stable" . "https://stable.melpa.org/packages/"))
 (add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
 (package-initialize)
 )

(require 'org)
(require 'org-element)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t) ;; すべてのuse-packageで:ensure tを省略可能に

(use-package smartparens
  :ensure t  ;; インストールされていなければ自動でインストール
  :hook (prog-mode . smartparens-mode)  ;; プログラミングモードで有効化
  :config
  (require 'smartparens-config)) ;; 標準の括弧設定


;;(unless (package-installed-p 'smartparens)
;;  (package-refresh-contents)          ; 一度だけ実行される
;;  (package-install 'smartparens))


(use-package markdown-mode
  :ensure t
  :mode ("\\.md\\'" . gfm-mode) ;; .mdファイルではgfm-modeを使用
  :init
  (setq markdown-command "pandoc"
        markdown-fontify-code-blocks-natively t
        markdown-header-scaling t
        markdown-indent-on-enter 'indent-and-new-item)
  :config
  (define-key markdown-mode-map (kbd "<S-tab>") #'markdown-shifttab))


;;; ---------------- Super+Space → fcitx5 トグル -----------------
;; 端末では Super+Space が CSI “ESC [ 32 ; 9 ~” として届くので
;; まずその列を <s-SPC> として認識させる
;;(define-key input-decode-map ";9uz" [s-SPC])
;; fcitx5-remote -t で IME 状態 (0/2) をトグル
;(defun my/toggle-fcitx5 ()
;;  "Toggle fcitx5 (Japanese ↔ English)."
;  (interactive)
;  (call-process "fcitx5-remote" nil nil nil "-t"))

;; Super+Space で日本語切替（GUI Emacs でも同じキーで動く）
;(global-set-key [s-SPC] #'my/toggle-fcitx5)
;;; --------------------------------------------------------------

;; ★備考
;; • ESC [ 32 ; 9 ~ ＝ “Space(32) + Super(9)” ── xterm/kitty の CSI u 符号化
;; • `fcitx5-remote -t` は状態を ON/OFF 切替  0=OFF, 2=ON :contentReference[oaicite:0]{index=0}
;; • escape 列が異なる端末は `C-h l` で確認して "\e[…~" 部分を書き換える
;; • Emacs が警告 “M-[ 32;9 is undefined” を出さなくなる理由は、
;;   input-decode-map で既に意味付けされているため :contentReference[oaicite:1]{index=1}


(setq ring-bell-function 'ignore)

;; スタートアップメッセージを表示させない
(setq inhibit-startup-message 1)

;; scratchの初期メッセージ消去
(setq initial-scratch-message "")

;; ツールバーを表示しない
(tool-bar-mode 0)

;; スクロールバーを表示しない
(set-scroll-bar-mode nil)

;;行番号を常に左端に表示させる(%の後の数字を変えることで左端からの幅が変更可能)

;;(global-linum-mode)
;;(setq linum-format "%4d")

;;現在いる行を目立たせる

(global-hl-line-mode ) 
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(hl-line ((t ()))))
;;対応する括弧のハイライト(マクロを書いている時など、対応括弧が分からなくなりがちなので便利)
(require 'smartparens-config)

(smartparens-global-mode t)

;; 画面内に対応する括弧がある場合は括弧だけを、ない場合は括弧で囲まれた部分をハイライト
(setq show-paren-style 'mixed)

;; タブ表示
(tab-bar-mode t)

;; 背景色
(add-to-list 'default-frame-alist '(background-color . "grey13"))
;; 文字色
(add-to-list 'default-frame-alist '(foreground-color . "WhiteSmoke"))

;; 色分け
(global-font-lock-mode t)
(setq font-lock-support-mode 'jit-lock-mode)
;;; 種類ごとの色
(add-hook 'font-lock-mode-hook
          '(lambda ()
             (set-face-foreground 'font-lock-comment-face "green")
             (set-face-foreground 'font-lock-string-face "DarkOrange")
             (set-face-foreground 'font-lock-keyword-face "palevioletred2")
             (set-face-foreground 'font-lock-builtin-face "RoyalBlue3")
             (set-face-foreground 'font-lock-function-name-face "palevioletred2")
             (set-face-foreground 'font-lock-variable-name-face "WhiteSmoke")
             (set-face-foreground 'font-lock-type-face "green1")
             (set-face-foreground 'font-lock-constant-face "cyan1")
             (set-face-foreground 'font-lock-warning-face "violet")
             ))

(setq default-frame-alist
      (append '((width                . 140)  ; フレーム幅
                (height               . 40 ) ; フレーム高
                (left                 . 170 ) ; 配置左位置
                (top                  . 30 ) ; 配置上位置
                (line-spacing         . 0  ) ; 文字間隔
                (left-fringe          . 12 ) ; 左フリンジ幅
                (right-fringe         . 12 ) ; 右フリンジ幅
                (menu-bar-lines       . 1  ) ; メニューバー
                (cursor-type          . box) ; カーソル種別
                (alpha                . 100) ; 透明度
                )
              default-frame-alist))
(setq initial-frame-alist default-frame-alist)

;;時間を表示
(display-time) 
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(markdown-mode smartparens)))
