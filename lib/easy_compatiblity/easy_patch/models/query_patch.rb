module EasyCompatibility
  module QueryPatch

    def self.included(base)
      base.include InstanceMethods
      base.extend(ClassMethods)

      base.class_eval do
        alias_method :add_available_filter_without_easy_compatibility, :add_available_filter
        alias_method :add_available_filter, :add_available_filter_with_easy_compatibility
      end
    end

    module InstanceMethods
      def add_available_filter_with_easy_compatibility(field, options)
        self.filters ||= {}
        add_available_filter_without_easy_compatibility(field, options)
      end
    end

    module ClassMethods
    end
  end
end
RedmineExtensions::PatchManager.register_model_patch 'Query', 'EasyCompatibility::QueryPatch'#, if: proc { Redmine::Plugin.installed?(:redmine_contacts) }
