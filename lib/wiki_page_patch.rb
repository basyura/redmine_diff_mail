module DiffMail
  module WikiPagePatch
    def self.included(base)
    end
    def diff_text(version_to = nil, version_from = nil)
      version_to = version_to ? version_to.to_i : self.content.version
      content_to = content.versions.find_by_version(version_to)
      content_from = version_from ? content.versions.find_by_version(version_from.to_i) : content_to.try(:previous)

      puts "to   #{content_to.id}"
      puts "from #{content_from.id}"
      return nil unless content_to && content_from

      if content_from.version > content_to.version
        content_to, content_from = content_from, content_to
      end

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
  end
end
