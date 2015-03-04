

Redmine::Plugin.register :redmine_diff_mail do
  name 'Redmine Diff Mail plugin'
  author 'basyura name'
  description 'This is a plugin for Redmine'
  version '0.0.1'
  url 'http://example.com/path/to/plugin'
  author_url 'http://basyura.org'
end

ActionDispatch::Callbacks.to_prepare do
  require_dependency 'wiki_page'
	WikiPage.send(:include, DiffMail::WikiPagePatch)
end

require 'wiki_page_patch.rb'
