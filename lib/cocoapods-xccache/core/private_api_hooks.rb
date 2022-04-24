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
            def parse_xccache_option(name, requirements)
                should_cache = Pod::Podfile::DSL.cache_all

                options = requirements.last
                if options.is_a?(Hash) && options[Pod::CacheOption.keyword] != nil 
                    should_cache = options.delete(Pod::CacheOption.keyword)
                    requirements.pop if options.empty?
                end
        
                pod_name = Specification.root_name(name)
                
                if should_cache == true
                    @cache_pod_names ||= []
                    @cache_pod_names.push pod_name
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
    class Installer

        def cache_pod_targets
            @cache_pod_targets ||= (
            all = []

            aggregate_targets = self.aggregate_targets
            aggregate_targets.each do |aggregate_target|
                target_definition = aggregate_target.target_definition
                targets = aggregate_target.pod_targets || []

                # filter prebuild
                prebuild_names = target_definition.prebuild_framework_pod_names
                if not Podfile::DSL.prebuild_all
                    targets = targets.select { |pod_target| prebuild_names.include?(pod_target.pod_name) } 
                end
                dependency_targets = targets.map {|t| t.recursive_dependent_targets }.flatten.uniq || []
                targets = (targets + dependency_targets).uniq

                # filter should not prebuild
                explict_should_not_names = target_definition.should_not_prebuild_framework_pod_names
                targets = targets.reject { |pod_target| explict_should_not_names.include?(pod_target.pod_name) } 

                all += targets
            end

            all = all.reject {|pod_target| sandbox.local?(pod_target.pod_name) }
            all.uniq
            )
        end

        # the root names who needs cache, including dependency pods.
        def cache_pod_names 
           @cache_pod_names ||= self.cache_pod_targets.map(&:pod_name)
        end

    end
end
