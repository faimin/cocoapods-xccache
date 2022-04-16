require 'cocoapods-xccache/command'
require 'cocoapods'
require_relative 'cocoapods-xccache/core/zabel'

module CocoapodsXccache
    # 注册post_install钩子
    Pod::HooksManager.register('cocoapods-xccache', :post_install) do |context|
        puts ""
        puts ">>>>>>>>>: post_install, 开始执行 pre 函数"
        Zabel.zabel_pre({})
    end

    # 注册post update钩子
    Pod::HooksManager.register('cocoapods-xccache', :post_update) do |context|
        puts ""
        puts ">>>>>>>>>>: post_update, 开始执行 pre 函数"
        Zabel.zabel_pre({})
    end
end