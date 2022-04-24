module Pod    
    class Podfile
        module DSL
            
            private
            #attr_accessor :cache_all
            @@cache_all = true

            def self.cache_all
                return @@cache_all
            end

            # Enable cache for all pods
            # it has a lower priority to other cache settings
            def cache_all!
                @@cache_all = true
            end

        end
    end
end
