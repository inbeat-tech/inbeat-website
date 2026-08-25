# InBeat 官网

零依赖静态站点，入口为 `index.html`。通过 GitHub Pages 发布。

## 线上地址

自定义域名（仓库根目录 `CNAME`）：

```text
https://inbeat.cn/
```

GitHub 默认地址仍可用：`https://inbeat-tech.github.io/inbeat-website/`

## 自定义域名（CNAME）

根目录 `CNAME` 文件只写一行规范域名，不要 `https://`：

```text
inbeat.cn
```

部署工作流会把它拷进 Pages 产物。若漏拷，GitHub 会在每次发布时清掉自定义域名。

### DNS

在 `inbeat.cn` 的 DNS 控制台添加：

| 类型 | 主机记录 | 值 |
|------|----------|-----|
| A | `@` | `185.199.108.153` |
| A | `@` | `185.199.109.153` |
| A | `@` | `185.199.110.153` |
| A | `@` | `185.199.111.153` |
| AAAA | `@` | `2606:50c0:8000::153` |
| AAAA | `@` | `2606:50c0:8001::153` |
| AAAA | `@` | `2606:50c0:8002::153` |
| AAAA | `@` | `2606:50c0:8003::153` |
| CNAME | `www` | `inbeat-tech.github.io` |

apex（`inbeat.cn`）不能用 DNS CNAME，必须用上面的 A / AAAA。`www` 才是 CNAME 到 `inbeat-tech.github.io`。

`www.inbeat.cn` 配好后，GitHub 会把 www 跳到 apex。DNS 生效后到 **Settings → Pages** 勾选 **Enforce HTTPS**。验证域名时按页面提示加一条 `_github-pages-challenge-inbeat-tech` 的 TXT。

若要把 `www.inbeat.cn` 当主域名，把 `CNAME` 文件改成那一行即可。

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

脚本会推送到 `origin`（`git@github.com:inbeat-tech/inbeat-website.git`），并把 Pages 切到 **GitHub Actions**、绑定 `CNAME` 里的域名。之后每次推送 `main` 都会自动部署。

**不用 `gh` 时：**

```bash
git push -u origin main
```

然后 GitHub → **Settings** → **Pages** → Build and deployment → **GitHub Actions**，Custom domain 填 `inbeat.cn`。

## 目录

- `index.html`：页面内容与结构
- `styles.css`：响应式样式
- `script.js`：导航与二维码弹窗交互
- `images/`：页面图片与小程序码
- `CNAME`：GitHub Pages 自定义域名
- `.github/workflows/pages.yml`：GitHub Pages 部署
- `publish.sh`：推送并启用 Pages
