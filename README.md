# OhMyForm

## 功能特性

- 创建自定义表单和问卷
- 多种题型（单选/多选/文本/评分/文件上传等）
- 表单提交数据统计
- 多语言支持（默认中文）
- 用户管理与权限控制
- 表单嵌入与分享

## 快速部署

```bash
docker run -d \
  -p 3000:3000 \
  -e MONGODB_URI=mongodb://mongo:27017/ohmyform \
  --name ohmyform-zh \
  wsng911/ohmyform-zh:latest
```

访问 `http://localhost:3000`
