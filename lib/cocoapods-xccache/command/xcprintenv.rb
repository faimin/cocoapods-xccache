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
      class Xcprintenv < Command
        self.summary = '打印环境变量'
  
        # 参数设置 https://juejin.cn/post/7005979638904127518
  
        self.description = <<-DESC
          一个CocoaPods插件，基于对zabel的封装
        DESC
  
        self.arguments = [
        #   CLAide::Argument.new('update', true),
        ]

        def self.options
            [
                ['--targetname', 'target名称'],
                ["--projectpath", '工程路径']
            ].concat(super)
        end
  
        def initialize(argv)
          #puts "xccache 初始化参数 #{argv.to_s}"
          #@name = argv.shift_argument
          @target_name = argv.option("targetname")
          @project_path = argv.option("projectpath")
          super
        end
  
        def validate!
          super
          #help! 'A Pod name is required.' unless @name
        end
  
        def run
          UI.puts "[XCCACHE/I] 执行 printEnv"
          Zabel.zabel_printenv(@target_name, @project_path)
        end
      end
    end
  end
  