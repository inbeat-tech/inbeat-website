# InBeat 官网

零依赖静态站点，入口为 `index.html`。通过 GitHub Pages 发布。

## 线上地址

推送 `main` 并启用 Pages 后：

```text
https://inbeat-tech.github.io/inbeat-website/
```

## 本地预览

在项目根目录运行：

```bash
python3 -m http.server 4173
```

然后打开 `http://127.0.0.1:4173`。

## 发布

`gh` 在本机位于 `~/.local/bin/gh`（若未加入 PATH，可先 `export PATH="$HOME/.local/bin:$PATH"`）。

```bash
gh auth login -h github.com -p ssh -w
./publish.sh
```

脚本会推送到 `origin`（`git@github.com:inbeat-tech/inbeat-website.git`），并把 Pages 切到 **GitHub Actions**。之后每次推送 `main` 都会自动部署。

**不用 `gh` 时：**

```bash
git push -u origin main
```

然后 GitHub → **Settings** → **Pages** → Build and deployment → **GitHub Actions**。

## 目录

- `index.html`：页面内容与结构
- `styles.css`：响应式样式
- `script.js`：导航与二维码弹窗交互
- `images/`：页面图片与小程序码
- `.github/workflows/pages.yml`：GitHub Pages 部署
- `publish.sh`：推送并启用 Pages
