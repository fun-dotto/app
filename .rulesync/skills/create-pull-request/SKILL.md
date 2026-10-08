---
name: create-pull-request
description: 現在のブランチから GitHub の Pull Request を作成する。PR の作成を依頼されたときに使う。
---

# Pull Request の作成

1. `git fetch origin` を実行し、ベースブランチ (既定は `main`) との差分全体を `git diff origin/main...HEAD` と `git log origin/main..HEAD` で確認する。
2. 未 push のコミットがあれば push する。
3. `.github/PULL_REQUEST_TEMPLATE.md` を読み、その形式を引き継いで本文を作成する。
   - コミットメッセージの羅列ではなく、ベースブランチとの差分全体を踏まえて記述する。
   - タイトルと本文は全て日本語で記述する。
4. 以下の条件で作成する。

   ```sh
   gh pr create --draft --assignee @me --base main --title "<タイトル>" --body "<本文>"
   ```

5. 作成した PR の URL をユーザーに伝える。
