Redmine::Plugin.register :easy_compatibility do
  name 'Easy Compatibility'
  author 'Easy Software'
  author_url 'http://www.easyproject.cz/en'
  description 'Fix compatibility with redmine_zenedit and redmine_contacts'
  version '1.0'
end

Dir[File.dirname(__FILE__) + '/lib/easy_compatiblity/easy_patch/**/*.rb'].each {|file| require_dependency file }