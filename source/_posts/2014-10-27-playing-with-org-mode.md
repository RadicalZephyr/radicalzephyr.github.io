---
layout: post
title: "Playing with Org-mode"
date: 2014-10-27 18:30:05 -0400
comments: true
categories:
---

``` elisp
(progn
  (require 'org)
  (progn
    (condition-case nil
        (while t
          (insert (read-string "") "\n"))
      (error nil))
    (set-buffer
     (org-export-to-buffer 'html "*Org HTML Export*"
       nil nil nil t nil
       (lambda () t)))
       (message "%s" (buffer-string))))
```


```
tail -n+4 hello.org | $emacs --batch --eval "(progn (require 'org) (progn (condition-case nil (while t (insert (read-string \"\") \"\\n\")) (error nil)) (set-buffer (org-export-to-buffer 'html \"*Org HTML Export*\" nil nil nil t nil (lambda () t))) (message \"%s\" (buffer-string))))"
```
