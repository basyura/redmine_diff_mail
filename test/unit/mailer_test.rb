# Redmine - project management software
# Copyright (C) 2006-2014  Jean-Philippe Lang
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

require File.expand_path('../../test_helper', __FILE__)

class MailerTest < ActiveSupport::TestCase

  def test_wiki_content_updated
    #content = WikiContent.find(1)
    #valid_languages.each do |lang|
      #Setting.default_language = lang.to_s
      #assert_difference 'ActionMailer::Base.deliveries.size' do
        #assert Mailer.wiki_content_updated(content).deliver
        #assert_select_email do
          #assert_select 'a[href=?]',
            #'http://mydomain.foo/projects/ecookbook/wiki/CookBook_documentation',
            #:text => 'CookBook documentation'
        #end
      #end
    #end
  end
end
