# Windowsの設定ファイルなど

## 普段利用するソフトウェアのインストール方法

### 前準備

Chocolateyからインストールするためには、ダウンロードしたスクリプトを実行できる必要がある。なので、PowerShellのExecutionPolicyを変更する。

```
Get-ExecutionPolicy # 現在の設定を確認
Set-ExecutionPolicy RemoteSigned # RemoteSignedに設定
```

### OneGetの設定

Windows 10にはPackageManagement (OneGet)の機能がある。Chocolateyからパッケージをインストールできるように設定する。
そして、毎回確認が出るのが面倒なので、Chocolateyのsourceをtrustedに設定する（自己責任で）。

```
Get-PackageProvider -Name Chocolatey
Get-PackageProvider -Name NuGet
set-packagesource -Name "chocolatey" -NewName "trusted-chocolatey" -Trusted -ProviderName "chocolatey"
```

### インストール

PowerShellを管理者権限で起動し、以下のコマンドを実行する。
するといろいろインストールされる。

```
./setup.ps1
```

Windows 10でない場合は、Chocolateyをインストールして、package.configを書きかえて最新にしてインストールすると良いと思う。そのときになって考える。


## その他の初期設定

vimfilesフォルダをホームディレクトリ以下に移動する。またはジャンクションなどを作成する。
`.latexmkrc`と`.gitconfig`もホームディレクトリに配置する（Windowsではシンボリックリンクを作成するのが面倒なのでコピーが良い）。


## Vagrant

プログラミングのできる仮想環境を一発で作成するVagrantfileを書いている予定だけど微妙。


