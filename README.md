# dotfiles

必ずsetup対象のユーザで実行すること．
また，cloneされるパスや実行時のカレントディレクトリも今の所重要なので，下のコマンドの特に最後のスクリプト実行コマンドを必ず守ること．

```
$ sudo apt update & sudo apt install git 
$ mkdir ~/git
$ git clone https://github.com/kawaharasouta/dotfiles ~/git/dotfiles & cd $_
$ ./scripts/setup.sh
```
