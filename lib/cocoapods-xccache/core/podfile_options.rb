module Pod    
    class Podfile
        module DSL
            
            private
            class_attr_accessor :cache_all
            cache_all = false

            # Enable cache for all pods
            # it has a lower priority to other cache settings
            def all_cache!
                DSL.cache_all = true
            end

        end
    end
end
