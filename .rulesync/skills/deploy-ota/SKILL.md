---
name: deploy-ota
description: GitHub Actions の Deploy OTA ワークフロー (`.github/workflows/deploy-ota.yml`) を手動で発火し、iOS/Android の全フレーバーを Firebase App Distribution へ配信する。OTA 配信・テスト配信を依頼されたときに使う。
argument-hint: "[branch]"
---

# Deploy OTA の発火

1. 対象ブランチを決める。引数 `$ARGUMENTS` で指定されたブランチを使い、指定がなければ `main` を使う。
2. 対象ブランチがリモートに push 済みで、ローカルとの差分がないことを確認する。
   - 未 push のコミットがある場合は、push してよいかユーザーに確認する。
3. 対象ブランチと配信内容 (iOS/Android × dev/stg/prd) をユーザーに伝え、発火してよいか確認する。
4. ワークフローを発火する。

   ```sh
   gh workflow run deploy-ota.yml --ref <branch>
   ```

5. 数秒待ってから、発火した Run を取得して URL をユーザーに伝える。

   ```sh
   gh run list --workflow deploy-ota.yml --branch <branch> --event workflow_dispatch --limit 1 --json databaseId,url,status
   ```

6. 完了まで見守るよう依頼された場合は `gh run watch <run-id> --exit-status` をバックグラウンドで実行し、結果 (失敗時は `gh run view <run-id> --log-failed` の要点) を報告する。

## 注意

- `main` への push でも自動実行されるため、`main` で発火すると同一コミットの重複配信になりうる。その場合は発火前にユーザーへ伝える。
- 同一ブランチの実行は `concurrency` によりキャンセルされず待機する。
