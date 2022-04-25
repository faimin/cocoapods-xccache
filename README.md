# cocoapods-xccache

A CocoaPods plugin which cache pods with [zabel](https://github.com/WeijunDeng/Zabel) to speed compile.

## Installation

```ruby
$ gem install cocoapods-xccache
```

local install

```ruby
#cd to the project root

$ gem build cocoapods-xccache.gemspec
$ gem install cocoapods-xccache-0.0.1.gem
```

## Usage

add the `plugin` to `Podfile`.

```ruby
plugin 'cocoapods-xccache'
```

default cache all pods, if you want ignore one, set `:cache => false` flag.

e.g.

```ruby
pod 'SDWebImage', :cache => false
```

## Reference

- [Zabel](https://github.com/WeijunDeng/Zabel)

- [使用VSCode debug CocoaPods源码和插件](https://github.com/X140Yu/debug_cocoapods_plugins_in_vscode)

- [cocoapods-localpodbinary](https://github.com/wing3501/cocoapods-localpodbinary)

- [cocoapods-binary](https://github.com/leavez/cocoapods-binary)

- [Cocoapods 命令解析器 CLAide](https://juejin.cn/post/7005979638904127518)
