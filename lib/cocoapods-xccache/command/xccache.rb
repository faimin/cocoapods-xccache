module Pod
  class Command
    # This is an example of a cocoapods plugin adding a top-level subcommand
    # to the 'pod' command.
    #
    # You can also create subcommands of existing or new commands. Say you
    # wanted to add a subcommand to `list` to show newly deprecated pods,
    # (e.g. `pod list deprecated`), there are a few things that would need
    # to change.
    #
    # - move this file to `lib/pod/command/list/deprecated.rb` and update
    #   the class to exist in the the Pod::Command::List namespace
    # - change this class to extend from `List` instead of `Command`. This
    #   tells the plugin system that it is a subcommand of `list`.
    # - edit `lib/cocoapods_plugins.rb` to require this file
    #
    # @todo Create a PR to add your plugin to CocoaPods/cocoapods.org
    #       in the `plugins.json` file, once your plugin is released.
    #
    class Xccache < Command
      self.summary = '基于Xcode cache的缓存插件之缓存'

      # 参数设置 https://juejin.cn/post/7005979638904127518

      self.description = <<-DESC
        一个CocoaPods插件，基于对zabel的封装
      DESC

      self.arguments = [
        #CLAide::Argument.new('update',true)
      ]

      # 可选参数
      def self.options 
        [
          ['--update', 'need exec pod update'],
          ['--install', 'need exec pod install']
        ].concat(super)
      end

      def initialize(argv)
        #puts "xccache 初始化参数 #{argv.to_s}"
        #@name = argv.shift_argument
        @update = argv.flag?("update")
        @install = argv.flag?("install")
        super
      end

      def validate!
        super
        #help! 'A Pod name is required.' unless @name
      end

      def run
        UI.puts "[XCCACHE/I] 开始执行pod xccache 流程:"
        Zabel.zabel_post({})
      end
    end
  end
end
