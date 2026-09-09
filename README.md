# 回门宴邀请函 - Cloudflare Pages 部署说明

本项目为杜冠云 & 向可微的回门宴电子邀请函，支持两种超简单的部署上线方式：

---

## 方式一：一键脚本部署（推荐，最省心）

1. 双击运行当前目录下的 **`deploy.bat`**。
2. 若首次运行尚未登录 Cloudflare，脚本会自动在浏览器打开授权页面，点击 **「Allow / 允许」** 即可。
3. 脚本会自动创建项目并将本目录的文件一键推送到 Cloudflare Pages 全球 CDN。
4. 部署成功后，控制台会输出访问链接，如：
   ```
   https://wedding-invitation-huimen.pages.dev
   ```

---

## 方式二：Cloudflare 网页控制台拖拽上传（免装任何工具）

如果您不想走命令行或浏览器授权弹窗，可以直接在 Cloudflare 官网直接拖拽上传：

1. 打开 [Cloudflare 控制台](https://dash.cloudflare.com/) 并登录账号。
2. 在左侧菜单点击 **「Workers 和 Pages」** -> **「概述 (Overview)」**。
3. 点击右上角 **「创建 (Create)」** -> 切换到 **「Pages」** 标签页。
4. 选择 **「上传资产 (Upload assets)」**。
5. 项目名称输入例如 `wedding-invitation-huimen`。
6. 点击上传并选择当前的文件夹（或打包好的 zip）。
7. 点击 **「部署站点 (Deploy site)」**，数秒内即可上线！

---

## 包含文件清单

- `index.html`：回门宴邀请函完整页面（含倒计时、相册、一键导航、微信分享卡片等）。
- `share-cover.jpg`：微信/朋友圈/社交卡片分享封面图。
- `assets/`：背景音乐与相册媒体资源。
- `deploy.bat`：Windows 一键部署脚本。

---

## 常用进阶设置

- **自定义域名**：在 Cloudflare Pages 项目后台中点击 **「自定义域 (Custom domains)」**，即可免费绑定您自己的独立域名（自动配置免费 SSL 证书）。
- **国内访问加速**：Cloudflare 默认提供全球 Anycast CDN 节点，无需备案即可快速访问。
