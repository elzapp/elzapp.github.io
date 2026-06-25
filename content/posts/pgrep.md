---
title: "Stop grepping ps output for processes"
date: 2023-09-25T12:38:19+02:00
draft: false
summary: "if you're piping ps aux output to grep to find a process, grep -fla is probably what you really need"
tags:
 - "Linux"
 - "Bash"
 - "Unix"
 - "MacOS"
---

If you're piping <code>ps aux</code> to <code>grep</code> to find a process, <code>pgrep -fla</code> is probably the tool you're looking for

```bash
[user@host ~]$ pgrep -fla nginx
6584 nginx: master process nginx -g daemon off;
7173 nginx: worker process
7174 nginx: worker process
7175 nginx: worker process
7176 nginx: worker process
7177 nginx: worker process
7178 nginx: worker process
7179 nginx: worker process
7180 nginx: worker process
```
