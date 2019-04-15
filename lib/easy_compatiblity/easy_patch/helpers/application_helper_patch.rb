module EasyCompatibility
  module ApplicationHelperPatch

    def self.included(base)
      base.include InstanceMethods
      base.extend(ClassMethods)

      base.class_eval do
        alias_method_chain :javascript_heads, :easy_compatibility
      end
    end

    module InstanceMethods
      def javascript_heads_with_easy_compatibility
        tags = javascript_heads_without_easy_compatibility
        if controller.is_a?(EasyWbsController) || controller.is_a?(EasyGanttController)
          tags << "\n".html_safe
          tags << [
            javascript_include_tag(:zenedit, plugin: 'redmine_zenedit'),
            stylesheet_link_tag(:zenedit, plugin: 'redmine_zenedit')
          ].join("\n".html_safe).html_safe
        end
        tags
      end
    end

    module ClassMethods
    end
  end
end
RedmineExtensions::PatchManager.register_helper_patch 'ApplicationHelper', 'EasyCompatibility::ApplicationHelperPatch', if: proc { Redmine::Plugin.installed?(:redmine_zenedit) }
