# Windowsの設定ファイルなど

## 普段利用するソフトウェアのインストール方法

### 前準備

Chocolateyからインストールするためには、ダウンロードしたスクリプトを実行できる必要がある。なので、PowerShellのExecutionPolicyを変更する。

```
Get-ExecutionPolicy # 現在の設定を確認
Set-ExecutionPolicy RemoteSigned # RemoteSignedに設定
```

### Chocolateyのインストール

PowerShellで以下のコマンドを実行する。（[Installation](https://chocolatey.org/install)）

```
iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
```

### インストール

PowerShellを管理者権限で起動し、以下のコマンドを実行する。

```
choco install packages.config
```


## その他の初期設定

vimfilesフォルダをホームディレクトリ以下に移動する。またはジャンクションなどを作成する。
`.latexmkrc`と`.gitconfig`もホームディレクトリに配置する（Windowsではシンボリックリンクを作成するのが面倒なのでコピーが良い）。


## Vagrant

プログラミングのできる仮想環境を一発で作成するVagrantfileを書いている予定だけど微妙。



---------

## OneGetはやめた

OneGetよりChocolateyのほうが機能が豊富。
PackageManagementはデフォルトで入っているといっても設定が必要なので、それならChocolateyをインストールしても同じだと思った。

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
