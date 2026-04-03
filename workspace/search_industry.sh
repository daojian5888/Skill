#!/bin/bash
# 搜索道简网络相关行业最新动态

echo "=== 搜索1: 企业数字化转型 2026最新动态 ==="
curl -s "https://www.tavily.com/api/v1/search" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $TAVILY_API_KEY" \
  -d '{"query":"企业数字化转型 2026年最新政策动态", "search_depth":"basic", "max_results":5, "time_range":"3m"}' 2>/dev/null | jq -r '.results[]? | "【标题】\(.title)\n【来源】\(.source)\n【链接】\(.url)\n【摘要】\(.content)\n---"' || echo "Tavily搜索失败，尝试其他方式"

echo ""
echo "=== 搜索2: 智能安防行业动态 2026 ==="
curl -s "https://www.tavily.com/api/v1/search" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $TAVILY_API_KEY" \
  -d '{"query":"智能安防 弱电工程 2026年最新动态", "search_depth":"basic", "max_results":5, "time_range":"3m"}' 2>/dev/null | jq -r '.results[]? | "【标题】\(.title)\n【来源】\(.source)\n【链接】\(.url)\n【摘要】\(.content)\n---"' || echo "Tavily搜索失败"

echo ""
echo "=== 搜索3: 网络系统集成 IT运维 2026最新 ==="
curl -s "https://www.tavily.com/api/v1/search" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $TAVILY_API_KEY" \
  -d '{"query":"网络系统集成 IT运维服务 2026最新动态", "search_depth":"basic", "max_results":5, "time_range":"3m"}' 2>/dev/null | jq -r '.results[]? | "【标题】\(.title)\n【来源】\(.source)\n【链接】\(.url)\n【摘要】\(.content)\n---"' || echo "Tavily搜索失败"

echo ""
echo "=== 搜索4: 政企数字化 2026最新动态 ==="
curl -s "https://www.tavily.com/api/v1/search" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $TAVILY_API_KEY" \
  -d '{"query":"政企数字化转型 解决方案 2026年最新", "search_depth":"basic", "max_results":5, "time_range":"3m"}' 2>/dev/null | jq -r '.results[]? | "【标题】\(.title)\n【来源】\(.source)\n【链接】\(.url)\n【摘要】\(.content)\n---"' || echo "Tavily搜索失败"
