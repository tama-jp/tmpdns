# TmpDNS

テンポラリなネームサーバー．
設定ファイルなどは存在せず，起動時のコマンドライン引数のみで完結する簡易DNSです．

ACMEのDNS認証用に作ったやつです．
APIがないネームサーバを使っている場合に_acme-challengeのNSレコードを適当なホストに向けておいて，そこで起動する想定．
(dns_tmpdns.sh がacme.shから使えます)

Dockerビルド。ACMへインストールを追加。

# install

```
git clone https://github.com/tama-jp/tmpdns.git
cd ./tmpdns
sh install.sh
```

# 証明書を取得する

```
acme.sh --issue --dnssleep 60 --dns dns_tmpdns -d example.jp 
```

# License

MIT License
