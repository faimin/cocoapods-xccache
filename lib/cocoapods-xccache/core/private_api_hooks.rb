require_relative "podfile_options"

# https://github.com/joncardasis/cocoapods-user-defined-build-types/blob/e34a802bb135ed3549f2b79ac0ac146c645106a7/lib/cocoapods-user-defined-build-types/private_api_hooks.rb
#
# https://github.com/leavez/cocoapods-binary/blob/b22bd948a3168a323b1ffa61095468f2c91c1cee/lib/cocoapods-binary/helper/podfile_options.rb

module Pod
    
    class CacheOption
        def self.keyword
            :cache
        end
    end

    class Podfile
        class TargetDefinition

            @@ignore_pod_names = Set.new

            def self.ignore_pod_names
                @@ignore_pod_names
            end

            def parse_xccache_option(name, requirements)
                should_cache = Pod::Podfile::DSL.cache_all

                options = requirements.last
                if options.is_a?(Hash) && options[Pod::CacheOption.keyword] != nil 
                    should_cache = options.delete(Pod::CacheOption.keyword)
                    requirements.pop if options.empty?
                end
        
                pod_name = Specification.root_name(name)
                
                if should_cache == false
                    @@ignore_pod_names.add(pod_name)
                end
            end

            # ======================
            # ==== PATCH METHOD ====
            # ======================
            swizzled_parse_subspecs = instance_method(:parse_subspecs)

            define_method(:parse_subspecs) do |name, requirements|
                parse_xccache_option(name, requirements)
                # Call origin Method
                swizzled_parse_subspecs.bind(self).(name, requirements)
            end
            
        end
    end
end


module Pod
    class Target
        attr_accessor :user_define_whether_cache
    end

    class Installer

        def resolve_all_pod_cache(pod_targets)
            root_pod_cache_options = Pod::Podfile::TargetDefinition.ignore_pod_names.clone
            pod_targets.each do |target|
                # next if not root_pod_cache_options.include?(target.name)
        
                notCache = root_pod_cache_options.include?(target.name)
                dependencies = target.dependent_targets
        
                # Cascade build_type down
                while not dependencies.empty?
                    new_dependencies = []
                    dependencies.each do |dep_target|
                        dep_target.user_define_whether_cache = (not notCache)
                        new_dependencies.push(*dep_target.dependent_targets)
                    end
                    dependencies = new_dependencies
                end
        
                target.user_define_whether_cache = (not notCache)
            end
        end

        # ======================
        # ==== PATCH METHOD ====
        # ======================
        swizzled_analyze = instance_method(:analyze)

        define_method(:analyze) do |analyzer = create_analyzer|
            # Call origin Method
            swizzled_analyze.bind(self).(analyzer)

            resolve_all_pod_cache(pod_targets)

            cache_hash = {}
            pod_targets.each do | target |
                cache_hash[target.name] = target.user_define_whether_cache
            end
            File.write(Zabel.zd_cache_file_path, cache_hash.to_yaml)
        end
    end
end
