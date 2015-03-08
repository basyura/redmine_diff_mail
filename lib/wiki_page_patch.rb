module DiffMail
  #
  #
  module WikiPagePatch
    #
    #
    def diff_text(version_to = nil, version_from = nil)
      version_to = version_to ? version_to.to_i : self.content.version
      content_to = content.versions.find_by_version(version_to)
      content_from = version_from ? content.versions.find_by_version(version_from.to_i) : content_to.try(:previous)

      return nil unless content_to && content_from

      if content_from.version > content_to.version
        content_to, content_from = content_from, content_to
      end

      if RbConfig::CONFIG["host_os"].downcase =~ /mswin|mingw/
        windows_text(content_from, content_to)
      else
        unix_text(content_from, content_to)
      end
    end
    #
    #
    private
    #
    #
    def unix_text(content_from, content_to)

      path1 = Tempfile.open("temp1") do |fp|
        fp.puts content_from.text
        fp.path
      end
      path2 = Tempfile.open("temp2") do |fp|
        fp.puts content_to.text
        fp.path
      end

      array = `diff -u #{path1} #{path2}`.split("\n")
      array = array[2, array.count]

      File.delete(path1)
      File.delete(path2)

      array.join("\n")
    end
    #
    #
    def windows_text(content_from, content_to)

      now = Time.now.strftime("%Y%m%d%H%M%S%3N")

      path1 = "#{ENV['TEMP']}\\redmine_wiki_page_mail_temp_#{now}_from_#{content_from.page.id}".upcase
      path2 = "#{ENV['TEMP']}\\redmine_wiki_page_mail_temp_#{now}_to_#{content_to.page.id}".upcase

      open(path1, "w:sjis") {|f| f.puts content_from.text }
      open(path2, "w:sjis") {|f| f.puts content_to.text   }

      msg = `fc /n #{path1} #{path2}`.toutf8
      msg = msg.gsub(path1, "version #{content_from.version}")
      msg = msg.gsub(path2, "version #{content_to.version}")
      msg = msg.gsub("\n\n", "\n")

      File.delete(path1)
      File.delete(path2)

      msg
    end
  end
end
