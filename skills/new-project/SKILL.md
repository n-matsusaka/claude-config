---
name: new-project
description: 新しいプロジェクトを開始する。「新プロジェクト」「プロジェクト作って」「新規プロジェクト」と言われたら自動的にこのスキルを使う。
---

# 新プロジェクト作成スキル

## 手順

### 1. ヒアリング
まとめて聞く。すでに分かっている項目は飛ばす。

```
新しいプロジェクトを作ります。教えてください：
1. **プロジェクト名**（英語・ハイフン区切り。例: gas-automation）
2. **目的**（1〜2行で）
3. **使用技術**（例: GAS + スプレッドシート）
4. **GCPプロジェクト**: 会社業務用（collabohouse-automation）or 個人用（gas-management-489201）？
5. **外部API**: Gemini API等を使う場合は申告してください
```

### 2. 最新設定の取得
プロジェクト作成前に、必ずGitHubから最新の設定とテンプレートを取得する。

```bash
# グローバル設定（CLAUDE.md + skills）を最新化
if [ -d "$HOME/claude-config" ]; then
  cd "$HOME/claude-config" && git pull origin master
else
  git clone https://github.com/n-matsusaka/claude-config.git "$HOME/claude-config"
fi
cp "$HOME/claude-config/CLAUDE.md" "$HOME/.claude/CLAUDE.md"
cp -r "$HOME/claude-config/skills/"* "$HOME/.claude/skills/"

# テンプレートを最新化
if [ -d "$HOME/_template" ]; then
  cd "$HOME/_template" && git pull origin master
else
  git clone https://github.com/n-matsusaka/claude-template.git "$HOME/_template"
fi
```

### 3. プロジェクト作成
```bash
# 重複チェック
ls "$HOME/projects/[名前]" 2>/dev/null && echo "既に存在します"

# コピーして配布用ファイルを除外
cp -r "$HOME/_template" "$HOME/projects/[名前]"
rm -rf "$HOME/projects/[名前]/.git" "$HOME/projects/[名前]/skills" "$HOME/projects/[名前]/README.md"

# CLAUDE.md のプレースホルダーを置換
# {{PROJECT_NAME}} / {{PURPOSE}} / {{TECH_STACK}}

# Git初期化
cd "$HOME/projects/[名前]"
git init && git add -A && git commit -m "初期セットアップ"
```

### 4. セキュリティ設定

#### 4a. .gitignore の確認
テンプレートからコピーされた `.gitignore` に以下が含まれていることを確認：
- `.env` / `.env.*`
- `credentials.json` / `token.json`

#### 4b. APIキーの発行（外部APIを使う場合）
プロジェクト専用のAPIキーを発行する（使い回し禁止）。

**Gemini API の場合:**
```bash
# API有効化（初回のみ）
gcloud services enable generativelanguage.googleapis.com --project=[GCPプロジェクトID]

# キー発行（Gemini API のみに制限）
gcloud services api-keys create \
  --display-name="[プロジェクト名]-gemini" \
  --api-target=service=generativelanguage.googleapis.com \
  --project=[GCPプロジェクトID]
```

#### 4c. シークレットの保存
発行したキーをコードにハードコードしない。保存先は技術スタックで決まる：

| 技術 | 保存先 | 手順 |
|-----|-------|------|
| Python / Node.js | `.env` ファイル | `GEMINI_API_KEY=AIza...` と記載 |
| GAS | スクリプトプロパティ | `_setup_props.gs` で設定→clasp push→GASエディタで実行→削除→再push |
| Cloud Run | GCP Secret Manager | `gcloud secrets create` |

#### 4d. hooks の確認
テンプレートからコピーされた hooks が正しく設置されていることを確認：
```bash
ls "$HOME/projects/[名前]/.claude/hooks/"
# block-dangerous.sh, secret-guard.sh, secret-guard-write.sh, verify-gas-deploy.sh, verify-xlsx.sh が存在すること
```

### 5. 完了報告
```
✅ ~/projects/[名前] を作成しました

📁 構成:
  .claude/hooks/  — セキュリティhook設置済み
  .gitignore      — credentials/token/.env 除外済み
  docs/input/     — 要件・参考資料
  docs/output/    — 成果物

🔑 APIキー:
  [発行したキーの名前] → [保存先]

VS Codeで開く → Ctrl+Shift+N → フォルダーを開く
```
