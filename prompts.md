# ohmyform-zh Prompts

> 项目：ohmyform/ohmyform 汉化版（ohmyform-zh）
> 技术栈：React + Next.js 前端，NestJS + MongoDB 后端，i18next 国际化

---

## 功能迭代

**1. 添加表单逻辑跳转功能**
在 ohmyform-zh 的表单编辑器中添加条件逻辑功能。根据用户对某道题的回答，自动跳转到指定题目或结束表单。在题目设置面板中添加"逻辑跳转"配置项，支持多条件组合。

**2. 支持表单模板库**
在 ohmyform-zh 中添加表单模板功能，提供常用表单模板（满意度调查、活动报名、联系表单等）。用户可以从模板库一键创建表单，也可以将自己的表单保存为模板分享给其他用户。

**3. 添加表单数据图表分析**
在 ohmyform-zh 的表单提交统计页面，为每道题目自动生成可视化图表：单选/多选题显示饼图，评分题显示柱状图，文本题显示词云，帮助用户快速分析问卷结果。

**4. 支持表单提交 Webhook 通知**
在 ohmyform-zh 的表单设置中添加 Webhook 配置，每次有新提交时自动向指定 URL 发送 POST 请求，包含提交数据的 JSON 格式，支持自定义请求头和重试机制。

**5. 添加表单访问密码保护**
在 ohmyform-zh 中为表单添加密码保护功能。表单创建者可以设置访问密码，填写者需要输入正确密码才能查看和提交表单，密码在服务端进行 bcrypt 哈希存储。

---

## Bug 修复

**6. 修复文件上传题型在移动端无法使用**
在 ohmyform-zh 的表单填写页面，文件上传题型在移动端浏览器中点击无响应。请检查文件输入框的触摸事件处理，确保在 iOS Safari 和 Android Chrome 上正常工作。

**7. 修复表单提交后数据乱序**
在 ohmyform-zh 中，表单提交的数据在后台查看时，题目顺序与表单设计时的顺序不一致。请检查提交数据的存储逻辑，确保按题目索引顺序保存和展示提交数据。

**8. 修复批量导出提交数据时中文乱码**
在 ohmyform-zh 中，将表单提交数据导出为 CSV 文件时，包含中文的字段在 Excel 中打开显示乱码。请在 CSV 文件头部添加 BOM（`\uFEFF`），确保 Excel 正确识别 UTF-8 编码。

**9. 修复表单嵌入代码在 HTTPS 页面中不工作**
在 ohmyform-zh 中，将表单嵌入到 HTTPS 页面时，如果 ohmyform 部署在 HTTP 环境下，会因混合内容策略被浏览器阻止。请在嵌入代码生成时检测协议，并提示用户配置 HTTPS。

**10. 修复长文本回答在列表页截断无法展开**
在 ohmyform-zh 的表单提交列表中，长文本回答被截断显示，且没有展开查看完整内容的方式。请添加"展开/收起"功能，或在点击时弹出完整内容的对话框。

---

## 重构

**11. 将表单验证逻辑统一为共享 Schema**
ohmyform-zh 的表单验证逻辑分散在前端和后端，存在重复代码。请使用 Zod 定义共享的验证 Schema，前后端统一引用，确保验证规则一致性。

**12. 将表单渲染引擎抽象为独立包**
ohmyform-zh 的表单渲染逻辑与 UI 框架耦合紧密。请将表单渲染引擎抽象为独立的 `@ohmyform/core` 包，与框架无关，便于在不同前端框架中复用。

---

## 测试

**13. 为表单 CRUD API 编写集成测试**
使用 Jest + Supertest 为 ohmyform-zh 的表单 API 编写集成测试，覆盖：创建表单、获取表单列表、更新表单字段、删除表单、提交表单数据、获取提交统计。使用内存 MongoDB 隔离测试。

**14. 为表单渲染组件编写快照测试**
使用 React Testing Library 为 ohmyform-zh 的各种题型组件（单选/多选/文本/评分/文件上传）编写快照测试和交互测试，确保题型渲染正确，用户输入被正确捕获。

**15. 为 i18n 翻译完整性编写测试**
为 ohmyform-zh 编写翻译完整性检查脚本，对比所有语言文件与英文基准文件，找出缺失的翻译 key，并在 CI 中运行此检查，防止新增功能时遗漏翻译。

---

## 代码理解

**16. 解释 ohmyform 的表单数据模型设计**
在 ohmyform-zh 中，MongoDB 中的表单数据是如何建模的？Form、Field、Submission 之间的关系是怎样的？如何支持动态字段类型（不同题型有不同的配置属性）？

**17. 解释 ohmyform 的多语言表单支持**
在 ohmyform-zh 中，界面语言通过 i18next 实现，默认设为中文。请解释语言文件的目录结构、`fallbackLng` 的作用，以及如何在 NestJS 后端的错误消息中也实现多语言支持。

---

## DevOps

**18. 编写 GitHub Actions 多架构构建流水线**
为 ohmyform-zh 编写 `.github/workflows/docker-build.yml`，实现推送 main 分支时自动构建多架构（amd64/arm64）Docker 镜像并推送到 Docker Hub，分别缓存前端 yarn 和后端 npm 依赖。

**19. 编写 docker-compose.yml 生产部署配置**
为 ohmyform-zh 编写 `docker-compose.yml`，包含：ohmyform 服务（映射 3000 端口）、MongoDB 服务（数据持久化）、环境变量配置（MongoDB URI、JWT 密钥、邮件服务）、健康检查、自动重启。

**20. 编写数据库备份脚本**
为 ohmyform-zh 编写自动备份脚本，使用 `mongodump` 定期备份 MongoDB 数据库，保留最近 7 天的备份，支持通过环境变量配置备份目录和 MongoDB 连接信息。

---

## 构建与截图命令

**构建截图：**
```bash
cd /path/to/ohmyform-zh && docker build -t ohmyform-zh-test .
```

**网页截图：**
```bash
docker run -d -p 3000:3000 --name ohmyform-zh-test ohmyform-zh-test && sleep 5 && open http://localhost:3000
```

**清理：**
```bash
docker rm -f ohmyform-zh-test && docker rmi ohmyform-zh-test
```
